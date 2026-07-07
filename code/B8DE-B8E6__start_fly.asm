; --- start_fly: enter the flying state (Jackrabbit) (@done)
start_fly:
	ld (ix+ALIEN.state), $07
	ld (ix+ALIEN.param1), $04
	ret
