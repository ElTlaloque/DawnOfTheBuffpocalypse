Scriptname SnusnuMusclePowerNPCScript Extends ActiveMagicEffect

Snusnu Property snusnuMain Auto
Package Property doNothingPackage Auto  

String SNUSNU_BUFF_KEY = "Snusnu_BUFF"


;FMG Morphs
Float[] cbbeValuesFMG
Float[] uunpValuesFMG
Float[] bhunpValuesFMG
Float[] cbbeSEValuesFMG
Float[] cbbe3BAValuesFMG
Float[] bonesValuesFMG
Float[] maleValuesFMG


Event OnEffectStart(Actor akTarget, Actor akCaster)
	String ActorName = (akTarget.GetBaseObject() as ActorBase).getName()

	If StorageUtil.GetIntValue(akTarget, "SNU_UltraMuscle_NPC") != 2 ;2 means it is currently transforming
		If StorageUtil.GetIntValue(akTarget, "SNU_UltraMuscle_NPC") == 0
			Debug.Notification(ActorName+" is turning into a muscular powerhouse!")
			StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle_NPC", 2)
			transformFMG(akTarget)
			StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle_NPC", 1)
		Else
			Debug.Notification(ActorName+" is turning back to normal")
			StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle_NPC", 2)
			disTransformFMG(akTarget)
			StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle_NPC", 0)
		EndIf
	Else
		Debug.Notification(ActorName+" is already going through a transformation")
	EndIf

EndEvent

Function transformFMG(Actor fmgTarget)
	Bool play_TF_Idle = !fmgTarget.IsOnMount() && !fmgTarget.IsSprinting() && !fmgTarget.IsRunning() && fmgTarget.GetSleepState() == 0 && \
									!fmgTarget.IsInCombat() && fmgTarget.GetSitState() == 0 && !fmgTarget.IsSwimming()
	
	initFMGSliders()
	If !loadFMGMorphs()
		Debug.Notification("Could not load the FMG morphs!")
		Dispel()
		return
	EndIf
	
	If fmgTarget.GetBaseObject().getName() != ""
		Debug.Trace("SNU - Actor is not generic. Adding to list.")
		StorageUtil.SetFloatValue(fmgTarget, "hasMuscle", snusnuMain.npcMuscleScore)
		StorageUtil.FormListAdd(none, "MUSCLE_NPCS", fmgTarget, false)
	EndIf
	
	If snusnuMain.tfAnimationNPC
		; 0 - Dialogue Anger		8 - Mood Anger		15 - Combat Anger
		fmgTarget.SetExpressionOverride(8, 65)
		fmgTarget.SetExpressionPhoneme(0, 0.4)
		
		Int tfSoundInstance
		If snusnuMain.playTFSound
			tfSoundInstance = snusnuMain.snusnuTFSound.Play(fmgTarget)
		EndIf
		
		If play_TF_Idle
			ActorUtil.AddPackageOverride(fmgTarget, doNothingPackage, 1)
			fmgTarget.EvaluatePackage()
			Utility.wait(0.5)
			Debug.SendAnimationEvent(fmgTarget, "Snu_idle1")
		EndIf
		
		;TLALOC- First we check if overlay slot is available
		;String overlaySlot = initOverlaySlot(fmgTarget)
		
		float growSteps = snusnuMain.npcMuscleScore
		float growVal = 0.01
		int growStage = 1
		bool goingUp = true
		int currentStage = 1
		while growVal != growSteps || goingUp
			muscleChange(fmgTarget, growVal )
			
			;Apply the pulsating animation: Muscles will suddently grow a lot, then will shrink a little, 
			;                               then grow again, then shrink again, until desired size is achieved
			If goingUp
				growVal = growVal + 0.02
				If growVal >= growStage * 0.1
					goingUp = false
					;Debug.Trace("SNU - growVal is "+growVal+", going back down")
					
					;TLALOC- Update normals if needed
					currentStage = switchMuscleNormals(fmgTarget, currentStage, growVal * 100 )
					
					snusnuMain.changeSpineBoneScale(fmgTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[0]))
					snusnuMain.changeForearmBoneScale(fmgTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[1]))
				EndIf
			Else
				growVal = growVal - 0.01
				If growVal >= growSteps - 0.01 && growVal <= growSteps + 0.01
					;Debug.Trace("SNU - growVal has rested on "+growVal)
					
					growVal = growSteps ;TLALOC - Break condition
					
					snusnuMain.changeSpineBoneScale(fmgTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[0]))
					snusnuMain.changeForearmBoneScale(fmgTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[1]))
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
		
		If snusnuMain.playTFSound
			Sound.StopInstance(tfSoundInstance)
		EndIf
		
		fmgTarget.ResetExpressionOverrides()
		fmgTarget.ClearExpressionOverride()
	Else
		muscleChange(fmgTarget, snusnuMain.npcMuscleScore )
		
		snusnuMain.changeSpineBoneScale(fmgTarget, snusnuMain.getBoneSize(snusnuMain.npcMuscleScore, bonesValuesFMG[0]))
		snusnuMain.changeForearmBoneScale(fmgTarget, snusnuMain.getBoneSize(snusnuMain.npcMuscleScore, bonesValuesFMG[1]))
		
		switchMuscleNormals(fmgTarget, 4, snusnuMain.npcMuscleScore * 100 )
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
	
	Debug.Notification((fmgTarget.GetBaseObject() as ActorBase).getName()+" has finished transforming")
