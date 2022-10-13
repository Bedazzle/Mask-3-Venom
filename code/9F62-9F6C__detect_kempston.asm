; out: A=0 kempston present
;   A<>0 no kempston
; https://zxpress.ru/article.php?id=16611

detect_kempston:
	ld b, $00
loop_kempston:
	in a, ($1F)
	and $E0	; 1110 0000
	ret nz		; no kempston

	djnz loop_kempston

	xor a
	ret
