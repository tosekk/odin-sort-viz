package main

import "core:fmt"
import la "core:math/linalg"

import rl "vendor:raylib"

import "algos"


main :: proc() {
    // Window settings
    screenWidth: i32 = 800
    screenHeight: i32 = 450
    windowCenter: la.Vector2f32 = {f32(screenWidth / 2.0), f32(screenHeight / 2.0)}
    windowTitle: cstring = "Sorting algorithms visualizer"

    // Camera settings
    camera: rl.Camera2D = { 0, 0, 0, 0 }
    camera.offset = {windowCenter.x, windowCenter.y}
    camera.target = {windowCenter.x, windowCenter.y}
    camera.rotation = 0.0
    camera.zoom = 1.0

    rl.InitWindow(screenWidth, screenHeight, windowTitle)

    // Rectangle settings
    rec: rl.Rectangle = {windowCenter.x, f32(screenHeight - 200), 50, 200}
    baseColor: rl.Color = {0, 119, 182, 255}
    selectedColor: rl.Color = {144, 224, 239, 255}

    // Collision
    collision: bool = false

    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {
        // Update executes here
        // --------------------
        if rl.IsMouseButtonPressed(rl.MouseButton.LEFT) {
            mousePos := rl.GetMousePosition()

            collision = rl.CheckCollisionCircleRec(mousePos, 2.0, rec)
        }

        if rl.IsMouseButtonPressed(rl.MouseButton.RIGHT) {
            collision = false
        }
        // --------------------

        // Drawing starts here
        // --------------------
        rl.BeginDrawing()
            rl.ClearBackground(rl.RAYWHITE)

            rl.BeginMode2D(camera)
            // Screen's x=0, y=0 position is at the top left corner of the window.
            // To place the rectangle at the bottom of the window
            // posY = screenHeight - rectHeight
                if collision {
                    rl.DrawRectangleRec(rec, selectedColor)
                } else {
                    rl.DrawRectangleRec(rec, baseColor)
                }
                rl.EndMode2D()
        rl.EndDrawing()
        // --------------------
    }

    rl.CloseWindow()
}
