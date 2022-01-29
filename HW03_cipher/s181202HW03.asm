Comment /
Written by: Kim Sumi (20181202)
Function:	Cipher-Decipher
Input:		Num_Str, Cipher_Str
Output:		Os181202_out.txt
/

TITLE		HW3_CSE3030
INCLUDE		Irvine32.inc
INCLUDE		CSE3030_PHW03.inc

;-------- Data Declaration --------
.data
filename		BYTE "0s181202_out.txt", 0
fileHandle		DWORD ?
buffSize		= 10
newLine			BYTE 0dh, 0ah

buffer			BYTE buffSize DUP (?)
L				BYTE "QRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ", 0

L1_temp			DWORD ?
L2_temp			DWORD 0

;-------- Code Declaration --------
.code
main PROC
	;-------- open file --------
	mov		edx, OFFSET filename
	call	CreateOutputFile
	mov		filehandle, eax
	
	;-------- L1 loop --------
	mov		ecx, Num_Str
	L1:
		mov		L1_temp, ecx	;save ecx for L1

		;-------- put in stack --------
		mov		esi, L2_temp
		mov		ecx, buffSize
		L2:			
				movzx	eax, Cipher_Str[esi]
				push	eax
				inc		esi
		loop L2

		;-------- pop from stack --------
		mov		ecx, buffSize
		mov		esi, buffSize - 1
		L3:
				pop		eax
				sub		eax, 65			;for de-cipher(1)
				mov		al, L[eax]		;for de-cipher(2)
				mov		buffer[esi], al
				dec		esi  
		loop L3

		;-------- print file --------
		mov		eax, filehandle
		mov		edx, OFFSET buffer		;buffer will be printed in the file
		mov		ecx, buffSize
		call	WriteToFile

		mov		eax, filehandle
		mov		edx, OFFSET newLine		;make new line
		mov		ecx, 2
		call	WriteToFile

		;-------- back to L1 --------
		mov		ecx, L1_temp
		add		L2_temp, buffSize + 1
	loop L1

	call	CloseFile
	exit
main ENDP
END main