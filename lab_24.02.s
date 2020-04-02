	AREA veriler, DATA,READWRITE
A DCD 0,0,0,0,0
	
	AREA RESET, CODE, READONLY
		ENTRY
	;LDR R6, =arrayA ;address
	;LDR R7, =arrayB ;address
	;MOV R0, #2 ;f
	;MOV R1, #3 ;g
	;MOV R2, #4 ;h
	;LDR R3, [R6, #16]
	;ADD R0, R1, R2; f=g+h
	;ADD R0, R1, R2, R3 ; f=f+B[4]
	
;arrayA 	DCD 10, 20, 30, 40, 50
;arrayB	DCD 1, 2, 3, 2, 1
	
	;LDR R6, =arrayA ;Array a address
	;LDR R7, =arrayB ;Array b address
	;MOV R1, #25 ;g
	;MOV R2, #4 
	;LDR R3, [R7, #16]
	
	;MUL R5, R3, R2	;A[1]
	;LDR R8, [R6, R5]
	
	;SUB R0, R1, R8 ; f=f-A[B[4]]
	
;arrayA 	DCD 10, 20, 30, 40, 50
;arrayB	DCD 1, 2, 3, 2, 1
	
	
	
	END