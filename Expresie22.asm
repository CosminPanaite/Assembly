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
  ;second expression: a/2+b*b-a*b*c+e; a,b,c-byte; e-doubleword; =0 + 1 + 0 + 3=4

  a db 0
  b db 1
  c db 2
  e dd 2
  aux resb 0
  bux resb 0
  cux resw 0
  dux resd 0
  ; our code starts here
segment code use32 class=code
    start:
        ; ...
        
    mov al,byte[a]
    cbw
    mov byte[aux],2
    idiv byte[aux] 
    mov byte[aux],al ;quotient
    mov al,byte[b]
    mov bl, byte[b]
    imul bl
    ;ax b*b
    movsx bx,byte[aux]
    add ax,bx
    mov word[cux],ax
    mov al,byte[b]
    mov bl,byte[a]
    imul bl
    movsx bx,byte[c]
    imul bx
    ;dx:ax a*b*c
    mov [dux+0],ax
    mov [dux+2],dx
    mov ecx,dword[e]
    add ecx,dword[dux]
    movsx eax,word[cux]
    add eax,ecx

    ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
