Scriptname SnusnuMusclePowerScript extends ActiveMagicEffect  

import NiOverride
Import StorageUtil

String Property SNUSNU_BUFF_KEY = "Snusnu.esp_BUFF" AutoReadOnly

Snusnu Property snusnuMain Auto
Bool Property wasWMEnabled = false Auto
Float Property wmWeight = 0.0 Auto
Float Property originalMuscleScore = 0.0 Auto

;FMG Morphs
Float[] cbbeValuesFMG
Float[] uunpValuesFMG
Float[] bhunpValuesFMG
Float[] cbbeSEValuesFMG
Float[] cbbe3BAValuesFMG
Float[] bonesValuesFMG
Float[] maleValuesFMG


event OnEffectStart(Actor akTarget, Actor akCaster)
	If snusnuMain.PlayerRef.GetActorBase().GetSex() == 0
		Debug.Notification("This spell only works on female characters")
		Dispel()
		return
	EndIf
	
	initFMGSliders()
	If !loadFMGMorphs()
		Debug.Notification("Could not load the FMG morphs!")
		Dispel()
		return
	EndIf
	
	StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 1)
	Debug.Notification("FMG transformation starting")
	Debug.Trace("SNU - Starting transformation effect")
	If snusnuMain.isWeightMorphsLoaded
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If WMCM != none && snusnuMain.removeWeightMorphs
			If WMCM.WMorphs.Enabled
				wasWMEnabled = true
				WMCM.WMorphs.Enabled = false
				wmWeight = WMCM.WMorphs.Weight
				
				;ToDo- Gradually move Weight to 0.0 instead of just ClearMorphs
				;WMCM.WMorphs.ClearMorphs()
				
				;WMCM.WMorphs.RegisterEvents(false)
			EndIf
		EndIf
	EndIf
	
	If snusnuMain.tfAnimation
		; 0 - Dialogue Anger		8 - Mood Anger		15 - Combat Anger
		akTarget.SetExpressionOverride(8, 65)
		akTarget.SetExpressionPhoneme(0, 0.4)
		
		If snusnuMain.playTFSound
			snusnuMain.snusnuTFSound.Play(akTarget)
		EndIf
		
		If akTarget != snusnuMain.PlayerRef || (akTarget == snusnuMain.PlayerRef && !akTarget.isInCombat())
			;Unequip weapons
			akTarget.SheatheWeapon()
			Utility.wait(0.5)
			Debug.SendAnimationEvent(akTarget, "Snu_idle1")
		EndIf
		
		;TLALOC- First we check if overlay slot is available
		;String overlaySlot = initOverlaySlot(akTarget)
		
		;ToDo- Move this loop to onUpdate(). Make functions to apply stuff before and after this animation. Call the after anim
		;      function here if anim is disabled or in onUpdate if anim is enabled. Do the same with WeightMorphs
		float growSteps = 1
		float growVal = 0.01
		int growStage = 1
		bool goingUp = true
		int currentStage = snusnuMain.currentBuildStage
		originalMuscleScore = snusnuMain.getfightingMuscle()
		while growVal != growSteps || goingUp
			If goingUp
				;TLALOC- Gradually remove normal muscle
				removeNormalMuscle(akTarget, growVal)
			EndIf
			muscleChange(akTarget, growVal );NOTE- growVal should be a value between 0 and 1
			;TLALOC-ToDo- Also gradually change normal muscle mass (snusnuMain.UpdateWeight())
			
			;Apply the pulsating animation: Muscles will suddently grow a lot, then will shrink a little, then grow again, 
			;                               then shrink again, until desired size is achieved
			;
			;                               ToDo- We can apply the shrinking of the normal morphs, and then the growing of the 
			;                               FMG morphs. So we need to have the FMG morphs stored appart from the normal ones
			If goingUp
				growVal = growVal + 0.01
				If growVal >= growStage * 0.1
					goingUp = false
					;Debug.Trace("SNU - growVal is "+growVal+", going back down")
					
					;TLALOC- Update normals if needed
					currentStage = switchMuscleNormals(akTarget, currentStage, growVal * 100 )
						
					snusnuMain.changeSpineBoneScale(akTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[0]))
					snusnuMain.changeForearmBoneScale(akTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[1]))
				EndIf
			Else
				growVal = growVal - 0.005
				If growVal >= growSteps - 0.01 && growVal <= growSteps + 0.01
					;Debug.Trace("SNU - growVal has rested on "+growVal)
					
					growVal = growSteps ;TLALOC - Break condition
					
					snusnuMain.changeSpineBoneScale(akTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[0]))
					snusnuMain.changeForearmBoneScale(akTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[1]))
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
			AddNodeOverrideFloat(akTarget, true, overlaySlot, 8, -1, growVal, true)	
			;AddNodeOverrideFloat(akTarget, true, "Face [Ovl0]", 8, -1, 1.0, true)
			;AddNodeOverrideFloat(akTarget, true, "Hands [Ovl1]", 8, -1, 1.0, true)
			;AddNodeOverrideFloat(akTarget, true, "Feet [Ovl1]", 8, -1, 1.0, true)
	/;		
			If goingUp
				Utility.wait(0.04)
			Else
				Utility.wait(0.2)
			EndIf
		endWhile
		;Debug.Trace("SNU - Final growVal is "+growVal)
		
		snusnuMain.ClearMorphs(false)
		
		If !akTarget.isInCombat()
			Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
		EndIf
		
		akTarget.ResetExpressionOverrides()
		akTarget.ClearExpressionOverride()
	Else
		removeNormalMuscle(akTarget, 1.0)
		muscleChange(akTarget, 1.0 )
		
		snusnuMain.changeSpineBoneScale(akTarget, snusnuMain.getBoneSize(1.0, bonesValuesFMG[0]))
		snusnuMain.changeForearmBoneScale(akTarget, snusnuMain.getBoneSize(1.0, bonesValuesFMG[1]))
		
		switchMuscleNormals(akTarget, 4, 100 )
	EndIf
	
	;Ultra punching strength
	akTarget.AddItem(snusnuMain.FistsOfRage, 1, True)
	akTarget.EquipItem(snusnuMain.FistsOfRage, True, True)
	
	;TLALOC-ToDo- Change hair?
	;switchBarbarianHair(akTarget)
	
	;TLALOC-ToDo- Change skin?
	;applyBarbarianSkin(akTarget)
	
	;TLALOC-ToDo- Add a thick neck headmesh!!! -Add a MCM option for it
	;changeHeadMesh(akTarget)
	
	;Improved jump height
	Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
	
	snusnuMain.updateBoobsPhysics(true, 1)
	
	If snusnuMain.useAltAnims
		snusnuMain.updateAnimations(4)
	EndIf

	;TLALOC- Instad of changing the full body with BodyChange, we use our own muscular head with the appropiate HDT preset
	If snusnuMain.changeHeadPart
		ActorBase akTargetBase = akTarget.getActorBase()
		Int headIndex = akTargetBase.GetIndexOfHeadPartByType(1)
		snusnuMain.originalHead = akTargetBase.GetNthHeadPart(headIndex)
		Debug.Trace("SNU - Original head: "+snusnuMain.originalHead)
		
		akTarget.ChangeHeadPart(snusnuMain.MuscleHead)
		akTarget.RegenerateHead()
	EndIf
	
	If snusnuMain.heavyItemsEquiped && snusnuMain.PlayerRef.GetActorValue("CarryWeight") < -100
		Debug.Trace("SNU - All heavy items were removed. Restoring carryWeight")
		snusnuMain.PlayerRef.ModActorValue("CarryWeight", snusnuMain.actualCarryWeight + 500)
	EndIf
	
	Utility.wait(1.0)
	
	;CarryWeight Boost
	akTarget.ModActorValue("CarryWeight", 200)
	
	Debug.Trace("SNU - Finished applying transformation effect")
	Debug.Notification("FMG transformation finished")
	registerForSingleUpdate(10)
