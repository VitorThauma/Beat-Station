/*
 *
 * EMOTE DECLARATION
 *
 */

/datum/forbidden/action/emote/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(P == H)
		return -1

/datum/forbidden/action/emote/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, text = null)
	if(text)
		add_logs(P, H, text)

/datum/forbidden/action/emote/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(HPleasure)
		H.pleasure += HPleasure * rand(0.9, 1.2)
		if(H.pleasure >= MAX_PLEASURE)
			H.cum(P, HHole ? HHole : "floor")

	if(PPleasure)
		P.pleasure += PPleasure * rand(0.9, 1.2)
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
	return "Kiss [P.gender == FEMALE ? "her" : "his"] lips"

/datum/forbidden/action/emote/kiss/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()

	if(!H.check_has_mouth() || !P.check_has_mouth())
		return -1
	if(!H.is_face_clean() || !P.is_face_clean())
		return 0

	return 1

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
	return "Lick [P.gender == FEMALE ? "her" : "his"] lips"

/datum/forbidden/action/emote/lick/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()

	if(!H.check_has_mouth() || !P.check_has_mouth())
		return -1
	if(H.species.name != "Tajaran") // Only tajarans can lick other's lips
		return -1
	if(!H.is_face_clean() || !P.is_face_clean())
		return 0

	return 1

/datum/forbidden/action/emote/lick/fuckText(mob/living/carbon/human/H, mob/living/carbon/human/P)
	H.visible_message("<span class='erp'><b>[H]</b> licks [P]'s lips.</span>")

/datum/forbidden/action/emote/lick/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..(H, P, "licked")

/datum/forbidden/action/emote/lick/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()