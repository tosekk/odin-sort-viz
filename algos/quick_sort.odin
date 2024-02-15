package algos

import "core:slice"


quick_sort :: proc(arr: []i32, low: int, high: int) {
    if low < high {
        pivot: int = partition(arr[:], low, high)

        quick_sort(arr[:], low, pivot - 1)
        quick_sort(arr[:], pivot + 1, high)
    }
}

partition :: proc(arr: []i32, low: int, high: int) -> int {
    pivot: i32 = arr[high]
    i: int = low - 1

    for j in low..=high {
        if arr[j] < pivot {
            i += 1
            slice.swap(arr[:], i, j)
        }
    }

    slice.swap(arr[:], i + 1, high)

    return i + 1
}
