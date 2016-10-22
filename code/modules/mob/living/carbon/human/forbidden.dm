/*
 *
 * FORBIDDEN FRUITS
 *
 */

/mob/living/carbon/human
	var/pleasure = 0

	var/virgin
	var/anal_virgin
	var/penis_size

	var/mob/living/carbon/human/lastfucked		// Last person you did something
	var/datum/forbidden/action/lfaction			// Last action you did to someone

	var/mob/living/carbon/human/lastreceived	// Last person you reveived something
	var/datum/forbidden/action/lraction			// Last action you received by someone

	var/canfuck = 1
	var/erpcooldown

/*
 * UI
 */

/mob/living/carbon/human/MouseDrop_T(mob/living/carbon/human/target, mob/living/carbon/human/user)
	// User drag himself to [src]
	if(istype(target))
		if(user == target && get_dist(user, src) <= 1)
			ui_interact(user)
	return ..()

/mob/living/carbon/human/ui_interact(mob/living/carbon/human/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(!istype(user) || get_dist(user, src) > 1)
		return

	var/data[0]
	data["src_gender"] = (gender == FEMALE ? 1 : 0)
	data["usr_gender"] = (user.gender == FEMALE ? 1 : 0)

	data["src_penis"] = has_penis()
	data["usr_penis"] = user.has_penis()

	data["src_vagina"] = has_vagina()
	data["usr_vagina"] = user.has_vagina()

	data["src_hands"] = has_hands()
	data["usr_hands"] = user.has_hands()

	data["src_anus"] = species.anus
	data["usr_anus"] = user.species.anus

	data["yourself"] = (src == user)

	data["src_name"] = "[src]"
	data["dist"] = get_dist(user, src)

	data["src_nude"] = is_nude()
	data["usr_nude"] = user.is_nude()

	data["src_face"] = is_face_clean()
	data["usr_face"] = user.is_face_clean()

	data["icon"] = (gender == user.gender ? gender == MALE ? "mars-double" : "venus-double" : "venus-mars")

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "erp.tmpl", "Forbidden Fruits", 450, 550, ignore_status = 1)
		ui.set_initial_data(data)
		ui.open()

/mob/living/carbon/human/proc/process_erp_href(href_list, mob/living/carbon/human/user)
	if(get_dist(user, src) <= 1 && user.incapacitated())
		if(user != src)
			if(user.is_face_clean() && is_nude())
				if(href_list["oral"])
					switch(href_list["oral"])
						if("penis")
							if(has_penis())
								user.fuck(src, forbidden_actions["blowjob"])

						else if("vagina")
							if(has_vagina())
								user.fuck(src, forbidden_actions["cunnilingus"])

			if(user.is_nude() && get_dist(user, src) == 0 && user.has_penis())
				if(href_list["fuck"])
					switch(href_list["fuck"])
						if("anus")
							if(is_nude() && species.anus)
								user.fuck(src, forbidden_actions["anal"])
						if("vagina")
							if(has_vagina() && is_nude())
								user.fuck(src, forbidden_actions["vaginal"])
						if("mouth")
							if(is_face_clean())
								user.fuck(src, forbidden_actions["mouthfuck"])

			if((user.is_nude() && user.has_vagina()) && (is_nude() && has_penis()) && get_dist(user, src) == 0)
				if(href_list["mount"])
					user.fuck(src, forbidden_actions["mount"])

			if(user.has_hands() && is_nude())
				if(href_list["finger"])
					switch(href_list["finger"])
						if("vagina")
							if(has_vagina())
								user.fuck(src, forbidden_actions["fingering"])

		if(user.is_nude())
			if(href_list["masturbate"])
				switch(href_list["masturbate"])
					if("genitals")
						user.fuck(src, forbidden_actions["masturbation"])
					if("anus")
						user.fuck(src, forbidden_actions["analmasturbation"])


/*
 *
 * ANAL STORAGE
 *
 */

/obj/item/weapon/storage/ass
	name = "ass storage"
	max_w_class = 2
	max_combined_w_class = 4
	silent = 1

