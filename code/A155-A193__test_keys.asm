test_keys:
	push bc
	ld c, $00
	ld a, (KEY_RIGHT)
	call LA090
	jr nz, test_left

	set 0, c
	jr test_down

test_left:
	ld a, (KEY_LEFT)
	call LA090
	jr nz, test_down

	set 1, c
test_down:
	ld a, (KEY_DOWN)
	call LA090
	jr nz, test_up

	set 2, c
	jr test_fire

test_up:
	ld a, (KEY_UP)
	call LA090
	jr nz, test_fire

	set 3, c
test_fire:
	ld a, (KEY_FIRE)
	call LA090
	jr nz, copy_keys

	set 4, c
copy_keys:
	ld a, c
	ld (KEY_FIRE_CURRENT), a
	pop bc

	ret