endevent

Event OnUpdate()
	;Jump height fix
	If Game.GetGameSettingFloat("fJumpHeightMin") < 180.0
		Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
	EndIf
	
	registerForSingleUpdate(10)
EndEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	;StorageUtil.SetIntValue(akTarget, "PSQ_HasMuscle", -1)
	StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 0)
	
	Debug.Trace("SNU - Starting removal of transformation effect")
	
	If snusnuMain.isWeightMorphsLoaded
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If WMCM != none && snusnuMain.removeWeightMorphs
			If !WMCM.WMorphs.Enabled && wasWMEnabled
				WMCM.WMorphs.Weight = wmWeight
				WMCM.WMorphs.Enabled = true
				wasWMEnabled = false
				WMCM.WMorphs.RegisterEvents(true)
			EndIf
		EndIf
	EndIf
	
	;TLALOC-ToDo- Make a deflate animation for this
	clearMuscleMorphs(akTarget)
	snusnuMain.clearBoneScales(akTarget)
	
	;TLALOC-ToDo- Remove normals overlay
	;AddNodeOverrideFloat(akTarget, true, overlaySlot, 8, -1, growVal, true)
	RemoveAllReferenceSkinOverrides(akTarget);For the custom normals
	;RemoveSkinOverride(akTarget, true, false, 0x04, 9, 1)
	
	If snusnuMain.useAltAnims
		;We need to check for the actual muscle level which is already done in checkBodyNormalsState()
		snusnuMain.checkBodyNormalsState()
	EndIf
	
	akTarget.RemoveItem(snusnuMain.FistsOfRage, akTarget.GetItemCount(snusnuMain.FistsOfRage), True)
	
	;TLALOC-ToDo- Change hair?
	;switchBarbarianHair()
	
	;TLALOC-ToDo- Change skin?
	;applyBarbarianSkin()
	
	If snusnuMain.changeHeadPart && snusnuMain.originalHead != none
			akTarget.ChangeHeadPart(snusnuMain.originalHead)
			akTarget.RegenerateHead()
	EndIf
	
	Game.SetGameSettingFloat("fJumpHeightMin", 76.0)
	
	;CarryWeight Boost
	akTarget.ModActorValue("CarryWeight", -200)
	
	Utility.wait(1.0)
	
	If snusnuMain.itemsEquipedWeight > snusnuMain.allowedItemsEquipedWeight
		snusnuMain.actualCarryWeight = snusnuMain.PlayerRef.GetActorValue("CarryWeight")
		Float modWeight = snusnuMain.actualCarryWeight + 500.0
		Debug.Trace("SNU - actualCarryWeight="+snusnuMain.actualCarryWeight)
		
		snusnuMain.PlayerRef.ModActorValue("CarryWeight", -modWeight)
		snusnuMain.heavyItemsEquiped = 1
	EndIf
	
	Debug.Trace("SNU - Finished removal of transformation effect")
