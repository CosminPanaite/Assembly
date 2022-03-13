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
    ;a*[b+c+d/b]+d data types: a,b,c - byte, d - word
    a db 5
    b db 3
    c db 2
    d dw 6
    result resw 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;d/b we can do the division
        mov ax,word [d]
        div byte [b]
        ; al=d/b ->quotient ah->remainder
        add al,byte [b]
        add al,byte [c] ;al=b+c+d/b
        mul byte [a] 
        add ax,word [d];final result 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
