Scriptname SnusnuMusclePowerNPCScript Extends ActiveMagicEffect

import NiOverride

Snusnu Property snusnuMain Auto
Package Property doNothingPackage Auto  

String SNUSNU_BUFF_KEY = "Snusnu_BUFF"

Event OnEffectStart(Actor akTarget, Actor akCaster)
	String ActorName = (akTarget.GetBaseObject() as ActorBase).getName()

	If StorageUtil.GetIntValue(akTarget, "SNU_UltraMuscle") != 2 ;2 means it is currently transforming
		If StorageUtil.GetIntValue(akTarget, "SNU_UltraMuscle") == 0
			Debug.Notification(ActorName+" is turning into a muscular powerhouse!")
			StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 2)
			transformFMG(akTarget)
			StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 1)
		Else
			Debug.Notification(ActorName+" is turning back to normal")
			StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 2)
			disTransformFMG(akTarget)
			StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 0)
		EndIf
	Else
		Debug.Notification(ActorName+" is already going through a transformation")
	EndIf

EndEvent

Function transformFMG(Actor fmgTarget)
	Bool play_TF_Idle = !fmgTarget.IsOnMount() && !fmgTarget.IsSprinting() && !fmgTarget.IsRunning() && fmgTarget.GetSleepState() == 0 && \
									!fmgTarget.IsInCombat() && fmgTarget.GetSitState() == 0 && !fmgTarget.IsSwimming()
	
	If snusnuMain.tfAnimationNPC
		; 0 - Dialogue Anger		8 - Mood Anger		15 - Combat Anger
		fmgTarget.SetExpressionOverride(8, 65)
		fmgTarget.SetExpressionPhoneme(0, 0.4)
			
		If snusnuMain.playTFSound
			snusnuMain.snusnuTFSound.Play(fmgTarget)
		EndIf
		
		If play_TF_Idle
			ActorUtil.AddPackageOverride(fmgTarget, doNothingPackage, 1)
			fmgTarget.EvaluatePackage()
			Utility.wait(0.5)
			Debug.SendAnimationEvent(fmgTarget, "Snu_idle1")
		EndIf
		
		;TLALOC- First we check if overlay slot is available
		;String overlaySlot = initOverlaySlot(fmgTarget)
		
		float growSteps = 1
		float growVal = 0.01
		int growStage = 1
		bool goingUp = true
		int currentStage = 1
		while growVal != growSteps || goingUp
			muscleChange(fmgTarget, growVal );NOTE- growVal should be a value between 0 and 1
			;TLALOC-ToDo- Also gradually change normal muscle mass (snusnuMain.UpdateWeight())
			
			;Apply the pulsating animation: Muscles will suddently grow a lot, then will shrink a little, 
			;                               then grow again, then shrink again, until desired size is achieved
			If goingUp
				growVal = growVal + 0.01
				If growVal >= growStage * 0.1
					goingUp = false
					;Debug.Trace("SNU - growVal is "+growVal+", going back down")
					
					;TLALOC- Update normals if needed
					currentStage = switchMuscleNormals(fmgTarget, currentStage, growVal * 100 )
					
					snusnuMain.changeSpineBoneScale(fmgTarget, growVal * 0.125)
					snusnuMain.changeForearmBoneScale(fmgTarget, growVal * 0.125)
				EndIf
			Else
				growVal = growVal - 0.005
				If growVal >= growSteps - 0.01 && growVal <= growSteps + 0.01
					;Debug.Trace("SNU - growVal has rested on "+growVal)
					
					growVal = growSteps ;TLALOC - Break condition
					snusnuMain.changeSpineBoneScale(fmgTarget, growVal * 0.125)
					snusnuMain.changeForearmBoneScale(fmgTarget, growVal * 0.125)
				ElseIf growVal <= (growStage * 0.1) - 0.05
					If !((growStage * 0.1) - 0.05 > growSteps) ;TLALOC - Fix for special case where the target size is skipped
						goingUp = true
						growStage = growStage + 1
						;Debug.Trace("SNU - growVal is "+growVal+", going back up")
					EndIf
				EndIf
			EndIf
	;/		
			;TLALOC- Update normals if needed
			AddNodeOverrideFloat(fmgTarget, true, overlaySlot, 8, -1, growVal, true)	
			;AddNodeOverrideFloat(fmgTarget, true, "Face [Ovl0]", 8, -1, 1.0, true)
			;AddNodeOverrideFloat(fmgTarget, true, "Hands [Ovl1]", 8, -1, 1.0, true)
			;AddNodeOverrideFloat(fmgTarget, true, "Feet [Ovl1]", 8, -1, 1.0, true)
	/;		
			If goingUp
				Utility.wait(0.04)
			Else
				Utility.wait(0.2)
			EndIf
		endWhile
		;Debug.Trace("SNU - Final growVal is "+growVal)
		
		If play_TF_Idle
			Debug.SendAnimationEvent(fmgTarget,"IdleForceDefaultState")
			
			ActorUtil.RemovePackageOverride(fmgTarget, doNothingPackage)
			fmgTarget.EvaluatePackage()
		EndIf
		
		fmgTarget.ResetExpressionOverrides()
		fmgTarget.ClearExpressionOverride()
	Else
		muscleChange(fmgTarget, 1.0 )
		snusnuMain.changeSpineBoneScale(fmgTarget, 0.125)
		snusnuMain.changeForearmBoneScale(fmgTarget, 0.125)
		switchMuscleNormals(fmgTarget, 4, 100 )
	EndIf
	
	If snusnuMain.useAltAnimsNPC
		snusnuMain.setMuscleAnimations(fmgTarget)
	EndIf
	
	;Ultra punching strength
	fmgTarget.AddItem(snusnuMain.FistsOfRage, 1, True)
	fmgTarget.EquipItem(snusnuMain.FistsOfRage, True, True)
	
	addBuffEffects(fmgTarget)
	
	;TLALOC-ToDo- Change hair?
	;switchBarbarianHair()
	
	;TLALOC-ToDo- Change skin?
	;applyBarbarianSkin()
