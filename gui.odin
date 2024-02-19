package main

import la "core:math/linalg"

import rl "vendor:raylib"


drawButton :: proc(button: rl.Rectangle, text: cstring, textDetails: []i32, clicked: bool) {
    if clicked {
        rl.DrawRectangleRec(button, HIGHLIGHT_COLOR)
    } else {
        rl.DrawRectangleRec(button, BASE_COLOR)
    }
    rl.DrawText(text, textDetails[0], textDetails[1], textDetails[2], SCREEN_BG_COLOR)
}

drawElement :: proc(arr: []i32, i: int) {
    recWidth: f32 = ((f32(SCREEN_WIDTH) - (REC_MARGIN * 2)) - f32(len(arr) - 1) * REC_GUTTER) / f32(len(arr))

    recPosX: f32 = REC_MARGIN + REC_GUTTER * f32(i) + recWidth * f32(i)
    recPosY: f32 = f32(SCREEN_HEIGHT - arr[i])
    
    rl.DrawRectangleRec(rl.Rectangle{recPosX, recPosY, recWidth, f32(arr[i])}, HIGHLIGHT_COLOR)
}

drawElements :: proc(arr: []i32, highlighted: bool, j: int) {
    recWidth: f32 = ((f32(SCREEN_WIDTH) - (REC_MARGIN * 2)) - f32(len(arr) - 1) * REC_GUTTER) / f32(len(arr))

    for id in 1..=len(arr) {
        recPosX: f32 = REC_MARGIN + REC_GUTTER * f32(id - 1) + recWidth * f32(id - 1)
        recPosY: f32 = f32(SCREEN_HEIGHT - arr[id - 1])

        rl.DrawRectangleRec(rl.Rectangle{recPosX, recPosY, recWidth, f32(arr[id - 1])}, BASE_COLOR)
    }
}