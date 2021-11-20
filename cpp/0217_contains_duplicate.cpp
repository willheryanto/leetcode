// Source : https://leetcode.com/problems/contains-duplicate/
// Author : willheryanto
// Date   : 2021-11-20

/*******************************************************************************
 *
 * Given an integer array `nums`, return `true` if any value appears at least
 * twice in the array, and return `false` if every element is distinct.
 *
 *
 * Example 1:
 * Input: nums = [1,2,3,1]
 * Output: true
 * Example 2:
 * Input: nums = [1,2,3,4]
 * Output: false
 * Example 3:
 * Input: nums = [1,1,1,3,3,4,3,2,4,2]
 * Output: true
 *
 *
 * Constraints:
 *
 *
 *  - `1 <= nums.length <= 105`
 *  - `-109 <= nums[i] <= 109`
 *
 *******************************************************************************/

#include <iostream>
#include <istream>
#include <unordered_set>
#include <vector>

using namespace std;

class Solution {
  public:
    bool containsDuplicate(vector<int> &nums) {
        unordered_set<int> s;
        int n = nums.size();
        for (size_t i = 0; i < n; i++) {
            if (s.find(nums[i]) != s.end()) {
                return true;
            }
            s.insert(nums[i]);
        }
        return false;
    }
};

#define EACH(x, a) for (auto &x : a)

template <class A> void read(vector<A> &v);
template <class T> void read(T &x) { cin >> x; }
template <class A> void read(vector<A> &x) {
    EACH(a, x)
    read(a);
}

void solve() {
    int n;
    read(n);
    vector<int> vt(n);
    read(vt);
    Solution s;
    cout << s.containsDuplicate(vt) << endl;
}

int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    cout.tie(0);
    int tc = 1;
    read(tc);
    for (int t = 1; t <= tc; t++) {
        cout << "Case #" << t << ": ";
        solve();
    };
}