endevent

Function removeNormalMuscle(Actor buffTarget, Float changePercent)
	Float fightingMuscle = originalMuscleScore * (1 - changePercent)
	
	Int totalSliders = StorageUtil.IntListCount(buffTarget, snusnuMain.SNUSNU_KEY)
	Int slidersLoop = 0
	while slidersLoop < totalSliders
		Int currentSliderIndex = StorageUtil.IntListGet(buffTarget, snusnuMain.SNUSNU_KEY, slidersLoop)
		SetBodyMorph(buffTarget, snusnuMain.getSliderString(currentSliderIndex), snusnuMain.SNUSNU_KEY, fightingMuscle * snusnuMain.getSliderValue(currentSliderIndex))
		slidersLoop += 1
	endWhile
EndFunction

Function muscleChange(Actor buffTarget, Float changePercent)
	
	;ToDo- We nedd to load the FMG profile here and save it on temporal arrays so that in can be gradually applied.
	;      We could actually have property arrays in the main script so that both this and the NPC TF scripts can use them.
	
	Int totalSliders = IntListCount(none, SNUSNU_BUFF_KEY)
	Int slidersLoop = 0
	while slidersLoop < totalSliders
		Int currentSliderIndex = IntListGet(none, SNUSNU_BUFF_KEY, slidersLoop)
		NiOverride.SetBodyMorph(buffTarget, snusnuMain.getSliderString(currentSliderIndex), SNUSNU_BUFF_KEY, changePercent * getSliderValue(currentSliderIndex))
		slidersLoop += 1
	endWhile
	
	UpdateModelWeight(buffTarget)
