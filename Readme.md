## Motivation
Avoid git errors like "git checkout failed" for file names when pulling from an
MS Windows client. File names that are invalid for MS Windows may have been
checked in under Linux.

## Installation
Copy the file pre-commit to .git/hooks and make it executable.

By executing
```sh
git config hooks.enforcecompatiblefilenames true
```
you can then enable the hook.

## Testing
Clone the repository and execute ./test-hook.sh
Also testIfWinValidFileName.sh may be tested in advance to git commit to check
for Windows filename compatibility to avoid too much I/O (unneccessary git
repository changes).

## Limitation
The maximum absolute file path can not be reliable enforced as the path length
leading to the repository root is unknown for other clients.
