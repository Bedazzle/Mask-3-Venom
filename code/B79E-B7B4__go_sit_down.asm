go_sit_down:
	ld a, (KEY_FIRE_CURRENT)
	bit 2, a
	jr z, LB79E_0		; optimize -> change to jp nz collect_box

	jp collect_box		; optimize -> remove

LB79E_0:
	ld (ix+$00), $01
	ld a, (PLAYER_Y_COORD)
	sub $08
	ld (PLAYER_Y_COORD), a

	ret
