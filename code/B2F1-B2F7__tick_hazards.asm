; --- tick_hazards: per-frame hazard tick - drowning check + rotator alien spawn (@done)
tick_hazards:
	call check_drowning
	call spawn_alien_at_rotator
	ret