EndFunction

Function disTransformFMG(Actor fmgTarget)
	If snusnuMain.tfAnimationNPC
		initFMGSliders()
		If !loadFMGMorphs()
			Debug.Notification("Could not load the FMG morphs!")
			
			clearMuscleMorphs(fmgTarget)
			snusnuMain.clearBoneScales(fmgTarget)
		Else
			float deflateVal = StorageUtil.GetFloatValue(fmgTarget, "hasMuscle", 0)
			while deflateVal > 0.0
				muscleChange(fmgTarget, deflateVal)
				
				If (deflateVal * 100) as Int % 16 == 0
					snusnuMain.changeSpineBoneScale(fmgTarget, snusnuMain.getBoneSize(deflateVal, bonesValuesFMG[0]))
					snusnuMain.changeForearmBoneScale(fmgTarget, snusnuMain.getBoneSize(deflateVal, bonesValuesFMG[1]))
				endIf
				
				deflateVal -= 0.02
				Utility.wait(0.04)
			endWhile
			
			snusnuMain.changeSpineBoneScale(fmgTarget, snusnuMain.getBoneSize(0, bonesValuesFMG[0]))
			snusnuMain.changeForearmBoneScale(fmgTarget, snusnuMain.getBoneSize(0, bonesValuesFMG[1]))
			
			clearMuscleMorphs(fmgTarget)
			snusnuMain.clearBoneScales(fmgTarget)
		EndIf
	Else
		clearMuscleMorphs(fmgTarget)
		snusnuMain.clearBoneScales(fmgTarget)
	EndIf
	
	;TLALOC-ToDo- Remove normals overlay
	;AddNodeOverrideFloat(fmgTarget, true, overlaySlot, 8, -1, growVal, true)
	;RemoveAllReferenceSkinOverrides(fmgTarget);For the custom normals
	;RemoveAllReferenceNodeOverrides(fmgTarget);For the custom normals
	NiOverride.RemoveSkinOverride(fmgTarget, true, false, 0x04, 9, 1)
	
	If snusnuMain.useAltAnimsNPC
		snusnuMain.setMuscleAnimations(fmgTarget, true)
	EndIf
	
	fmgTarget.RemoveItem(snusnuMain.FistsOfRage, fmgTarget.GetItemCount(snusnuMain.FistsOfRage), True)
	
	removeBuffEffects(fmgTarget)
	
	If !fmgTarget.IsOnMount()
		fmgTarget.QueueNiNodeUpdate()
	EndIf
	;/	
	Armor currentArmor = fmgTarget.GetWornForm(Armor.GetMaskForSlot(32)) as Armor
	If currentArmor
		Utility.Wait(1)
		fmgTarget.UnequipItemSlot(32)
		Utility.Wait(1)
		fmgTarget.equipItem(currentArmor)
	EndIf
	/;
	
	StorageUtil.SetFloatValue(fmgTarget, "hasMuscle", 0)
	StorageUtil.FormListRemove(none, "MUSCLE_NPCS", fmgTarget, true)
	
	Debug.Notification((fmgTarget.GetBaseObject() as ActorBase).getName()+" is back to normal")
EndFunction

Function muscleChange(Actor buffTarget, Float changePercent)
	Int totalSliders = StorageUtil.IntListCount(none, SNUSNU_BUFF_KEY)
	Int slidersLoop = 0
	while slidersLoop < totalSliders
		Int currentSliderIndex = StorageUtil.IntListGet(none, SNUSNU_BUFF_KEY, slidersLoop)
		NiOverride.SetBodyMorph(buffTarget, snusnuMain.getSliderString(currentSliderIndex), SNUSNU_BUFF_KEY, changePercent * getSliderValue(currentSliderIndex))
		slidersLoop += 1
	endWhile
	
	NiOverride.UpdateModelWeight(buffTarget)
EndFunction

Function clearMuscleMorphs(Actor buffTarget)
	NiOverride.ClearBodyMorphKeys(buffTarget, SNUSNU_BUFF_KEY)
	NiOverride.UpdateModelWeight(buffTarget)
