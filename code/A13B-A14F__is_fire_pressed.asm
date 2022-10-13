is_fire_pressed:
	ld a, (KEY_FIRE_CURRENT)
	ld (KEY_FIRE_PREVIOUS), a
	ld a, (KEMPSTON_YES)
	and a
	jp nz, test_keys	; optimize to JR

	in a, ($1F)			; kempston
	and %00011111		; 4=Fire, 3=Up, 2=Down, 1=Left, 0=Right
	ld (KEY_FIRE_CURRENT), a

	ret
