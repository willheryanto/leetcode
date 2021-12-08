// Source : https://leetcode.com/problems/product-of-array-except-self/
// Author : willheryanto
// Date   : 2021-12-08

/*******************************************************************************
 *
 * Given an integer array `nums`, return an array `answer` such that
 * `answer[i]` is equal to the product of all the elements of `nums` except
 * `nums[i]`.
 *
 * The product of any prefix or suffix of `nums` is guaranteed to fit in a
 * 32-bit integer.
 *
 * You must write an algorithm that runs in `O(n)` time and without using the
 * division operation.
 *
 *
 * Example 1:
 * Input: nums = [1,2,3,4]
 * Output: [24,12,8,6]
 * Example 2:
 * Input: nums = [-1,1,0,-3,3]
 * Output: [0,0,9,0,0]
 *
 *
 * Constraints:
 *
 *
 *  - `2 <= nums.length <= 105`
 *  - `-30 <= nums[i] <= 30`
 *  - The product of any prefix or suffix of `nums` is guaranteed to
 * fit in a 32-bit integer.
 *
 *
 *
 * Follow up: Can you solve the problem in `O(1) `extra space complexity? (The
 * output array does not count as extra space for space complexity analysis.)
 *
 *******************************************************************************/

#include <my/libs.h>

class Solution {
  public:
    vector<int> productExceptSelf(vector<int> &nums) {
        vector<int> res;
        int n = nums.size();

        int p = 1;
        for (int i = 0; i < n; i++) {
            res.push_back(p);
            p *= nums[i];
        }

        p = 1;
        for (int i = n - 1; i >= 0; i--) {
            res[i] *= p;
            p *= nums[i];
        }

        return res;
    }
};

void solve() {
    int n;
    read(n);
    vector<int> nums(n);
    read(nums);
    Solution s;
    auto ans = s.productExceptSelf(nums);
    EACH(a, ans)
    cout << a << " ";
    cout << endl;
}

int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    cout.tie(0);
    int tc = 1;
    cin >> tc;
    for (int t = 1; t <= tc; t++) {
        cout << "Case #" << t << ": ";
        solve();
    }
}
