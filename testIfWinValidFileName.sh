concatCause() #https://www.shellscript.sh/functions.html 
{
  currCause=$1
  if test "$cause" = "" ;then
    cause=$currCause
  else
    #see https://linuxize.com/post/bash-concatenate-strings/
    cause=$cause", "$currCause
  fi
}

#testIfWinValidFileName () {
  echo "File name: $1"
  filename=$1
  # Non-printable characters from ASCII range 0-31 
  nonprintablechars=$(echo -n "$filename" | LC_ALL=C tr -d '[ -~]' | wc -c)

  # Illegal characters: < > : " / \ | ? *
  # We don't test for / (forward slash) here as that is even on *nix not allowed in *filename*
  illegalchars=$(echo -n "$filename" | LC_ALL=C grep -E '(<|>|:|"|\\|\||\?|\*)' | wc -c)

  # Reserved names plus possible extension
  # CON, PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7, COM8, COM9, LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, and LPT9
  reservednames=$(echo -n "$filename" | LC_ALL=C grep -i -E '(CON|PRN|AUX|NUL|COM1|COM2|COM3|COM4|COM5|COM6|COM7|COM8|COM9|LPT1|LPT2|LPT3|LPT4|LPT5|LPT6|LPT7|LPT8|LPT9).[a-z]{3}' | wc -c)

  # No trailing period or space
  trailingperiodorspace=$(echo -n "$filename" | LC_ALL=C grep -E '(\.| )$' | wc -c)

  # File name is all periods
  filenameallperiods=$(echo -n "$filename" | LC_ALL=C grep -E '^\.+$' | wc -c)

  # Check complete path length to be smaller than 260 characters
  # This test can not be really accurate as we don't know if PWD on the windows filesystem itself is not very long 
  absolutepathtoolong=0
  if test $(echo "$filename" | wc -c) -ge 260
  then
    absolutepathtoolong=1
  fi

  # debug output
  if test -n "$GIT_TRACE"
  then
    echo "File: ${filename}"
    echo nonprintablechars=$nonprintablechars
    echo illegalchars=$illegalchars
    echo reservednames=$reservednames
    echo trailingperiodorspace=$trailingperiodorspace
    echo filenameallperiods=$filenameallperiods
    echo absolutepathtoolong=$absolutepathtoolong
  fi

  cause=""
  if test $nonprintablechars -ne 0
   then
    concatCause "non-printable chars"
  fi
  if test $illegalchars -ne 0
   then
    concatCause "illegal characters (1 of <>:\"\|?*)"
  fi
  if test $reservednames -ne 0
   then
    concatCause "reserved names"
  fi
  if test $trailingperiodorspace -ne 0
   then
    concatCause "trailing period or space"
  fi
  if test $filenameallperiods -ne 0
   then
    concatCause "file name all periods"
  fi 
  if test $absolutepathtoolong -ne 0
   then
    concatCause "absolute path too long"
  fi
  if test "$cause" != ""
  then
  #else
    echo "Error: file name is incompatible to MS Windows file systems:"
    echo $cause 
    exit 1
  fi
  exit 0
#}

