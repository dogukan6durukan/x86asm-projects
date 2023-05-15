; Compile with - nasm -f elf stringcomparer.asm
; Link with - ld -m elf_i386 stringcomparer.o -o stringcomparer
; Run with - ./stringcomparer

; Program result - "Strings are not equal"

section .data
    str1 db "hello1", 0
    str2 db "hello2", 0
    equal_msg db "Strings are equal", 0
    equal_msg_lng equ $-equal_msg

    not_equal_msg db "Strings are not equal", 0
    not_equal_msg_lng equ $-not_equal_msg

    lng_not_equal db "String lengths are not equal", 0
    lng_not_equal_lng equ $-lng_not_equal

section .text
global _start

_start:
    mov eax, str1
    mov edx, eax

    mov ebx, str2
    mov ecx, ebx

    ; STRING LENGTH COMPARING
    find_str_length1:
        cmp byte [eax], 0
        jz finished_str1
        inc eax
        jmp find_str_length1

    finished_str1:
        sub eax, edx
        push eax

    find_str_length2:
        cmp byte [ebx], 0
        jz finished_str2
        inc ebx
        jmp find_str_length2

    finished_str2:
        sub ebx, ecx
        push ebx

    length_compare:
        pop ebx
        pop eax
        cmp eax, ebx
        je string_compare

    write_lng_not_equal:
        ; Print message indicating that the strings lengths are not equal
        mov edx, lng_not_equal_lng
        mov ecx, lng_not_equal
        jmp print_message

    ; STRING COMPARING
    string_compare:
        mov esi, str1 ; Source index
        mov edi, str2 ; Destination index
        mov ecx, eax  ; Counter register

        repe cmpsb    ; Compare when they are equal
        je strings_equal 

        cmp byte [esi], 0
        jne strings_not_equal

    strings_not_equal:
        ; Print message indicating that the strings are not equal
        mov edx, not_equal_msg_lng
        mov ecx, not_equal_msg
        jmp print_message

    strings_equal:
        ; Print message indicating that the strings are equal
        mov edx, equal_msg_lng
        mov ecx, equal_msg
        jmp print_message

    ; MESSAGE PRINTING
    print_message:
        mov ebx, 1
        mov eax, 4
        int 0x80

        ; exit the program
        mov eax, 1
        xor ebx, ebx
        int 0x80    
