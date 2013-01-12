#!/bin/sh

#
# This function will print to the screen instructions on how to
# use the command.
#
usage_instructions() {
  echo "usage: getScripts [-p] user_id group_number exercise_number store_folder_name"
  echo "  see README for more details."
  return 0
}


# True if required to print the submissions,
# False otherwise.
to_print=false

# This is the directory which the second argument (where the
# submissions will be saved) is relative to. Currently set to
# the folder that the script was called from.
base_dir=$PWD/


# If there are no arguments, print usage instructions.
# Otherwise get the scripts.
if [ $# -eq 0 ]; then
  usage_instructions
else

  # Manage options.
  while getopts ":p" opt; do
    case $opt in
      p)
        to_print=true
       # echo "-p was triggered"
        ;;
      \?)
       # echo "invalid option"
        exit 1
        ;;
    esac
  done

  # remove options from arguments so that we are left with only
  # the mass_arguments.
  shiftAmount=`expr $OPTIND - 1`
  shift $shiftAmount

  # Check that there are the correct number of arguments.
  if [ $# -ne 4 ]; then
    echo "Incorrect number of arguments parameters"
    exit 1
  fi

  # Your user id.
  user=$1

  # Your group number.
  group=$2

  # The exercise number.
  ex_num=$3

  # The path to store the submissions.
  store_dir=$base_dir$4

  # Check that the group number is an integer.
  if [ $group -eq $group 2> /dev/null ]; then
    :
  else
    echo "The group number should be an integer"
    exit 1
  fi

  # Check the exercise number is an integer.
  if [ $ex_num -eq $ex_num 2> /dev/null ]; then
    :
  else
    echo "The exercise number should be an integer."
    exit 1
  fi 

  # Check that the path to store the scripts doesn't already exist.
  if [ ! -e $store_dir -a ! -d $store_dir ]; then
    :
  else
    echo "A directory with this path already exists, please try a different one"
    exit 1
  fi 

  # Create the folder where the submissions will be stored.
  echo "Creating target directory..."
  mkdir $store_dir

  # Download submissions tar file to the folder.
  echo "Downloading submissions archive..."
  wget -O $store_dir/autotest.tgz --quiet --user=$user --ask-password https://www.doc.ic.ac.uk/~tora/firstyear/ppt/group/$group/exercise/$ex_num/autotest.tgz
  wget_status=$?
  # Check invalid password
  if [ $wget_status -eq 6 ]; then
    echo "Incorrect password"
    exit 1
  # Check for other errors
  elif [ $wget_status -ne 0 ]; then
    echo "An error occurred. Perhaps you entered the wrong exercise number?"
    exit 1
  fi

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
