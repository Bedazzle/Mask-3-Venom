; --- go_appear: alien spawn-in - play appear sfx, start dissolve animation, advance state (@done)
go_appear:
	ld a, $09
	call play_sfx
	ld a, $32  ; duration
	ld (ix+ALIEN.timer), a
	ld a, $04
	ld (DISSOLVE), a
	inc (ix+ALIEN.state)
	ret
