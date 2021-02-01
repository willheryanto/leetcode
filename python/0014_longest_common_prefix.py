# Source : https://leetcode.com/problems/longest-common-prefix/
# Author : William Heryanto
# Date   : 2021-02-01

###############################################################################
#
# Write a function to find the longest common prefix string amongst an array of
# strings.
#
# If there is no common prefix, return an empty string `""`.
#
# Example 1:
#
# Input: strs = ["flower","flow","flight"]
# Output: "fl"
#
# Example 2:
#
# Input: strs = ["dog","racecar","car"]
# Output: ""
# Explanation: There is no common prefix among the input strings.
#
# Constraints:
#
# `0 <= strs.length <= 200`
# `0 <= strs[i].length <= 200`
# `strs[i]` consists of only lower-case English letters.
#
###############################################################################


class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        if not strs:
            return ""

        prefix = min(strs, key=len)

        for i, key in enumerate(prefix):
            for s in strs:
                if s[i] != key:
                    return prefix[0:i]

        return prefix
