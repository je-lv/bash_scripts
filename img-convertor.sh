#!/bin/bash

====================================
= Convert JPG to PNG and viceversa =
====================================

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Check if correct arguments are provided
if [ $# -ne 2 ]; then
    echo -e "${RED}[!] Error: Usage: $0 <source_extension> <target_extension>${NC}"
    echo "Example: $0 jpg png"
    exit 1
fi

# Get source and target extensions from arguments
SOURCE_EXT=$1
TARGET_EXT=$2

# Convert source extension to uppercase for display
SOURCE_EXT_UPPER=$(echo "$SOURCE_EXT" | tr '[:lower:]' '[:upper:]')

# Directory to search for image files
DIRECTORY="."

# Find all source files
image_files=("$DIRECTORY"/*."$SOURCE_EXT")

# Check if any source files are found
if [ ${#image_files[@]} -eq 0 ]; then
    echo -e "${RED}[!] Error: No .$SOURCE_EXT_UPPER files found in the directory.${NC}"
    exit 1
else
    echo -e "${GREEN}[+] ${#image_files[@]} $SOURCE_EXT_UPPER files found in the directory.${NC}\n"
fi

# Loop through all source files and convert to target extension
for file in "${image_files[@]}"; do
    if [[ -f "$file" ]]; then
        # Get the filename without extension
        filename=$(basename "$file" .$SOURCE_EXT)

        # Convert the file to target format and handle errors
        if convert "$file" "$DIRECTORY/$filename.$TARGET_EXT"; then
            echo -e "${GREEN}[+] Converted $file to $filename.$TARGET_EXT${NC}"
        else
            echo -e "${RED}[!] Error: Failed to convert $file${NC}"
        fi
    else
        echo -e "${RED}[!] Error: $file is not a valid file.${NC}"
    fi
done
