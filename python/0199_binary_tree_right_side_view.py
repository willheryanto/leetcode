# Source : https://leetcode.com/problems/binary-tree-right-side-view/
# Author : William Heryanto
# Date   : 2021-02-06

###############################################################################
#
# Given a binary tree, imagine yourself standing on the right side of it,
# return the values of the nodes you can see ordered from top to bottom.
#
# Example:
#
# Input: [1,2,3,null,5,null,4]
# Output: [1, 3, 4]
# Explanation:
#
#    1            <---
#  /   \
# 2     3         <---
#  \     \
#   5     4       <---
#
###############################################################################


class Solution:
    def rightSideView(self, root: TreeNode) -> List[int]:
        return self.traversal(root)

    def traversal(self, root) -> List[int]:
        res = []
        self._traversal(root, res, 0)
        return res

    def _traversal(self, root, arr, level):
        if root:
            try:
                arr[level] = root.val
            except IndexError:
                arr.append(root.val)
            self._traversal(root.left, arr, level + 1)
            self._traversal(root.right, arr, level + 1)
