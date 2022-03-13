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
    ;B4. A string of words S is given. Compute string D containing only high bytes multiple of 7 from string S.
    ;If S = 1735h, 0778h, 0E20h => D = 07h, 0Eh

    s dw 1735h,0778h,0E20h
    lens equ ($-s)/2
    sapte db 7
    d times lens db -3
    ; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov esi,1
    mov edi,0

    mov ecx,lens 
    
    myLoop:
        mov al,[s+esi]
        mov bl,al
        cbw
        idiv byte[sapte]
        cmp ah,0
            
            JE multiplu
            JNE nonMultiplu
            multiplu:
                mov [d+edi],bl
                inc edi
                add esi,2
                jmp endrep
            nonMultiplu:
                add esi,2
                
        endrep:
       loop myLoop
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
