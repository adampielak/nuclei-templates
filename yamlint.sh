#!/bin/sh
#
# Simple tool to syntax check yaml template files.
#     sh yamllint.sh [yourfile.yaml]
#
# Install the required library for python
#     pip install pyyaml
#
if [ "$1" ]; then
 python -c 'import yaml, sys; yaml.safe_load(sys.stdin)' < $1
else
 echo "Needs a parameter specifying the .yaml file to check"
fi
