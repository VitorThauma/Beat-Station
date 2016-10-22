/*
 *
 * ACTION DECLARATION
 *
 */

/datum/forbidden/action
	var/name
	var/HPleasure	// How much pleasure who is giving the action receive
	var/PPleasure	// How much pleasure who is receiving the action receive
					// This is a base, can be more or less

	var/HHole		// Used when who is giving the action cums
	var/PHole		// Used when who is receiving the action cums

/datum/forbidden/action/proc/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return

/datum/forbidden/action/proc/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H.incapacitated())
		return 0
	if(get_dist(H, P) > 1)
		return 0
	return 1

/datum/forbidden/action/proc/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	return

/datum/forbidden/action/proc/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "fucked")

/datum/forbidden/action/proc/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	H.do_fucking_animation(P)

	if(P != H)
		H.pleasure += HPleasure
		P.pleasure += PPleasure

		if(H.pleasure >= MAX_PLEASURE)
			H.cum(P, HHole ? HHole : "floor")
		if(P.pleasure >= MAX_PLEASURE)
			P.cum(H, PHole ? PHole : "floor")
	else
		P.pleasure += PPleasure
		if(P.pleasure >= MAX_PLEASURE)
			P.cum(H, PHole ? PHole : "floor")

/*
 *
 * ACTIONS
 *
 */


/*
 * ORAL ACTIONS
 */

/datum/forbidden/action/oral/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H == P)
		return 0
	return ..()

// Cunnilingus
/datum/forbidden/action/oral/cunnilingus
	name = "cunnilingus"
	HPleasure = 3	// How much pleasure who is giving the action receive
	PPleasure = 4	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/action/oral/cunnilingus/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Lick her vagina"

/datum/forbidden/action/oral/cunnilingus/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(!H.is_face_clean())
		return 0
	if(!P.has_vagina() || !P.is_nude())
		return 0
	return ..()

/datum/forbidden/action/oral/cunnilingus/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to lick <b>[P]</b>.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> licks <b>[P]</b>.</span>")

/datum/forbidden/action/oral/cunnilingus/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "gave a cunnilingus to")

/datum/forbidden/action/oral/cunnilingus/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	P.moan()
	..()


// Blowjob
/datum/forbidden/action/oral/blowjob
	name = "blowjob"
	HPleasure = 2	// How much pleasure who is giving the action receive
	PPleasure = 5	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "mouth"

/datum/forbidden/action/oral/blowjob/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Give him a blowjob"

/datum/forbidden/action/oral/blowjob/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(isfuck(P.lfaction))
		return 0
	if(!H.is_face_clean())
		return 0
	if(!P.has_penis() || !P.is_nude())
		return 0
	return ..()

/datum/forbidden/action/oral/blowjob/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to suck [P]'s cock.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> sucks [P]'s cock.</span>")

/datum/forbidden/action/oral/blowjob/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "gave a blowjob to")

/datum/forbidden/action/oral/blowjob/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()


/*
 * FUCK ACTIONS
 */

/datum/forbidden/action/fuck/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H == P)
		return 0
	return ..()

// Anal
/datum/forbidden/action/fuck/anal
	name = "anal"
	HPleasure = 6	// How much pleasure who is giving the action receive
	PPleasure = 6	// How much pleasure who is receiving the action receive

	HHole = "anus"
	PHole = "floor"

/datum/forbidden/action/fuck/anal/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Fuck [P.gender == FEMALE ? "her" : "his"] anus"

/datum/forbidden/action/fuck/anal/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H.loc != P.loc)
		return 0
	if(P.lastreceived != H && istype(P.lraction, type))
		return 0
	if(!P.species.anus || !H.has_penis())
		return 0
	if(!H.is_nude() || P.is_nude())
		return 0
	return ..()

/datum/forbidden/action/fuck/anal/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to fuck [P]'s anus.</span>")
	else
		if(P.anal_virgin)
			H.visible_message("<span class='erp'><b>[H]</b> tears [P]'s anus to pieces.</span>")
		else
			H.visible_message("<span class='erp'><b>[H]</b> fucks [P]'s anus.</span>")

/datum/forbidden/action/fuck/anal/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "ass fucked")

/datum/forbidden/action/fuck/anal/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(P.anal_virgin)
		P.anal_virgin = 0
	P.moan()

	P.staminaloss += H.pleasure * 0.2

	..()


// Vaginal
/datum/forbidden/action/fuck/vaginal
	name = "vaginal"
	HPleasure = 5	// How much pleasure who is giving the action receive
	PPleasure = 5	// How much pleasure who is receiving the action receive

	HHole = "vagina"
	PHole = "floor"

/datum/forbidden/action/fuck/vaginal/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Fuck her vagina"

/datum/forbidden/action/fuck/vaginal/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H.loc != P.loc)
		return 0
	if(P.lastreceived != H && istype(P.lraction, type))
		return 0
	if(!P.has_vagina() || !H.has_penis())
		return 0
	if(!H.is_nude() || P.is_nude())
		return 0
	return ..()

/datum/forbidden/action/fuck/vaginal/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to [pick("fuck","penetrate")] <b>[P]</b>.</span>")
	else
		if(P.anal_virgin)
			H.visible_message("<span class='erp'><b>[H]</b> mercilessly tears [P]'s hymen!</span>")
		else
			H.visible_message("<span class='erp'><b>[H]</b> [pick("fucks","penetrates")] <b>[P]</b>.</span>")

