/mob/living/carbon/human/Move()
	. = ..()
	if(erp_controller.fucking && get_dist(erp_controller.fucking, src) > 1)
		erp_controller.fucking.erp_controller.fucked = null
		erp_controller.fucking.erp_controller.fucked_action = null

		erp_controller.fucking = null
		erp_controller.fucking_action = null
	if(erp_controller.fucked && get_dist(erp_controller.fucked, src) > 1)
		erp_controller.fucked.erp_controller.fucking = null
		erp_controller.fucked.erp_controller.fucking_action = null

		erp_controller.fucked = null
		erp_controller.fucked_action = null