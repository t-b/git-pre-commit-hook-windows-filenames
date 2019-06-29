## Motivation
Avoid git errors like "git checkout failed" for file names when pulling from a MS Windows client.
File name that are invalid for MS Windows may have been check in under Linux.

## Installation
Copy the file pre-commit to .git/hooks and make it executable.

By executing 
```sh
git config hooks.enforcecompatiblefilenames true
```
you can then enable the hook.

## Testing
Clone the repository and execute ./test-hook.sh
Also testIfWinValidFileName.sh may be tested in advance to git commit to check for Windows filename compatibility to avoid too much I/O.

## Limitation
The maximum absolute file path can not be reliable enforced as the path length
leading to the repository root is unknown for other clients.

Copyright thomas dot braun aeht virtuell minus zuhause dot de,  2013
