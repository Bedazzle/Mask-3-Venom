; --- enter_new_key ---------------------------------------------
; @done
; Prompt for and wait for a single keypress to assign to a control.
; In: hl = prompt string
enter_new_key:
	call print_string

	push hl
loop_press_key:
	call wait_keypress

	ex af, af'
	ld hl, KEY_FIRE
	ld b, $05

loop_check_pressed:
	cp (hl)
	jr z, loop_press_key

	inc hl
	djnz loop_check_pressed

	pop hl

	ret
