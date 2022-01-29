Comment /
Written by: Kim Sumi (20181202)
Function:	Repeats every char in string for k times
Input:		input txt file (redirection)
Output:		ouput txt file (redirection)
/

TITLE		HW6_CSE3030
INCLUDE		Irvine32.inc

;==================================================
;---------------- Data Declaration ----------------
;==================================================
.data
stdinHandle		HANDLE	?
stdoutHandle	HANDLE	?
BUF_SIZE		EQU		256
inBuf			BYTE	BUF_SIZE DUP (?)
bytesREAD		DWORD ?
outBuf			BYTE	BUF_SIZE DUP (?)
bytesWRITE		DWORD ?

;==================================================
;---------------- Code Declaration ----------------
;==================================================
.code
main	PROC
	;------- set HANDLE to read/write files -------
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov stdinHandle, eax
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov stdoutHandle, eax

	Start:
		;--------- Get input (input file) ---------
		mov		eax, stdinHandle
		mov		edx, OFFSET inBuf
		call	Read_a_Line
		cmp		ecx, 0
		je		Finish					;empty string -> end program

		;--------- Get data from string ---------
		mov		edx, OFFSET inBuf		;edx = one line of input file
		movzx	eax, BYTE PTR [edx]		;eax = first letter of 'line'
		cmp		eax, 48					;not empty but only ' ' -> end program
		jb		Finish

		sub		eax, 48					;eax = k
		push	eax						
		mov		edi, eax				;edi = k
		sub		ecx, 2					;ecx = length of 'string'
		push	ecx

		mov		edx, OFFSET inBuf
		add		edx, 2					;edx = first letter of 'string'
		mov		esi, 0					;esi = outBuf index

		;--------- Visit every char in the string ---------
		L1:
			push	ecx						;save ecx for L1
			movzx	eax, BYTE PTR [edx]		;eax = every letter of 'string'
			push	edx						;edx = inBuf address

			mov		ecx, edi				;ecx = k
			mov		edx, OFFSET outBuf		;edx = outBuf address

			;--------- Repeat every char for k times ---------
			L2:
				mov		BYTE PTR[edx + esi], al
				add		esi, 1
			loop		L2

			;----------- Get ready to go back to L1 ----------
			pop		edx						;edx = inBuf address
			add		edx, 1					;edx -> next letter of string
			pop		ecx						;get ecx for L1
		loop	L1

		;--------- Write result : outBuf ---------
		pop		eax							;eax = k
		pop		ebx							;ecx = length of 'string'
		mul		ebx							;eax = k * (length of 'string')
		mov		ebx, eax					;ebx = length of outBuf

		mov		edx, OFFSET outBuf
		mov		BYTE PTR[edx + ebx], 0dh
		inc		ebx
		mov		BYTE PTR[edx + ebx], 0ah	;add Crlf at the end of each line
		inc		ebx

		INVOKE WriteFile, stdoutHandle, edx, ebx, ADDR bytesWRITE, 0

	jmp Start								;do until input file ends

	Finish:
		exit

main	ENDP

;==================================================
;---------------- PROC Declaration ----------------
;==================================================
Read_a_Line		PROC
	;-------- PROC data --------
	.data
	Single_Buf__	BYTE ?
	Byte_Read__		DWORD ?
	;-------- PROC code --------
	.code
	xor		ecx, ecx
	Read_Loop:
		push eax
		push ecx
		push edx
		INVOKE ReadFile, EAX, OFFSET Single_Buf__,1,OFFSET Byte_Read__, 0
		pop edx
		pop ecx
		pop eax

		cmp DWORD PTR Byte_Read__, 0
			je Read_End
		mov bl, Single_Buf__
		cmp bl, 0dh
			je Read_Loop
		cmp bl, 0ah
			je Read_End

		mov [edx], bl
		inc edx
		inc ecx
		jmp Read_Loop

		Read_End:
			mov BYTE PTR [edx],0
			ret
Read_a_Line ENDP
END		main