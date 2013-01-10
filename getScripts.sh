#!/usr/bin/bash

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
      echo "usage: getScripts [-p] exercise_number store_folder_name"
      ;;
    2)
      echo "incorrect usage"
      ;;
  esac
}


# True if required to print the submissions,
# False otherwise.
to_print=false

# This is the directory which the second argument (where the
# submissions will be saved) is relative to.
base_dir=~/


# If there are no arguments, print usage instructions.
# Otherwise get the scripts.
if [ $# -eq 0 ]; then
  usage_instructions 1
else

  # Manage options.
  while getopts ":p" opt; do
    case $opt in
      p)
        to_print=true
        echo "-p was triggered"
        ;;
      \?)
        echo "invalid option"
        exit 1
        ;;
    esac
  done

  # remove options from arguments so that we are left with only
  # the mass_arguments.
  shift $((OPTIND-1))

  # Check that there are the correct number of arguments.
  if [ $# -ne 2 ]; then
    echo "Incorrect number of arguments parameters"
    usage_instructions 1
    exit 1
  fi

  # The exercise number.
  ex_num=$1

  # The path to store the submissions.
  store_dir=$base_dir$2

  # Check the exercise number is an integer.
  if [ $ex_num -eq $ex_num 2> /dev/null ]; then
    :
  else
    echo "First argument should be an integer (ie. the exerice number)"
    exit 1
  fi 

  # Check that the path to store the scripts doesn't already exist.
  if [[ ! -e $store_dir || ! -d $store_dir ]]; then
    :
  else
    echo "A directory with this path already exists, please try a different one"
    exit 1
  fi 

  echo "Scripts downloaded"

  if $to_print; then
    echo "Scripts printed"
  fi

  # Create the folder where the submissions will be stored.
  echo "Creating target directory..."
  mkdir $store_dir

  # Download submissions tar file to the folder.
  echo "Downloading submissions archive..."
  wget -O $store_dir/autotest.tgz --user=nc1610 --ask-password https://www.doc.ic.ac.uk/~tora/firstyear/ppt/group/2/exercise/$1/autotest.tgz

  # Extract the submissions for the tar file.
  echo "Extracting archive..."
  tar -xf $store_dir/autotest.tgz -C $store_dir

  # Delete the tar file. It isn't required anymore.
  echo "Removing archive..."
  rm -f $store_dir/autotest.tgz

  # If the print option was specified, print the submissions.
  if $to_print; then
    echo "Printing submissions..."
    for f in $store_dir/*.pdf
    do
      lpr -P ICTMono -o HPStaplerOptions=1diagonal $f
    done
  fi

  echo "Completed successfully!"
fi
