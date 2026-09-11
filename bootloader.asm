;===================================================
;           COPYRIGHT©️ 2026 NORTGH Inc.
;===================================================
;       USE OF THIS SOURCE CODE IS BY LICENSE
;
[BITS 16]; For now the OS uses the 16 bits Real Mode
[ORG 0x7C00]; Origin, tell the assembler that where the code will
; Main Entry

mov si, hello
CALL ps
jmp $           ; Infinite Loop(so the os cannot see something that he DONT need to see)
prch: ; PROC to print character on screen
;Assume that ASCII values is in the register AL

MOV ah, 0x0E    ; Telling BIOS we want to print character on screen
MOV BH, 0x00    ; Page No
MOV BL, 0x07    ; fg, bg and color to the text
INT 0x10
RET
ps:
next_char:
mov al, [SI]
inc si
or al, al
jz exit_func
call prch
jmp next_char
exit_func:
RET
;DATA

hello db "Hello, NortGhOS!", 0
TIMES 510 - ($ - $$) db 0   ; 512 KB(for os)
dw 0xAA55                   ; Of Course our bootloader signature(telling the pc that this is the os with the signature of 0xAA55)
