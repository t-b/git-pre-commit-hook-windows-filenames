#!/bin/sh

# Copyright thomas dot braun aeht virtuell minus zuhause dot de,  2013
#
# test suite for hook

cp pre-commit .git/hooks
chmod a+x .git/hooks

git config --replace-all hooks.enforcecompatiblefilenames true
commit=$(git rev-parse HEAD)

counter=0

checkname ()
{
  
  filename="$1"
  counter=$(expr $counter \+ 1)
  touch "$filename" &&
  git add "$filename" &&
  GIT_TRACE=1 git commit -m "my message"
  ret=$?
  git reset --hard $commit > /dev/null

  if test $ret -eq 1
  then
    echo "Test $counter passed"
  else
    echo "Failed"
    exit 1
  fi
}

echo "non printable characters"
checkname "a\t.pdf"
checkname "b\n.pdf"

echo "###illegal chars###"
checkname "a<.txt"
checkname "a>.txt"
checkname "a:.txt"
checkname "a\".txt"
checkname "a\\.txt"
checkname "a|.txt"
checkname "a?.txt"
checkname "a*.txt"

echo "###reserved names###"
checkname "CON.txt" 
checkname "AUX.txt" 
checkname "LPT1.txt" 

echo "###no trailing period or space###"
checkname " "
checkname "a.txt." 
checkname "b.txt. " 
checkname "c.txt ."

echo "###filename all periods###"
checkname "..."

echo "###absolute path too long###"
path="1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890/1234567890"

mkdir -p $path
validfile="a.txt"

checkname "$path/$validfile"

