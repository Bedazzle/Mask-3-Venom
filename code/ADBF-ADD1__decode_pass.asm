; DE=password address
; HL=password buffer
decode_pass:
	push af
decode_loop:
	ld a, (de)
	and a
	jr z, decode_last

	call decode_char

	ld (hl), a
	inc hl
	inc de
	jp decode_loop		; optimize to JR

decode_last:
	dec hl
	set 7, (hl)
	pop af

	ret
