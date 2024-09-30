    org 0x0100

start:
    mov ax, 0x0002
    int 0x10

    mov ax, 0xb800
    mov es, ax
    cld

    push 0x3800
    push 0x1125
    push 44
    push 160 * 5
    call draw_box

    mov ah, 0x38
    mov bp, title_string
    mov cx, 64 + 8 * 160
    call print_string

    jmp exit

title_string: db "hello world!", 0

    ; draw_box function
    ; Parameters:
    ;   [bp+2] - row offset
    ;   [bp+4] - column offset
    ;   [bp+6] - box dimensions (H: height, L: width)
    ;   [bp+8] - char & color
draw_box:
    mov bp, sp      ; Get the stack base
    mov di, [bp+2]  ; Set DI to the row offset

    mov dx, [bp+6]
    mov ax, [bp+8]
    mov bl, dh

    xor ch, ch
    mov cl, dl
    add di, [bp+4]
    rep stosw

    add word [bp+2], 160    ; Add a line (160 bytes) to offset
    sub byte [bp+7], 0x01   ; Remove one line of height
    mov cx, [bp+6]
    cmp ch, 0
    jnz draw_box
    ret

    ; print_string function
    ; Params:
    ;    AH - background/foreground color
    ;    BP - string addr
    ;    CX - position/offset
print_string:
    mov di, cx
    mov al, byte [bp]
    cmp al, 0
    jz _0
    stosw
    add cx, 2
    inc bp
    jmp print_string
_0:
    ret

exit:
    int 0x20