EndFunction

Function disTransformFMG(Actor fmgTarget)
	;TLALOC-ToDo- Make a deflate animation for this
	clearMuscleMorphs(fmgTarget)
	snusnuMain.clearBoneScales(fmgTarget)
	
	;TLALOC-ToDo- Remove normals overlay
	;AddNodeOverrideFloat(fmgTarget, true, overlaySlot, 8, -1, growVal, true)
	RemoveAllReferenceSkinOverrides(fmgTarget);For the custom normals
	RemoveAllReferenceNodeOverrides(fmgTarget);For the custom normals
	RemoveSkinOverride(fmgTarget, true, false, 0x04, 9, 1)
	
	If snusnuMain.useAltAnimsNPC
		snusnuMain.setMuscleAnimations(fmgTarget, true)
	EndIf
	
	fmgTarget.RemoveItem(snusnuMain.FistsOfRage, fmgTarget.GetItemCount(snusnuMain.FistsOfRage), True)
	
	removeBuffEffects(fmgTarget)
	
	;TLALOC-ToDo- Change hair?
	;switchBarbarianHair()
	
	;TLALOC-ToDo- Change skin?
	;applyBarbarianSkin()
	
	Armor currentArmor = fmgTarget.GetWornForm(Armor.GetMaskForSlot(32)) as Armor
	If currentArmor
		Utility.Wait(1)
		fmgTarget.UnequipItemSlot(32)
		Utility.Wait(1)
		fmgTarget.equipItem(currentArmor)
	EndIf
EndFunction

