/datum/forbidden_controller
	var/mob/living/carbon/human/owner
	var/pleasure = 0

	var/mob/living/carbon/human/lastfucked		// Last person you did something
	var/datum/forbidden/action/lfaction			// Last action you did to someone

	var/mob/living/carbon/human/lastreceived	// Last person you reveived something
	var/datum/forbidden/action/lraction			// Last action you received by someone

	var/list/transa_log = list()

	var/timevar
	var/click_time

/datum/forbidden_controller/New(mob/living/carbon/human/own)
	if(!istype(own))
		return 0
	owner = own


/datum/forbidden_controller/proc/give_pleasure(datum/forbidden/action/action)
	else if(base)
		pleasure += (base + rand(-1, 3))

	if(pleasure >= MAX_PLEASURE)
		cum()

/*
	if(owner.stat != DEAD)
		// Pleasure messages
		if(pleasure >= 70 && prob(15) && owner.gender == FEMALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> twists in orgasm!</span>")

		if(pleasure >= 30 && prob(12))
			owner.visible_message("<span class='erp'><b>[owner]</b> [owner.gender == FEMALE ? pick("moans in pleasure", "moans") : "moans"].</span>")
*/

/datum/forbidden_controller/proc/fucking(mob/living/carbon/human/P, /datum/forbidden/action/action, auto_pleasure = 1)

	if(!istype(P) || !action.conditions(owner, P))
		return 0

	if(!click_check())
		return 0

	owner.face_atom(P)

	P.erp_controller.time_check()

	click_time = world.time + 10
	P.erp_controller.timevar = world.time + 40

	lfaction = action
	lastfucked = P

	var/begins = 0
	if(owner in P.erp_controller.fucking_list)
		begins = 1
		action.log(owner, P)

	action.fuckText(owner, P, begins)
	action.lose_virgin(owner, P)

	P.erp_controller.lastreceived = owner
	P.erp_controller.lraction = action

	if(auto_pleasure)
		give_pleasure(action)

	return 1

/datum/forbidden_controller/proc/masturbate(action)
	if(!click_check())
		return 0
	if(owner.stat == DEAD)
		return 0

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

/datum/forbidden_controller/proc/cum()
	if(owner.stat != DEAD)
		var/pleasure_message = pick("... I'M FEELING SO GOOD! ...",  "... It's just INCREDIBLE! ...", "... MORE AND MORE AND MORE! ...")
		to_chat(owner, "<span class='cum'>[pleasure_message]</span>")
		cum_text()
	pleasure = 0

// Checks
/datum/forbidden_controller/proc/time_check()
	if(world.time > timevar)
		fucking_list = new()
		fucked = null
		fucked_action = null

/datum/forbidden_controller/proc/click_check()
	if(world.time >= click_time)
		return 1
	return 0