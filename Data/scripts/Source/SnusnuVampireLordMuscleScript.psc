Scriptname SnusnuVampireLordMuscleScript Extends ActiveMagicEffect

Snusnu Property snusnuMain Auto

String SNUSNU_BUFF_KEY = "Snusnu_BUFF"

Float Property originalMuscleScore = 0.0 Auto
Float Property musclePercent = 1.0 Auto

;FMG Morphs
Float[] cbbeValuesFMG
Float[] uunpValuesFMG
Float[] bhunpValuesFMG
Float[] cbbeSEValuesFMG
Float[] cbbe3BAValuesFMG
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

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Debug.Trace("SNU - SnusnuVampireLordMuscleScript.OnEffectFinish()")
EndEvent

Event OnPlayerLoadGame()
	Debug.Trace("SNU - SnusnuVampireLordMuscleScript.OnPlayerLoadGame()")
	
	Utility.Wait(7)
	;Fix for normals not loading correctly
	forceSwitchMuscleNormals(snusnuMain.PlayerRef, musclePercent * 100, snusnuMain.getNormalsByBodyType(snusnuMain.PlayerRef))
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
	Debug.Notification("Starting Vampire Lord Muscle Effect")
	initFMGSliders()
	If !loadFMGMorphs(akTarget)
		Debug.Notification("Could not load the FMG morphs!")
		Dispel()
		return
	EndIf
	
	musclePercent = snusnuMain.muscleScore / snusnuMain.muscleScoreMax
	musclePercent = musclePercent * 1.2
	If musclePercent > 1.0
		musclePercent = 1.0
	EndIf
	
	removeNormalMuscle(akTarget, musclePercent)
	muscleChange(akTarget, musclePercent)
	updateBones(akTarget, musclePercent)
	forceSwitchMuscleNormals(akTarget, musclePercent * 100, snusnuMain.getNormalsByBodyType(akTarget))
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

Function removeNormalMuscle(Actor buffTarget, Float changePercent)
	Float fightingMuscle = originalMuscleScore * (1 - changePercent)
	
	Int totalSliders = StorageUtil.IntListCount(buffTarget, snusnuMain.SNUSNU_KEY)
	Int slidersLoop = 0
	while slidersLoop < totalSliders
		Int currentSliderIndex = StorageUtil.IntListGet(buffTarget, snusnuMain.SNUSNU_KEY, slidersLoop)
		NiOverride.SetBodyMorph(buffTarget, snusnuMain.getSliderString(currentSliderIndex), snusnuMain.SNUSNU_KEY, fightingMuscle * snusnuMain.getSliderValue(currentSliderIndex))
		slidersLoop += 1
	endWhile
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

Int Function forceSwitchMuscleNormals(Actor buffTarget, Float newWeight, String bodyType) Global
	Int newStage = 1

	If newWeight >= 30.0 && newWeight < 55.0
		newStage = 2
	ElseIf newWeight >= 55.0 && newWeight < 75.0
		newStage = 3
	ElseIf newWeight >= 75.0
		newStage = 5
	EndIf
	
	Debug.Trace("SNU - Going to switch normals? newStage="+newStage+", newWeight="+newWeight)
	;If newStage > 1
		applyMuscleNormals(buffTarget, newStage, bodyType)
	;/Else
		;TLALOC- For some reason normals still get fucked up on NPCs sometimes so we need to regenerate their textures
		RemoveAllReferenceSkinOverrides(buffTarget);For the custom normals
		RemoveAllReferenceNodeOverrides(buffTarget);For the custom normals
		RemoveSkinOverride(buffTarget, true, false, 0x04, 9, 1)
	EndIf
	/;
	return newStage
EndFunction

Function applyMuscleNormals(Actor buffTarget, int stage, String bodyType) Global
	String tempNormalsPath = "textures\\Snusnu\\Normals\\" + bodyType
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
	Bool isFemale = buffTarget.GetActorBase().GetSex() != 0
	NiOverride.AddSkinOverrideString(buffTarget, isFemale, false, 0x04, 9, 1, tempNormalsPath, true)
EndFunction

Function initFMGSliders()
	cbbeValuesFMG = new Float[52]
	uunpValuesFMG = new Float[74]
	bhunpValuesFMG = new Float[43]
	cbbeSEValuesFMG = new Float[27]
	cbbe3BAValuesFMG = new Float[40]
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

