#!/usr/bin/bash
# THERE IS NO ERROR CHECKING ON THE ARGUMENTS!

# First argument is the exercise number which can be found from the url of the
# page where you would usually download the scripts submissions. It is of the form:
# https://www.doc.ic.ac.uk/~tora/firstyear/ppt/group/2/exercise/number
# where number is the exercise number.

# Second argument is the name which you would like to call the directory where the submissions will be saved.

#
# This function will print to the screen instructions on how to
# use the command.
# TODO: add what the -p option means
#
function usage_instructions {
  case $1 in
    1)
      echo "usage: getScripts [-p] exercise store_folder_name"
      ;;
    2)
      echo "incorrect usage"
      ;;
  esac
}

# True if required to print the submissions
# False otherwise
to_print=false

# If there are no arguments, print usage instructions.
# Otherwise get the scripts.
if [ $# -eq 0 ]; then
  usage_instructions 1
else

  while getopts ":p" opt; do
    case $opt in
      p)
        to_print=true
        echo "-p was triggered"
        ;;
      \?)
        echo "invalid option"
        ;;
    esac
  done

  shift $((OPTIND-1))
  echo "argument 1 is: $1"

  echo "Scripts downloaded"

  if $to_print; then
    echo "Scripts printed"
  fi
#  # This is the path to the folder where you store all the submissions.
#  storeDir=~/Documents/ThirdYear/PPT-UTA/$2

#  echo "Creating target directory..."
#  mkdir $storeDir

#  echo "Downloading submissions archive..."
#  wget -O $storeDir/autotest.tgz --user=nc1610 --ask-password https://www.doc.ic.ac.uk/~tora/firstyear/ppt/group/2/exercise/$1/autotest.tgz

#  echo "Extracting archive..."
#  tar -xf $storeDir/autotest.tgz -C $storeDir

#  echo "Removing archive..."
#  rm -f $storeDir/autotest.tgz

#  echo "Printing submissions..."
#  for f in $storeDir/*.pdf
#  do
#    lpr -P ICTMono -o HPStaplerOptions=1diagonal $f
#  done

#  echo "Complete!"
fi
