; --- test_keys -------------------------------------------------
; @done
; Test the 5 control keys (right/left/down/up/fire) via read_key
; and build the direction+fire bitmask.
; Out: a = control bits
test_keys:
	push bc
	ld c, $00
	ld a, (KEY_RIGHT)
	call read_key
	jr nz, test_left

	set 0, c
	jr test_down

test_left:
	ld a, (KEY_LEFT)
	call read_key
	jr nz, test_down

	set 1, c
test_down:
	ld a, (KEY_DOWN)
	call read_key
	jr nz, test_up

	set 2, c
	jr test_fire

test_up:
	ld a, (KEY_UP)
	call read_key
	jr nz, test_fire

	set 3, c
test_fire:
	ld a, (KEY_FIRE)
	call read_key
	jr nz, copy_keys

	set 4, c
copy_keys:
	ld a, c
	ld (KEY_FIRE_CURRENT), a
	pop bc

	ret
