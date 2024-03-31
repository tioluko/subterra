/mob/proc/overlay_fullscreen(category, type, severity)
	var/obj/screen/fullscreen/screen = screens[category]
	if (!screen || screen.type != type)
		// needs to be recreated
		clear_fullscreen(category, FALSE)
		screens[category] = screen = new type()
		screen.category = category
	else if ((!severity || severity == screen.severity) && (!client || screen.screen_loc != "CENTER-7,CENTER-7" || screen.view == client.view))
		// doesn't need to be updated
		return screen

	screen.icon_state = "[initial(screen.icon_state)][severity]"
	screen.severity = severity
	if (client && screen.should_show_to(src))
		screen.update_for_view(client.view)
		client.screen += screen

	return screen


/mob/proc/flash_fullscreen(state)
	var/obj/screen/fullscreen/flashholder/screen = screens["flashholder"]

	if(!screen)
		screen = new /obj/screen/fullscreen/flashholder()
		screens["flashholder"] = screen

	if(client && screen.should_show_to(src))
		screen.update_for_view(client.view)
		client.screen += screen

	flick(state,screen)
	return screen


/mob/proc/clear_fullscreen(category, animated = 10)
	var/obj/screen/fullscreen/screen = screens[category]
	if(!screen)
		return

	screens -= category

	if(animated)
		animate(screen, alpha = 0, time = animated)
		addtimer(CALLBACK(src, .proc/clear_fullscreen_after_animate, screen), animated, TIMER_CLIENT_TIME, flags = ANIMATION_PARALLEL)
	else
		if(client)
			client.screen -= screen
		qdel(screen)

/mob/proc/clear_fullscreen_after_animate(obj/screen/fullscreen/screen)
	if(client)
		client.screen -= screen
	qdel(screen)

/mob/proc/clear_fullscreens()
	for(var/category in screens)
		clear_fullscreen(category)

/mob/proc/hide_fullscreens()
	if(client)
		for(var/category in screens)
			client.screen -= screens[category]

/mob/proc/reload_fullscreen()
	if(client)
		var/obj/screen/fullscreen/screen
		for(var/category in screens)
			screen = screens[category]
			if(screen.should_show_to(src))
				screen.update_for_view(client.view)
				client.screen |= screen
			else
				client.screen -= screen

/obj/screen/fullscreen
	icon = 'icons/mob/screen_full.dmi'
	icon_state = "default"
	screen_loc = "CENTER-7,CENTER-7"
	layer = FULLSCREEN_LAYER
	plane = FULLSCREEN_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/view = 7
	var/severity = 0
	var/show_when_dead = FALSE

/obj/screen/fullscreen/proc/update_for_view(client_view)
	if (screen_loc == "CENTER-7,CENTER-7" && view != client_view)
		var/list/actualview = getviewsize(client_view)
		view = client_view
		transform = matrix(actualview[1]/FULLSCREEN_OVERLAY_RESOLUTION_X, 0, 0, 0, actualview[2]/FULLSCREEN_OVERLAY_RESOLUTION_Y, 0)

/obj/screen/fullscreen/proc/should_show_to(mob/mymob)
	if(!show_when_dead && mymob.stat == DEAD)
		return FALSE
	return TRUE

/obj/screen/fullscreen/Destroy()
	severity = 0
	. = ..()

/obj/screen/fullscreen/brute
	icon_state = "brutedamageoverlay"
	layer = UI_DAMAGE_LAYER
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/painflash
	icon_state = "painflash"
	layer = 20.19
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/oxy
	icon_state = "oxydamageoverlay"
	layer = UI_DAMAGE_LAYER
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/love
	icon_state = "lovehud"
	layer = 20.509
	plane = FULLSCREEN_PLANE
	alpha = 0

/obj/screen/fullscreen/love/New(client/C)
	. = ..()
	animate(src, alpha = 255, time = 30)

/obj/screen/fullscreen/crit
	icon_state = "passage"
	layer = 20.51
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/crit/uncon
	icon_state = "uncon"
	layer = 20.511
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/crit/zeth
	icon = 'icons/mob/z.dmi'
	icon_state = "zeth"
	name = "NECRA"
//	layer = 20.09
	layer = 20.512
	plane = FULLSCREEN_PLANE
	mouse_opacity = 1
	nomouseover = FALSE

/obj/screen/fullscreen/crit/zeth/Click()
	if(isliving(usr))
		var/mob/living/L = usr
		if(L.stat != DEAD)
			if(alert("Are you done living?", "", "Yes", "No") == "Yes")
				if(!L.succumb_timer || (world.time < L.succumb_timer + 111 SECONDS) )
					var/ttime =  round(((L.succumb_timer + 111 SECONDS) - world.time) / 10)
					to_chat(L, "<span class='redtext'>I'm not dead enough yet. [ttime]</span>")
				else
					L.succumb(reaper = TRUE)

/obj/screen/fullscreen/crit/death
	icon_state = "DD"
	layer = 20.511
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/crit/cmode
	icon_state = "cmode"
	layer = 20.09
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/crit/vision
	icon_state = "oxydamageoverlay"
	layer = BLIND_LAYER

/obj/screen/fullscreen/blackimageoverlay
	icon_state = "blackimageoverlay"
	layer = BLIND_LAYER
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/blind
	icon_state = "blind"
	layer = BLIND_LAYER
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/curse
	icon_state = "curse"
	layer = CURSE_LAYER
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/flashholder
	icon_state = ""
	layer = CRIT_LAYER
	plane = FULLSCREEN_PLANE

/obj/screen/fullscreen/impaired
	icon_state = "impairedoverlay"

/obj/screen/fullscreen/flash
	icon = 'icons/mob/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "flash"

/obj/screen/fullscreen/flash/static
	icon = 'icons/mob/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "noise"

/obj/screen/fullscreen/high
	icon = 'icons/mob/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "druggy"
	alpha = 80

/obj/screen/fullscreen/purest
	icon = 'icons/mob/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "purest"
	alpha = 100

/obj/screen/fullscreen/fade
	icon = 'icons/mob/roguehudback2.dmi'
	screen_loc = ui_backhudl
	icon_state = "fade"
	layer = 50
	plane = 50
	alpha = 255

/obj/screen/fullscreen/color_vision
	icon = 'icons/mob/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "flash"
	alpha = 80

/obj/screen/fullscreen/color_vision/green
	color = "#00ff00"

/obj/screen/fullscreen/color_vision/red
	color = "#ff0000"

/obj/screen/fullscreen/color_vision/blue
	color = "#0000ff"

/obj/screen/fullscreen/lighting_backdrop
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "flash"
	transform = matrix(200, 0, 0, 0, 200, 0)
	plane = LIGHTING_PLANE
	blend_mode = BLEND_OVERLAY
	show_when_dead = TRUE

//Provides darkness to the back of the lighting plane
/obj/screen/fullscreen/lighting_backdrop/lit
	invisibility = INVISIBILITY_LIGHTING
	layer = BACKGROUND_LAYER+21
	color = "#000"
	show_when_dead = TRUE

//Provides whiteness in case you don't see lights so everything is still visible
/obj/screen/fullscreen/lighting_backdrop/unlit
	layer = BACKGROUND_LAYER+20
	show_when_dead = TRUE

/obj/screen/fullscreen/see_through_darkness
	icon_state = "nightvision"
	plane = LIGHTING_PLANE
	layer = LIGHTING_LAYER
	blend_mode = BLEND_ADD
	show_when_dead = TRUE
