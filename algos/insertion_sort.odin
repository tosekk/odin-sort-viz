package algos


insertion_sort :: proc(arr: []i32) {
    for i in 0..=(len(arr) - 1) {
        key: i32 = arr[i]
        j: int = i - 1

        for j >= 0 && arr[j] > key {
            arr[j + 1] = arr[j]
            j = j - 1
        }

        arr[j + 1] = key
    }
}

binary_insertion_sort :: proc(arr: []i32) {
    for i in 0..=(len(arr) - 1) {
        key: i32 = arr[i]
        j: int = i - 1

        id: int = binary_search(arr, key, 0, j)

        for j >= id {
            arr[j + 1] = arr[j]
            j -= 1
        }

        arr[j + 1] = key
    }
}

binary_search :: proc(arr: []i32, item: i32, low: int, high: int) -> int {
    if high <= low {
        return item > arr[low] ? low + 1 : low
    }

    mid: int = (low + high) / 2

    if item == arr[mid] {
        return mid + 1
    }

    if item > arr[mid] {
        return binary_search(arr, item, mid + 1, high)
    }

    return binary_search(arr, item, low, mid - 1)
}