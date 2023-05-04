; Compile with - nasm -f elf stringcomparer.asm
; Link with - ld -m elf_i386 stringcomparer.o -o stringcomparer
; Run with -./stringcomparer

section .data
    str1 db "hello", 0
    str2 db "hello", 0
    equal_msg db "Strings are equal", 0h
    not_equal_msg db "Strings are not equal", 0h

section .text
    global _start

_start:

    mov esi, str1 ; source index
    mov edi, str2 ; destination index
    mov ecx, 5    ; counter register

    repe cmpsb       ; compare until end of string or mismatch and values are loaded from esi and edi registers

    je strings_equal ; jump if both strings are equal

strings_not_equal:
    ; print message indicating that the strings are not equal
    mov eax, 4          
    mov ebx, 1          
    mov ecx, not_equal_msg   
    mov edx, 21         
    int 0x80            

    ; exit the program
    mov eax, 1         
    xor ebx, ebx       
    int 0x80           

strings_equal:
    ; print message indicating that the strings are equal
    mov eax, 4         
    mov ebx, 1         
    mov ecx, equal_msg 
    mov edx, 17        
    int 0x80           

    ; exit the program
    mov eax, 1          
    xor ebx, ebx        
    int 0x80            
