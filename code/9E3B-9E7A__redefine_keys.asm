redefine_keys:
	xor a
	ld (KEY_FIRE), a
	ld (KEY_UP), a
	ld (KEY_DOWN), a
	ld (KEY_LEFT), a
	ld (KEY_RIGHT), a

	call L9E10

	ld hl, WORD_PRESS
	ld de, $080A

	call print_string

	ld hl, WORD_FIRE
	ld e, $10

	call enter_new_key
	ld (KEY_FIRE), a

	call enter_new_key
	ld (KEY_UP), a

	call enter_new_key
	ld (KEY_DOWN), a

	call enter_new_key
	ld (KEY_LEFT), a

	call enter_new_key
	ld (KEY_RIGHT), a

	ret