/datum/forbidden/action/fuck/vaginal/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "fucked")

/datum/forbidden/action/fuck/vaginal/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(P.virgin)
		P.emote("scream")
		new /obj/effect/decal/cleanable/blood(P.loc)
		P.virgin = 0
	P.moan()

	P.staminaloss += H.pleasure * 0.2

	..()


// Mouthfuck
/datum/forbidden/action/fuck/mouth
	name = "mouthfuck"
	HPleasure = 5	// How much pleasure who is giving the action receive
	PPleasure = 2	// How much pleasure who is receiving the action receive

	HHole = "mouth"
	PHole = "floor"

/datum/forbidden/action/fuck/mouth/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Fuck [P.gender == FEMALE ? "her" : "his"] mouth"

/datum/forbidden/action/fuck/mouth/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H.loc != P.loc)
		return 0
	if(P.lastreceived != H && istype(P.lraction, type))
		return 0
	if(!P.is_face_clean())
		return 0
	if(!H.has_penis() || !H.is_nude())
		return 0
	return ..()

/datum/forbidden/action/fuck/mouth/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to fuck [P]'s mouth.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> fucks [P]'s mouth.</span>")

/datum/forbidden/action/fuck/mouth/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "mouth fucked")

/datum/forbidden/action/fuck/mouth/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()


/*
 * MISC ACTIONS
 */

// Mount
/datum/forbidden/action/vagina/mount
	name = "mount"
	HPleasure = 5	// How much pleasure who is giving the action receive
	PPleasure = 5	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "vagina"

/datum/forbidden/action/vagina/mount/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Mount on him"

/datum/forbidden/action/vagina/mount/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H.loc != P.loc)
		return 0
	if(P.lastreceived != H && istype(P.lraction, type))
		return 0
	if(istype(P.lfaction, /datum/forbidden/action/fuck/vaginal))
		return 0
	if(!P.has_penis() || !H.has_vagina())
		return 0
	if(!H.is_nude() || P.is_nude())
		return 0
	if(H == P)
		return 0
	if(!P.lying)
		to_chat(H, "<span class='warning'>[H] needs to be lying to do that!</span>")
		return 0
	return ..()

/datum/forbidden/action/vagina/mount/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to mount on [P].</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> mounts on [P].</span>")

/datum/forbidden/action/vagina/mount/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "mounted on")

/datum/forbidden/action/vagina/mount/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H.virgin)
		H.emote("scream")
		new /obj/effect/decal/cleanable/blood(P.loc)
		H.virgin = 0
	H.moan()

	H.staminaloss += P.pleasure * 0.2

	..()


// Vagina Fingering
/datum/forbidden/action/fingering/vagina
	name = "fingering"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 2	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/action/fingering/vagina/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Finger [H == P ? "your" : "her"] vagina"

/datum/forbidden/action/fingering/vagina/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(!P.has_vagina() || !P.is_nude())
		return 0
	if(!H.has_hands())
		return 0
	return ..()

/datum/forbidden/action/fingering/vagina/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(H != P)
		if(begins)
			H.visible_message("<span class='erp'><b>[H]</b> begins to finger <b>[P]</b>.</span>")
		else
			H.visible_message("<span class='erp'><b>[H]</b> fingers <b>[P]</b>.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> fingers her vagina.</span>")

/datum/forbidden/action/fingering/vagina/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "vagina fingered")

/datum/forbidden/action/fingering/vagina/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()


// Ass Fingering
/datum/forbidden/action/fingering/anus
	name = "analfingering"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 2	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/action/fingering/anus/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Finger [H == P ? "your" : P.gender == FEMALE ? "her" : "his"] anus"

/datum/forbidden/action/fingering/anus/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(!P.species.anus || !P.is_nude())
		return 0
	if(!H.has_hands())
		return 0
	return ..()

/datum/forbidden/action/fingering/anus/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(H != P)
		if(begins)
			H.visible_message("<span class='erp'><b>[H]</b> begins to play with [P]'s anus.</span>")
		else
			H.visible_message("<span class='erp'><b>[H]</b> plays with [P]'s anus.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> plays with [H.gender == FEMALE ? "her" : "his"] anus.</span>")

/datum/forbidden/action/fingering/anus/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "ass fingered")

/datum/forbidden/action/fingering/anus/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()


// Handjob
/datum/forbidden/action/handjob
	name = "handjob"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 2	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/action/handjob/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "[H == P ? "Masturbate your penis" : "Give him a handjob"]"

/datum/forbidden/action/handjob/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(isfuck(P.lfaction))
		return 0
	if(!P.has_penis() || !P.is_nude())
		return 0
	if(!H.has_hands())
		return 0
	return ..()

/datum/forbidden/action/handjob/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(H != P)
		if(begins)
			H.visible_message("<span class='erp'><b>[H]</b> begins to give [P] a handjob.</span>")
		else
			H.visible_message("<span class='erp'><b>[H]</b> gives [P] a handjob.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> masturbates.</span>")

/datum/forbidden/action/handjob/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "handjob")

/datum/forbidden/action/handjob/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()