TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005


; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang

INCLUDE Irvine32.inc

Str_remove PROTO,pStart:PTR BYTE,nChars:DWORD

main  EQU start@0 ;
.data
target BYTE "106502573106502011ABCDEF",0

.code
main PROC

	mov edi, OFFSET target  ;edi = target起始位置
	mov al, '3';al = 學號1最後一碼(字元)
	mov ecx, LENGTHOF target  ;ecx = target 字串的長度
	cld              ;clear direction flag
	repne scasb      ;repeat searching while not equal
	dec edi         ;將找到的字元位置減一
	mov eax, OFFSET target  ;eax = target起始位置
	sub edi, eax  ;edi -= target起始位置
	call DumpRegs   ;顯示目前暫存器狀況

	mov edx,OFFSET target
	call WriteString
	call Crlf
	INVOKE Str_remove, eax, edi	;呼叫 Str_remove
	mov edx,OFFSET target
	call WriteString
	call Crlf
	call WaitMsg
	exit
main ENDP

Str_remove PROC,
	pStart:PTR BYTE,	; 要移除的字串頭
	nChars:DWORD		; 將移除的字元數

	INVOKE Str_length, pStart
	mov	ecx,eax			;ecx = 字串長度

	.IF nChars <= ecx	; check range of nChars
	  sub ecx, nChars 	; set counter for REP prefix
	.ENDIF

	mov esi, pStart	;esi = 字串起始位置
	add esi, nChars	;esi += 要移除的字元數
	mov edi, pStart	;edi = 字串起始位置

	cld               ;clear direction flag
	rep movsb	     ;do the move

	mov	BYTE PTR [edi],0	; insert new null byte

Exit_proc:
	ret
Str_remove ENDP
END main
