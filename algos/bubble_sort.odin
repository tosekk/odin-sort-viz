package algos

import "core:slice"


bubble_sort :: proc(arr: []i32) {    
    for i in 0..=(len(arr) - 1) {
        swapped: bool = false

        for j in 0..=(len(arr) - i - 1) {
            if j >= (len(arr) - 1) {
                break
            }

            if arr[j] > arr[j + 1] {
                slice.swap(arr[:], j, j + 1)
                swapped = true
            }
        }

        if swapped == false {
            break
        }
    }
}

bubble_sort_recursive :: proc(arr: []i32) {
    if len(arr) <= 1 {
        return
    }
    
    count: int = 0

    for i in 0..=(len(arr) - 1) {
        if i >= (len(arr) - 1) {
            break
        }

        if arr[i] > arr[i + 1] {
            slice.swap(arr[:], i, i + 1)
            count += 1
        }
    }
    
    if count == 0 {
        return
    }

    bubble_sort_recursive(arr[:])
}