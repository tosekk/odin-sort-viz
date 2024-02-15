package main

import "core:fmt"

import rl "vendor:raylib"

import "algos"


main :: proc() {
    screenWidth: i32 = 800
    screenHeight: i32 = 450
    windowTitle: cstring = "Sorting algorithms visualizer"

    rl.InitWindow(screenWidth, screenHeight, windowTitle)

    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
            rl.ClearBackground(rl.RAYWHITE)
            rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY)

            rl.DrawRectangle(0, 250, 100, 200, rl.BLUE)
        rl.EndDrawing()
    }

    rl.CloseWindow()
}
