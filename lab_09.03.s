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
	
;karDizisi DCB 'f', 'a', 't', 'i', 'h'
;karDizisi1 DCB "bilgisayar"
	;END