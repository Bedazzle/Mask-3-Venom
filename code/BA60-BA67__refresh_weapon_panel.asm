; --- refresh_weapon_panel -------------------------------------
; @done
; Repaint the weapon panel (slot 6 row) via update_weapon_panel.
refresh_weapon_panel:
	push af
	ld a, $06

	call update_weapon_panel

	pop af

	ret
