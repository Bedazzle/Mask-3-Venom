; --- start_teleport: begin the teleport-out dissolve (state $0A, sound 9) (@done)
start_teleport:
	ld (ix+ALIEN.state), $0A
	ld (ix+ALIEN.timer), $32
	ld a, $01
	ld (DISSOLVE), a
	ld a, $09
	call play_sfx
	ret
