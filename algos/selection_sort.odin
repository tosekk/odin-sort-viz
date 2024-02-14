package algos

import "core:fmt"
import "core:slice"


selection_sort :: proc(unsorted_arr: []i32) -> []i32 {
    for i in 0..=(len(unsorted_arr) - 1) {
        min_id := i

        for j in (i + 1)..=(len(unsorted_arr) - 1) {
            if unsorted_arr[j] < unsorted_arr[min_id] {
                min_id = j
            }
        }

        if min_id != i {
            slice.swap(unsorted_arr[:], min_id, i)
        }
    }

    return unsorted_arr[:]
}

selection_sort_recursive :: proc(unsorted_arr: []i32, head: int) {
    if head == len(unsorted_arr) {
        return
    }

    k: int = min_index(unsorted_arr, head, len(unsorted_arr) - 1)

    if k != head {
        slice.swap(unsorted_arr[:], head, k)
    }

    selection_sort_recursive(unsorted_arr[:], head + 1)
}