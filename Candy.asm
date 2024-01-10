include title.inc
include draws.inc
.model small
.stack 100h
.data
check db 15
allfull db 0

corx dw 0
cordy dw 0
i dw 0;iteration values
j dw 0
k db 0
l db 0
m dw 0
n dw 0
btemp db 0
btemp2 db 0
btemp3 db 0
temp dw 0 ;temp
temp2 dw 0
temp3 dw 0
temp4 dw 0
temp5 dw 0
temp6 dw 0
temp7 dw 0

digitCount db 0

score dw 0 ;score variable
rand dw 0 ;random number variable
seed dw 0
board dw 7 dup (7 dup(0)) ;Board values

player db 30 dup ("$") ; Player name
numcount dw 0

msg3 db 'CANDY CRUSH$'
 msg db 'Please Enter Your Name:$'
 msg2 db '___________________________$'
 msg1 db 'Instructions:$'
 msg4 db'1)Score points by crushing candies.$'
 msg5 db '2)Crush them by lining up at least three in a row of the same type of candy.$'
 msg6 db '3)The more candies you crush, the higher your score will go.$'

 msg7 db 'SCORE: $'
 msg8 db 'CRUSHING!$'
 msg9 db 'EXPLOSION!$'
 msg10 db 'Turns Left: $'
 blank db '          $'
.code
jmp start

;/////Display name 
DisplayName proc uses ax bx cx dx

mov dh,0
mov dl,1
mov ah,2h
mov bx,0
int 10h

mov si,0

.while si != numcount
mov dl,player[si]
add dl,65
mov ah,2
int 21h

inc si
.endw


ret
DisplayName endp

;///////Display score 
DisplayScore proc uses ax bx cx dx

mov dh,3
mov dl,1
mov ah,2h
mov bx,0
int 10h

mov dx,offset msg7 ; display string
mov ah,9h
int 21h

mov digitCount,0
mov ax, score
Pushing:
 
 mov dx,0
 mov bx,10
 div bx    
 push dx
 inc digitCount
 cmp ax,0
 jne Pushing
 
 display:
 cmp digitCount,0
 je stopDisplay
 dec digitCount 
 pop dx
 add dx,48
 mov ah,02h
 int 21h
 jmp display

stopDisplay:

ret
DisplayScore endp

; display turns left
DisplayTurns proc uses ax bx cx dx

mov dh,24
mov dl,1
mov ah,2h
mov bx,0
int 10h

mov dx,offset msg10
mov ah,9h
int 21h

mov digitCount,0
mov ah,0
mov al, check

.if check <= 9
mov dl,check
add dl,48
mov ah,2
int 21h
mov dl,' '
mov ah,2
int 21h
jmp stopTurns
.endif

label1:
 
 mov dx,0
 mov bx,10
 div bx    
 push dx
 inc digitCount
 cmp ax,0
 jne label1
 
 label2:
 cmp digitCount,0
 je stopTurns
 dec digitCount 
 pop dx
 add dx,48
 mov ah,02h
 int 21h
 jmp label2

stopTurns:

ret
DisplayTurns endp

; Display string of crushing
DisplayCrush proc uses cx dx ax bx

mov dh,10
mov dl,1
mov ah,2h
mov bx,0
int 10h

mov dx,offset msg8
mov ah,9h
int 21h

ret
DisplayCrush endp

;Display strng of explosion
DisplayExplosion proc uses ax bx cx dx

mov dh,10
mov dl,1
mov ah,2h
mov bx,0
int 10h

mov dx,offset msg9
mov ah,9h
int 21h

ret
DisplayExplosion endp

;display blank string
DisplayBlank proc uses ax bx cx dx

mov dh,10
mov dl,1
mov ah,2h
mov bx,0
int 10h

mov dx,offset blank
mov ah,9h
int 21h

ret 
DisplayBlank endp

;Calculate respective indexes using mouse click coordinates in x and y
calccors macro x,y

mov dx,0
mov ax,x
sub ax,100

mov bx,25
div bx

mov corx,ax

mov ax,0

mov dx,0
mov ax,y
sub ax,10

mov bx,25
div bx

mov cordy,ax

endcalc:

endm

;Swap values in x1,y1 and x2,y2
swap macro x1,x2,y1,y2

mov i,0
mov j,0

mov cx,x1
mov dx,y1

mov si,0

.while i != 7
.while j != 7

.if (cx == j) && (dx == i)
jmp endrowloop
.endif

inc si
inc si
inc j
.endw
mov j,0
inc si
inc si
inc i
.endw

endrowloop:

mov i,0
mov j,0

mov cx,x2
mov dx,y2

mov di,0

.while i != 7
.while j != 7

.if (cx == j) && (dx == i)
jmp endcolloop
.endif

inc di
inc di
inc j
.endw
mov j,0
inc di
inc di
inc i
.endw

endcolloop:

mov ax,board[si]
mov bx,board[di]

mov board[di],ax
mov board[si],bx

;IF swap was with bomb, then make explosion

.if board[si] == 5
mov temp7,ax
bomb temp7
mov board[si],0
.elseif board[di] == 5
mov temp7,bx
bomb temp7
mov board[di],0
.endif

dec check

endswap:



endm

bomb macro val ;Remove all instances of val swapped with bomb 

mov dx,val

mov si,0

mov m,0
mov n,0

.while m != 7
.while n != 7

.if board[si] == dx
mov board[si],0
inc score
.endif

inc si
inc si
inc n
.endw
mov n,0
inc si
inc si
inc m
.endw

call DisplayExplosion

endm

; Checking for any empty spaces in game and to replace with above candies
checkEmpty proc uses si dx bx ax

mov m,0
mov n,0

mov si,0

mov allfull,1

.while m != 7
 .while n != 7
  .if board[si] == 0
   mov allfull,0
   .if m >= 1	; if not in 1st row then replace with above
	mov bx,si
	sub bx,16
	mov dx,board[si]
	mov ax,board[bx]
	mov board[si],ax
	mov board[bx],dx
	
   .else        ; if in first row, then randomly spawn
    mov rand,0
    .while (rand == 0) || (rand == 5)
    call randgen
    .endw
    mov dx,rand
    mov board[si],dx
   .endif
  .endif
  inc si
  inc si
  inc n
 .endw
 inc si
 inc si
 inc m
 mov n,0
.endw

ret
checkEmpty endp

updateBoard proc uses si ;Replace old candies with new candies using updated board array

mov k,0
mov l,0

mov si,0

mov temp2,100
mov temp3,10

.while k != 7
.while l != 7
 .if board[si] == 1
 drawCandy1 temp2,temp3
 .elseif board[si] == 2
 drawCandy2 temp2,temp3
 .elseif board[si] == 3
 drawCandy3 temp2,temp3
 .elseif board[si] == 4
 drawCandy4 temp2,temp3
 .elseif board[si] == 5
 colorBomb temp2,temp3
 .elseif board[si] == 0
 drawEmpty temp2,temp3
 .endif
add temp2,25
inc si
inc si
inc l
.endw
add temp3,25
mov temp2,100
inc si
inc si
inc k
mov l,0
.endw

ret
updateBoard endp

checkRows proc uses ax bx cx dx si ;Checking for same candies in a row

mov btemp,0
mov temp,0

mov si,0

mov m,0
mov n,0

.while m != 7
 .while n != 7
  mov dx,board[si]
  mov bx,si
  mov btemp,0
  mov btemp2,0
  mov ax,n
  mov temp,ax
  .while (board[bx] == dx) && (temp < 7)
   inc btemp
   inc btemp2
   add bx,2
   inc temp
  .endw
  
  .if btemp >= 3
   mov bx,si
   .while (btemp != 0)
    dec btemp
	mov board[bx],0
	add bx,2
   .endw
   
   mov cx,score
   mov al,btemp2
   mov ah,0
   add cx,ax
   mov score,cx
   
   call DisplayCrush
  .endif
  
  
  
  .if btemp2 >= 5  ; if 5 candies together, then spawn bomb there
  mov board[si],5
  .endif
  
  add si,2
  inc n
 .endw
 add si,2
 inc m
 mov n,0
.endw

ret
checkRows endp

checkCols proc uses ax bx cx dx si ; Checking for same candies in a column
mov btemp,0
mov temp,0

mov si,0

mov m,0
mov n,0

.while m != 7
 .while n != 7
  mov dx,board[si]
  mov bx,si
  mov btemp,0
  mov btemp2,0
  mov ax,m
  mov temp,ax
  .while (board[bx] == dx) && (temp < 7)
   inc btemp
   inc btemp2
   add bx,16
   inc temp
  .endw
  
  .if btemp >= 3
   mov bx,si
   .while (btemp != 0)
    dec btemp
	mov board[bx],0
	add bx,16
   .endw
   
   mov cx,score
   mov al,btemp2
   mov ah,0
   add cx,ax
   mov score,cx
   
   call DisplayCrush
  .endif
  
  .if btemp2 == 5 ; if 5 candies together, then spawn bomb there
  mov board[si],5
  .endif
  
  add si,2
  inc n
 .endw
 add si,2
 inc m 
 mov n,0
.endw


ret
checkCols endp

drawBoard macro x,y ; drawboard for initializing board borders

mov ah,0ch
mov al,07h

mov cx,x
mov dx,y

mov i,0
mov j,0
.while i != 175
.while j != 175
int 10h
inc cx
inc j
.endw
inc dx
mov cx,x
inc i
mov j,0
.endw

mov cx,x
mov dx,y

mov i,0

.while i != 7
call makelineh
add dx,25
inc i
.endw

mov cx,x
mov dx,y

mov i,0

.while i != 7
call makelinev
add cx,25
inc i
.endw

endm


; to make horizontal line of dark gray color
makelineh proc
mov al,78h

mov temp,cx

mov j,0

.while j != 175
int 10h
inc j
inc cx
.endw

mov cx,temp

ret

makelineh endp

; to make vertical line of dark grey color
makelinev proc
mov al,78h

mov temp,dx

mov j,0

.while j != 175
int 10h
inc j
inc dx
.endw

mov dx,temp

ret

makelinev endp

;/////////////////////////
; generate a random number
randgen proc

mov ax, 25173          
mul word ptr seed
add ax, 13849
mov seed, ax

xor dx,dx

mov bx,6
div bx

.if rand == dx
mov rand,0
.else
mov rand,dx
.endif
  
ret
randgen endp

;/////////////////////
populateBoard macro x,y ;Initial population of board with random candies

mov i,0
mov j,0

mov si,0

.while i != 7
.while j != 7
call randgen
.while (rand == 0) || (rand == 5)
call randgen
.endw
mov dx,rand
mov board[si],dx   ;randomly populating board
inc si
inc si
inc j
.endw
mov j,0
inc si
inc si
inc i
.endw

mov k,0
mov l,0

mov si,0

mov temp2,x
mov temp3,y

.while k != 7    ;Displaying candies respective of random number at location
.while l != 7
 .if board[si] == 1
 drawCandy1 temp2,temp3
 .elseif board[si] == 2
 drawCandy2 temp2,temp3
 .elseif board[si] == 3
 drawCandy3 temp2,temp3
 .elseif board[si] == 4
 drawCandy4 temp2,temp3
 .elseif board[si] == 5
 colorBomb temp2,temp3
 .elseif board[si] == 0
 drawEmpty temp2,temp3
 .endif
add temp2,25
inc si
inc si
inc l
.endw
add temp3,25  ; as one box is of 25x25 size
mov temp2,x
inc si
inc si
inc k
mov l,0
.endw

endm

;/////////////DELAYS
delay10000 proc uses bx
mov bx,0
.while bx != 10000
inc bx
.endw
ret
delay10000 endp

delay1000 proc uses bx
mov bx,0
.while bx != 1000
inc bx
.endw
ret
delay1000 endp

delay100 proc uses bx
mov bx,0
.while bx != 100
inc bx
.endw
ret
delay100 endp

delay10 proc uses bx
mov bx,0
.while bx != 10
inc bx
.endw

ret 
delay10 endp

;///////////MAIN CODE//////////////
start: ; start of main code
main proc
mov ax,@data
mov ds,ax

mov ah,00h
int 1Ah

add dx,seed
mov ax,25173
mul dx
add ax,13849
mov seed,ax ; Initializing seed

push ax
push bx
push cx
push dx
titleDisplay
pop dx
pop cx
pop bx 
pop ax

mov dh,13
mov dl,25
mov ah,2h
mov bx,0
int 10h

mov si,0
mov al,0

.while al != 13 ;Taking user name input

mov ah,1
int 21h

inc numcount

mov player[si],al
inc si
.endw

mov ah,06
int 10h; scroll up


mov ah,0
mov al,0dh
int 10h ;entering video mode

mov ah,06
int 10h; scroll up

drawBoard 100,10; initializing board borders etc

populateBoard 100,10

mov ax,0 ; 640x200
int 33h

mov ax,1
int 33h

mov cx,200
mov dx,550
mov ax,7 ;horizontal restriction
int 33h

mov cx,10
mov dx,185
mov ax,8 ;vertical restriction
int 33h

mov temp,0
mov temp2,0
mov temp3,0
mov temp4,0
mov temp5,0
mov bx,0
mov cx,200
mov dx,10

mov ax,4
int 33h

;///Checking rows and columns for random generated combinations

call checkRows
call updateBoard

call checkCols
call updateBoard

mov allfull,0
.while allfull != 1
call checkEmpty
call updateBoard
call delay10000
.endw

.while check != 0

mov ax,5
int 33h

.if check == 15
mov score,0     ;Initializing score
.endif

call DisplayName
call DisplayScore

.if bx == 1 ;IF click detected
mov ax,3 ; Getting coordinates in cx and dx
int 33h
shr cx,1   ;As our resolution in 320 and mouse resolution 640 so shr for /2

mov temp6,cx
mov temp7,dx

calccors temp6,temp7

.if (temp4 == 0) && (temp5 == 0) ;If first click
mov dx,corx
mov temp4,dx
mov dx,cordy
mov temp5,dx

.else                          ; if second click
swap temp4,corx,temp5,cordy
call updateBoard
call delay1000

mov allfull,0
.while allfull != 1
call checkEmpty
call updateBoard
call delay10000
.endw

call DisplayBlank ;Dilsplaying blank for any string to be removed


mov temp4,0
mov temp5,0
.endif

nextitr:

mov bx,0

.endif


call checkRows
call updateBoard

call checkCols
call updateBoard

mov allfull,0
.while allfull != 1
call checkEmpty
call updateBoard
call delay10000
.endw

call DisplayBlank
call DisplayTurns

.endw

mov ah,0
int 16h
mov ax,3
int 10h ; checking for keyboard entry to return to text mode

gameend:

mov ah,4ch
int 21h
main endp

end