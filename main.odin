package main

import "core:fmt"
import "core:slice"


main :: proc() {
    unsorted := [?]i32{12, 65, 11, 24, 37, 9}

    // selection_sort_recursive(unsorted[:], 0)
    bubble_sort_recursive(unsorted[:])

    fmt.println(unsorted)
}

min_index :: proc(arr: []i32, i: int, j: int) -> int {
    if i == j {
        return i
    }

    k: int = min_index(arr, i + 1, j)

    return arr[i] < arr[k] ? i : k
}