/*
 *
 * ACTION DECLARATION
 *
 */

/datum/forbidden/action
	var/HPleasure	// How much pleasure who is giving the action receive
	var/PPleasure	// How much pleasure who is receiving the action receive
					// This is a base, can be more or less

	var/HHole		// Used when who is giving the action cums
	var/PHole		// Used when who is receiving the action cums

/datum/forbidden/action/proc/playSound(turf/T)
	return

/datum/forbidden/action/proc/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H.incapacitated())
		return 0
	return 1

/datum/forbidden/action/proc/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	return

/datum/forbidden/action/proc/log(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "fucked")

/datum/forbidden/action/proc/lose_virgin(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return

/*
 *
 * ACTIONS
 *
 */


/*
 * ORAL ACTIONS
 */

// Cunnilingus
/datum/forbidden/action/oral/cunnilingus
	HPleasure = 3	// How much pleasure who is giving the action receive
	PPleasure = 4	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/action/oral/cunnilingus/playSound(turf/T)
	return ..()

/datum/forbidden/action/oral/cunnilingus/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return ..()

/datum/forbidden/action/oral/cunnilingus/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to lick <b>[P]</b>.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> licks <b>[P]</b>.</span>")

/datum/forbidden/action/oral/cunnilingus/log(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "gave a cunnilingus to")


// Blowjob
/datum/forbidden/action/oral/blowjob
	HPleasure = 2	// How much pleasure who is giving the action receive
	PPleasure = 5	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "mouth"

/datum/forbidden/action/oral/blowjob/playSound(turf/T)
	return ..()

/datum/forbidden/action/oral/blowjob/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return ..()

/datum/forbidden/action/oral/blowjob/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to suck [P]'s cock.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> sucks [P]'s cock.</span>")

/datum/forbidden/action/oral/blowjob/log(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "gave a blowjob to")



/*
 * FUCK ACTIONS
 */

// Anal
/datum/forbidden/action/fuck/anal
	HPleasure = 6	// How much pleasure who is giving the action receive
	PPleasure = 6	// How much pleasure who is receiving the action receive

	HHole = "ass"
	PHole = "floor"

/datum/forbidden/action/fuck/anal/playSound(turf/T)
	return ..()

/datum/forbidden/action/fuck/anal/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return ..()

/datum/forbidden/action/fuck/anal/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to fuck [P]'s anus.</span>")
	else
		if(P.anal_virgin)
			H.visible_message("<span class='erp'><b>[H]</b> tears [P]'s anus to pieces.</span>")
		else
			H.visible_message("<span class='erp'><b>[H]</b> fucks [P]'s anus.</span>")

/datum/forbidden/action/fuck/anal/log(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "ass fucked")

/datum/forbidden/action/fuck/anal/lose_virgin(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(P.anal_virgin)
		P.anal_virgin = 0


// Vaginal
/datum/forbidden/action/fuck/vaginal
	HPleasure = 5	// How much pleasure who is giving the action receive
	PPleasure = 5	// How much pleasure who is receiving the action receive

	HHole = "vagina"
	PHole = "floor"

/datum/forbidden/action/fuck/vaginal/playSound(turf/T)
	return ..()

/datum/forbidden/action/fuck/vaginal/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return ..()

/datum/forbidden/action/fuck/vaginal/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to [pick("fuck","penetrate")] <b>[P]</b>.</span>")
	else
		if(P.anal_virgin)
			H.visible_message("<span class='erp'><b>[H]</b> mercilessly tears [P]'s hymen!</span>")
		else
			H.visible_message("<span class='erp'><b>[H]</b> [pick("fucks","penetrates")] <b>[P]</b>.</span>")

/datum/forbidden/action/fuck/vaginal/log(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "fucked")

/datum/forbidden/action/fuck/vaginal/lose_virgin(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(P.virgin)
		P.emote("scream")
		new /obj/effect/decal/cleanable/blood(P.loc)
		P.virgin = 0


// Mouthfuck
/datum/forbidden/action/fuck/mouth
	HPleasure = 5	// How much pleasure who is giving the action receive
	PPleasure = 2	// How much pleasure who is receiving the action receive

	HHole = "mouth"
	PHole = "floor"

/datum/forbidden/action/fuck/mouth/playSound(turf/T)
	return ..()

/datum/forbidden/action/fuck/mouth/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return ..()

/datum/forbidden/action/fuck/mouth/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(begins)
		H.visible_message("<span class='erp'><b>[H]</b> begins to fuck [P]'s mouth.</span>")
	else
		H.visible_message("<span class='erp'><b>[H]</b> fucks [P]'s mouth.</span>")

/datum/forbidden/action/fuck/mouth/log(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	add_logs(P, H, "mouth fucked")

/*
if(MOUNT)
	erp_c.give_pleasure(5)
	give_pleasure(5)
if(ASS_FINGERING)
	erp_c.give_pleasure(3.5)
	give_pleasure(1)
if(VAGINA_FINGERING)
	erp_c.give_pleasure(3)
	give_pleasure(2)
*/