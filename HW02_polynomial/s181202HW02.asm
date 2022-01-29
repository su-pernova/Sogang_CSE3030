Comment /
Written by : Kim Sumi (20181202)
Function : Calculation using only MOV, ADD, SUB
Input : x1, x2, x3
Output : 90(x1)-30(x2)+19(x3)
/

TITLE HW2_CSE3030

INCLUDE Irvine32.inc
INCLUDE CSE3030_PHW02.inc

.data
temp DWORD 0

.code
main PROC
	mov eax, x1		; eax = x1
	add eax, eax	; eax = 2(x1)
	add temp, eax		; temp = 2(x1)
	add eax, eax	; eax = 4(x1)
	add eax, eax	; eax = 8(x1)
	add temp, eax		; temp = 10(x1)
	add eax, eax	; eax = 16(x1)
	add temp, eax		; temp = 26(x1)
	add eax, eax	; eax = 32(x1)
	add eax, eax	; eax = 64(x1)
	add temp, eax		; temp = 90(x1)

	mov eax, x2		; eax = x2
	add eax, eax	; eax = 2(x2)
	sub temp, eax		; temp = 90(x1) - 2(x2)
	add eax, eax	; eax = 4(x2)
	sub temp, eax		; temp = 90(x1) - 6(x2)
	add eax, eax	; eax = 8(x2)
	sub temp, eax		; temp = 90(x1) - 14(x2)
	add eax, eax	; eax = 16(x2)
	sub temp, eax		; temp = 90(x1) - 30(x2)

	mov eax, x3		; eax = x3
	add temp, eax		; temp = 90(x1) - 30(x2) + x3
	add eax, eax	; eax = 2(x3)
	add temp, eax		; temp = 90(x1) - 30(x2) + 3(x3)
	add eax, eax	; eax = 4(x3)
	add eax, eax	; eax = 8(x3)
	add eax, eax	; eax = 16(x3)
	add eax, temp	; eax = 90(x1) - 30(x2) + 19(x3)

	call WriteInt	; print (90(x1) - 30(x2) + 19(x3))
	exit
main ENDP
END main