EndFunction

Int Function switchMuscleNormals(Actor buffTarget, Int currentStage, Float newWeight) Global
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

Int Function forceSwitchMuscleNormals(Actor buffTarget, Float newWeight) Global
	Int newStage = 1

	If newWeight >= 50.0 && newWeight < 70.0
		newStage = 2
	ElseIf newWeight >= 70.0 && newWeight < 85.0
		newStage = 3
	ElseIf newWeight >= 85.0
		newStage = 4
	EndIf
	
	Debug.Trace("SNU - Going to switch normals? newStage="+newStage+", newWeight="+newWeight)
	;If newStage > 1
		applyMuscleNormals(buffTarget, newStage)
	;/Else
		;TLALOC- For some reason normals still get fucked up on NPCs sometimes so we need to regenerate their textures
		RemoveAllReferenceSkinOverrides(buffTarget);For the custom normals
		RemoveAllReferenceNodeOverrides(buffTarget);For the custom normals
		RemoveSkinOverride(buffTarget, true, false, 0x04, 9, 1)
	EndIf
	/;
	return newStage
EndFunction

Function applyMuscleNormals(Actor buffTarget, int stage) Global
	String tempNormalsPath = "textures\\Snusnu\\Normals\\"
	;Debug.Trace("SNU - Normals path is now "+tempNormalsPath)
	
	If stage == 1
		tempNormalsPath = "textures\\actors\\character\\female\\femalebody_1_msn"
	ElseIf stage == 2
		tempNormalsPath = tempNormalsPath + "athletic"
	ElseIf stage == 3
		tempNormalsPath = tempNormalsPath + "boneCrusher"
	ElseIf stage == 4
		tempNormalsPath = tempNormalsPath + "boneCrusherExtra"
	ElseIf stage == 5
		tempNormalsPath = tempNormalsPath + "boneCrusherUltra"
	EndIf
	
	tempNormalsPath = tempNormalsPath + ".dds"
	
	Debug.Trace("SNU - Normals path is now "+tempNormalsPath)
	NiOverride.AddSkinOverrideString(buffTarget, true, false, 0x04, 9, 1, tempNormalsPath, true)
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
	;buffTarget.AddSpell(snusnuMain.AbilityCombat, False)
EndFunction


Function initFMGSliders()
	cbbeValuesFMG = new Float[52]
	uunpValuesFMG = new Float[74]
	bhunpValuesFMG = new Float[43]
	cbbeSEValuesFMG = new Float[27]
	cbbe3BAValuesFMG = new Float[40]
	bonesValuesFMG = new Float[2]
	maleValuesFMG = new Float[2]
EndFunction

Bool Function loadFMGMorphs()
	String fileName = "SnuSnuProfiles/SnuDefaultFMG"
	
	If JsonUtil.Load(fileName) && JsonUtil.IsGood(fileName)
		int[] tempMorphsArray = JsonUtil.IntListToArray(fileName, "MainMorphs")
		If !StorageUtil.IntListCopy(none, SNUSNU_BUFF_KEY, tempMorphsArray)
			Debug.Trace("SNU - ERROR: FMG Morphs array could not be loaded!!")
			Return false
		EndIf
		
		cbbeValuesFMG = JsonUtil.FloatListToArray(fileName, "CBBEMorphs")
		uunpValuesFMG = JsonUtil.FloatListToArray(fileName, "UUNPMorphs")
		bhunpValuesFMG = JsonUtil.FloatListToArray(fileName, "BHUNPMorphs")
		cbbeSEValuesFMG = JsonUtil.FloatListToArray(fileName, "CBBESEMorphs")
		cbbe3BAValuesFMG = JsonUtil.FloatListToArray(fileName, "3BAMorphs")
		
		bonesValuesFMG = JsonUtil.FloatListToArray(fileName, "BoneMorphs")
		maleValuesFMG = JsonUtil.FloatListToArray(fileName, "MaleMorphs")
	Else
		Debug.Trace("SNU - ERROR: FMG Morphs array could not be loaded!!")
		Return false
	EndIf
	
	Return true
EndFunction

Float Function getSliderValue(int newIndex)
	Int group = snusnuMain.getGroupIndex(newIndex)
	
	If group == 1
		return cbbeValuesFMG[newIndex]
	ElseIf group == 2
		return uunpValuesFMG[newIndex - 52]
	ElseIf group == 3
		return bhunpValuesFMG[newIndex - 52 - 74]
	ElseIf group == 4
		return cbbeSEValuesFMG[newIndex - 52 - 74 - 43]
	ElseIf group == 5
		return cbbe3BAValuesFMG[newIndex - 52 - 74 - 43 - 27]
	EndIf
	
	return 0.0
EndFunction

