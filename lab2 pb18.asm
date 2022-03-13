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
    ;19. [(a-b)*3+c*2]-d/4
    a db 11
    b db 2
    c db 3
    d dw 20
    aux dw 0; or we can use aux resw 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;a-b
        mov al,[a]
        sub al,[b];al=a-b
        mov bl,3 
        mul bl; ax=(a-b)*3
        mov [aux],ax; aux = (a-b)*3 (word)
        mov al,2
        mul byte[c]; ax=c*2;
        ;aux + ax
        ;word + word
        mov bx,[aux]
        add bx,ax; bx=(a-b)*3+c*2
        ; d/4
        ;word/const
        mov ax,[d];
        mov cl, 4
        div cl; ax/cl =al quotient and in ah remainder
        
        ;[(a-b)*3+c*2]-d/4
        movzx dx,al; dx=d/4
        sub bx,dx; bx=final result
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
