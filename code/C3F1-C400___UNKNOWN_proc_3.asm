LC3F1:
	dec (ix+$10)
	jr nz, LC3F1_0

	ld (ix+$00), $00

	ret
LC3F1_0:
	inc (ix+$18)

	jp LC362
