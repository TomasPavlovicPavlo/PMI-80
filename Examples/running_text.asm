        ; 8080 assembler code
        .project running_text.com

temp1   equ     1C60h
temp2   equ     1C61h

CLEAR   equ     00ABh
DISP    equ     0140h
OUTKE2  equ     011Ch

; character codes
_A      equ     0Ah
_B      equ     0Bh
_C      equ     0Ch
_D      equ     0Dh
_E      equ     0Eh
_F      equ     0Fh
_G      equ     20h
_H      equ     1Ah
_I      equ     01h
_J      equ     21h
_K      equ     85h
_L      equ     14h
_M      equ     16h
_N      equ     1Bh
_O      equ     11h
_P      equ     13h
_Q      equ     43h
_R      equ     12h
_S      equ     05h
_T      equ     10h
_U      equ     15h
_V      equ     8Eh
_X      equ     9Bh
_Y      equ     23h
_Z      equ     02h
_equal  equ     18h     ; =
_minus  equ     1Fh     ; -
_apostr equ     1Eh     ; "
_comma  equ     22h     ; ,
_qstn   equ     1Dh     ; ?
_1      equ     01h
_2      equ     02h
_3      equ     03h
_4      equ     04h
_5      equ     05h
_6      equ     06h
_7      equ     07h
_8      equ     08h
_9      equ     09h
_0      equ     00h
_space  equ     19h


        .org 1C00h
        MVI A,_space     ; move space to A
        CALL CLEAR       ; call subroutine CLEAR from MONITOR
        MVI A,00h        ; Register A = 00
        STA temp1        ; save A to 1C60
loop1:       
        CALL loop2       ; 
        LDA temp1        ; save value from 1C60 to A
        MOV L,A          ; move A to L
        MVI H,1Dh        ; H = 1D
        SHLD 1FFCh       ; save value from HL to 1FFC
        INR A            ; A++
        CPI 24h          ; is A = 24 ?
        JNZ loop7        ; if Z = 0 then jump
        MVI A,00h        ; else A = 00
loop7:
        STA temp1        ; store A to 1C60
        JMP loop1        ; jump to start
loop2:       
        MVI A,00h        ; A = 00
        STA temp2        ; 1C61 = A
loop6:       
        LDA temp2        ; A = 1C61
        MOV B,A          ; B = A
        MVI A,00h        ; A = 00
loop3:       
        INR A            ; A++
        CPI 00h          ; is A = 00 ?
        JNZ loop3        ; if Z = 0 then jump
        MOV A,B          ; else A = B
        INR A            ; A++
        CPI 40h          ; is A = 40 ?
        STA temp2        ; 1C61 = A
        JNZ loop4        ; if Z = 0 then jump
        RET              ; else return to main loop
loop4:       
        CALL DISP        ; call subroutine DISP from MONITOR
        JC loop5         ; if C = 1 then jump to loop5
        JMP loop6        ; else jump to loop6
loop5:       
        CALL OUTKE2      ; call subroutine OUTKE2 from MONITOR
        CPI 97h          ; is A = 97 ? (key „BR“)
        JNZ loop6        ; if Z = 0 then jump to loop6
        JMP 0000h        ; else jump to 0000 (reset)



        .org 1D00h
        db _space,_space,_space,_space,_space,_space,_space,_space
        db _space,_space,_space,_space,_space,_space,_space,_space
        db _H,_E,_L,_L,_O,_space,_W,_O
        db _R,_L,_D,_space,_space,_space,_space,_space
        db _space,_space,_space,_space,_space,_space,_space,_space
        db _space,_space,_space,_space,_space,_space,_space,_space
        
        
        
        