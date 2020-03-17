import UIKit

var str = "Hello, playground"

//[2,1,1,2,6,7,8]
var numbers = [2,7,9,3,1] //==> 12
var numbers2 = [2, 1, 1, 2] //==> 4
var numbers3 = [6,6,4,8,4,3,3,10] //==> 27
var numbers4 = [8,9,9,4,10,5,6,9,7,9] //==> 45

func rob(_ nums: [Int]) -> Int {
    
    if nums.count < 1 {
        return 0
    }
    
    var max1 = 0
    var max2 = 0

    for i in 0...nums.count-1 {
        
        if i % 2 == 0 {
            max1 = max(max1+nums[i], max2)
        } else {
            max2 = max(max2+nums[i], max1)
        }
    }
    
    return max(max1, max2)
}

rob(numbers)
rob(numbers2)
rob(numbers3)
rob(numbers4)