Function muscleChange(Actor buffTarget, Float changePercent)
	SetBodyMorph(buffTarget, "Breasts", SNUSNU_BUFF_KEY, changePercent * -0.6 );TLALOC- Inverted
	SetBodyMorph(buffTarget, "BreastsSSH", SNUSNU_BUFF_KEY, changePercent * -0.8 )
	SetBodyMorph(buffTarget, "BreastsFantasy", SNUSNU_BUFF_KEY, changePercent * -1.0 )
	SetBodyMorph(buffTarget, "DoubleMelon", SNUSNU_BUFF_KEY, changePercent * 1.3 )
	SetBodyMorph(buffTarget, "BreastFlatness", SNUSNU_BUFF_KEY, changePercent * 0.1 )
	SetBodyMorph(buffTarget, "BreastGravity", SNUSNU_BUFF_KEY, changePercent * 0.7 )
	SetBodyMorph(buffTarget, "BreastHeight", SNUSNU_BUFF_KEY, changePercent * 1.8 )
	SetBodyMorph(buffTarget, "BreastPerkiness", SNUSNU_BUFF_KEY, changePercent * -1.2 )
	SetBodyMorph(buffTarget, "BreastWidth", SNUSNU_BUFF_KEY, changePercent * 1.2 )
	
	SetBodyMorph(buffTarget, "NippleDistance", SNUSNU_BUFF_KEY, changePercent * -0.2 );TLALOC- Inverted
	SetBodyMorph(buffTarget, "NippleUp", SNUSNU_BUFF_KEY, changePercent * -1.0 )
	SetBodyMorph(buffTarget, "NippleDown", SNUSNU_BUFF_KEY, changePercent * 0.3 )
	
	SetBodyMorph(buffTarget, "Arms", SNUSNU_BUFF_KEY, changePercent * -0.6 );TLALOC- Inverted
	SetBodyMorph(buffTarget, "ChubbyArms", SNUSNU_BUFF_KEY, changePercent * 1.5 )
	SetBodyMorph(buffTarget, "ShoulderSmooth", SNUSNU_BUFF_KEY, changePercent * -1.5 )
	SetBodyMorph(buffTarget, "ShoulderWidth", SNUSNU_BUFF_KEY, changePercent * -0.3 );TLALOC- Inverted
	
	SetBodyMorph(buffTarget, "Belly", SNUSNU_BUFF_KEY, changePercent * 1.4 )
	SetBodyMorph(buffTarget, "TummyTuck", SNUSNU_BUFF_KEY, changePercent * -1.0 )
	
	SetBodyMorph(buffTarget, "BigTorso", SNUSNU_BUFF_KEY, changePercent * 0.6 )
	SetBodyMorph(buffTarget, "Waist", SNUSNU_BUFF_KEY, changePercent * -0.25 )
	SetBodyMorph(buffTarget, "WideWaistLine", SNUSNU_BUFF_KEY, changePercent * -0.85 )
	SetBodyMorph(buffTarget, "ChubbyWaist", SNUSNU_BUFF_KEY, changePercent * -0.15 )
	SetBodyMorph(buffTarget, "Back", SNUSNU_BUFF_KEY, changePercent * 0.6 )
	
	SetBodyMorph(buffTarget, "Butt", SNUSNU_BUFF_KEY, changePercent * -0.4 );TLALOC- Inverted
	SetBodyMorph(buffTarget, "ButtSmall", SNUSNU_BUFF_KEY, changePercent * 0.2 );TLALOC- Inverted
	SetBodyMorph(buffTarget, "ButtShape2", SNUSNU_BUFF_KEY, changePercent * 1.0 )
	SetBodyMorph(buffTarget, "BigButt", SNUSNU_BUFF_KEY, changePercent * 0.5 )
	SetBodyMorph(buffTarget, "AppleCheeks", SNUSNU_BUFF_KEY, changePercent * -0.1 )
	
	SetBodyMorph(buffTarget, "SlimThighs", SNUSNU_BUFF_KEY, changePercent * -0.3 )
	SetBodyMorph(buffTarget, "Thighs", SNUSNU_BUFF_KEY, changePercent * -0.3 )
	SetBodyMorph(buffTarget, "ChubbyLegs", SNUSNU_BUFF_KEY, changePercent * 0.8 )
	SetBodyMorph(buffTarget, "Legs", SNUSNU_BUFF_KEY, changePercent * -0.2 );TLALOC- Inverted
	SetBodyMorph(buffTarget, "CalfSize", SNUSNU_BUFF_KEY, changePercent * 1.58 )
	SetBodyMorph(buffTarget, "CalfSmooth", SNUSNU_BUFF_KEY, changePercent * -0.5 )
	
	SetBodyMorph(buffTarget, "UNPSH High", SNUSNU_BUFF_KEY, changePercent)
	
	;TLALOC- BHUNP
	;SetBodyMorph(buffTarget, "ChubbyArms", SNUSNU_BUFF_KEY, changePercent * 0.3 )
	;SetBodyMorph(buffTarget, "MuscleArms", SNUSNU_BUFF_KEY, changePercent * 1.5 )
	;SetBodyMorph(buffTarget, "MuscleAbs", SNUSNU_BUFF_KEY, changePercent)
	;SetBodyMorph(buffTarget, "MusclePecs", SNUSNU_BUFF_KEY, changePercent)
	
	UpdateModelWeight(buffTarget)
EndFunction

