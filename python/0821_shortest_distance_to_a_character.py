# Source : https://leetcode.com/problems/shortest-distance-to-a-character/
# Author : William Heryanto
# Date   : 2021-02-07

###############################################################################
#
# Given a string `s` and a character `c` that occurs in `s`, return an array of
# integers `answer` where `answer.length == s.length` and `answer[i]` is the
# shortest distance from `s[i]` to the character `c` in `s`.
#
# Example 1:
# Input: s = "loveleetcode", c = "e"
# Output: [3,2,1,0,1,0,0,1,2,2,1,0]
# Example 2:
# Input: s = "aaab", c = "b"
# Output: [3,2,1,0]
#
# Constraints:
#
# `1 <= s.length <= 104`
# `s[i]` and `c` are lowercase English letters.
# `c` occurs at least once in `s`.
#
###############################################################################


class Solution:
    def shortestToChar(self, s: str, c: str) -> List[int]:
        res = []
        indexes = [i for i, x in enumerate(s) if x == c]
        offset = 0

        if not indexes:
            return res

        for i, x in enumerate(s):
            if len(indexes) == 1:
                res.append(abs(i - indexes[offset]))
            else:
                l = abs(i - indexes[offset])
                r = abs(i - indexes[offset + 1])

                res.append(min(l, r))

                if r < l and offset + 1 < len(indexes) - 1:
                    offset += 1

        return res
