# Source : https://leetcode.com/problems/pairs-of-songs-with-total-durations-divisible-by-60/
# Author : William Heryanto
# Date   : 2021-02-27

###############################################################################
#
# You are given a list of songs where the ith song has a duration of `time[i]`
# seconds.
#
# Return the number of pairs of songs for which their total duration in seconds
# is divisible by `60`. Formally, we want the number of indices `i`, `j` such
# that `i < j` with `(time[i] + time[j]) % 60 == 0`.
#
# Example 1:
#
# Input: time = [30,20,150,100,40]
# Output: 3
# Explanation: Three pairs have a total duration divisible by 60:
# (time[0] = 30, time[2] = 150): total duration 180
# (time[1] = 20, time[3] = 100): total duration 120
# (time[1] = 20, time[4] = 40): total duration 60
#
# Example 2:
#
# Input: time = [60,60,60]
# Output: 3
# Explanation: All three pairs have a total duration of 120, which is divisible
# by 60.
#
# Constraints:
#
# `1 <= time.length <= 6 * 104`
# `1 <= time[i] <= 500`
#
###############################################################################

class Solution:
    def numPairsDivisibleBy60(self, time: List[int]) -> int:
        k = 60
        hash_map = {}
        res = 0

        for x in time:
            num = x % k
            if num != 0:
                hash_map[num] = hash_map.get(num, 0) + 1
            else:
                hash_map[k] = hash_map.get(k, 0) + 1

        for key in hash_map:
            if key == k or key == 30:
                num = hash_map[key] - 1
                res += int((num ** 2 + num) / 2)
            else:
                diff = k - key
                if diff in hash_map and hash_map[diff] > 0:
                    res += hash_map[diff] * hash_map[key]
                    hash_map[key] = 0
        return res
