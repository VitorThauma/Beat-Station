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

	var/click_CD
	var/remove_CD
	var/pleasure_CD

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
	var/list/penis_actions = list()
	var/list/vagina_actions = list()
	var/list/mouth_actions = list()
	var/list/misc_actions = list()

	var/list/emote_list = list()

	var/data[0]

	for(var/key in forbidden_actions)
		var/datum/forbidden/action/A = forbidden_actions[key]

		if(!A.conditions(user, src))
			continue
		if(isoral(A))
			mouth_actions.Add(list(list(\
				"action_button" = A.actionButton(user, src), \
				"name" = A.name)))
		else if(isfuck(A))
			penis_actions.Add(list(list(\
				"action_button" = A.actionButton(user, src), \
				"name" = A.name)))
		else if(isvagina(A))
			vagina_actions.Add(list(list(\
				"action_button" = A.actionButton(user, src), \
				"name" = A.name)))
		else if(isemote(A))
			emote_list.Add(list(list(\
				"action_button" = A.actionButton(user, src), \
				"name" = A.name)))
		else
			misc_actions.Add(list(list(\
				"action_button" = A.actionButton(user, src), \
				"name" = A.name)))

	data["penis_list"] = penis_actions
	data["penis_len"] = penis_actions.len

	data["vagina_list"] = vagina_actions
	data["vagina_len"] = vagina_actions.len

	data["mouth_list"] = mouth_actions
	data["mouth_len"] = mouth_actions.len

	data["misc_list"] = misc_actions
	data["misc_len"] = misc_actions.len

	data["emote_list"] = emote_list
	data["emote_len"] = emote_list.len

	data["src_name"] = "[src]"
	data["icon"] = (gender == user.gender ? gender == MALE ? "mars-double" : "venus-double" : "venus-mars")

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "erp.tmpl", "Forbidden Fruits", 450, 550, ignore_status = 1)
		ui.set_initial_data(data)
		ui.open()

/mob/living/carbon/human/proc/process_erp_href(href_list, mob/living/carbon/human/user)
	if(user.incapacitated())
		return 0

	if(href_list["action"])
		if(!(href_list["action"] in forbidden_actions))
			return 0

		var/datum/forbidden/action/A = forbidden_actions[href_list["action"]]
		if(!A.conditions(user, src))
			return 0

		user.fuck(src, A)

	if(href_list["emote"])
		if(!(href_list["emote"] in forbidden_actions))
			return 0

		var/datum/forbidden/action/emote/A = forbidden_actions[href_list["emote"]]
		if(!A.conditions(user, src))
			return 0

		user.actionEmote(src, A)


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
				ass_storage.remove_from_storage(item, loc)
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
	if(!istype(P) || !istype(action) || !click_time())
		return 0

	if(!action.conditions(src, P))
		return 0

	P.remove_CD = world.time + 100

	click_CD = world.time + 10

	face_atom(P)

	lfaction = action
	lastfucked = P

	var/begins = 0
	if(P.lastreceived != src || P.lraction != action)
		begins = 1
		action.logAction(src, P)

	action.fuckText(src, P, begins)
	action.doAction(src, P, begins)

	P.lastreceived = src
	P.lraction = action

	return 1

/mob/living/carbon/human/proc/moan()
	if(stat != DEAD)
		// Pleasure messages
		if(pleasure >= 70 && prob(15) && gender == FEMALE)
			visible_message("<span class='erp'><b>[src]</b> twists in orgasm!</span>")
		if(pleasure >= 30 && prob(12))
			visible_message("<span class='erp'><b>[src]</b> [gender == FEMALE ? pick("moans in pleasure", "moans") : "moans"].</span>")
			if(gender == FEMALE)
				playsound(loc, "sound/forbidden/erp/moan_f[rand(1, 7)].ogg", 50, 1, 0, pitch = get_age_pitch())

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
		playsound(loc, "sound/forbidden/erp/final_f[rand(1, 3)].ogg", 50, 1, 0, pitch = get_age_pitch())
	else
		visible_message("<span class='cum'>[src] cums!</span>")

	add_logs(P, src, "came on")
	pleasure = 0

	druggy = 60
	if(staminaloss > 100)
		druggy = 300

/mob/living/carbon/human/proc/handle_lust()
	if(world.time >= remove_CD)
		if(lastfucked && lastfucked.lastreceived == src)
			lastfucked.lastreceived = null
			lastfucked.lraction = null
		lastfucked = null
		lfaction = null

	if(world.time >= pleasure_CD && (!lastfucked || !lastreceived))
		pleasure -= 3
		pleasure_CD = world.time + 10

	if(pleasure <= 0)
		pleasure = 0
		remove_CD = 0

/mob/living/carbon/human/proc/click_time()
	if(world.time >= click_CD)
		return 1
	return 0


/mob/living/carbon/human/verb/interact()
	set name = "Interact"
	set desc = "Interaction is good!"
	set category = "IC"
	set src in view(1)

	if(usr.stat == 1 || usr.restrained() || !isliving(usr))
		return

	ui_interact(usr)

/*
 * EMOTES
 */

/mob/living/carbon/human/proc/actionEmote(mob/living/carbon/human/P, datum/forbidden/action/emote/emote)
	if(!istype(P) || !istype(emote) || !click_time())
		return 0

	if(!emote.conditions(src, P))
		return 0

	click_CD = world.time + 10

	face_atom(P)

	emote.logAction(src, P)
	emote.fuckText(src, P)
	emote.doAction(src, P)

	return 1