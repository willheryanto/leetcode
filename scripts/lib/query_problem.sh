#!/bin/bash

BASE_LEETCODE_URL=https://leetcode.com/problems/

function extract_question_slug() {
	QUESTION_TITLE_SLUG=$(echo ${1#${BASE_LEETCODE_URL}} | sed 's/\/.*//')
}

function query_problem() {
	TMP_JSON_FILENAME=tmp.json

	curl -s 'https://leetcode.com/graphql' \
		-H 'accept-encoding: gzip, deflate' \
		-H 'accept-language: en-US,en;q=0.9' \
		-H 'cookie: __cfduid=d27792c4ac95b7513049a6be5ce265fcc1612088622; csrftoken=zSG4oSSSpqozIJeGlWjYRkQXEuidVVCmoIYrJhBEa3Ls1tNIVBfGqKGLbbvsxDNH; __cf_bm=03ad8e90eeb87bed0dbb43fe1d0cec898944f954-1612088622-1800-AecRFwQR+ynjRLcKwE+EUb4X6ysqSfBKdaiP4nucyDEDgddotITgMnKOuo+bloJO63MNJF8nkw1v9JpSmVwwwGc=' \
		-H 'x-csrftoken: zSG4oSSSpqozIJeGlWjYRkQXEuidVVCmoIYrJhBEa3Ls1tNIVBfGqKGLbbvsxDNH' \
		-H 'content-type: application/json' \
		--data-binary '{"operationName":"questionData","variables":{"titleSlug":"'$2'"},"query":"query questionData($titleSlug: String!) {\n  question(titleSlug: $titleSlug) {\n    questionId\n    questionFrontendId\n    boundTopicId\n    title\n    titleSlug\n    content\n    translatedTitle\n    translatedContent\n    isPaidOnly\n    difficulty\n    likes\n    dislikes\n    isLiked\n    similarQuestions\n    contributors {\n      username\n      profileUrl\n      avatarUrl\n      __typename\n    }\n    langToValidPlayground\n    topicTags {\n      name\n      slug\n      translatedName\n      __typename\n    }\n    companyTagStats\n    codeSnippets {\n      lang\n      langSlug\n      code\n      __typename\n    }\n    stats\n    hints\n    solution {\n      id\n      canSeeDetail\n      __typename\n    }\n    status\n    sampleTestCase\n    metaData\n    judgerAvailable\n    judgeType\n    mysqlSchemas\n    enableRunCode\n    enableTestMode\n    envInfo\n    __typename\n  }\n}\n"}' \
		--compressed >${TMP_JSON_FILENAME}

	BASE_JSON_PATH='.data.question'
	QUESTION_CONTENT=$(cat ${TMP_JSON_FILENAME} | jq -r "${BASE_JSON_PATH}.content" | sed -E 's/<\/?code>/\`/g; s/<li>/ - /g; s/<[^>]*>//g; s/&nbsp;/ /g; s/&amp;/\&/g; s/&lt;/\</g; s/&gt;/\>/g; s/&quot;/\"/g; s/&#39;/\'"'"'/g; s/&ldquo;/\"/g; s/\\t//g;')
	QUESTION_TITLE=$(cat ${TMP_JSON_FILENAME} | jq -r "${BASE_JSON_PATH}.title")
	QUESTION_FRONTEND_ID=$(cat ${TMP_JSON_FILENAME} | jq -r "${BASE_JSON_PATH}.questionFrontendId")

	rm -rf $TMP_JSON_FILENAME
}
