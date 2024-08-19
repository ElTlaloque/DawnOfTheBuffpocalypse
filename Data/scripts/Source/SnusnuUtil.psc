Scriptname SnusnuUtil Hidden

Bool Function canPlayAnimation(Actor animatedDude) Global
	If animatedDude.isInCombat() || animatedDude.IsOnMount() || animatedDude.IsSwimming() || animatedDude.IsSprinting() || \
	animatedDude.IsWeaponDrawn() || animatedDude.GetSleepState() != 0 || animatedDude.GetSitState() != 0 || !Game.IsMovementControlsEnabled()
		return false
	EndIf
	
	return true
EndFunction

Float Function getWeightmorphsWeight() Global
	;;/
	If Game.IsPluginInstalled("WeightMorphs.esp")
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		return WMCM.WMorphs.Weight
	EndIf
	;
	return 0
EndFunction

Function changeWeightmorphsWeight(Float amount, Bool applyNow = True) Global
	;;/
	If Game.IsPluginInstalled("WeightMorphs.esp")
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		WMCM.WMorphs.ChangeWeight(amount, true)
	EndIf
	;
EndFunction


;-----------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------- BREASTS PHYSICS RELATED STUFF -----------------------------------------------


Bool Function checkSMPPhysics(Actor theActor) Global
	;/	
	armor property SMPONObjectP48 auto
	armor property SMPONObjectP50 auto
	armor property SMPONObjectP51 auto
	armor property SMPONObjectP60 auto
	/;
	
	Armor smpArmor = theActor.GetWornForm(Armor.GetMaskForSlot(48)) as Armor
	If smpArmor && StringUtil.Find(smpArmor.getName(), "3BBB Body SMP", 0) != -1
		return true
	Else
		smpArmor = theActor.GetWornForm(Armor.GetMaskForSlot(50)) as Armor
		If smpArmor && StringUtil.Find(smpArmor.getName(), "3BBB Body SMP", 0) != -1
			return true
		Else
			smpArmor = theActor.GetWornForm(Armor.GetMaskForSlot(51)) as Armor
			If smpArmor && StringUtil.Find(smpArmor.getName(), "3BBB Body SMP", 0) != -1
				return true
			Else
				smpArmor = theActor.GetWornForm(Armor.GetMaskForSlot(60)) as Armor
				If smpArmor && StringUtil.Find(smpArmor.getName(), "3BBB Body SMP", 0) != -1
					return true
				EndIf
			EndIf
		EndIf
	EndIf
	
	return false
EndFunction

function CBPCBreastsSmall(actor target, bool Pstop = false) Global
	if checkSMPPhysics(target) || !Game.IsPluginInstalled("3BBB.esp")
		return
	endif
	
	if !Pstop
		CBPCPluginScript.StartPhysics(target, "L Breast03")
		CBPCPluginScript.StartPhysics(target, "R Breast03")
	else
		CBPCPluginScript.StopPhysics(target, "L Breast03")
		CBPCPluginScript.StopPhysics(target, "R Breast03")

		resetCBPCBreasts(target)
	endif
endFunction

function CBPCBreastsMid(actor target, bool Pstop = false) Global
	if checkSMPPhysics(target) || !Game.IsPluginInstalled("3BBB.esp")
		return
	endif
	
	if !Pstop
		CBPCPluginScript.StartPhysics(target, "L Breast01")
		CBPCPluginScript.StartPhysics(target, "L Breast03")
		CBPCPluginScript.StartPhysics(target, "R Breast01")
		CBPCPluginScript.StartPhysics(target, "R Breast03")
		;Debug.Trace("SNU - Level 2 physics just started")
	else
		CBPCPluginScript.StopPhysics(target, "L Breast01")
		CBPCPluginScript.StopPhysics(target, "L Breast03")
		CBPCPluginScript.StopPhysics(target, "R Breast01")
		CBPCPluginScript.StopPhysics(target, "R Breast03")

		resetCBPCBreasts(target)
		;Debug.Trace("SNU - Level 2 physics just stoped")
	endif
endFunction

function CBPCBreastsBig(actor target, bool Pstop = false) Global
	if checkSMPPhysics(target) || !Game.IsPluginInstalled("3BBB.esp")
		return
	endif
	
	if !Pstop
		CBPCPluginScript.StartPhysics(target, "L Breast02")
		CBPCPluginScript.StartPhysics(target, "L Breast03")
		CBPCPluginScript.StartPhysics(target, "R Breast02")
		CBPCPluginScript.StartPhysics(target, "R Breast03")
		Debug.Trace("SNU - Level 3 physics just started")
	else
		CBPCPluginScript.StopPhysics(target, "L Breast02")
		CBPCPluginScript.StopPhysics(target, "L Breast03")
		CBPCPluginScript.StopPhysics(target, "R Breast02")
		CBPCPluginScript.StopPhysics(target, "R Breast03")

		resetCBPCBreasts(target)
		Debug.Trace("SNU - Level 3 physics just stoped")
	endif
endFunction

function resetCBPCBreasts(Actor victim) Global
	;if Game.GetModByName("3BBB.esp") != 255
	if Game.IsPluginInstalled("3BBB.esp")
		Mus3BPhysicsManager PhysicsManager = Game.GetFormFromFile(0x0500084A, "3BBB.esp") As Mus3BPhysicsManager
		;Debug.Trace("SNU - Request to reset physics")
		PhysicsManager.CBPCBreastsReset(victim)
	endIf
EndFunction

function setCBPCBreastsPhysics(Actor victim, Bool stopPhysics = false) Global
	;if Game.GetModByName("3BBB.esp") != 255
	if Game.IsPluginInstalled("3BBB.esp")
		Mus3BPhysicsManager PhysicsManager = Game.GetFormFromFile(0x0500084A, "3BBB.esp") As Mus3BPhysicsManager
		;Debug.Trace("SNU - Request to update physics")
		PhysicsManager.CBPCBreasts(victim, stopPhysics)
	endIf
EndFunction

