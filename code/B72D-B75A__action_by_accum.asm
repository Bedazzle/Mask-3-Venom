; choose target to jump by A value
; in: A is 2 to 12

action_by_accum: ;LB72D:
	sub $02
	; mult
	ld l, a
	add a, a	; x2
	add a, l	; x3
	ld l, a
	; mult L=A*3
	ld h, $00
	ld de, trunk_0
	add hl, de	; HL= trunk_0 + A*3  (jp ...)
	jp (hl)

trunk_0:
	jp go_upstairs

trunk_1:
	jp go_downstairs

trunk_2:
	jp go_sit_down

trunk_3:
	jp go_jump

trunk_4:
	jp go_fall

trunk_5:
	jp go_fly

trunk_6:
	jp LB99B

trunk_7:
	jp LB9B8

trunk_8:
	jp LB9D8

trunk_9:
	jp go_appear

trunk_10:
	jp LBA7B
