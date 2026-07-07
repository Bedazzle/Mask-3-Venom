; --- dead_exit4 (DEAD) --------------------------------------------
; @done
; Vestigial 4th-exit handler (unreferenced -> never runs). Reads
; the current room's exit record and tests the unused
; ROOM_EXITS._03 slot, which is always $FF, so it always returns;
; otherwise it would set that as the level and redraw the room.
dead_exit4:
	ld ix, (ROOM_EXITS_ADDR)
	ld a, (ix+ROOM_EXITS._03)
	cp $FF
	ret z

	ld (LEVEL_NUMBER), a
	jp draw_room
