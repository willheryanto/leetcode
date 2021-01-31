#!/bin/bash

AUTHOR="Default"
FILE_TYPE="p"

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

source ${SCRIPTPATH}/lib/query_problem.sh

function usage()
{

    echo -e "Usage: ${0} [url] [source_file] [file_type]"
    echo -e ""
    echo -e "Example:"
    echo -e ""
    echo -e "   1) Create a file named largest_number.py, and add Copyright & Problem description"
    echo -e "   ${0} https://leetcode.com/problems/largest-number/"
    echo -e ""
    echo -e "   2) Add Copyright & Problem description into existed file"
    echo -e "   ${0} https://leetcode.com/problems/largest-number/ largestNumber.cpp"
    echo -e ""
}

function get_author_name() {
    if ! type git > /dev/null 2>&1; then
       AUTHOR=`whoami`
    else
       AUTHOR=`git config --get user.name`
    fi
}

# Check if argument provided
if [ $# -lt 1 ] ; then
    usage
    exit 255
fi

LEETCODE_URL=$1
CURRENT_DATE=`date +%Y-%m-%d`

# Check if jq exist
if ! type jq > /dev/null 2>&1; then
    echo "jq not found"
    exit 255
fi

# Get question details
extract_question_slug $LEETCODE_URL
query_problem $LEETCODE_URL $QUESTION_TITLE_SLUG

file_name=`echo $QUESTION_TITLE_SLUG | sed 's/-/_/g' | xargs printf '%04d_%s' $QUESTION_FRONTEND_ID`

# Check if file type provided
if [ $# -gt 1 ]; then
    FILE_TYPE="${2}"
fi

# Build file path
case $FILE_TYPE in
    cpp )
        FILE_EXT=".cpp"
        FOLDER_NAME="cpp"
        COMMENT_TAG="//"
        ;;
    p | py | python )
        FILE_EXT=".py"
        FOLDER_NAME="python"
        COMMENT_TAG="#"
        ;;
    * )
        echo "File type not yet supported"
        exit 1
esac

FULL_FILE_PATH=`echo ${FOLDER_NAME}/${file_name}${FILE_EXT}`

if [ ! -f ${FULL_FILE_PATH} ]; then
    echo "Create a new file - ${FULL_FILE_PATH}"
    echo -e "\n" > ${FULL_FILE_PATH}
fi

# Get author name
get_author_name

# Add copyright
if ! grep "${COMMENT_TAG} Author :" $FULL_FILE_PATH > /dev/null; then
    sed -i.bak '1i\'$'\n'"${COMMENT_TAG} Source : ${LEETCODE_URL}"$'\n' $FULL_FILE_PATH > /dev/null
    sed -i.bak '2i\'$'\n'"${COMMENT_TAG} Author : ${AUTHOR}"$'\n' $FULL_FILE_PATH > /dev/null
    sed -i.bak '3i\'$'\n'"${COMMENT_TAG} Date   : ${CURRENT_DATE}" $FULL_FILE_PATH > /dev/null
    rm ${FULL_FILE_PATH}.bak
fi

function build_comment() {
    CONTENT=$1
    STYLE=$2
    OUTPUT_PATH=$3

    WIDTH=80
    case $STYLE in
        clike )
            WIDTH_OFFSET=$(expr $WIDTH - 2)
            WIDTH_FOLD=$(expr $WIDTH - 3)
            ;;
        script )
            WIDTH_OFFSET=$(expr $WIDTH - 1)
            WIDTH_FOLD=$(expr $WIDTH - 2)
            ;;
    esac

    WIDTH_SEQ=`seq 1 ${WIDTH_OFFSET}`

    case $STYLE in
        clike )
            if ! grep '\*\*\*\*\*' $OUTPUT_PATH > /dev/null; then
                echo "${QUESTION_CONTENT}" |
                    sed 's/^[[:space:]]*$/\n/g' | cat -s |
                    fold -w ${WIDTH_FOLD} -s |
                    sed -E 's/^/ * /g' |
                    sed '1i\'$'\n'"/*$(printf "%0.s*" ${WIDTH_SEQ})"$'\n' |
                    sed '2i\'$'\n'" *"$'\n' |
                    sed '$a\'$'\n'" *"$'\n' |
                    sed '$a\'$'\n'"$(printf "%0.s*" ${WIDTH_SEQ})*/"$'\n' |
                    sed 's/\r//'>> ${OUTPUT_PATH}
            fi
            ;;
        script )
            if ! grep '#####' $OUTPUT_PATH > /dev/null; then
                echo "${QUESTION_CONTENT}" |
                    sed 's/^[[:space:]]*$/\n/g' | cat -s |
                    fold -w ${WIDTH_FOLD} -s |
                    sed 's/^/# /' |
                    sed '1i\'$'\n'"$(printf "%0.s#" ${WIDTH_SEQ})"$'\n' |
                    sed '2i\'$'\n'"#"$'\n' |
                    sed '$a\'$'\n'"#"$'\n' |
                    sed '$a\'$'\n'"$(printf "%0.s#" ${WIDTH_SEQ})"$'\n' |
                    sed 's/\r//'>> ${OUTPUT_PATH}
            fi
            ;;
        * )
            echo "Wut?"
            exit 1
    esac
}

# Add problem description to file
case ${FILE_EXT} in 
    .c | .cpp )
        build_comment  "${QUESTION_CONTENT}" clike "${FULL_FILE_PATH}"
        ;;
    .py )
        build_comment  "${QUESTION_CONTENT}" script "${FULL_FILE_PATH}"
        ;;
    * )
        echo "File extension not supported"
        exit 1
esac
