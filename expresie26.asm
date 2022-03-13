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

    ;(a*a+b/c-1)/(b+c)+d;
    ; a-word; b-byte; c-word; d-doubleword;
    a dw 0 
    b db 1
    c dw 1
    d dd 10
    aux resw 0
    bux resd 0
    
    ; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov al,byte[b]
    cbw
    cwd
    mov bx,word[c]
    idiv bx
    ;ax-> cat
    mov bl,1
    mov bh,0
    sub ax,bx
    mov ax,word[a]
    mov word[aux],ax
    mov ax,word[a]
    imul word[a]
    ;dx:ax a*a 
    mov [bux+0],ax
    mov [bux+2],dx
    mov ecx,dword[bux]
    mov ax,word[aux]
    cwde
    sub eax,ecx
    mov al,byte[b]
    cbw
    sub ax,word[b]
    mov bx,ax
    mov dword[bux],eax
    mov ax,word[bux+0]
    mov dx,word[bux+2]
    idiv bx
    cwde 
    mov ebx , dword[d]
   ; add eax,ebx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
