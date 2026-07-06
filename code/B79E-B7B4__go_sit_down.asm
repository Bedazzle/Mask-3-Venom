; --- go_sit_down -----------------------------------------------
; @done
; Player crouch/sit state: if down+fire is held, collect the box
; under the player (collect_box).
; In: ix = player
go_sit_down:
	ld a, (KEY_FIRE_CURRENT)
	bit 2, a
	jr z, .no_box		; optimize -> change to jp nz collect_box

	jp collect_box		; optimize -> remove

.no_box:
	ld (ix+ALIEN.state), $01
	ld a, (PLAYER_Y_COORD)
	sub $08
	ld (PLAYER_Y_COORD), a

	ret
