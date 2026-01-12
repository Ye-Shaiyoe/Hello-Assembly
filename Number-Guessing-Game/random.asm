; random.asm - Simple random number generator
; Menggunakan Linear Congruential Generator (LCG)

section .data
    seed dq 0

section .text
    global get_random
    global init_seed

; Inisialisasi seed dengan timestamp
; Input: none
; Output: none
init_seed:
    push rbp
    mov rbp, rsp
    
    ; Gunakan syscall time untuk mendapat timestamp
    mov rax, 201    ; syscall: time
    xor rdi, rdi    ; NULL pointer
    syscall
    
    ; Simpan sebagai seed
    mov [seed], rax
    
    pop rbp
    ret

; Generate random number dalam range
; Input: rdi = min, rsi = max
; Output: rax = random number
get_random:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    
    mov r12, rdi    ; simpan min
    mov r13, rsi    ; simpan max
    
    ; Cek apakah seed sudah diinit
    cmp qword [seed], 0
    jne .generate
    call init_seed
    
.generate:
    ; LCG formula: next = (a * seed + c) mod m
    ; a = 1103515245, c = 12345, m = 2^31
    mov rax, [seed]
    mov rbx, 1103515245
    mul rbx
    add rax, 12345
    and rax, 0x7FFFFFFF  ; mod 2^31
    mov [seed], rax
    
    ; Scale ke range [min, max]
    ; range = max - min + 1
    mov rbx, r13
    sub rbx, r12
    inc rbx
    
    xor rdx, rdx
    div rbx         ; rdx = seed % range
    mov rax, rdx    ; ambil remainder
    add rax, r12    ; + min
    
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret