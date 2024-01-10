;CODES FOR ALL CANDIES

drawEmpty macro x,y

mov ah,0ch
mov al,07h

mov cx,x
mov dx,y

add cx,6
add dx,6

mov i,1
mov j,1

.while i != 15
.while j != 15
int 10h
inc cx
inc j
.endw
inc dx
mov cx,x
add cx,6
inc i
mov j,1
.endw

endm

drawCandy1 macro x,y

mov ah,0ch
mov al,01h

mov cx,x
mov dx,y

add cx,6
add dx,6

mov i,1
mov j,1

.while i != 15
.while j != 15
int 10h
inc cx
inc j
.endw
inc dx
mov cx,x
add cx,6
inc i
mov j,1
.endw

endm

drawCandy2 macro x,y

mov ah,0ch
mov al,02h

mov cx,x
mov dx,y

add cx,6
add dx,6

mov i,1
mov j,1

.while i != 15
.while j != 15
int 10h
inc cx
inc j
.endw
inc dx
mov cx,x
add cx,6
inc i
mov j,1
.endw

endm

drawCandy3 macro x,y

mov ah,0ch
mov al,0Eh

mov cx,x
mov dx,y

add cx,6
add dx,6

mov i,1
mov j,1

.while i != 15
.while j != 15
int 10h
inc cx
inc j
.endw
inc dx
mov cx,x
add cx,6
inc i
mov j,1
.endw

endm

drawCandy4 macro x,y

mov ah,0ch
mov al,04h

mov cx,x
mov dx,y

add cx,6
add dx,6

mov i,1
mov j,1

.while i != 15
.while j != 15
int 10h
inc cx
inc j
.endw
inc dx
mov cx,x
add cx,6
inc i
mov j,1
.endw

endm

colorBomb macro x,y

mov ah,0ch
mov al,06h

mov cx,x
mov dx,y

add cx,6
add dx,6

mov i,1
mov j,1

.while i != 15
.while j != 15
int 10h
inc cx
inc j
.endw
inc dx
mov cx,x
add cx,6
inc i
mov j,1
.endw

mov cx,x
mov dx,y

add cx,5
add dx,5

mov al,02h
add cx,7 
add dx,2
int 10h

mov cx,x
mov dx,y

add cx,5
add dx,5

mov al,0Eh
add cx,3
add dx,4
int 10h

mov cx,x
mov dx,y

add cx,5
add dx,5

mov al,01h
add cx,7
add dx,7
int 10h

mov cx,x
mov dx,y

add cx,5
add dx,5

mov al,00h
add cx,9
add dx,9
int 10h

mov cx,x
mov dx,y

add cx,5
add dx,5

mov al,0Fh
add cx,3
add dx,9
int 10h

mov cx,x
mov dx,y

add cx,5
add dx,5

mov al,0Bh
add cx,9
add dx,4
int 10h

endm