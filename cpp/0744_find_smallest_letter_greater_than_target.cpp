// Source :
// https://leetcode.com/problems/find-smallest-letter-greater-than-target/
// Author : willheryanto
// Date   : 2021-11-20

/*******************************************************************************
 *
 * Given a characters array `letters` that is sorted in non-decreasing order
 * and a character `target`, return the smallest character in the array that is
 * larger than `target`.
 *
 * Note that the letters wrap around.
 *
 *
 *  - For example, if `target == 'z'` and `letters == ['a', 'b']`, the
 * answer is `'a'`.
 *
 *
 *
 * Example 1:
 *
 *
 * Input: letters = ["c","f","j"], target = "a"
 * Output: "c"
 *
 *
 * Example 2:
 *
 *
 * Input: letters = ["c","f","j"], target = "c"
 * Output: "f"
 *
 *
 * Example 3:
 *
 *
 * Input: letters = ["c","f","j"], target = "d"
 * Output: "f"
 *
 *
 * Example 4:
 *
 *
 * Input: letters = ["c","f","j"], target = "g"
 * Output: "j"
 *
 *
 * Example 5:
 *
 *
 * Input: letters = ["c","f","j"], target = "j"
 * Output: "c"
 *
 *
 *
 * Constraints:
 *
 *
 *  - `2 <= letters.length <= 104`
 *  - `letters[i]` is a lowercase English letter.
 *  - `letters` is sorted in non-decreasing order.
 *  - `letters` contains at least two different characters.
 *  - `target` is a lowercase English letter.
 *
 *******************************************************************************/

class Solution {
  public:
    char nextGreatestLetter(vector<char> &letters, char target) {
        int lowest = INT8_MAX;
        char res = ' ';

        for (int var : letters) {
            int cur = min(abs(var - target), lowest);
            if (cur != 0 and var > target and cur < lowest) {
                lowest = cur;
                res = var;
            }
        }

        if (res == ' ')
            res = letters[0];
        return res;
    }
};
