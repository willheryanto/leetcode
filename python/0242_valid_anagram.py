# Source : https://leetcode.com/problems/valid-anagram/
# Author : William Heryanto
# Date   : 2021-02-11

###############################################################################
#
# Given two strings s and t , write a function to determine if t is an anagram
# of s.
#
# Example 1:
#
# Input: s = "anagram", t = "nagaram"
# Output: true
#
# Example 2:
#
# Input: s = "rat", t = "car"
# Output: false
#
# Note:
# You may assume the string contains only lowercase alphabets.
#
# Follow up:
# What if the inputs contain unicode characters? How would you adapt your
# solution to such case?
#
###############################################################################


class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False
        return all((s.count(c)==t.count(c) for c in set(s)))
