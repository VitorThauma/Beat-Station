/datum/forbidden_controller
	var/timevar
	var/click_time

// Checks
/datum/forbidden_controller/proc/time_check()
	if(world.time > timevar)
		//bla

/datum/forbidden_controller/proc/click_check()
	if(world.time >= click_time)
		return 1
	return 0