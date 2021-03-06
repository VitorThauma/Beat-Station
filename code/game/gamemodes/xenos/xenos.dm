/datum/game_mode
	var/list/datum/mind/xenos = list()


/datum/game_mode/xenos
	name = "xenos"
	config_tag = "xenos"
	required_players = 30
	required_enemies = 3
	var/result = 0
	var/checkwin_counter = 0
	var/xenos_list = list()
	var/gammacalled = 0

	var/gammaratio = 4 //At what alien to human ratio will the Gamma security level be called and the nuke be made available?

/datum/game_mode/xenos/announce()
	var/text = "<B>The current game mode is - Xenos!</B><br>"
	text += "<B>There is an Xenomorph attack on the station.<BR>Aliens - Kill or infect the crew. Protect the Queen. <BR>Crew - Protect the station. Exterminate all aliens.</B>"
	..(text)

/datum/game_mode/xenos/can_start()
	if(!..())
		return 0

	var/list/candidates = get_players_for_role(ROLE_ALIEN)
	var/playersready = 0
	var/xenos_num = required_enemies
	for(var/mob/new_player/player in player_list)
		if((player.client)&&(player.ready))
			playersready += 1

	//Check that we have enough alien candidates
	if(candidates.len < required_enemies)
		return 0

	//Grab candidates randomly until we have enough.
	while(xenos_num > 0)
		var/datum/mind/new_xenos = pick(candidates)
		xenos += new_xenos
		candidates -= new_xenos
		xenos_num--

	for(var/datum/mind/xeno in xenos)
		xeno.assigned_role = "MODE"
		xeno.special_role = "Alien"
		set_antag_hud(xeno, "hudalien")//like this is needed...
	return 1

/datum/game_mode/xenos/pre_setup()
	return 1

/datum/game_mode/xenos/post_setup()

	var/list/turf/xenos_spawn = list()

	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Xenos-Spawn")
			xenos_spawn += get_turf(A)
			qdel(A)
			continue

	var/xenoqueen_selected = 0
	var/spawnpos = 1

	for(var/datum/mind/xeno_mind in xenos)
		if(spawnpos > xenos_spawn.len)
			spawnpos = 1
		//XenoQueen Selection
		if(!xenoqueen_selected)
			var/mob/living/carbon/alien/humanoid/queen/O = new(xenos_spawn[spawnpos])
			if(xeno_mind.current)
				xeno_mind.transfer_to(O)
			else
				O.key = xeno_mind.current.key
			xeno_mind.name = O.name
			//qdel(xeno_mind)
			xenoqueen_selected = 1
			spawnpos++
			continue
		//Additional larvas if playercount > 20
		else
			var/mob/living/carbon/alien/larva/O = new(xenos_spawn[spawnpos])
			if(xeno_mind.current)
				xeno_mind.transfer_to(O)
			else
				O.key = xeno_mind.current.key
			xeno_mind.name = O.name
			//qdel(xeno_mind)
		spawnpos++

	return ..()

/datum/game_mode/xenos/process()
	checkwin_counter++
	if(checkwin_counter >= 5)
		if(!result)
			ticker.mode.check_win()
		checkwin_counter = 0
	return 0


/datum/game_mode/xenos/check_win()
	var/xenosalive = xenos_alive()
	var/playersalive = players_alive()
	var/playeralienratio = 0
	if(playersalive)
		playeralienratio = xenosalive / playersalive
	if(shuttle_master && shuttle_master.emergency.mode >= SHUTTLE_ESCAPE)
		return ..()
	if(!xenosalive)
		result = 1
		return 1
	else if(!playersalive)
		result = 2
		return 1
	else if(station_was_nuked)
		result = 3
		return 1
	else
		if(playeralienratio >= gammaratio && !gammacalled)
			gammacalled = 1
			command_announcement.Announce("The aliens have nearly succeeded in capturing the station and exterminating the crew. Activate the nuclear failsafe to stop the alien threat once and for all. The Nuclear Authentication Code is [get_nuke_code()] ", "Alien Lifeform Alert")
			set_security_level("gamma")
			var/obj/machinery/door/airlock/vault/V = locate(/obj/machinery/door/airlock/vault) in world
			if(V && (V.z in config.station_levels))
				V.locked = 0
				V.update_icon()
		return ..()

/datum/game_mode/xenos/check_finished()
	return result != 0

/datum/game_mode/xenos/proc/xenos_alive()
	var/list/livingxenos = list()
	for(var/datum/mind/xeno in xenos)
		if((xeno) && (xeno.current) && (xeno.current.stat != 2) && (xeno.current.client))
			if(istype(xeno.current,/mob/living/carbon/alien))
				livingxenos += xeno
	return livingxenos.len

/datum/game_mode/xenos/proc/players_alive()
	var/list/livingplayers = list()
	for(var/mob/M in player_list)
		var/turf/T = get_turf(M)
		if((M) && (M.stat != 2) && M.client && T && ((T.z in config.station_levels) || shuttle_master.emergency.mode >= SHUTTLE_ESCAPE && ((T.z in config.station_levels) || (T.z in config.admin_levels))))
			if(ishuman(M))
				livingplayers += 1
	return livingplayers.len

/datum/game_mode/xenos/declare_completion()
	var/text = ""
	if(station_was_nuked)
		feedback_set_details("round_end_result","win - xenos nuked")
		text += "<FONT size = 3><B>Crew Victory</B></FONT>"
		text += "<B>The station was destroyed in a nuclear explosion, preventing the aliens from overrunning it!</B>"
	else if(result == 1)
		feedback_set_details("round_end_result","win - xenos killed")
		text += "<FONT size = 3><B>Crew Victory</B></FONT>"
		text += "<B>The aliens did not succeed and were exterminated by the crew!</B>"
	else if(result == 2)
		feedback_set_details("round_end_result","win - crew killed")
		text += "<FONT size = 3><B>Alien Victory</B></FONT>"
		text += "<B>The aliens were successful and slaughtered the crew!</B>"
	else
		feedback_set_details("round_end_result","win - crew escaped")
		text += "<FONT size = 3><B>Draw</B></FONT>"
		text += "<B>The crew has escaped from the aliens but did not exterminate them, allowing them to overrun the station.</B>"
	
	text += "<br><br><FONT size=3><b>There were [xenos.len] aliens.</b></FONT>"
	text += "<br><FONT size=3><b>The aliens were:</b></FONT>"
	for(var/datum/mind/xeno in xenos)
		text += "<br><b>[xeno.key]</b> was <b>[xeno.name]</b> ("
		if(xeno.current)
			if(xeno.current.stat == DEAD)
				text += "died"
			else if(!xeno.current.client)
				text += "SSD"
			else
				text += "survived"
		else
			text += "body destroyed"
		text += ")"
	to_chat(world, text)
	..(text)
	return 1