; --- player_dying: death state (accum 9) - wait out the timer, flush the screen, lose a life (@done)
player_dying:
	dec (ix+ALIEN.timer)
	ret nz
	call playfield_to_screen
	call playfield_to_screen
	jp lose_life_1
