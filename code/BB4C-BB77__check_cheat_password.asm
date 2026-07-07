; --- check_cheat_password -------------------------------------
; @done
; Compare the password the player typed (PASS_BUFFER) against the
; secret CHEAT_PASSWORD - the OFFICIAL CHEAT "JUDGE DREDD". On an
; exact match set CHEAT_FLAG, which disables ammo drain
; (consume_ammo) and drowning (check_drowning). Called from the
; interrupt on the password screen.
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


; *** THE OFFICIAL CHEAT: on the password screen, type  JUDGE DREDD ***
; Stored as ZX-keyboard codes (high nibble = half-row, low nibble = key index;
; e.g. $12 = half-row 1 key 2 = D, $70 = half-row 7 key 0 = SPACE), same scheme
; as the level passwords PASS_1..4.
CHEAT_PASSWORD:					; "JUDGE DREDD"
	DB $63,$53,$12,$14,$22		; J U D G E
	DB $70					;   (space)
	DB $12,$23,$22,$12,$12		; D R E D D
	DB $00					;   terminator
CHEAT_FLAG:
	DB $00
