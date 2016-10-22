// Cum text
/datum/forbidden_controller/proc/cum_text()
	if(owner.gender == MALE)
		if(fucking_action == ANAL)
			owner.visible_message("<span class='cum'>[owner] cums into [fucking]'s ass!</span>")
		else if(fucking_action == VAGINAL)
			owner.visible_message("<span class='cum'>[owner] cums into <b>[fucking]</b>!</span>")
		else if(fucking_action == MOUTHFUCK)
			owner.visible_message("<span class='cum'>[owner] cums into [fucking]'s mouth!</span>")
		else if(fucked_action == BLOWJOB)
			owner.visible_message("<span class='cum'>[owner] cums into [fucked]'s mouth!</span>")
		else if(fucked_action == MOUNT)
			owner.visible_message("<span class='cum'>[owner] cums into <b>[fucking]</b>!</span>")
		else
			owner.visible_message("<span class='cum'>[owner] cums on the floor!</span>")
			var/obj/effect/decal/cleanable/sex/cum = new /obj/effect/decal/cleanable/sex/semen(owner.loc)
			cum.add_blood_list(owner)

	else if(owner.gender == FEMALE)
		owner.visible_message("<span class='cum'>[owner] cums!</span>")
		var/obj/effect/decal/cleanable/sex/cum = new /obj/effect/decal/cleanable/sex/femjuice(owner.loc)
		cum.add_blood_list(owner)
// Cum text end