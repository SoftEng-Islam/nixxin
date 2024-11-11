#!/bin/bash

# Prompt for the destination directory path
read -r -p "Enter the destination directory path: " dest_dir

# Check if the directory exists, if not, create it
if [ ! -d "$dest_dir" ]; then
    echo "Directory does not exist. Creating it..."
    mkdir -p "$dest_dir"
    echo "Directory created: $dest_dir"
fi

# Copy the nixos directory content to the specified path
if cp -r nixos/* "$dest_dir"; then
    echo "All files from the nixos directory have been successfully copied to $dest_dir."
else
    echo "Error: Failed to copy files to $dest_dir."
fi
