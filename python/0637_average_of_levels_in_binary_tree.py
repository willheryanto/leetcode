# Source : https://leetcode.com/problems/average-of-levels-in-binary-tree/
# Author : William Heryanto
# Date   : 2021-03-05

###############################################################################
#
# Given a non-empty binary tree, return the average value of the nodes on each
# level in the form of an array.
#
# Example 1:
#
# Input:
#     3
#    / \
#   9  20
#     /  \
#    15   7
# Output: [3, 14.5, 11]
# Explanation:
# The average value of nodes on level 0 is 3,  on level 1 is 14.5, and on level
# 2 is 11. Hence return [3, 14.5, 11].
#
# Note:
#
# The range of node's value is in the range of 32-bit signed integer.
#
#
###############################################################################

class Solution:
    def averageOfLevels(self, root: TreeNode) -> List[float]:
        res = []

        def dfs(node, depth=0):
            try:
                res[depth]
            except IndexError:
                res.append([])

            res[depth].append(node.val)

            if node.left:
                dfs(node.left, depth=depth + 1)

            if node.right:
                dfs(node.right, depth=depth + 1)

        dfs(root)
        return [sum(x)/len(x) for x in res]
