## Installation
Copy the file pre-commit to .git/hooks and make it executable.

By executing 
```sh
git config hooks.enforcecompatiblefilenames true
```
you can then enable the hook.

## Testing
Clone the repository and execute ./test-hook.sh

## Limitation
The maximum absolute file path can not be reliable enforced as the path length
leading to the repository root is unknown for other clients.

Copyright thomas dot braun aeht virtuell minus zuhause dot de,  2013
