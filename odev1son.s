	;asagidaki kod java'dan assembly'ye cevirildi.
	;Bir dizi siralamak orneigidir.
	;public static void countingSort(int[] input, int k) {
        ;// create buckets 
        ;int counter[] = new int[k + 1];

        ;// fill buckets
        ;for (int d = 0; d < input.length; d++) {
            ;int r = input[d];
            ;counter[r] = counter[r] + 1;
        ;}
        ;// sort array 
        ;int ndx = 0;
        ;for (int i = 0; i < counter.length; i++) {
            ;for (; 0 < counter[i];) {
                ;input[ndx] = i;
                ;ndx = ndx + 1;
                ;counter[i] = counter[i] - 1;
            ;}
        ;}
    ;}
	AREA ornek, CODE, READONLY
	ENTRY
	LDR r5, =counterDizisi ; dizinin addresi (dizinin baslangici) 
	LDR r6, =inputDizisi ; dizinin addresi (dizinin baslangici)
	
;---- birinci loop degiskenleri-----
	LDR r7, = 7 ; inputDizisi boyutu (yani inputDizisi'ndeki en buyuk elemani kacsa, odur)
	LDR r8, = 0 ; inputDizisine gezmek icin (d=0) (dorder atlayacak)
	LDR r9, = 0 ; birinci loop un limiti kontrol etmek icin, birnci loop un offset degeri (d++)
; ------- birinci loop baslangici--------
birinciLoopDon
	CMP r9, r7
	BGT birinciLoopSon
; ------- birinci loop baslangici--------
	LDR r0, [r6, r8] ; birinci loop, counterDizisinin ust sinirina gelmediyse (yani r0 = input[d]) yap
	LDR r3, =4 ; bu dort counterDizisindeki atlamalar icin, MUL komutunda kullanilacak 
	MUL r2, r0, r3
	LDR r1, [r5, r2] ; r1 temp register olarak counterDizisinin r'deki degeri tutuyor (yani r1 = counter[r] ) 
	ADD r1, r1, #1 ; temp deki degeri bir kadar artiyoruz (yani r1 = counter[r] + 1)
	LDR r3, =4 ; bu dort counterDizisindeki atlamalar icin, MUL komutunda kullanilacak 
	MUL r2, r0, r3
	STR r1 , [r5, r2] ; degeri artigimizda geri diziye yaziyoruz (yani counter[r] = r1)
	ADD r8, r8, #4
	ADD r9, #1
	B birinciLoopDon
birinciLoopSon	
;-------- birinci loop sonu--------

	LDR r2, =0 ; ndx degiskeni icin
	
;---- ikinci, dis loop degiskenleri------
	LDR r10, =6 ; counterDizisinin boyutu yani hem dis hem de ic looplarin ust siniri
	LDR r11, =0 ; counterDizisine gezmek icin (i=0) (dorder atlayacak)
	LDR r12, =0 ;  ikinci, distaki loop un limiti kontrol etmek icin, distaki loop un offset degeri (i++)
; ------- distaki loop baslangici--------
disLoopDon
	CMP r12, r10 ; distaki loop, dizinin sinirina geldi mi
	BGT disLoopSon ; distaki loop, dizinin sinirina geldiyse loop u bitir
	LDR r3, [r5, r11] ; distaki loop, counterDizisinin ust sinirina gelmediyse (r3 = counter[i]) yap
	
; ------- icteki loop baslangici--------
icLoopDon
	CMP r3, #0 ; icteki loop, sifir olana kadar don
	BLE icLoopSon ; icteki loop, dizinin sinirina geldiyse bitir programi yani for (; 0 < counter[i];) {
	STR r12, [r5, r2] ; input[ndx] = i
	ADD r2, r2, #1 ; ndx = ndx + 1
	SUB r3, r3, #1 ; r3 = counter[i] - 1
	STR r3, [r5, r12]
	B icLoopDon
icLoopSon
;-------- icteki loop sonu--------

	ADD r11, r11, #4 ; distaki loop, dizinin ust sinirina gelmediyse, offset i dort byte kadar artir
	ADD r12, #1 ; distaki loop, dizinin ust sinirina gelmediyse, alt siniri bir artir
	B disLoopDon
disLoopSon
;-------- ikinci, distaki loop sonu--------

inputDizisi DCD 3, 4, 6, 2, 1, 1, 3, 5
counterDizisi DCD 0, 0, 0, 0, 0, 0, 0 ,0
	END