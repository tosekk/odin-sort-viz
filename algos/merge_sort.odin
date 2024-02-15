package algos

import "core:fmt"


merge_sort :: proc(arr: []i32, left: int, right: int) {
    if left < right {
        mid: int = left + (right - left) / 2

        merge_sort(arr[:], left, mid)
        merge_sort(arr[:], mid + 1, right)

        merge(arr[:], left, mid, right)
    }
}

merge :: proc(arr: []i32, left: int, mid: int, right: int) {
    n1: int = mid - left + 1
    n2: int = right - mid

    L: [dynamic]i32
    R: [dynamic]i32

    for i in 0..=(n1 - 1) {
        append(&L, arr[left + i])
    }

    for j in 0..=(n2 - 1) {
        append(&R, arr[mid + 1 + j])
    }

    i: int = 0
    j: int = 0
    k: int = left

    for (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i]
            i += 1
        }
        else {
            arr[k] = R[j]
            j += 1
        }
        k += 1
    }
 
    for (i < n1) {
        arr[k] = L[i]
        i += 1
        k += 1
    }
 
    for (j < n2) {
        arr[k] = R[j]
        j += 1
        k += 1
    }
}