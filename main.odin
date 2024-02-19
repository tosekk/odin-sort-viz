package main

import "core:fmt"
import la "core:math/linalg"
import "core:slice"

import rl "vendor:raylib"

import "sorting"


// Constants
SCREEN_WIDTH: i32: 800
SCREEN_HEIGHT: i32: 450
SCREEN_BG_COLOR: rl.Color: {241, 250, 238, 255}
BASE_COLOR: rl.Color: {29, 53, 87, 255}
HIGHLIGHT_COLOR: rl.Color: {69, 123, 157, 255}
REC_GUTTER: f32 = 10
REC_MARGIN: f32 = 60

// Enums
Sort :: enum {
    BUBBLE_SORT = 0,
    INSERTION_SORT,
    MERGE_SORT,
    QUICK_SORT,
    SELECTION_SORT,
}



main :: proc() {
    unsorted := randomizeArray(rl.GetRandomValue(6, 30), 1, 200)

    // Screen settings
    screenCenter: la.Vector2f32 = {f32(SCREEN_WIDTH / 2), f32(SCREEN_HEIGHT / 2)}
    screenTitle: cstring = "Sorting algorithms visualizer"
    SCREEN_BG_COLOR: rl.Color = {241, 250, 238, 255}

    // Camera settings
    camera: rl.Camera2D = { 0, 0, 0, 0 }
    camera.offset = {screenCenter.x, screenCenter.y}
    camera.target = {screenCenter.x, screenCenter.y}
    camera.rotation = 0.0
    camera.zoom = 1.0

    rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, screenTitle)

    // Sorting
    sortActive: Sort = Sort.BUBBLE_SORT
    frameCounter: int = 0
    sortComplete: bool = false

    // Button
    sortButton: rl.Rectangle = {12, 40, 140, 48}
    sortButtonClicked: bool = false
    sortButtonDetails := [3]i32{55, 12+40, 24}

    randomizeButton: rl.Rectangle = {12 + sortButton.width + sortButton.x, sortButton.y, 200, 48}
    randomizeButtonClicked: bool = false
    randomizeButtonDetails := [3]i32{55+12+i32(sortButton.width), 12+40, 24}

    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {
        // Update executes here
        // --------------------
        frameCounter += 1

        if rl.IsMouseButtonPressed(rl.MouseButton.LEFT) {
            mousePos: la.Vector2f32 = rl.GetMousePosition()

            sortButtonClicked = rl.CheckCollisionPointRec(mousePos, sortButton)
            randomizeButtonClicked = rl.CheckCollisionPointRec(mousePos, randomizeButton)

            if sortButtonClicked && !sortComplete {
                sortArray(unsorted[:], sortActive)
                sortComplete = true
            }

            if randomizeButtonClicked {
                unsorted = randomizeArray(rl.GetRandomValue(6, 30), 1, 200)
                sortComplete = false
            }
        }

        if rl.IsMouseButtonReleased(rl.MouseButton.LEFT) {
            randomizeButtonClicked = false
        }

        if rl.IsKeyPressed(rl.KeyboardKey.ONE) {
            sortActive = Sort.BUBBLE_SORT
        } else if rl.IsKeyPressed(rl.KeyboardKey.TWO) {
            sortActive = Sort.INSERTION_SORT
        } else if rl.IsKeyPressed(rl.KeyboardKey.THREE) {
            sortActive = Sort.MERGE_SORT
        } else if rl.IsKeyPressed(rl.KeyboardKey.FOUR) {
            sortActive = Sort.QUICK_SORT
        } else if rl.IsKeyPressed(rl.KeyboardKey.FIVE) {
            sortActive = Sort.SELECTION_SORT
        }

        if sortComplete {
            sortButtonClicked = false
        }
        // --------------------

        // Drawing starts here
        // --------------------
        rl.BeginDrawing()
            rl.ClearBackground(SCREEN_BG_COLOR)

            rl.BeginMode2D(camera)
                drawElements(unsorted[:], false, 0)

                switch sortActive {
                    case Sort.BUBBLE_SORT:
                        rl.DrawText("Sorting algorithm: Bubble sort", 12, 12, 24, BASE_COLOR)
                    case Sort.INSERTION_SORT:
                        rl.DrawText("Sorting algorithm: Insertion sort", 12, 12, 24, BASE_COLOR)
                    case Sort.MERGE_SORT:
                        rl.DrawText("Sorting algorithm: Merge sort", 12, 12, 24, BASE_COLOR)
                    case Sort.QUICK_SORT:
                        rl.DrawText("Sorting algorithm: Quick sort", 12, 12, 24, BASE_COLOR)
                    case Sort.SELECTION_SORT:
                        rl.DrawText("Sorting algorithm: Selection sort", 12, 12, 24, BASE_COLOR)
                }

                drawButton(sortButton, "Sort", sortButtonDetails[:], sortButtonClicked)
                drawButton(randomizeButton, "Randomize", randomizeButtonDetails[:], randomizeButtonClicked)
                
            rl.EndMode2D()
        rl.EndDrawing()
        // --------------------
    }

    rl.CloseWindow()
}

sortArray :: proc(unsorted: []i32, sortAlgorithm: Sort) {
    switch sortAlgorithm {
        case Sort.BUBBLE_SORT:
            bubbleSort(unsorted[:])
        case Sort.INSERTION_SORT:
            insertionSort(unsorted[:])
        case Sort.MERGE_SORT:
            mergeSort(unsorted[:], 0, len(unsorted) - 1)
        case Sort.QUICK_SORT:
            quickSort(unsorted[:], 0, len(unsorted) - 1)
        case Sort.SELECTION_SORT:
            selectionSort(unsorted[:])
        case:
            fmt.println("Unexpected token!")
    }
}

randomizeArray :: proc(size, min, max: i32) -> []i32 {
    arr: [dynamic]i32

    for i in 0..=size {
        append(&arr, rl.GetRandomValue(min, max))
    }

    return arr[:]
}