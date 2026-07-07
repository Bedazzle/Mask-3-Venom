; --- check_ground: test the two cells under the player for solid ground; returns count in a (@done)
check_ground:
	push de
	push bc
	bit 7, (ix+ALIEN.draw_x)
	jr z, check_ground_0
	call calc_player_map_ptr
	jr check_ground_1
check_ground_0:
	ld hl, (PLAYER_CELL_PTR)
	ld de, $0081
	add hl, de
check_ground_1:
	ld c, $00
	call is_solid
	jr nc, check_ground_2
	inc c
check_ground_2:
	inc l
	call is_solid
	jr nc, check_ground_3
	inc c
check_ground_3:
	ld a, c
	pop bc
	pop de
	ret
