; --- spawn_alien_at_rotator -----------------------------------
; @done
; If the player overlaps a rotator (ROTATORS list), destroy it -
; mark its cell ROTATOR_KILL, clear the collision cells - and spawn
; an alien at that spot (VANISH_MED template). Drains energy unless
; SAFEROTATOR is defined.
spawn_alien_at_rotator:
	ld a, (BLAST_ARMED)
	and a
	ret nz

	ld ix, ROTATORS
	ld b, $04
	ld de, ROTATOR_LEN
	ld a, (PLAYER_X_COORD)
	ld l, a
	ld a, (PLAYER_Y_COORD)
	ld h, a
.scan:
	ld a, l
	add a, $0A
	sub (ix+ROTATOR.X)
	jr c, .next

	cp $0E
	jr nc, .next

	ld a, h
	add a, $14
	sub (ix+ROTATOR.Y)
	jr c, .next
	jr .found

.next:
	add ix, de
	djnz .scan

	ret

.found:
	ld a, (ix+ROTATOR.Y)
	add a, $08
	and $F8
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld a, (ix+ROTATOR.X)
	sub $40
	srl a
	srl a
	ld e, a
	ld d, $00
	add hl, de
	ld de, PLAYFIELD_MAP
	add hl, de
	xor a
	ld (hl), a
	inc l
	ld (hl), a
	ld de, $001F
	add hl, de
	ld (hl), a
	inc l
	ld (hl), a
	ld l, (ix+ROTATOR.CELL_LO)
	ld h, (ix+ROTATOR.CELL_HI)
	ld (hl), ROTATOR_KILL	;$47
	ld iy, ALIEN.1
	ld de, ALIEN_LEN
	ld b, $06
.find_slot:
	ld a, (iy+ALIEN.state)
	and $7F
	jr z, .spawn

	add iy, de
	djnz .find_slot

	jr .drain

.spawn:
	ld a, (ix+ROTATOR.X)
	ld (ix+ROTATOR.X), $00
	ld (iy+ALIEN.x), a
	ld a, (ix+ROTATOR.Y)
	add a, $08
	ld (iy+ALIEN.y), a
	push iy
	pop ix

	ld hl, VANISH_MED	; rotator disappearing by collision
	call start_vanish

	ld (ix+ALIEN.xvel), $00
	ld (ix+ALIEN.yvel), $FE
.drain:
	ld a, (ENERGY)
	IFNDEF SAFEROTATOR
		sub $19
	ELSE
		nop
		nop
	ENDIF
	ld (ENERGY), a
	ret nc
	
	xor a
	ld (ENERGY), a

	ret
