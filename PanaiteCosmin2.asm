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
    a db 1,2,3,7,14,-7
    lena equ ($-a)
    b db 7,21,4
    lenb equ ($-b)
    d times lena+lenb db 0
    sapte db 7
; our code starts here
segment code use32 class=code
    start:
        ; ...

    mov esi ,0
    mov edi ,0
    mov ecx , lena
    myLoop1:
        mov al , [a+esi]
        mov bl,al
        cmp al,0
            JG pozitiv
            JL negativ
                negativ:
                    inc esi
                    jmp final
           pozitiv :
                cbw
                idiv byte[sapte]
                   
                   cmp ah,0
                        JE multiplu7
                        JNE nonmultiplu
                        multiplu7:
                            mov [d+edi],bl
                            
                            inc esi
                            inc edi
                            jmp final
                        nonmultiplu :
                            inc esi
                            
                             
            
            final:
           loop myLoop1
        
    
    mov esi ,0
    mov edi ,0
    mov ecx , lenb
    myLoop2:
        mov al , [b+esi]
        mov bl, al
        cmp ah,0
            JGE pozitiv2
            JL negativ2
                negativ2:
                    inc esi
                    jmp final2
           pozitiv2 :
                
                cbw
                idiv byte[sapte]
                   
                   cmp ah,0
                        JE multiplu72
                        JNE nonmultiplu2
                        multiplu72:
                            mov [d+edi],bl
                            
                            inc esi
                            inc edi
                            jmp final2
                        nonmultiplu2 :
                            inc esi
                             
            
            final2:
           loop myLoop2
        
    
; ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
