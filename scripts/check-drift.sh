#!/usr/bin/env bash
# check-drift.sh - report which OpenTofu stacks are out of sync.
#
# Every stack (lxc/*, vm/*, k3s/*, special/*) has its own S3 state file, so
# drift is invisible unless you plan each one. This runs a read-only
# `tofu plan -detailed-exitcode` in every stack and summarises the results.
#
# Per-stack status:
#   OK       plan is empty; config, state and Proxmox agree
#   DRIFT    plan wants changes (config edited, or Proxmox changed out-of-band)
#   STALE    plan is empty, but Proxmox changed outside OpenTofu and state is
#            behind (an apply/refresh would just update state)
#   ERROR    plan failed (auth, backend unreachable, not initialised, ...)
#
# Exit code: 0 all OK, 2 any DRIFT/STALE, 1 any ERROR (ERROR wins).
#
# Usage: scripts/check-drift.sh [options] [stack ...]
#   -j N, --jobs N   parallel plans (default 4)
#   -v, --verbose    print the full plan for every non-OK stack
#   --init           run `tofu init` first for stacks missing .terraform
#   -h, --help
# Stacks are paths relative to the repo root, e.g. `lxc/grafana k3s/k3s-0`.
# With none given, every stack with an S3 backend is checked.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JOBS=4
VERBOSE=0
DO_INIT=0
STACKS=()

usage() { sed -n '2,/^$/p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    -j|--jobs) JOBS="${2:?--jobs needs a number}"; shift 2 ;;
    -v|--verbose) VERBOSE=1; shift ;;
    --init) DO_INIT=1; shift ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "unknown option: $1" >&2; exit 1 ;;
    *) STACKS+=("${1%/}"); shift ;;
  esac
done

command -v tofu >/dev/null || { echo "tofu not found in PATH" >&2; exit 1; }

if [[ ${#STACKS[@]} -eq 0 ]]; then
  # A stack is a directory under lxc/vm/k3s/special whose versions.tf declares
  # a backend. This skips modules/ and any dir without remote state.
  while IFS= read -r f; do
    d="$(dirname "$f")"; d="${d#"$REPO_ROOT"/}"
    [[ "$(basename "$d")" == _* ]] && continue   # lxc/_template
    STACKS+=("$d")
  done < <(grep -l 'backend "' "$REPO_ROOT"/{lxc,vm,k3s,special}/*/versions.tf 2>/dev/null | sort)
fi

OUT_DIR="$(mktemp -d)"
trap 'rm -rf "$OUT_DIR"' EXIT

check_stack() {
  local stack="$1" dir="$REPO_ROOT/$1" log="$OUT_DIR/${1//\//__}.log" rc
  if [[ ! -d "$dir" ]]; then echo "no such stack" >"$log"; echo "ERROR" >"$log.status"; return; fi

  if [[ $DO_INIT -eq 1 && ! -d "$dir/.terraform" ]]; then
    tofu -chdir="$dir" init -input=false -no-color >"$log" 2>&1 || { echo ERROR >"$log.status"; return; }
  fi

  # -lock=false: read-only check must not block (or be blocked by) a real apply.
  tofu -chdir="$dir" plan -detailed-exitcode -lock=false -input=false -no-color >"$log" 2>&1
  rc=$?

  case $rc in
    0) if grep -q 'Objects have changed outside' "$log"; then echo STALE; else echo OK; fi ;;
    2) echo DRIFT ;;
    *) echo ERROR ;;
  esac >"$log.status"
}
export -f check_stack
export REPO_ROOT OUT_DIR DO_INIT

echo "Checking ${#STACKS[@]} stacks ($JOBS parallel)..." >&2
printf '%s\n' "${STACKS[@]}" | xargs -P "$JOBS" -I{} bash -c 'check_stack "$1"' _ {}

# One-line reason per non-OK stack.
summarize() {
  local log="$1" status="$2"
  case "$status" in
    DRIFT) grep -E '^Plan: ' "$log" | tail -1 ;;
    STALE) echo "Proxmox changed outside OpenTofu; state needs refresh" ;;
    ERROR) grep -m1 -E '^(Error|│ Error)' "$log" | sed 's/^│ //' || tail -1 "$log" ;;
  esac
}

declare -A COUNT=([OK]=0 [DRIFT]=0 [STALE]=0 [ERROR]=0)
printf '\n%-28s %-7s %s\n' STACK STATUS DETAIL
printf '%-28s %-7s %s\n' ---------------------------- ------- ------

for stack in "${STACKS[@]}"; do
  log="$OUT_DIR/${stack//\//__}.log"
  status="$(cat "$log.status" 2>/dev/null || echo ERROR)"
  COUNT[$status]=$(( ${COUNT[$status]} + 1 ))
  detail=""
  [[ "$status" != OK ]] && detail="$(summarize "$log" "$status")"
  printf '%-28s %-7s %s\n' "$stack" "$status" "$detail"
done

printf '\nOK: %d  DRIFT: %d  STALE: %d  ERROR: %d\n' \
  "${COUNT[OK]}" "${COUNT[DRIFT]}" "${COUNT[STALE]}" "${COUNT[ERROR]}"

if [[ $VERBOSE -eq 1 ]]; then
  for stack in "${STACKS[@]}"; do
    log="$OUT_DIR/${stack//\//__}.log"
    [[ "$(cat "$log.status" 2>/dev/null)" == OK ]] && continue
    printf '\n===== %s =====\n' "$stack"
    cat "$log"
  done
elif (( COUNT[DRIFT] + COUNT[STALE] + COUNT[ERROR] > 0 )); then
  echo "Re-run with -v for full plans, or: tofu -chdir=<stack> plan" >&2
fi

(( COUNT[ERROR] > 0 )) && exit 1
(( COUNT[DRIFT] + COUNT[STALE] > 0 )) && exit 2
exit 0
