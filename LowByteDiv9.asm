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
   ; B5. A string of words S is given. Compute string D containing only low bytes multiple of 9 from string S.
   ;  If S = 3812h, 5678h, 1a09h => D = 12h, 09h
   s dw 3812h, 5678h,1a09h
   lens equ ($-s)/2
   d resb lens
   zece db 9
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
    mov esi,0
    mov edi,0
    mov ecx,lens
    
    myLoop:
        mov al,[s+esi]
        mov bl,al
        cbw ;
        idiv byte[zece]
        cmp ah,0
            JE divizibil
            JNE nedivizibil
            
            divizibil:
                mov [d+edi],bl
                add esi,2
                inc edi
                jmp endLoop
            nedivizibil:
                add esi,2
           
           endLoop:     
       loop myLoop
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
