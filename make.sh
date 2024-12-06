#!/bin/env bash

set -e

name="fakeintel"

install_dir="/usr/lib"

source_file_name="${name}.c"
binary_file_name="lib${name}.so"

# Parse arguments

# ./make.sh --install
if [ "${1}" = "clean" ]; then
	install=1
fi

echo "Compiling ${source_file_name} to ${binary_file_name}..."
gcc -shared -fPIC \
	-o ${binary_file_name} \
	${source_file_name}
echo "Compilation complete."

current_path=$(pwd)

echo "export LD_PRELOAD=${current_path}/${binary_file_name}"

# Check if not have install option
if [ "${install}" != "1" ]; then
	# Ask if user wants to install
	echo "Do you want to install the library? (y/n)"
	read install
	if [ "${install}" = "y" ]; then
		install=1
	fi
fi

if [ "${install}" = "1" ]; then
	echo "Installing..."
	sudo cp ${binary_file_name} ${install_dir}
	echo "Installation complete."

	echo "export LD_PRELOAD=${install_dir}/${binary_file_name}"
fi

echo "Done."
