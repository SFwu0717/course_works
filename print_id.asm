TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005


; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang

INCLUDE Irvine32.inc
 
Str_copyN PROTO,
    source:PTR DWORD,   ; source string address
    target:PTR DWORD,   ; target string address
    maxChars:DWORD      ; maximum number of characters to copy
 main   EQU start@0
.data
string_1 BYTE "106502573",0    ;填入組員1學號
string_2 BYTE "106502011",0    ;填入組員2學號
 
.code
main PROC
    INVOKE Str_copyN,        ; copy string_1 to string_2
      ADDR string_1 ,        
      ADDR string_2 + 9,     
      (SIZEOF string_2) - 1 ; save space for null byte
 
; Display the destination string
    mov  edx,OFFSET string_2
    call WriteString
    call Crlf
    call WaitMsg
    exit
main ENDP
 
Str_copyN PROC USES eax ecx esi edi,
    source:PTR DWORD,            ; source string
    target:PTR DWORD,        ; target string
    maxChars:DWORD       ; max chars to copy
	mov esi, source
	mov edi, target
	cld
	mov ecx, maxChars
	rep movsb
	mov edi, 0
	ret
Str_copyN ENDP
 
END main

;
; Copy a string from source to target, limiting the number
; of characters to copy. Value in maxChars does not include
; the null byte.