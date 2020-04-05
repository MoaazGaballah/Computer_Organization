;;f=g-A[B[4]]
	;AREA veriler, DATA, READWRITE
;Array	DCD 0,0,0,0,0
	;AREA ornek, CODE, READONLY
	;ENTRY
	;LDR r6, =Adizi
	;LDR r7, =Bdizi
	;MOV r1, #25
	;LDR r3, [r7,#16] ;r3 =B[4]
	;LDR r8, [r6, r3] ;r4 =A[B[4]]
	;SUB r0, r1, r8
	
	
	
;Adizi	DCD 10,20,30,40,50
;Bdizi	DCD	1,2,3,2,1
	;END
	;AREA ornek, CODE, READONLY
	;ENTRY
	;LDR r6, =dizi
	;LDR r7, =5
	;LDR r3, [r6]
;bas
	;ADD r1, r1, #4
	;LDR r4, [r6, r1]
	;CMP r3, r4
	;BGT	islem
	;MOV r3, r4
;islem
	;sub r7, r7, #1
	;CMP r7, #0
	;BNE bas
;dizi DCD 5,7,1,2,15,10	
	;END
	
	;AREA soru1, CODE, READONLY
	;ENTRY
	;LDR r7, =karDizisi
	;LDR r3, =1
	;LDR r0, =0 ;karakter saayisi
;bas	LDRB r4, [r7, r3] ;karDizisi[r3] (1 karakter)
	;CMP r4, #'$'
	;BEQ son
	;ADD r0, r0, #1
	;ADD r3, r3, #1 ; go to next index
	;B bas
;son
	
;karDizisi DCB 'f', 'a', 't', 'i', 'h', '$'
;karDizisi1 DCB "bilgisayar"
	;END
	
	;AREA soru2, CODE, READONLY
;NUM EQU 14
	;ENTRY
	;;r0 ilk, r1 son, r2 orta, r3 index, r5 aranan, r6 dizini adresi
	;MOV r5, #10
	;LDR r6, =dizi ;ADR r6, dizi
	;MOV r0, #0
	;MOV r1, #NUM-1 ;son elemanin index'i
;don	CMP r0, r1
	;BGT son
	;ADD r2, r0, r1
	;MOV r2, r2, ASR #1
	;LDR r7, [r6, r2, LSL #2]
	;CMP r5, r7
	;ADDGT r0, r2, #1
	;SUBLT r1, r2, #1
	;BNE	don
	
;son	MOV r4, r2
	
	
;dizi DCD 1,2,3,4,5,6,7,8,9,10,11,12,13,14
	;END
	
	;AREA veriler,DATA,READWRITE	
;Array DCD 0, 0, 0, 0, 0
	
	;AREA ornek,CODE,READONLY
	;ENTRY
	;;LDR R6,=0X00001000
	;LDR R6,=Array
	;LDR R7,=dizi
	;LDR R3,[R7]	
	;STR R3,[R6]
	;LDR R2,[R6]
	
;dizi DCD 3, 20, 30, 40, 50
	;END
