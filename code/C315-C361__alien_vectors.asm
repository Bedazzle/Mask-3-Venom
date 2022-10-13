alien_vectors:
	IFNDEF DESERT
		ld a, (ix+$00)
	ELSE
		ret
		nop
		nop
	ENDIF

	and $3F
	ret z

	ld l, a
	add a, a
	add a, l
	ld l, a
	ld h, $00
	ld de, LC326
	add hl, de

	jp (hl)


LC326:
	jp deadly_loop	; vector 0

LC329:
	jp LC375	; vector 1 spheres

LC32C:
	jp LC3A6	; vector 2 rockets

LC32F:
	jp LC3F1	; vector 3 hit by sphere/mushroom
				; rockets

LC332:
	jp LC457	; vector 4 cannon

somejump_LC335:
	jp LC521	; vector 5 cannon

LC338:
	jp LC562	; vector 6

LC33B:
	jp LC5D9	; vector 7 mushrooms

LC33E:
	jp LC64E	; vector 8

LC341:
	jp just_a_ret	; vector 9

LC344:
	jp LC6D4	; vector 10 mushroom/rocket shot

somejump_LC347:
	jp LC6F2	; vector 11 collision with rotator
				; bomber

LC34A:
	jp LC73F	; vector 12

LC34D:
	jp LC78A	; vector 13 bomb

LC350:
	jp LC81B	; vector 14

LC353:
	jp LC860	; vector 15

LC356:
	jp LC89B	; vector 16 bomber + rotators

somejump_LC359:
	jp LC922	; vector 17 collision with bomber

LC35C:
	jp LC980	; vector 18

LC35F:
	jp LC9B8	; vector 19
