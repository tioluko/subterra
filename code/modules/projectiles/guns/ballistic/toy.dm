/obj/item/gun/ballistic/automatic/toy
	name = "foam force SMG"
	desc = ""
	icon_state = "saber"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/toy/smg
	fire_sound = 'sound/blank.ogg'
	force = 0
	throwforce = 0
	burst_size = 3
	can_suppress = TRUE
	clumsy_check = 0
	item_flags = NONE
	casing_ejector = FALSE

/obj/item/gun/ballistic/automatic/toy/update_icon()
	. = ..()
	add_overlay("[icon_state]_toy")

/obj/item/gun/ballistic/automatic/toy/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/toy/pistol
	name = "foam force pistol"
	desc = ""
	icon_state = "pistol"
	bolt_type = BOLT_TYPE_LOCKING
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/toy/pistol
	fire_sound = 'sound/blank.ogg'
	burst_size = 1
	fire_delay = 0
	actions_types = list()

/obj/item/gun/ballistic/automatic/toy/pistol/riot
	mag_type = /obj/item/ammo_box/magazine/toy/pistol/riot

/obj/item/gun/ballistic/automatic/toy/pistol/riot/Initialize()
	magazine = new /obj/item/ammo_box/magazine/toy/pistol/riot(src)
	return ..()

/obj/item/gun/ballistic/automatic/toy/pistol/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/toy/pistol/riot/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/shotgun/toy
	name = "foam force shotgun"
	desc = ""
	force = 0
	throwforce = 0
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy
	fire_sound = 'sound/blank.ogg'
	clumsy_check = FALSE
	item_flags = NONE
	casing_ejector = FALSE
	can_suppress = FALSE
	pb_knockback = 0

/obj/item/gun/ballistic/shotgun/toy/update_icon()
	. = ..()
	add_overlay("[icon_state]_toy")

/obj/item/gun/ballistic/shotgun/toy/process_chamber(empty_chamber = 0)
	..()
	if(chambered && !chambered.BB)
		qdel(chambered)

/obj/item/gun/ballistic/shotgun/toy/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/shotgun/toy/crossbow
	name = "foam force crossbow"
	desc = ""
	icon = 'icons/obj/toy.dmi'
	icon_state = "foamcrossbow"
	item_state = "crossbow"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy/crossbow
	fire_sound = 'sound/blank.ogg'
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gun/ballistic/automatic/c20r/toy //This is the syndicate variant with syndicate firing pin and riot darts.
	name = "donksoft SMG"
	desc = ""
	can_suppress = TRUE
	item_flags = NONE
	mag_type = /obj/item/ammo_box/magazine/toy/smgm45/riot
	casing_ejector = FALSE
	clumsy_check = FALSE

/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted //Use this for actual toys
	pin = /obj/item/firing_pin
	mag_type = /obj/item/ammo_box/magazine/toy/smgm45

/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot
	mag_type = /obj/item/ammo_box/magazine/toy/smgm45/riot

/obj/item/gun/ballistic/automatic/c20r/toy/update_icon()
	. = ..()
	add_overlay("[icon_state]_toy")

/obj/item/gun/ballistic/automatic/l6_saw/toy //This is the syndicate variant with syndicate firing pin and riot darts.
	name = "donksoft LMG"
	desc = ""
	fire_sound = 'sound/blank.ogg'
	can_suppress = FALSE
	item_flags = NONE
	mag_type = /obj/item/ammo_box/magazine/toy/m762/riot
	casing_ejector = FALSE
	clumsy_check = FALSE

/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted //Use this for actual toys
	pin = /obj/item/firing_pin
	mag_type = /obj/item/ammo_box/magazine/toy/m762

/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted/riot
	mag_type = /obj/item/ammo_box/magazine/toy/m762/riot

/obj/item/gun/ballistic/automatic/l6_saw/toy/update_icon()
	. = ..()
	add_overlay("[icon_state]_toy")
