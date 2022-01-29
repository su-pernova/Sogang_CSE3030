Comment /
Written by: Kim Sumi (20181202)
Function:	Find the highest uphill
Input:		TN, CASE, HEIGHT
Output:		Height of the highest uphill
/

TITLE		HW4_CSE3030
INCLUDE		Irvine32.inc
INCLUDE		CSE3030_PHW04.inc

;-------- Data Declaration --------
.data
max_height		DWORD ?

;-------- Code Declaration --------
.code
main PROC
	push	DWORD PTR TN			;save ecx for L1
	mov		max_height, 0			;max height of uphill
	mov		ecx, CASE				;get ecx for L2
	dec		ecx						;ecx = CASE - 1
	mov		esi, 0

	mov		eax, HEIGHT[esi]		;start of array
	mov		edx, HEIGHT[esi]		;start of array

	jmp		L2

	;-------- Loop for all testcases --------
	L1:
	push	ecx						;save ecx for L1
	add		esi, TYPE HEIGHT		
	mov		ecx, HEIGHT[esi]		;HEIGHT[esi] = length of array
	dec		ecx						;set ecx for L2
	mov		max_height, 0			;initialize max_height

	add		esi, TYPE HEIGHT
	mov		eax, HEIGHT[esi]		;start of uphill
	mov		edx, HEIGHT[esi]		;end of uphill


	;-------- Loop for each testcase --------
	L2:
		add		esi, TYPE HEIGHT
		cmp		edx, HEIGHT[esi]
		jb		L5

		;-------- if uphill ends --------
		sub		edx, eax	
		cmp		edx, max_height 
		jbe		L4

		;-------- if edx > max_height --------
		L3:
			mov		max_height, edx			;update max_height

		;-------- new uphill starts --------
		L4:
			mov		eax, HEIGHT[esi]		;start of uphill
			mov		edx, HEIGHT[esi]		;end of uphill

		;-------- if uphill continues --------
		L5:
			mov		edx, HEIGHT[esi]		;update edx(end of uphill)
	loop L2

	;-------- Last calculation of L2 --------
	sub		edx, eax	
	cmp		edx, max_height
	jbe		L7
	mov		max_height, edx
	
	;-------- Print result --------
	L7:
	mov		eax, max_height
	call	WriteDec
	call	CrLf

	;-------- Ready to go back to L1 --------
	pop		ecx						;get ecx for L1
	loop	L1

	exit

main ENDP
END main