EndFunction

Function clearMuscleMorphs(Actor buffTarget)
	ClearBodyMorphKeys(buffTarget, SNUSNU_BUFF_KEY)
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
		tempNormalsPath = tempNormalsPath + "boneCrusherExtra_SLIM"
	ElseIf stage == 5
		tempNormalsPath = tempNormalsPath + "boneCrusherUltra"
	EndIf
	
	tempNormalsPath = tempNormalsPath + ".dds"
	
	AddSkinOverrideString(buffTarget, true, false, 0x04, 9, 1, tempNormalsPath, true)
	AddSkinOverrideString(buffTarget, true, true, 0x04, 9, 1, tempNormalsPath, true)
EndFunction

;TLALOC- Blatantly ripped from Blush When Aroused
string Function initOverlaySlot(Actor buffTarget) Global
	String normalsPath = "textures\\Snusnu\\Normals\\"
	string deftex = "Actors\\Character\\Overlays\\Default.dds"
	string newOverlayID = "x"
	int i = 0
	int maxOverlays = GetNumBodyOverlays()
	;Debug.Trace("SNU - maxOverlays="+maxOverlays)
	string overlayString
	while i < maxOverlays && newOverlayID == "x"
		overlayString = getCurrentOverlayString(buffTarget, i)
		Debug.Trace("SNU - overlayString="+overlayString)
		if overlayString == "" || overlayString == deftex || StringUtil.Find(overlayString, "blank.dds") != -1
			newOverlayID = "Body [Ovl" + i + "]"
		endIf
		i += 1
	endWhile
	
	If newOverlayID == "x"
		Debug.Trace("SNU - ERROR: No free slot was found to apply muscle overlays")
	Else
		;TLALOC-ToDo- Don't assume actor is female in all of niOverride calls
		AddNodeOverrideString(buffTarget, true, newOverlayID, 9, 0, normalsPath+"tan.dds", true)
		AddNodeOverrideString(buffTarget, true, newOverlayID, 9, 1, normalsPath+"ultra.dds", true)
		Debug.Trace("SNU - overlay slot was found: "+newOverlayID)
	EndIf
	
	return newOverlayID
EndFunction

string Function getCurrentOverlayString(Actor target, int index) Global
	string overlayID = "Body [Ovl" + index + "]"
	string tx = ""

	if NetImmerse.HasNode(target, overlayID, false)
		tx = GetNodepropertyString(target, false, overlayID, 9, 0)
	else
		tx = GetNodeOverrideString(target, true, overlayID, 9, 0)
	endIf

	return tx
EndFunction

Function applyOverlayStrings(Actor target, int index)
	string overlayID = "[Ovl" + index + "]"
	String normalsPath = "textures\\Snusnu\\Normals\\Ultra\\"
	;TLALOC-ToDo- We need to find free slots for all the other body parts!!!!!!
	AddNodeOverrideString(target, true, "Body "+overlayID, 9, 0, normalsPath+"Body.dds", true)
	AddNodeOverrideString(target, true, "Body "+overlayID, 9, 1, normalsPath+"Ultra.dds", true)

	AddNodeOverrideString(target, true, "Face "+overlayID, 9, 0, normalsPath+"Face.dds", true)
	AddNodeOverrideString(target, true, "Face "+overlayID, 9, 1, normalsPath+"FaceMSN.dds", true)
	
	AddNodeOverrideString(target, true, "Hands "+overlayID, 9, 0, normalsPath+"Hands.dds", true)
	
	AddNodeOverrideString(target, true, "Feet "+overlayID, 9, 0, normalsPath+"Feet.dds", true)
	
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
		If !IntListCopy(none, SNUSNU_BUFF_KEY, tempMorphsArray)
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
