// String identifiers for associative list lookup

// mob/var/list/mutations

// Used in preferences.
#define DISABILITY_FLAG_NEARSIGHTED 1
#define DISABILITY_FLAG_FAT         2
#define DISABILITY_FLAG_EPILEPTIC   4
#define DISABILITY_FLAG_DEAF        8
#define DISABILITY_FLAG_BLIND       16
#define DISABILITY_FLAG_MUTE        32

///////////////////////////////////////
// MUTATIONS
///////////////////////////////////////

// Generic mutations:
#define	TK			1
#define RESIST_COLD	2
#define XRAY			3
#define HULK			4
#define CLUMSY			5
#define FAT				6
#define HUSK			7
#define NOCLONE			8


// Extra powers:
#define LASER			9 	// harm intent - click anywhere to shoot lasers from eyes
#define GREY			10	//Wingdings for Greys -- Not activatable or researchable
//#define HEAL			10 	// (Not implemented) healing people with hands
//#define SHADOW		11 	// (Not implemented) shadow teleportation (create in/out portals anywhere) (25%)
//#define SCREAM		12 	// (Not implemented) supersonic screaming (25%)
//#define EXPLOSIVE		13 	// (Not implemented) exploding on-demand (15%)
//#define REGENERATION	14 	// (Not implemented) superhuman regeneration (30%)
//#define REPROCESSOR	15 	// (Not implemented) eat anything (50%)
//#define SHAPESHIFTING	16 	// (Not implemented) take on the appearance of anything (40%)
//#define PHASING		17 	// (Not implemented) ability to phase through walls (40%)
//#define SHIELD		18 	// (Not implemented) shielding from all projectile attacks (30%)
//#define SHOCKWAVE		19 	// (Not implemented) attack a nearby tile and cause a massive shockwave, knocking most people on their asses (25%)
//#define ELECTRICITY	20 	// (Not implemented) ability to shoot electric attacks (15%)

//bitflags for mutations
	// Extra powers:
#define SHADOW			(1<<10)	// shadow teleportation (create in/out portals anywhere) (25%)
#define SCREAM			(1<<11)	// supersonic screaming (25%)
#define EXPLOSIVE		(1<<12)	// exploding on-demand (15%)
#define REGENERATION	(1<<13)	// superhuman regeneration (30%)
#define REPROCESSOR		(1<<14)	// eat anything (50%)
#define SHAPESHIFTING	(1<<15)	// take on the appearance of anything (40%)
#define PHASING			(1<<16)	// ability to phase through walls (40%)
#define SHIELD			(1<<17)	// shielding from all projectile attacks (30%)
#define SHOCKWAVE		(1<<18)	// attack a nearby tile and cause a massive shockwave, knocking most people on their asses (25%)
#define ELECTRICITY		(1<<19)	// ability to shoot electric attacks (15%)


	//2spooky
#define SKELETON 29
#define PLANT 30

// Other Mutations:
#define NO_BREATH		100 	// no need to breathe
#define REMOTE_VIEW	101 	// remote viewing
#define REGEN			102 	// health regen
#define RUN			103 	// no slowdown
#define REMOTE_TALK	104 	// remote talking
#define MORPH			105 	// changing appearance
#define RESIST_HEAT	106 	// heat resistance
#define HALLUCINATE	107 	// hallucinations
#define FINGERPRINTS	108 	// no fingerprints
#define NO_SHOCK		109 	// insulated hands
#define DWARF			110 	// table climbing

// Goon muts
#define OBESITY       200		// Decreased metabolism
#define TOXIC_FARTS   201		// Duh
#define STRONG        202		// (Nothing)
#define SOBER         203		// Increased alcohol metabolism
#define PSY_RESIST    204		// Block remoteview
#define SUPER_FART    205		// Duh
#define EMPATH		206		//Read minds
#define COMIC			207		//Comic Sans

// /vg/ muts
#define LOUD		208		// CAUSES INTENSE YELLING
//#define WHISPER	209		// causes quiet whispering
#define DIZZY		210		// Trippy.

#define LISP		300
#define RADIOACTIVE 301
#define CHAV		302
#define SWEDISH		303
#define SCRAMBLED	304
#define HORNS		305
#define IMMOLATE	306
#define CLOAK		307
#define CHAMELEON	308
#define CRYO		309
#define EATER		310

#define JUMPY		400
#define POLYMORPH	401

//disabilities
#define NEARSIGHTED		1
#define EPILEPSY		2
#define COUGHING		4
#define TOURETTES		8
#define NERVOUS			16

//sdisabilities
#define BLIND			1
#define MUTE			2
#define DEAF			4

//Nutrition levels for humans. No idea where else to put it
#define NUTRITION_LEVEL_FAT 600
#define NUTRITION_LEVEL_FULL 550
#define NUTRITION_LEVEL_WELL_FED 450
#define NUTRITION_LEVEL_FED 350
#define NUTRITION_LEVEL_HUNGRY 250
#define NUTRITION_LEVEL_STARVING 150

//Blood levels
#define BLOOD_VOLUME_NORMAL			560
#define BLOOD_VOLUME_SAFE			501
#define BLOOD_VOLUME_OKAY			336
#define BLOOD_VOLUME_BAD			224
#define BLOOD_VOLUME_SURVIVE		122

//Used for calculations for negative effects of having genetics powers
#define DEFAULT_GENE_STABILITY 100
#define GENE_INSTABILITY_MINOR 5
#define GENE_INSTABILITY_MODERATE 10
#define GENE_INSTABILITY_MAJOR 15