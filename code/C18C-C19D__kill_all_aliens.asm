; --- kill_all_aliens: mark all 6 alien slots for removal (spawn = $FF) (@done)
kill_all_aliens:
	ld iy, ALIEN.1
	ld de, ALIEN_LEN
	ld b, $06
loop_kill_aliens:
	ld (iy+ALIEN.spawn), $FF
	add iy, de
	djnz loop_kill_aliens

	ret
