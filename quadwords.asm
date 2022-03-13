; A string of quadwords is given in data segment.
; Extract all bytes equal to a byte X (also defined in data segment) into string D.
bits 32 ; assembling for the 32 bits architecture
global start        
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
segment data use32 class=data
s dq 1122334455667788h, 1a2b3c4d5e6f3333h
ls equ ($-s)/8 ; 1 quad = 8 bytes

x db 33h

d  times ls*8 db  -1

segment code use32 class=code
    start:
        mov ecx, ls*8  ; 16 = 2 quad = 16 bytes
        mov esi, 0 ; s
        mov edi, 0; d
        repeta:
            mov al, byte[s+esi]
            cmp al, byte[x]
            JE addinR
            JNE next
            
                addinR:
                    mov [d+edi], al
                    inc edi
                    inc esi
                    
                    jmp end_repeta
                next:
                    inc esi
        end_repeta:
        loop repeta
        
       
       
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
