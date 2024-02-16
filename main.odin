package main

import "core:fmt"
import la "core:math/linalg"

import rl "vendor:raylib"

import "algos"


main :: proc() {
    unsorted := [6]i32{34, 12, 65, 11, 9, 23}

    // Screen settings
    screenWidth: i32 = 800
    screenHeight: i32 = 450
    screenCenter: la.Vector2f32 = {f32(screenWidth / 2), f32(screenHeight / 2)}
    screenTitle: cstring = "Sorting algorithms visualizer"
    screenBackgroundColor: rl.Color = {241, 250, 238, 255}


    // Camera settings
    camera: rl.Camera2D = { 0, 0, 0, 0 }
    camera.offset = {screenCenter.x, screenCenter.y}
    camera.target = {screenCenter.x, screenCenter.y}
    camera.rotation = 0.0
    camera.zoom = 1.0

    rl.InitWindow(screenWidth, screenHeight, screenTitle)

    // Rectangle settings
    recs: [dynamic]rl.Rectangle
    colors: [dynamic]rl.Color
    recGutter: f32 = 20
    recMargin: f32 = 120
    recWidth: f32 = ((f32(screenWidth) - (recMargin * 2)) - f32(len(unsorted) - 1) * recGutter) / f32(len(unsorted))

    baseColor: rl.Color = {29, 53, 87, 255}
    selectedColor: rl.Color = {69, 123, 157, 255}

    for id in 1..=len(unsorted) {
        recPosX: f32 = recMargin + recGutter * f32(id - 1) + recWidth * f32(id)
        recPosY: f32 = f32(screenHeight - unsorted[id - 1])

        append(&recs, rl.Rectangle{recPosX, recPosY, recWidth, f32(unsorted[id - 1])})
        append(&colors, baseColor)
    }

    // Collision
    collision: bool = false
    selectedRec: int = -1

    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {
        // Update executes here
        // --------------------

        if rl.IsMouseButtonPressed(rl.MouseButton.LEFT) {
            mousePos: la.Vector2f32 = rl.GetMousePosition()
            previousSelectedRec: int = selectedRec

            for id in 0..=(len(recs) - 1) {
                collision = rl.CheckCollisionPointRec(mousePos, recs[id])

                if collision {
                    selectedRec = id
                    break
                } else {
                    selectedRec = -1
                }
            }

            if previousSelectedRec != -1 && previousSelectedRec != selectedRec {
                colors[previousSelectedRec] = baseColor
            }

            if selectedRec != -1 {
                colors[selectedRec] = selectedColor
            }
        }

        if rl.IsMouseButtonPressed(rl.MouseButton.RIGHT) {
            collision = false

            if selectedRec != -1 {
                colors[selectedRec] = baseColor
                selectedRec = -1
            }
        }
        // --------------------

        // Drawing starts here
        // --------------------
        rl.BeginDrawing()
            rl.ClearBackground(screenBackgroundColor)

            rl.BeginMode2D(camera)
            // Screen's x=0, y=0 position is at the top left corner of the window.
            // To place the rectangle at the bottom of the window
            // posY = screenHeight - rectHeight

                for id in 0..=(len(recs) - 1) {
                    rl.DrawRectangleRec(recs[id], colors[id])
                }
            rl.EndMode2D()
        rl.EndDrawing()
        // --------------------
    }

    rl.CloseWindow()
}
