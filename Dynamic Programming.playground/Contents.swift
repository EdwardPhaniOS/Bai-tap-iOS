import UIKit

var str = "Hello, playground"

//Dynamic Programming: Caching, Optimization
//Lap trinh dong: Co luu tru du lieu tam thoi trong/ ngoai ham (uu tien luu tam trong ham) de tang toc do tinh toan

//Recursive: La ham tu goi chinh no voi tham so da duoc lam` nho (-, /) sau moi lan goi
//Tu van de lon chia thanh cac van de nho.

//Ta se han che su dung De quy (Recursive) vi no xu ly ton thoi gian (2^n), kho doc (doi voi ta va mot so lap trinh vien), nhung khi can phai dung De quy (BFS, DFS, create Tree,...) thi ta se su dung De quy, ket hop voi Dynamic Programming neu can thiet hoac neu co du thoi gian, nguon luc

//Time: O(n^2)
func fibonacci(n: Int) -> Int {
    
    //Base case
    if n < 2 {
        return n
    }
    
    //Recursive case
    return fibonacci(n: n-1) + fibonacci(n: n-2)
}

var result = 0
var cache: [Int : Int] = [Int: Int]()

//Time: O(n)
func dynamicFibonacci(n: Int) -> Int {
    //Top down: Tu van de lon chia thanh cac van de nho roi giai quyet cac van de nho truoc
    
    if let number = cache[n] {
        return number
    } else {
        
        if n < 2 {
            cache[n] = n
            return n
        } else {
            cache[n] = fibonacci(n: n-1) + fibonacci(n: n-2)
            let result = cache[n]!
            cache.removeAll()
            return result
        }
    }
}

//fibonacci(n: 20) //Xy ly 21896 tinh toan
//dynamicFibonacci(n: 20) //Xu ly 6765 tinh toan


//Time: O(n)
func betterDynamicFibonacci(n: Int) -> Int {
    var dict = [Int : Int]()
    return fib(n: n, cache: &dict)
}

func fib(n: Int, cache: inout [Int : Int]) -> Int {
    
    if let number = cache[n] {
        print("Fast method: \(number)")
        return number
    } else {
        if n < 2 {
            cache[n] = n
            return n
        } else {
            cache[n] = fibonacci(n: n-1) + fibonacci(n: n-2)
            return cache[n]!
        }
    }
}

fibonacci(n: 20) //Xy ly 21896 tinh toan
betterDynamicFibonacci(n: 20) //Xu ly 6765 tinh toan

func betterDynamicFibonacci2(n: Int) -> Int {
    //Bottom up solution: Di thang tu van de nho o duoi day len van de lon o tren cao
    var arr = [0, 1]
    
    if n < 2 {
        return arr[n]
    }
    
    for i in 2...n {
        let nextNumber = arr[i-1] + arr[i-2]
        arr.append(nextNumber)
    }
    
    return arr.last!
}

betterDynamicFibonacci2(n: 20) //Xu ly 6765 tinh toan
