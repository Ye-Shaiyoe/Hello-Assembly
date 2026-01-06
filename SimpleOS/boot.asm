; boot.asm - Simple Bootloader
[BITS 16]
[ORG 0x7C00]

start:
    ; Setup segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Print loading message
    mov si, msg_loading
    call print_string

    ; Load kernel from disk (sector 2+)
    mov ah, 0x02        ; Read sectors
    mov al, 10          ; Number of sectors to read
    mov ch, 0           ; Cylinder 0
    mov cl, 2           ; Start from sector 2
    mov dh, 0           ; Head 0
    mov bx, 0x1000      ; Load to 0x1000
    int 0x13
    jc disk_error

    ; Jump to kernel
    jmp 0x1000

disk_error:
    mov si, msg_error
    call print_string
    hlt

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

msg_loading db 'Loading SimpleOS...', 13, 10, 0
msg_error db 'Disk error!', 13, 10, 0

times 510-($-$$) db 0
dw 0xAA55