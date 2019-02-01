#!/usr/bin/env bash

print_usage() {
    echo "Usage: FILE [OPTION...]"
    echo "Compiles a variety of arbitrary files, based off of their specified type or extension"
    echo ""
    echo "Args:"
    echo "    FILE: The file that is meant to be compiled."
    echo ""
    echo "Options:"
    echo "    -h       Prints a help message"
    echo "    -t TYPE  Specifies the specific type the file is. Useful if the type cannot be"
    echo "             determined from the extension."
    echo ""
    echo "Authors:"
    echo "    Eli W. Hunter"
}

# Process all arguments except for the first one
file_type=''
file=''
while getopts ':hf:t:' flag; do
    case "${flag}" in
        f) file="${OPTARG}" ;;
        t) file_type="${OPTARG}";;
        h)
            print_usage
            exit 0
            ;;
        *)
            print_usage
            exit 1
            ;;
    esac
done
basename=$(basename "$file"); basename="${basename%.*}"

# Check the file
if [[ ! -f "$file" ]]; then
    echo "File not found. Terminating..."
    exit 2
fi

# Try to parse the file type if it was not specified
if [[ -z "$file_type" ]]; then
    ext=${file##*.}

    case "$ext" in
        md | markdown) file_type='markdown' ;;
        # Don't do anything with unknown extension
    esac
fi

# Process the file
case "$file_type" in
    markdown) pandoc "$file" -o "${basename}.pdf" ;;

    *)
        echo "Unknown filetype. Terminating..."
        exit 3
        ;;
esac
