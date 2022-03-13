bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    ;c-5 + (a*b)
    a db 4
    b dw 2
    c db 9
    aux resd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov cl,byte[c]
    mov dl,5
    sub cl,dl
    mov al,byte[a]
    cbw; in ax = 4
    imul word[b] ;dx:ax=4*9
    mov [aux+0],ax
    mov [aux+2],dx
    
    mov ax ,0
    mov al , cl
    cbw 
    cwde
    add eax,dword[aux]
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
