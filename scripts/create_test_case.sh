#!/bin/bash

FILEPATH=tmp

if ! type rg >/dev/null 2>&1; then
	echo "ripgrep not found"
	exit 255
fi

if [ $# -lt 1 ]; then
	echo "Usage: $0 <file>"
	exit 255
fi

function extract_number_from_rg() {
	awk -F ':' '{print $1}' $@
}

# Find range of lines in file
START=$(cat $1 | rg -n '/\*\*' | extract_number_from_rg)
END=$(cat $1 | rg -n '\*\*/' | extract_number_from_rg)

# Extract inputs
EXTRACTED_CONTENT=$(cat $1 | sed -n "${START},${END}p")
INPUT_CONTENT="$(echo "$EXTRACTED_CONTENT" | rg Input | sed 's/.*Input: \(.*\)/\1/g')"

# Extract test numbers
TEST_NUMBERS=$(echo "$INPUT_CONTENT" | wc -l)


# Write to file
echo "$TEST_NUMBERS" >$FILEPATH

# Change loop separator
IFS=$'\n'
for line in $INPUT_CONTENT; do
	length=0
    vars=$(echo "$line" | sed 's/, /\n/')

    v=''
    for var in $vars; do
        tmp=$(echo $var | awk -F '= ' '{print $2}')

        # Clean if it's array
        if [[ $tmp == "["* && $tmp == *"]" ]]; then
            tmp=$(echo "$tmp" | sed 's/\[//g' | sed 's/\]//g' | sed 's/ //g' | sed 's/,/ /g')
            tmpv=$(echo $tmp | sed 's/[0-9]//g' | sed 's/-//g')
            length=$(expr ${#tmpv} + 1)
        fi

        # If value exist, add space before adding value
        if [ ${#v} -gt 0 ]; then
            v+=" $tmp"
        else
            v+=$tmp
        fi
    done

    # If length greater than 0, add value to file to show array length
    if [ $length -gt 0 ]; then
        echo $length >>tmp
    fi

    echo $v >>tmp
done