/mob/living/carbon/human/attackby(obj/item/I, mob/user, params)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.a_intent == I_GRAB && H.zone_sel && H.zone_sel.selecting == "groin")
			if(ass_storage(H, I))
				return 1
	..()

/mob/living/carbon/human/proc/ass_storage(mob/living/carbon/human/H, obj/item/I = null)
	if(!species.anus)
		return 0

	if(!is_nude())
		to_chat(H, "<span class='notice'>You can't access [src == H ? "your" : "[src]'s"] anus.")
		return 0

	var/his = (src == H ? H.gender == FEMALE ? "her" : "his" : "[src]'s")
	var/your = (src == H ? "your" : "[src]'s")

	if(I)
		if(istype(I, /obj/item/weapon/disk/nuclear))
			to_chat(H, "<span class='warning'>Central command would kill you if you put it in there.</span>")
			return 1

		H.visible_message("<span class='notice'>[H] begins to put \the [I] inside [his] anus!", "<span class='notice'>You begin to put \the [I] inside [your] anus!")
		if(do_after(H, 30, target = src))
			if(ass_storage.can_be_inserted(I, 1))
				ass_storage.handle_item_insertion(I, 1)
				to_chat(H, "<span class='notice'>You put \the [I] inside [your] anus.")
			else
				to_chat(H, "<span class='warning'>\The [I] doesn't fit in [your] anus.")
	else
		H.visible_message("<span class='notice'>[H] begins to search inside [his] anus!", "<span class='notice'>You begin to search inside [your] anus!")
		if(do_after(H, 30, target = src))
			var/i = 0
			for(var/obj/item in ass_storage)
				i += 1
				ass_storage.remove_from_storage(item, src.loc)
			if(i == 0)
				to_chat(H, "<span class='warning'>[capitalize(your)] anus is empty.")
			else
				to_chat(H, "<span class='notice'>You remove everything from [your] anus.")
	return 1


/*
 *
 * HELPERS PROCS
 *
 */

/*
 * IS HELPERS
 */
/mob/living/carbon/human/proc/is_nude()
	return (!istype(w_uniform, /obj/item/clothing/under) && !istype(underpants, /obj/item/clothing/underwear/underpants))

/mob/living/carbon/human/proc/is_face_clean()
	if(((head && (head.flags & HEADCOVERSMOUTH)) || (wear_mask && (wear_mask.flags & MASKCOVERSMOUTH))))
		return 0
	if(!check_has_mouth())
		return 0
	return 1

/*
 * HAS HELPERS
 */
/mob/living/carbon/human/proc/has_penis()
	return (species.genitals && gender == MALE)

/mob/living/carbon/human/proc/has_vagina()
	return (species.genitals && gender == FEMALE)

/mob/living/carbon/human/proc/has_hands()
	var/obj/item/organ/external/temp = organs_by_name["r_hand"]
	var/hashands = (temp && temp.is_usable())
	if (!hashands)
		temp = organs_by_name["l_hand"]
		hashands = (temp && temp.is_usable())
	return hashands

/*
 * ACTION HELPERS
 */
/mob/living/carbon/human/proc/do_fucking_animation(mob/living/carbon/human/P)
	var/pixel_x_diff = 0
	var/pixel_y_diff = 0
	var/final_pixel_y = initial(pixel_y)

	var/direction = get_dir(src, P)
	if(direction & NORTH)
		pixel_y_diff = 8
	else if(direction & SOUTH)
		pixel_y_diff = -8

	if(direction & EAST)
		pixel_x_diff = 8
	else if(direction & WEST)
		pixel_x_diff = -8

	if(pixel_x_diff == 0 && pixel_y_diff == 0)
		pixel_x_diff = rand(-3,3)
		pixel_y_diff = rand(-3,3)
		animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
		animate(pixel_x = initial(pixel_x), pixel_y = initial(pixel_y), time = 2)
		return

	animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
	animate(pixel_x = initial(pixel_x), pixel_y = final_pixel_y, time = 2)

/*
 * Forbidden Controller
 */
/mob/living/carbon/human/proc/fuck(mob/living/carbon/human/P, datum/forbidden/action/action)
	if(!istype(P) || !istype(action) || !canfuck)
		return 0

	if(!action.conditions(src, P))
		return 0

	face_atom(P)

	lfaction = action
	lastfucked = P

	var/begins = 0
	if(P.lastreceived != src || P.lraction != action)
		begins = 1
		action.logAction(src, P)

	action.fuckText(src, P, begins)
	action.doAction(src, P)

	P.lastreceived = src
	P.lraction = action

	erpcooldown = world.time + 10;

	return 1

/mob/living/carbon/human/proc/moan()
	if(stat != DEAD)
		// Pleasure messages
		if(pleasure >= 70 && prob(15) && gender == FEMALE)
			visible_message("<span class='erp'><b>[src]</b> twists in orgasm!</span>")
		if(pleasure >= 30 && prob(12))
			visible_message("<span class='erp'><b>[src]</b> [gender == FEMALE ? pick("moans in pleasure", "moans") : "moans"].</span>")
			if(gender == FEMALE)
				playsound(loc, "sound/forbidden/erp/moan_f[rand(1, 7)].ogg", 70, 1, 0, pitch = get_age_pitch())

/mob/living/carbon/human/proc/cum(mob/living/carbon/human/P, hole = "floor")
	if(stat == DEAD)
		return 0

	var/pleasure_message = pick("... I'M FEELING SO GOOD! ...",  "... It's just INCREDIBLE! ...", "... MORE AND MORE AND MORE! ...")
	to_chat(src, "<span class='cum'>[pleasure_message]</span>")

	if(has_penis())
		switch(hole)
			if("floor")
				visible_message("<span class='cum'>[src] cums on the floor!</span>")
				var/obj/effect/decal/cleanable/sex/cum = new /obj/effect/decal/cleanable/sex/semen(loc)
				cum.add_blood_list(src)
			if("vagina")
				visible_message("<span class='cum'>[src] cums into <b>[P]</b>!</span>")
			if("anus")
				visible_message("<span class='cum'>[src] cums into [P]'s ass!</span>")
			if("mouth")
				visible_message("<span class='cum'>[src] cums into [P]'s mouth!</span>")
	else if(has_vagina())
		visible_message("<span class='cum'>[src] cums!</span>")
		var/obj/effect/decal/cleanable/sex/cum = new /obj/effect/decal/cleanable/sex/femjuice(loc)
		cum.add_blood_list(src)
		playsound(loc, "sound/forbidden/erp/final_f[rand(1, 3)].ogg", 90, 1, 0, pitch = get_age_pitch())
	else
		visible_message("<span class='cum'>[src] cums!</span>")

	add_logs(P, src, "came on")
	pleasure = 0

	druggy = 60
	if(staminaloss > 100)
		druggy = 300

mob/living/carbon/human/proc/handle_lust()
	pleasure -= 4
	if(pleasure <= 0)
		pleasure = 0
		lastfucked = null
		lfaction = null
	if(pleasure == 0)
		erpcooldown -= 1
	if(world.time > erpcooldown)
		canfuck = 1
	else
		canfuck = 0

/mob/living/carbon/human/verb/interact()
	set name = "Interact"
	set desc = "Interaction is good!"
	set category = "IC"
	set src in view(1)

	if(usr.stat == 1 || usr.restrained() || !isliving(usr))
		return

/*
	if(!click_check())
		return 0
*/

	ui_interact(usr)

/*
	var/message = ""
	if(action == ANAL)
		if(fucked_action == ANAL)
			return 0
		message = "plays with [owner.gender == MALE ? "his" : "her"] anus."
	else
		if(is_fuck(fucking_action))
			return 0
		if(is_oral(fucked_action))
			return 0
		if(fucking_action == VAGINAL)
			return 0
		message = "masturbates."
	owner.visible_message("<span class ='erp'><b>[owner]</b> [message]</span>")
	give_pleasure(3)
	click_time = world.time + 10
*/