Function clearMuscleMorphs(Actor buffTarget)
	ClearBodyMorph(buffTarget, "Breasts", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "BreastsSSH", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "BreastsFantasy", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "DoubleMelon", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "BreastFlatness", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "BreastGravity", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "BreastHeight", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "BreastPerkiness", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "BreastWidth", SNUSNU_BUFF_KEY)
	
	ClearBodyMorph(buffTarget, "NippleDistance", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "NippleUp", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "NippleDown", SNUSNU_BUFF_KEY)
	
	ClearBodyMorph(buffTarget, "Arms", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "ChubbyArms", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "ShoulderSmooth", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "ShoulderWidth", SNUSNU_BUFF_KEY)
	
	ClearBodyMorph(buffTarget, "Belly", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "TummyTuck", SNUSNU_BUFF_KEY)
	
	ClearBodyMorph(buffTarget, "BigTorso", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "Waist", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "WideWaistLine", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "ChubbyWaist", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "Back", SNUSNU_BUFF_KEY)
	
	ClearBodyMorph(buffTarget, "Butt", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "ButtSmall", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "ButtShape2", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "BigButt", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "AppleCheeks", SNUSNU_BUFF_KEY)
	
	ClearBodyMorph(buffTarget, "SlimThighs", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "Thighs", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "ChubbyLegs", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "Legs", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "CalfSize", SNUSNU_BUFF_KEY)
	ClearBodyMorph(buffTarget, "CalfSmooth", SNUSNU_BUFF_KEY)
	
	ClearBodyMorph(buffTarget, "UNPSH High", SNUSNU_BUFF_KEY)
	
	;TLALOC- BHUNP
	;ClearBodyMorph(buffTarget, "ChubbyArms", SNUSNU_BUFF_KEY)
	;ClearBodyMorph(buffTarget, "MuscleArms", SNUSNU_BUFF_KEY)
	;ClearBodyMorph(buffTarget, "MuscleAbs", SNUSNU_BUFF_KEY)
	;ClearBodyMorph(buffTarget, "MusclePecs", SNUSNU_BUFF_KEY)
	
	UpdateModelWeight(buffTarget)
EndFunction

Int Function switchMuscleNormals(Actor buffTarget, Int currentStage, Float newWeight)
	Int newStage = currentStage

	If currentStage == 1 && newWeight >= 30.0 && newWeight < 55.0
		newStage = 2
	ElseIf currentStage == 2 && newWeight >= 55.0 && newWeight < 75.0
		newStage = 3
	ElseIf currentStage == 3 && newWeight >= 75.0 && newWeight < 100.0
		newStage = 4
	ElseIf currentStage == 4 && newWeight == 100.0
		newStage = 5
	EndIf
	
	;Debug.Trace("SNU - Going to switch normals? currentStage="+currentStage+", newStage="+newStage+", newWeight="+newWeight)
	If newStage != currentStage
		applyMuscleNormals(buffTarget, newStage)
	EndIf
	return newStage
EndFunction

Function applyMuscleNormals(Actor buffTarget, int stage)
	String tempNormalsPath = "textures\\Snusnu\\Normals\\"
	;Debug.Trace("SNU - Normals path is now "+tempNormalsPath)
	
	If stage == 2
		tempNormalsPath = tempNormalsPath + "athletic"
	ElseIf stage == 3
		tempNormalsPath = tempNormalsPath + "boneCrusher"
	ElseIf stage == 4
		tempNormalsPath = tempNormalsPath + "boneCrusherExtra"
	ElseIf stage == 5
		tempNormalsPath = tempNormalsPath + "boneCrusherUltra"
	EndIf
	
	tempNormalsPath = tempNormalsPath + ".dds"
	
	AddSkinOverrideString(buffTarget, true, false, 0x04, 9, 1, tempNormalsPath, true)
EndFunction

Function removeBuffEffects(Actor buffTarget)
	buffTarget.RemoveSpell(snusnuMain.AbilityStamina)
	buffTarget.RemoveSpell(snusnuMain.AbilitySpeed)
	buffTarget.RemoveSpell(snusnuMain.AbilityCombat)
EndFunction

Function addBuffEffects(Actor buffTarget)
;/	Float magStamina = snusnuMain.Stamina * 2
	Float magSpeed = snusnuMain.Speed * 2
	Float magCombat = snusnuMain.combatProficiency * 2
	
	snusnuMain.AbilityStamina.SetNthEffectMagnitude(0, Math.abs(magStamina))
	snusnuMain.AbilitySpeed.SetNthEffectMagnitude(0, Math.abs(magSpeed))
	snusnuMain.AbilityCombat.SetNthEffectMagnitude(0, Math.abs(magCombat))
	snusnuMain.AbilityCombat.SetNthEffectMagnitude(1, Math.abs(magCombat))
	snusnuMain.AbilityCombat.SetNthEffectMagnitude(2, Math.abs(magCombat))
	snusnuMain.AbilityCombat.SetNthEffectMagnitude(3, Math.abs(magCombat))
/;	
	buffTarget.AddSpell(snusnuMain.AbilityStamina, False)
	buffTarget.AddSpell(snusnuMain.AbilitySpeed, False)
	buffTarget.AddSpell(snusnuMain.AbilityCombat, False)
EndFunction
