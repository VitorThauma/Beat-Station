/*
 *
 * EMOTE DECLARATION
 *
 */

/datum/forbidden/action/emote
	var/name
	var/HPleasure	// How much pleasure who is giving the action receive
	var/PPleasure	// How much pleasure who is receiving the action receive
					// This is a base, can be more or less

	var/HHole		// Used when who is giving the action cums
	var/PHole		// Used when who is receiving the action cums

/datum/forbidden/action/emote/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return

/datum/forbidden/action/emote/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(H.incapacitated())
		return 0
	if(get_dist(H, P) > 1)
		return 0
	if(P == H)
		return 0
	return 1

/datum/forbidden/action/emote/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	return

/datum/forbidden/action/emote/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, text = null)
	if(text)
		add_logs(P, H, text)

/datum/forbidden/action/emote/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(HPleasure)
		H.pleasure += HPleasure * rand(0.8, 1.2)
		if(H.pleasure >= MAX_PLEASURE)
			H.cum(P, HHole ? HHole : "floor")

	if(PPleasure)
		P.pleasure += PPleasure * rand(0.8, 1.2)
		if(P.pleasure >= MAX_PLEASURE)
			P.cum(H, PHole ? PHole : "floor")


/*
 *
 * EMOTES
 *
 */

// Kiss
/datum/forbidden/action/emote/kiss
	name = "kiss"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 1	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/action/emote/kiss/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Kiss [P.gender == FEMALE ? "her" : "him"]"

/datum/forbidden/action/emote/kiss/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(!H.is_face_clean() || !P.is_face_clean())
		return 0
	return ..()

/datum/forbidden/action/emote/kiss/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P)
	H.visible_message("<span class='erp'><b>[H]</b> kisses <b>[P]</b>.</span>")

/datum/forbidden/action/emote/kiss/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..(H, P, "kissed")

/datum/forbidden/action/emote/kiss/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()

// Lick (tajaran kiss)
/datum/forbidden/action/emote/lick
	name = "kiss"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 1	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/action/emote/lick/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Lick [P.gender == FEMALE ? "her" : "his"]"

/datum/forbidden/action/emote/lick/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(!H.is_face_clean() || !P.is_face_clean())
		return 0
	if(H.species.name != "Tajaran") // Only tajarans can lick
		return 0
	return ..()

/datum/forbidden/action/emote/lick/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P)
	H.visible_message("<span class='erp'><b>[H]</b> licks [P]'s [prob(50) ? "mouth" : "face"].</span>")

/datum/forbidden/action/emote/lick/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..(H, P, "licked")

/datum/forbidden/action/emote/lick/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()