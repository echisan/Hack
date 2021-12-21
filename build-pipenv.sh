#!/bin/sh

# /////////////////////////////////////////////////////////////////
#
# build-pipenv.sh
#  A shell script that creates a virtualenv for Hack font builds
#  Copyright 2018 Christopher Simpkins
#  MIT License
#
#  Usage: ./build-pipenv.sh
#
# /////////////////////////////////////////////////////////////////

if ! which pipenv
	then
		echo "Unable to detect a pipenv install.  Please install with 'pip install pipenv' then repeat your build attempt." 1>&2
		exit 1
fi

# create virtualenv and install build dependencies
pipenv install --ignore-pipfile --python=/usr/bin/python3.8

# test for fontmake install in venv
if ! pipenv run fontmake --version
	then
		echo "Unable to detect fontmake install with pipenv.  Please repeat your build attempt." 1>&2
		exit 1
fi

# test for fontTools install in venv
if ! pipenv run python -c "import fontTools"
	then
		echo "Unable to detect fontTools install with pipenv.  Please repeat your build attempt." 1>&2
		exit 1
fi

# print environment used for build to std output stream

echo "================================="
echo "  PYTHON BUILD ENVIRONMENT"
echo "================================="
echo " "
echo "Python interpreter version:"
pipenv run python --version
echo " "
pipenv graph

echo " "
echo "================================="
echo " "
echo "================================="
echo " "
