Comment /
Written by: Kim Sumi (20181202)
Function:	Calculate List Sum
Input:		Integers String
Output:		Sum of Integers in the String
/

TITLE		HW5_CSE3030
INCLUDE		Irvine32.inc

;-------- Data Declaration --------
.data
BUF_SIZE	EQU		256
inBuffer	BYTE	BUF_SIZE	DUP(?)
inBufferN	DWORD	?
intArray	SDWORD	BUF_SIZE/2	DUP(?)
intArrayN	DWORD	?

message		BYTE	"Enter numbers(<ent> to exit) :", 0dh, 0ah, 0
endMessage	BYTE	"Bye!", 0dh, 0ah, 0
errMessage	BYTE	"[Too Many Integers]", 0dh, 0ah, 0


;-------- Code Declaration --------
.code
main	PROC
	;-------- 1. Receive String and save in memory --------
	L5:
		mov		edx, OFFSET message			;show message
		call	WriteString					

		;-------- get input string --------
		mov		edx, OFFSET inBuffer		;edx = string
		mov		ecx, SIZEOF inBuffer-1		;ecx = size of string
		call	ReadString

		;-------- if nothing written : end program --------
		cmp		eax, 0
		je		L6

		;-------- get ready to call ExtractInt --------
		mov		edi, OFFSET	intArray	;edi = intArray
		mov		ecx, eax				;ecx = length of input string

		mov		ebx, edx
		add		ebx, ecx
		dec		ebx						;ebx = end of string
	
		mov		esi, 0					;esi = number of integers

	;-------- 2. Extract integers from the string --------
		call ExtractInt

		mov		intArrayN, esi			;esi = number of integers
		mov		edi, OFFSET	intArray	;edi = start of intArray
		mov		ecx, intArrayN			;ecx = number of integers
		mov		eax, 0					;eax = sum

		;-------- there were only gaps : jump to L5 --------
		cmp		esi, 0
		je		L5

		cmp		esi, 125
		jbe		L4
		mov		edx, OFFSET errMessage
		call	WriteString
		jmp		L5

	;-------- 3. Int existed the string : calculate List Sum --------
		L4:
			add		eax, SDWORD PTR [edi]
			add		edi, TYPE SDWORD
		loop	L4

		cmp		eax, 0
		jge		L7

		;-------- negative number --------
		call	WriteInt
		call	Crlf
		jmp		L5

		;-------- positive number --------
		L7:
			call WriteDec
			call Crlf

	jmp		L5

	;-------- 4. End the program --------
	L6:
		mov		edx, OFFSET endMessage
		call	WriteString				;show end message
	exit
main	ENDP



;-------- Function Declaration --------
ExtractInt	PROC
	dec		edx
	;-------- search until find a number --------
	L1:
		inc		edx
		cmp		edx, ebx			;check rather the string ended
		ja		L3
		movzx	eax, BYTE PTR [edx]
		cmp		eax, 32
	je		L1						;jump until meet number

	;-------- found number : save integer in intArray --------
	call	ParseInteger32
	mov		[edi],eax				;save integer
	add		edi, TYPE SDWORD
	inc		esi						;count number of int

	;-------- search until find a gap --------
	L2:
		inc		edx
		cmp		edx, ebx			;check rather the string ended
		ja		L3
		movzx	eax, BYTE PTR [edx]
		cmp		eax, 32
	jne		L2

	;-------- found a gap : jump to L1 --------
	jmp		L1

	L3:
		ret
ExtractInt	ENDP

END main