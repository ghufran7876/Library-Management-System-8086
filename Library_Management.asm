
.MODEL SMALL
.STACK 100H

.DATA

MAX_BOOKS EQU 10
TITLE_LEN EQU 31
AUTHOR_LEN EQU 16
ID_LEN EQU 6

bookTitle  DB MAX_BOOKS * TITLE_LEN DUP(0)
bookAuthor DB MAX_BOOKS * AUTHOR_LEN DUP(0)
bookID     DB MAX_BOOKS * ID_LEN DUP(0)
bookAvail  DB MAX_BOOKS DUP(0)
bookCount  DW 0

inTitle DB TITLE_LEN,0,TITLE_LEN DUP(0)
inAuthor DB AUTHOR_LEN,0,AUTHOR_LEN DUP(0)
inID DB ID_LEN,0,ID_LEN DUP(0)

tempIndex DW 0

msgTitle DB 13,10,"======================================",13,10
         DB " LIBRARY MANAGEMENT SYSTEM - 8086 ",13,10
         DB "======================================",13,10,"$"

msgMenu DB 13,10," [1] Add New Book",13,10
        DB " [2] Search Book by ID",13,10
        DB " [3] Display All Books",13,10
        DB " [4] Delete Book by ID",13,10
        DB " [5] Issue Book",13,10
        DB " [6] Return Book",13,10
        DB " [7] Exit",13,10,13,10
        DB " Enter Choice: $"

msgEnterTitle DB 13,10," Enter Book Title : $"
msgEnterAuthor DB 13,10," Enter Author Name : $"
msgEnterID DB 13,10," Enter Book ID : $"
msgEnterSID DB 13,10," Enter Book ID to Search : $"
msgEnterDID DB 13,10," Enter Book ID to Delete : $"
msgEnterIID DB 13,10," Enter Book ID to Issue : $"
msgEnterRID DB 13,10," Enter Book ID to Return : $"

msgAdded DB 13,10," [OK] Book added successfully!",13,10,"$"
msgFull DB 13,10," [!] Library Full!",13,10,"$"
msgFound DB 13,10," [FOUND] Book Details",13,10,"$"
msgNotFound DB 13,10," [X] Book not found",13,10,"$"
msgDeleted DB 13,10," [OK] Book deleted",13,10,"$"
msgIssued DB 13,10," [OK] Book issued",13,10,"$"
msgReturned DB 13,10," [OK] Book returned",13,10,"$"
msgAlready DB 13,10," [!] Already issued",13,10,"$"
msgNotIssued DB 13,10," [!] Not issued",13,10,"$"
msgNoBooks DB 13,10," [!] No books available",13,10,"$"
msgInvalid DB 13,10," [!] Invalid choice",13,10,"$"
msgGoodbye DB 13,10," Thank you!",13,10,"$"

msgID DB 13,10," ID : $"
msgBook DB 13,10," Title : $"
msgAuthor DB 13,10," Author : $"
msgStatus DB 13,10," Status : $"

msgAvail DB "Available$"
msgIssued2 DB "Issued$"

msgPress DB 13,10," Press any key...$"

.CODE

MAIN PROC

MOV AX,@DATA
MOV DS,AX

MENU:

CALL CLS

LEA DX,msgTitle
CALL PRINT

LEA DX,msgMenu
CALL PRINT

MOV AH,01H
INT 21H

CMP AL,'1'
JE ADD_BOOK

CMP AL,'2'
JE SEARCH_BOOK

CMP AL,'3'
JE DISPLAY_BOOKS

CMP AL,'4'
JE DELETE_BOOK

CMP AL,'5'
JE ISSUE_BOOK

CMP AL,'6'
JE RETURN_BOOK

CMP AL,'7'
JE EXIT_PROGRAM

LEA DX,msgInvalid
CALL PRINT
CALL PAUSE
JMP MENU

ADD_BOOK:

MOV AX,bookCount
CMP AX,MAX_BOOKS
JAE FULL

LEA DX,msgEnterTitle
CALL PRINT
LEA DX,inTitle
CALL INPUT

LEA DX,msgEnterAuthor
CALL PRINT
LEA DX,inAuthor
CALL INPUT

LEA DX,msgEnterID
CALL PRINT
LEA DX,inID
CALL INPUT

MOV BX,bookCount

MOV AX,BX
MOV CX,TITLE_LEN
MUL CX
MOV DI,AX

LEA SI,inTitle+2
LEA BX,bookTitle
ADD BX,DI

MOV CX,TITLE_LEN
COPY_TITLE:
MOV AL,[SI]
MOV [BX],AL
INC SI
INC BX
LOOP COPY_TITLE

MOV BX,bookCount

MOV AX,BX
MOV CX,AUTHOR_LEN
MUL CX
MOV DI,AX

LEA SI,inAuthor+2
LEA BX,bookAuthor
ADD BX,DI

MOV CX,AUTHOR_LEN
COPY_AUTHOR:
MOV AL,[SI]
MOV [BX],AL
INC SI
INC BX
LOOP COPY_AUTHOR

MOV BX,bookCount

MOV AX,BX
MOV CX,ID_LEN
MUL CX
MOV DI,AX

LEA SI,inID+2
LEA BX,bookID
ADD BX,DI

MOV CX,ID_LEN
COPY_ID:
MOV AL,[SI]
MOV [BX],AL
INC SI
INC BX
LOOP COPY_ID

MOV BX,bookCount
MOV bookAvail[BX],1

INC bookCount

LEA DX,msgAdded
CALL PRINT
CALL PAUSE

JMP MENU

FULL:
LEA DX,msgFull
CALL PRINT
CALL PAUSE
JMP MENU

SEARCH_BOOK:

