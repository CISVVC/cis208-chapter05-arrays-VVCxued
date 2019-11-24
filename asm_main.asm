;
; file: asm_main.asm

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
        syswrite: equ 4
        stdout: equ 1
        exit: equ 1
        SUCCESS: equ 0
        kernelcall: equ 80h


array_size:	dd 5
array1		dd 1,2,3,4,5	;test array
scalarprompt:	dd 'What scalar? ',0



; uninitialized data is put in the .bss segment
;
segment .bss

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; *********** Start  Assignment Code *******************

	mov	eax,[array_size]
	push	eax
	push	array1
	
	call	mult_by_scalar
	
	add	esp,8		; removes scalar and array_size and array1 from stack
	
	mov	ecx,[array_size]
	push	esi
	mov	esi,array1

	cld

print_loop:
	lodsd
	call	print_int
	call	print_nl
	loop	print_loop		

	pop	esi

; *********** End Assignment Code **********************

        popa
        mov     eax, SUCCESS       ; return back to the C program
        leave                     
        ret




mult_by_scalar:
	enter	0,0
	pusha


	mov	eax,scalarprompt
	call	print_string
	call	read_int
	call	print_nl
	mov	ebx,eax
	
	
	mov	esi,[ebp+8]
	mov	edi,[ebp+8]
	mov	ecx,[ebp+12]


	cld	

mult_loop:
	lodsd
	mul	ebx
	stosd
	loop	mult_loop


	popa
	leave
	ret



