	;asagidaki kod java'dan assembly'ye cevirildi.
	;Bir dizi siralamak orneigidir.
	;int[] a = {3, 0, 6, 2, 1};
	;int temp;
	;for (int i = 0; i < 5; i++) {
		;for (int j = i + 1; j < 5; j++) {
			;if (a[i] > a[j]) {
				;temp = a[i];
				;a[i] = a[j];
				;a[j] = temp;
			;}
		;}
	;}
	
	;AREA ornek, CODE, READONLY
	;ENTRY
	;LDR r6, =dizi ; dizinin address (dizinin baslangici)
	;LDR r7, =4 ; dizinin boyutu yani hem dis hem de ic looplarin ust siniri
	;LDR r8, =0 ; diziye gezmek icin (i=0) (dorder atlayacak)
	;LDR r9, =0 ;  distaki loop in limiti kontrol etmek icin, distaki loop in offset degeri (i++)
;disLoopDon
	;CMP r9, r7 ; distaki loop, dizinin sinirina geldi mi
	;BGT disLoopSon ; distaki loop, dizinin sinirina geldiyse bitir programi
	;LDR r3, [r6, r8] ; distaki loop, dizinin ust sinirina gelmediyse (r3 = a[i]) yap
;; ------- icteki loop baslangici--------
	;ADD r10, r8, #4 ; icteki loop in limiti kontrol etmek icin (j=i+1) yani icteki loop alt siniri
	;MOV r11, r9 ; diziye gezmek icin, icteki loop in offset degeri (j++)
;icLoopDon
	;CMP r11, r7 ; icteki loop, dizinin sinirina geldi mi
	;BGE icLoopSon ; icteki loop, dizinin sinirina geldiyse bitir programi
	;LDR r4, [r6, r10] ; icteki loop, dizinin ust sinirina gelmediyse (r4 = a[j]) yap
;;-------- karsilastirma ---------------
	;CMP r3, r4 ; r3 ile r4 karsilastir
	;BLE karsilastirmayiAtla ; kucuk veya esitse karsilastirmayi atla
	;MOV r2, r3 ; temp = a[i] ; buyukse temp'e yani r2'ye a[i] at
	;STR r4, [r3] ; a[i] = a[j]
	;STR r2, [r4] ; a[j] = temp
;;--------karsilastirma bitti ----------
;karsilastirmayiAtla
	;ADD r10, r10, #4 ; icteki loop, dizinin ust sinirina gelmediyse, offset i dort byte kadar artir
	;ADD r11, #1 ; icteki loop, dizinin ust sinirina gelmediyse, alt siniri bir artir
	;B icLoopDon
;icLoopSon
;;-------- icteki loop sonu--------
	;ADD r8, r8, #4 ; distaki loop, dizinin ust sinirina gelmediyse, offset i dort byte kadar artir
	;ADD r9, #1 ; distaki loop, dizinin ust sinirina gelmediyse, alt siniri bir artir
	;B disLoopDon
;disLoopSon
;dizi DCD 3, 0, 6, 2, 1
	;END