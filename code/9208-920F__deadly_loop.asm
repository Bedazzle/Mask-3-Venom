; do a stripes on the border
; exit via reset
; can be optimized by removing this code

deadly_loop:
	di
	xor a, $07
	out ($FE), a

	jp deadly_loop
