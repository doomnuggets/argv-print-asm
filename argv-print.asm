BITS 32

section .data
    arg_str db "Argument %d: %s", 0x0a, 0x00
    usage_str db "Usage: %s <arguments>", 0x0a, 0x00
    counter dd 0x00

section .text
    global _start
    extern printf

    _start:
        pop eax         ; Load argc
        cmp eax, 0x01   ; At least 1 commandline argument is required.
        pop ebx         ; Load argv ptr into ebx
        je usage        ; Show the usage if the argument count is 1 (no arguments were passed).
        push ebx        ; Move the ptr back to the stack.
        mov esi, esp    ; Save the stack pointer (which holds the commandline arguments)
        jmp loop_head

    loop_head:
        push dword [esi]       ; Push argv[n]. we use [] to dereference the pointer which leads to our string.
        push dword [counter]   ; Push n; the value for the n-th argument.
        push arg_str           ; Push format string: "Argument %d: %s\n"
        call printf            ; printf("Argument %d: %s\n", n, argv[n]); ...
        inc dword [counter]    ; Increment the counter
        add esi, 0x04          ; Increment the pointer of argv[n] to load the next one.
        cmp dword [esi], 0x00  ; Check if the next argv is null
        jne loop_head          ; If not, jump up.
        jmp exit

    usage:
        push ebx         ; push the program name (argv[0])
        push usage_str   ; push the format string.
        call printf      ; printf("Usage: %s <arguments>\n", argv[0])
        jmp exit

    exit:
        mov eax, 0x01
        mov ebx, 0x00
        int 0x80
