package main

import "core:math"
import "core:slice"

import rl "vendor:raylib"


bubbleSort :: proc(arr: []i32) {    
    if len(arr) <= 1 {
        return
    }

    for i in 0..=(len(arr) - 1) {
        swapped: bool = false

        for j in 0..=(len(arr) - i - 1) {
            if j >= len(arr) - 1 {
                break
            }
            
            if j + 1 <= (len(arr) - 1) {
                drawElement(arr[:], j)
                drawElement(arr[:], j + 1)
            } 

            if arr[j] > arr[j + 1] {
                slice.swap(arr[:], j, j + 1)
                swapped = true
            }
        }

        if !swapped {
            break
        }
    } 
}

insertionSort :: proc(arr: []i32) {
    for i in 0..=(len(arr) - 1) {
        key: i32 = arr[i]
        j: int = i - 1

        drawElement(arr[:], i)

        for j >= 0 && arr[j] > key {
            arr[j + 1] = arr[j]

            drawElement(arr[:], j)
            drawElement(arr[:], j + 1)
            
            j = j - 1
        }

        arr[j + 1] = key
    }
}

mergeSort :: proc(arr: []i32, left: int, right: int) {
    if left < right {
        mid: int = left + (right - left) / 2

        mergeSort(arr[:], left, mid)
        mergeSort(arr[:], mid + 1, right)

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
        drawElement(arr[:], k)
        k += 1
    }
    
    for (i < n1) {
        arr[k] = L[i]
        i += 1
        drawElement(arr[:], k)
        k += 1
    }
    
    for (j < n2) {
        arr[k] = R[j]
        j += 1
        drawElement(arr[:], k)
        k += 1
    }
}

quickSort :: proc(arr: []i32, low: int, high: int) {
    if low < high {
        pivot: int = partition(arr[:], low, high)

        quickSort(arr[:], low, pivot - 1)
        quickSort(arr[:], pivot + 1, high)
    }
}

partition :: proc(arr: []i32, low: int, high: int) -> int {
    pivot: i32 = arr[high]
    i: int = low - 1
    
    
    for j in low..=high {
        drawElement(arr[:], j)
        if arr[j] < pivot {
            i += 1
            drawElement(arr[:], i)
            slice.swap(arr[:], i, j)
        }
    }

    drawElement(arr[:], high)
    slice.swap(arr[:], i + 1, high)

    return i + 1
}

selectionSort :: proc(arr: []i32) {
    for i in 0..=(len(arr) - 1) {
        min_id := i

        drawElement(arr[:], i)
        
        for j in (i + 1)..=(len(arr) - 1) {
            drawElement(arr[:], j)
            if arr[j] < arr[min_id] {
                min_id = j
            }
        }

        if min_id != i {
            slice.swap(arr[:], min_id, i)
        }
    }
}