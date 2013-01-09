#!/usr/bin/bash
# THERE IS NO ERROR CHECKING ON THE ARGUMENTS!

# First argument is the exercise number which can be found from the url of the
# page where you would usually download the scripts submissions. It is of the form:
# https://www.doc.ic.ac.uk/~tora/firstyear/ppt/group/2/exercise/number
# where number is the exercise number.

# Second argument is the name which you would like to call the directory where the submissions will be saved.

function usage_instructions {
  echo "usage: getScripts [-p] exercise store_folder_name"
}

if [ -z "$1" ]; then
  usage_instructions
else
  # This is the path to the folder where you store all the submissions.
  storeDir=~/Documents/ThirdYear/PPT-UTA/$2

  echo "Creating target directory..."
  mkdir $storeDir

  echo "Downloading submissions archive..."
  wget -O $storeDir/autotest.tgz --user=nc1610 --ask-password https://www.doc.ic.ac.uk/~tora/firstyear/ppt/group/2/exercise/$1/autotest.tgz

  echo "Extracting archive..."
  tar -xf $storeDir/autotest.tgz -C $storeDir

  echo "Removing archive..."
  rm -f $storeDir/autotest.tgz

  echo "Printing submissions..."
  for f in $storeDir/*.pdf
  do
    lpr -P ICTMono -o HPStaplerOptions=1diagonal $f
  done

  echo "Complete!"
fi
