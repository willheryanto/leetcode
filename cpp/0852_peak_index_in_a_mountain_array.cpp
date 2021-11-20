// Source : https://leetcode.com/problems/peak-index-in-a-mountain-array/
// Author : willheryanto
// Date   : 2021-11-20

/*******************************************************************************
 *
 * Let's call an array `arr` a mountain if the following properties hold:
 *
 *
 *  - `arr.length >= 3`
 *  - There exists some `i` with `0 < i < arr.length - 1` such that:
 *
 *  - `arr[0] < arr[1] < ... arr[i-1] < arr[i] `
 *  - `arr[i] > arr[i+1] > ... > arr[arr.length - 1]`
 *
 *
 *
 *
 * Given an integer array `arr` that is guaranteed to be a mountain, return any
 * `i` such that `arr[0] < arr[1] < ... arr[i - 1] < arr[i] > arr[i + 1] > ...
 * > arr[arr.length - 1]`.
 *
 *
 * Example 1:
 * Input: arr = [0,1,0]
 * Output: 1
 * Example 2:
 * Input: arr = [0,2,1,0]
 * Output: 1
 * Example 3:
 * Input: arr = [0,10,5,2]
 * Output: 1
 * Example 4:
 * Input: arr = [3,4,5,1]
 * Output: 2
 * Example 5:
 * Input: arr = [24,69,100,99,79,78,67,36,26,19]
 * Output: 2
 *
 *
 * Constraints:
 *
 *
 *  - `3 <= arr.length <= 104`
 *  - `0 <= arr[i] <= 106`
 *  - `arr` is guaranteed to be a mountain array.
 *
 *
 *
 * Follow up: Finding the `O(n)` is straightforward, could you find an
 * `O(log(n))` solution?
 *
 *******************************************************************************/

class Solution {
  public:
    //int peakIndexInMountainArray(vector<int> &arr) {
        //for (int i = 1; i < arr.size(); i++) {
            //if (arr[i] < arr[i - 1])
                //return i - 1;
        //}
        //return 0;
    //}

    int peakIndexInMountainArray(vector<int> &arr) {
        int left = 0;
        int right = arr.size() - 1;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] < arr[mid + 1])
                left = mid + 1;
            else
                right = mid;
        }
        return right;
    }
};