LEA DX,msgEnterSID
CALL PRINT

LEA DX,inID
CALL INPUT

CALL FIND_BOOK

CMP BX,0FFFFH
JE NOT_FOUND1

MOV tempIndex,BX

LEA DX,msgFound
CALL PRINT

CALL SHOW_BOOK

CALL PAUSE
JMP MENU

NOT_FOUND1:
LEA DX,msgNotFound
CALL PRINT
CALL PAUSE
JMP MENU

DISPLAY_BOOKS:

MOV AX,bookCount
CMP AX,0
JE EMPTY

MOV BX,0

DISPLAY_LOOP:

CMP BX,bookCount
JAE DISPLAY_DONE

MOV tempIndex,BX
CALL SHOW_BOOK

INC BX
JMP DISPLAY_LOOP

DISPLAY_DONE:
CALL PAUSE
JMP MENU

EMPTY:
LEA DX,msgNoBooks
CALL PRINT
CALL PAUSE
JMP MENU

DELETE_BOOK:

LEA DX,msgEnterDID
CALL PRINT

LEA DX,inID
CALL INPUT

CALL FIND_BOOK

CMP BX,0FFFFH
JE NOT_FOUND2

MOV bookAvail[BX],0

LEA DX,msgDeleted
CALL PRINT
CALL PAUSE
JMP MENU

NOT_FOUND2:
LEA DX,msgNotFound
CALL PRINT
CALL PAUSE
JMP MENU

ISSUE_BOOK:

LEA DX,msgEnterIID
CALL PRINT

LEA DX,inID
CALL INPUT

CALL FIND_BOOK

CMP BX,0FFFFH
JE NOT_FOUND3

CMP bookAvail[BX],0
JE ALREADY_ISSUED

MOV bookAvail[BX],0

LEA DX,msgIssued
CALL PRINT
CALL PAUSE
JMP MENU

ALREADY_ISSUED:
LEA DX,msgAlready
CALL PRINT
CALL PAUSE
JMP MENU

NOT_FOUND3:
LEA DX,msgNotFound
CALL PRINT
CALL PAUSE
JMP MENU

RETURN_BOOK:

LEA DX,msgEnterRID
CALL PRINT

LEA DX,inID
CALL INPUT

CALL FIND_BOOK

CMP BX,0FFFFH
JE NOT_FOUND4

CMP bookAvail[BX],1
JE NOT_ISSUED

MOV bookAvail[BX],1

LEA DX,msgReturned
CALL PRINT
CALL PAUSE
JMP MENU

NOT_ISSUED:
LEA DX,msgNotIssued
CALL PRINT
CALL PAUSE
JMP MENU

NOT_FOUND4:
LEA DX,msgNotFound
CALL PRINT
CALL PAUSE
JMP MENU

EXIT_PROGRAM:

LEA DX,msgGoodbye
CALL PRINT

MOV AH,4CH
INT 21H

MAIN ENDP

FIND_BOOK PROC

MOV BX,0

NEXT_BOOK:

CMP BX,bookCount
JAE BOOK_NOT_FOUND

MOV AX,BX
MOV CX,ID_LEN
MUL CX
MOV DI,AX

LEA SI,bookID
ADD SI,DI

LEA DI,inID+2

MOV CX,ID_LEN

COMPARE_LOOP:

MOV AL,[SI]
MOV DL,[DI]

CMP AL,DL
JNE NO_MATCH

CMP AL,0
JE MATCH_FOUND

INC SI
INC DI
LOOP COMPARE_LOOP

MATCH_FOUND:
RET

NO_MATCH:
INC BX
JMP NEXT_BOOK

BOOK_NOT_FOUND:
MOV BX,0FFFFH
RET

FIND_BOOK ENDP

SHOW_BOOK PROC

MOV BX,tempIndex

LEA DX,msgID
CALL PRINT

MOV AX,BX
MOV CX,ID_LEN
MUL CX
MOV SI,AX

LEA SI,bookID[SI]
CALL PRINT_TEXT

LEA DX,msgBook
CALL PRINT

MOV AX,BX
MOV CX,TITLE_LEN
MUL CX
MOV SI,AX

LEA SI,bookTitle[SI]
CALL PRINT_TEXT

LEA DX,msgAuthor
CALL PRINT

MOV AX,BX
MOV CX,AUTHOR_LEN
MUL CX
MOV SI,AX

LEA SI,bookAuthor[SI]
CALL PRINT_TEXT

LEA DX,msgStatus
CALL PRINT

CMP bookAvail[BX],1
JE AVAILABLE

LEA DX,msgIssued2
CALL PRINT
RET

AVAILABLE:
LEA DX,msgAvail
CALL PRINT
RET

SHOW_BOOK ENDP

PRINT_TEXT PROC

MOV AL,[SI]

CMP AL,0
JE END_PRINT

MOV DL,AL
MOV AH,02H
INT 21H

INC SI
JMP PRINT_TEXT

END_PRINT:
RET

PRINT_TEXT ENDP

PRINT PROC

MOV AH,09H
INT 21H
RET

PRINT ENDP

INPUT PROC

MOV AH,0AH
INT 21H

MOV BX,DX
MOV AL,[BX+1]
MOV AH,0

ADD BX,AX
ADD BX,2

MOV BYTE PTR [BX],0

RET

INPUT ENDP

PAUSE PROC

LEA DX,msgPress
CALL PRINT

MOV AH,00H
INT 16H

RET

PAUSE ENDP

CLS PROC

MOV AX,0600H
MOV BH,07H
MOV CX,0000H
MOV DX,184FH
INT 10H

MOV AH,02H
MOV BH,00H
MOV DX,0000H
INT 10H

RET

CLS ENDP

END MAIN

