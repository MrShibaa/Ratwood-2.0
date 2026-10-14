/obj/effect/proc_holder/spell/aoe_turf/conjure/phantom_ear
	name = "Summon Phantom Ear"
	desc = "Creates a magical ear to listen in on distant sounds."
	cost = 1
	xp_gain = TRUE
	releasedrain = 30
	icon_state = "phantomear"
	human_req = TRUE
	recharge_time = 2 MINUTES
	invocations = list("Lend me thine ear.")
	invocation_type = "whisper"

	summon_type = list(/obj/item/phantom_ear)
	range = 0

	var/datum/weakref/current_ear

/obj/effect/proc_holder/spell/aoe_turf/conjure/phantom_ear/Destroy(force)
	QDEL_NULL(current_ear)
	return ..()

/obj/effect/proc_holder/spell/aoe_turf/conjure/phantom_ear/post_summon(obj/item/phantom_ear/summoned_object, mob/user)
	var/obj/item/phantom_ear/current = current_ear?.resolve()
	if(current)
		to_chat(user, span_notice("You close one ear to open another."))
		qdel(current)
	else
		to_chat(user, span_notice("You've conjured a phantom ear. You can hear through it as if you were there. Speak \"deafen\" to close this ear to the world, and \"listen\" to re-open it."))
	current_ear = WEAKREF(summoned_object)
	summoned_object.setup(user)
