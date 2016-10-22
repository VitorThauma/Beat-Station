/datum/forbidden_controller
	var/timevar
	var/click_time

/datum/forbidden_controller/proc/fuck(mob/living/carbon/human/P, /datum/forbidden/action/action)

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
	if(P.erp_controller.lastreceived != owner || P.erp_controller.lraction != action)
		begins = 1
		action.log(owner, P)

	action.fuckText(owner, P, begins)
	action.doAction(owner, P)

	P.erp_controller.lastreceived = owner
	P.erp_controller.lraction = action

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