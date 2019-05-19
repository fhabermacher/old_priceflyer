#!/bin/bash

PS1="$PS1"
set -eu

# check required tools
echo "Check whether should install py venv?"
select yn in "Yes" "No"; do #https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
  case $yn in
    Yes ) 
	    installTools=0;
			python3 pip --version 2> /dev/null || installTools=1;
			virtualenv --version 2> /dev/null || installTools=1;
			if [ $installTools -eq 1 ]; then
			  TOOLS="python3-pip virtualenv";
			  echo "Please provide password to install $TOOLS";
			  sudo apt install $TOOLS;
			fi;
    	break;;
    No ) break;;
  esac
done

VENV=venv
virtualenv -p python3 "$VENV"
. "$VENV/bin/activate"
python3 -m pip install -r requirements.txt

PRESUMABLE_SITEPKG_DIR="venv/lib/python3.5/site-packages" # Please update if it's different version or so
if [ ! -d $PRESUMABLE_SITEPKG_DIR ]; then
	echo "Error: directory not found, maybe update it in this script: $PRESUMABLE_SITEPKG_DIR"
	exit 1
fi

# Write py package subfolder paths to .pth file so python finds them (and IDE PyCharm can be nicely aware of them!)
subdir=${PWD}/sub # Directory of "sub/" folder. Note, ${PWD} = current dir, and parentdir="$(dirname "${PWD}")" gives parent dir of current directory
#subdir="$(dirname "${PWD}")"/sub # Directory of "sub/" folder. Note, ${PWD} = current dir, and parentdir="$(dirname "${PWD}")" gives parent dir of current directory
#PTH_PL=$subdir"/pylib"
#PTH_DA=$subdir"/dash-auth_fh"
PTH_FL=$subdir"/flib_py"
PTH_FN=${PRESUMABLE_SITEPKG_DIR}/priceflyer_external_libs.pth
if [ -f "$PTH_FN" ]
then
	echo "Error: .pth file $PTH_FN already exists. I don't dare appenting into it; please remove it first"
	exit 1
else
#	for fname in $PTH_PL $PTH_DA $PTH_FL
	for fname in $PTH_FL
	do
		echo $fname >> $PTH_FN
		echo "Written path ${fname} to ${PTH_FN} file"
	done
fi

# Clone flib from bitbucket:
echo "Clone flib? Note some simle flib routines required by project"
select yn in "Yes" "No"; do #https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
  case $yn in
    Yes ) git clone https://fhabermacher@bitbucket.org/fhabermacher/flib_py.git $PTH_FL; break;;
    No ) exit;;
  esac
done
#git clone https://fhabermacher@bitbucket.org/fhabermacher/flib_py.git $PTH_FL

set +eu

# TODO: adapt PS1
echo "Exuecuting shell in virtual enviroment"
exec $SHELL
