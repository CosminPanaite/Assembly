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
    a dw 2 
    b db 5
    c db 0 
    e dd 0
    aux resd 0
    aux2 resw 0
    ; our code starts here
segment code use32 class=code
    start:
        ; ...
    ; a*b-(100-c)/(b*b)+e; a-word; b,c-byte; e-doubleword;
    mov al,byte[b]
    cbw
    imul word[a]
    ;dx:ax -> a * b
    mov [aux+0],ax
    mov [aux+2],dx
    mov al,100
    mov bl,byte[c]
    sub al,bl
    mov cl,al
    mov al,byte[b]
    imul byte[b]
    ;ax=b*b
    mov word[aux2],ax
    mov al,cl
    cbw
    cwd
    idiv word[aux2]
    ;ax-quotient
    cwde;eax-quotient
    mov ebx,dword[aux2]
    add eax,ebx
    add eax,dword[e]
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
