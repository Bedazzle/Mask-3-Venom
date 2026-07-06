; --- check_cheat_password -------------------------------------
; @done
; Compare the password the player typed (PASS_BUFFER) against the
; secret CHEAT_PASSWORD. On an exact match set CHEAT_FLAG, which
; disables ammo drain (consume_ammo) and drowning
; (check_drowning). Called from the interrupt on the password
; screen.
check_cheat_password:
	push af
	ld bc, CHEAT_FLAG - $0100
	inc b			; bc = CHEAT_FLAG
	xor a
	ld (bc), a		; clear the flag
	ld de, CHEAT_PASSWORD
	ld hl, PASS_BUFFER - CHEAT_PASSWORD
	add hl, de		; hl = PASS_BUFFER (entered code)

.cmp:
	ld a, (de)

	cp (hl)
	jr nz, .done		; mismatch -> not the cheat

	and a
	jr z, .match		; reached the terminator -> full match

	inc de
	inc hl

	jp .cmp

.match:
	ld a, $FF
	ld (bc), a		; CHEAT_FLAG = $FF (bc still points at it)

.done:
	pop af

	ret


CHEAT_PASSWORD:
	DB $63,$53,$12,$14,$22,$70,$12,$23
	DB $22,$12,$12,$00
CHEAT_FLAG:
	DB $00
