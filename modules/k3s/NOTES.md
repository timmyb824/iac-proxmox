# Notes

## Removing a node

- Drain it from the cluster first — `kubectl drain`
- Remove it from the cluster — `kubectl delete node`
- Comment out `prevent_destroy = true` in the module
- Run `tofu destroy` targeted at just that node — `tofu destroy -target=module.k3s_2`
- Restore `prevent_destroy = true`
