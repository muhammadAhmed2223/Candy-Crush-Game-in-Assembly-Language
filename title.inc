titleDisplay macro
 MOV AH, 06h
 MOV AL, 0

 MOV cl, 0
 MOV ch, 0
 MOV DH, 80
 MOV DL, 80
 MOV BH, 00000111b
 INT 10h
;//////////////////////////////////////////// title
 mov ah,02h
 mov bh,0
 MOV DH, 2 ;Row Number
 MOV DL, 34 ;Column Number
 INT 10H


 mov dx, offset msg3
 mov ah,09
 int 21h
;/////////////////////////////////////////////
 mov ah,02h
 mov bh,0
 MOV DH, 12 ;Row Number
 MOV DL, 25 ;Column Number
 INT 10H


 mov dx, offset msg
 mov ah,09
 int 21h

 mov ah,02h
 mov bh,0
 MOV DH, 13 ;Row Number
 MOV DL, 24 ;Column Number
 INT 10H


 mov dx, offset msg2
 mov ah,09
 int 21h

 mov ah,02h
 mov bh,0
 MOV DH, 10 ;Row Number
 MOV DL, 24 ;Column Number
 INT 10H


 mov dx, offset msg2
 mov ah,09
 int 21h
;////////////////////////// Instructions

 mov ah,02h
 mov bh,0
 MOV DH, 4 ;Row Number
 MOV DL, 2 ;Column Number
 INT 10H


 mov dx, offset msg1
 mov ah,09
 int 21h
;////////////////////////////
 mov ah,02h
 mov bh,0
 MOV DH, 5 ;Row Number
 MOV DL, 2 ;Column Number
 INT 10H


 mov dx, offset msg4
 mov ah,09
 int 21h
;///////////////////////////

 mov ah,02h
 mov bh,0
 MOV DH, 6 ;Row Number
 MOV DL, 2 ;Column Number
 INT 10H


 mov dx, offset msg5
 mov ah,09
 int 21h
;///////////////////////////

mov ah,02h
 mov bh,0
 MOV DH, 7 ;Row Number
 MOV DL, 2 ;Column Number
 INT 10H


 mov dx, offset msg6
 mov ah,09
 int 21h
;////////////////////////// 
mov ah,06h
mov al,0
mov cl,5
mov ch,10
mov dl,10  ; row
mov dh,20  ; coloumn
;mov bh,20h
int 10h

mov ah,06h
mov al,0
mov cl,5
mov ch,10
mov dl,10
mov dh,20
mov bh,73h
int 10h

mov ah,06h
mov al,0
mov cl,5
mov ch,10
mov dl,10
mov dh,20
int 10h

mov ah,02h
;mov bh,0
mov dh,11
mov dl,22
int 10h
;/////////////////////////
mov ah,06h
mov al,0
mov cl,15
mov ch,10
mov dl,20  ; row
mov dh,20  ; coloumn
;mov bh,20h
int 10h

mov ah,06h
mov al,0
mov cl,15
mov ch,10
mov dl,20
mov dh,20
mov bh,73h
int 10h

mov ah,06h
mov al,0
mov cl,15
mov ch,10
mov dl,20
mov dh,20
int 10h

mov ah,02h
;mov bh,0
mov dh,11
mov dl,22
int 10h

;//////////////////////////


mov ah,06h
mov al,0
mov cl,25
mov ch,15
mov dl,30  ; row
mov dh,20  ; coloumn
;mov bh,20h
int 10h

mov ah,06h
mov al,0
mov cl,25
mov ch,15
mov dl,30
mov dh,20
mov bh,73h
int 10h

mov ah,06h
mov al,0
mov cl,25
mov ch,15
mov dl,30
mov dh,20
int 10h

mov ah,02h
;mov bh,0
mov dh,11
mov dl,22
int 10h

;//////////////////////////

mov ah,06h
mov al,0
mov cl,35
mov ch,15
mov dl,40  ; row
mov dh,20  ; coloumn
;mov bh,20h
int 10h

mov ah,06h
mov al,0
mov cl,35
mov ch,15
mov dl,40
mov dh,20
mov bh,73h
int 10h

mov ah,06h
mov al,0
mov cl,35
mov ch,15
mov dl,40
mov dh,20
int 10h

mov ah,02h
;mov bh,0
mov dh,11
mov dl,22
int 10h

;//////////////////////////////

mov ah,06h
mov al,0
mov cl,35
mov ch,15
mov dl,40  ; row
mov dh,20  ; coloumn
;mov bh,20h
int 10h

mov ah,06h
mov al,0
mov cl,45
mov ch,15
mov dl,50
mov dh,20
mov bh,73h
int 10h

mov ah,06h
mov al,0
mov cl,45
mov ch,15
mov dl,50
mov dh,20
int 10h

mov ah,02h
;mov bh,0
mov dh,11
mov dl,22
int 10h

;//////////////////////////

mov ah,06h
mov al,0
mov cl,55
mov ch,10
mov dl,60  ; row
mov dh,20  ; coloumn
;mov bh,20h
int 10h

mov ah,06h
mov al,0
mov cl,55
mov ch,10
mov dl,60
mov dh,20
mov bh,73h
int 10h

mov ah,06h
mov al,0
mov cl,55
mov ch,10
mov dl,60
mov dh,20
int 10h

mov ah,02h
;mov bh,0
mov dh,11
mov dl,22
int 10h

;//////////////////////////

mov ah,06h
mov al,0
mov cl,65
mov ch,10
mov dl,70  ; row
mov dh,20  ; coloumn
;mov bh,20h
int 10h

mov ah,06h
mov al,0
mov cl,65
mov ch,10
mov dl,70
mov dh,20
mov bh,73h
int 10h

mov ah,06h
mov al,0
mov cl,65
mov ch,10
mov dl,70
mov dh,20
int 10h

mov ah,02h
;mov bh,0
mov dh,11
mov dl,22
int 10h

;//////////////////////////
 mov ah,02h
 mov bh,0
 MOV DH, 80 ;Row Number
 MOV DL, 80 ;Column Number
 INT 10H

endm