Scriptname SnusnuVampireLordMuscleScript Extends ActiveMagicEffect

Snusnu Property snusnuMain Auto

String SNUSNU_BUFF_KEY = "Snusnu_BUFF"

;FMG Morphs
Float[] cbbeValuesFMG
Float[] uunpValuesFMG
Float[] bhunpValuesFMG
Float[] cbbeSEValuesFMG
Float[] cbbe3BAValuesFMG
Float[] bhunp3ValuesFMG
Float[] bonesValuesFMG
Float[] maleValuesFMG


Event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("SNU - VampireLordMuscle was cast")
	If snusnuMain.isVampireLord
		applyMuscleEffect(akTarget)
	Else
		;removeMuscleEffect(akTarget)
	EndIf
EndEvent

Function applyMuscleEffect(Actor akTarget)
	;Vampire lord form uses the same morphs as the FMG spell, so they cannot be active at the same time
	If StorageUtil.GetIntValue(akTarget, "SNU_UltraMuscle", 0) > 0
		snusnuMain.PlayerRef.DispelSpell(snusnuMain.MusclePowerSpell)
		snusnuMain.PlayerRef.DispelSpell(snusnuMain.UltraMusclePowerSpell)
		
		Utility.Wait(1)
		While snusnuMain.isTransforming
			Utility.Wait(0.4)
		EndWhile
	EndIf
			
	Debug.Trace("SNU - Starting Vampire Lord Muscle Effect")
	snusnuMain.showInfoNotification("Starting Vampire Lord Muscle Effect")
	initFMGSliders()
	If !loadFMGMorphs(akTarget)
		Debug.Notification("Could not load the FMG morphs!")
		Dispel()
		return
	EndIf
	
	snusnuMain.vampireLordMusclePercent = snusnuMain.muscleScore / snusnuMain.muscleScoreMax
	snusnuMain.vampireLordMusclePercent = snusnuMain.vampireLordMusclePercent * 1.2
	If snusnuMain.vampireLordMusclePercent > 1.0
		snusnuMain.vampireLordMusclePercent = 1.0
	EndIf
	
	snusnuMain.removeNormalMuscle(akTarget, snusnuMain.vampireLordMusclePercent)
	muscleChange(akTarget, snusnuMain.vampireLordMusclePercent)
	updateBones(akTarget, snusnuMain.vampireLordMusclePercent)
	
	Bool hasHandFix = false
	Armor handsArmor = akTarget.GetWornForm(0x00000008) as Armor
	if !handsArmor
		Debug.Trace("SNU - Attempting to apply hands fix!")
		akTarget.equipItem(snusnuMain.handsFix, true, true)
		Utility.wait(0.2)
		hasHandFix = true
	endIf
	
	Int level = SnusnuMusclePowerNPCScript.forceSwitchMuscleNormals(akTarget, snusnuMain.vampireLordMusclePercent * 100, snusnuMain.getNormalsByBodyType(akTarget))
	snusnuMain.chooseVampLordBoobsPhysics(level)
	
	if hasHandFix
		Debug.Trace("SNU - Finishing to apply hands fix!")
		Utility.wait(0.2)
		akTarget.unequipItemslot(33)
		akTarget.removeitem(snusnuMain.handsFix, 1, true)
	endIf
EndFunction

Function removeMuscleEffect(Actor akTarget)
	clearMuscleMorphs(akTarget)
	snusnuMain.clearBoneScales(akTarget)
	
	Bool isFemale = akTarget.GetActorBase().GetSex() != 0
	NiOverride.RemoveSkinOverride(akTarget, isFemale, false, 0x04, 9, 1)
	NiOverride.RemoveSkinOverride(akTarget, isFemale, true, 0x04, 9, 1)
	If !akTarget.IsOnMount()
		akTarget.QueueNiNodeUpdate()
	EndIf
	
	snusnuMain.UpdateWeight(true)
	;snusnuMain.checkBodyNormalsState()
	
	Debug.Trace("SNU - Finished Vampire Lord Muscle Effect")
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

Function updateBones(Actor theActor, Float magnitude, Bool goingUp = true)
	Int boneCounter = 0
	While boneCounter < snusnuMain.totalCurrentBones
		snusnuMain.changeBoneScale(theActor, boneCounter, snusnuMain.getBoneSize(magnitude, bonesValuesFMG[boneCounter]))
		boneCounter += 1
	EndWhile
EndFunction

Function initFMGSliders()
	cbbeValuesFMG = new Float[52]
	uunpValuesFMG = new Float[74]
	bhunpValuesFMG = new Float[43]
	cbbeSEValuesFMG = new Float[27]
	cbbe3BAValuesFMG = new Float[40]
	bhunp3ValuesFMG = new Float[43]
	bonesValuesFMG = new Float[68]
	maleValuesFMG = new Float[2]
EndFunction

Bool Function loadFMGMorphs(Actor theVampLord)
	String fileName = "SnuSnuProfiles/SnuDefaultFMG_" + snusnuMain.getNormalsByBodyType(theVampLord, false)
	
	If JsonUtil.Load(fileName) && JsonUtil.IsGood(fileName)
		int[] tempMorphsArray = JsonUtil.IntListToArray(fileName, "MainMorphs")
		If tempMorphsArray && tempMorphsArray.length > 0
			If !StorageUtil.IntListCopy(none, SNUSNU_BUFF_KEY, tempMorphsArray)
				Debug.Trace("SNU - ERROR: Main morphs array could not be loaded!!")
				Return false
			EndIf
		Else
			StorageUtil.IntListClear(none, SNUSNU_BUFF_KEY)
		EndIf
		
		cbbeValuesFMG = JsonUtil.FloatListToArray(fileName, "CBBEMorphs")
		uunpValuesFMG = JsonUtil.FloatListToArray(fileName, "UUNPMorphs")
		bhunpValuesFMG = JsonUtil.FloatListToArray(fileName, "BHUNPMorphs")
		cbbeSEValuesFMG = JsonUtil.FloatListToArray(fileName, "CBBESEMorphs")
		cbbe3BAValuesFMG = JsonUtil.FloatListToArray(fileName, "3BAMorphs")
		bhunp3ValuesFMG = JsonUtil.FloatListToArray(fileName, "BHUNP3Morphs")
		
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
	ElseIf group == 6
		return bhunp3ValuesFMG[newIndex - 52 - 74 - 43 - 27 - 40]
	EndIf
	
	return 0.0
EndFunction

