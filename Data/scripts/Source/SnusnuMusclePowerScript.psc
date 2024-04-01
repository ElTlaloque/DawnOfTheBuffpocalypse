Scriptname SnusnuMusclePowerScript extends ActiveMagicEffect  

;ToDo- Remove imports as they make the code harder to follow
import NiOverride
Import StorageUtil

String Property SNUSNU_BUFF_KEY = "Snusnu.esp_BUFF" AutoReadOnly

Snusnu Property snusnuMain Auto
Bool Property wasWMEnabled = false Auto
Float Property wmWeight = 0.0 Auto
Float Property originalMuscleScore = 0.0 Auto
Int Property originalSkinTint = 0 Auto
Int Property moreChangesCount = 0 Auto
Float Property tfTime = 0.0 Auto
Float Property currentMusclePercent = 1.0 Auto

;FMG Morphs
Float[] cbbeValuesFMG
Float[] uunpValuesFMG
Float[] bhunpValuesFMG
Float[] cbbeSEValuesFMG
Float[] cbbe3BAValuesFMG
Float[] bonesValuesFMG
Float[] maleValuesFMG

Bool reloadUpdate = false


event OnEffectStart(Actor akTarget, Actor akCaster)
	If snusnuMain.isTransforming
		Debug.Notification("Already transforming!")
		Dispel()
		return
	EndIf
	snusnuMain.isTransforming = true
	
	If StorageUtil.GetIntValue(akTarget, "SNU_UltraMuscle") > 0
		;FMG is already ongoing, so we can skip the initial TF part
		registerForSingleUpdate(10)
		return
	EndIf
	
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
	
	moreChangesCount = 0
	
	StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 1)
	Debug.Notification("I can feel the changes starting")
	Debug.Trace("SNU - Starting transformation effect")
	If snusnuMain.isWeightMorphsLoaded
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If WMCM != none && snusnuMain.removeWeightMorphs
			If WMCM.WMorphs.Enabled
				wasWMEnabled = true
				WMCM.WMorphs.Enabled = false
				wmWeight = WMCM.WMorphs.Weight
				
				WMCM.WMorphs.UpdateEffects(False)
				;WMCM.WMorphs.RegisterEvents(false)
			EndIf
		EndIf
	EndIf
	
	
	Debug.Trace("SNU - FMG Spell duration: "+GetDuration())
	currentMusclePercent = 1.0
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
		
		If snusnuMain.applyMoreChangesOvertime
			If GetDuration() >= 8940 ;2 days ingame plus 5 real minutes overhead
				currentMusclePercent = 0.5
			ElseIf GetDuration() >= 4620 ;1 days ingame plus 5 real minutes overhead
				currentMusclePercent = 0.75
			EndIf
			
			growSteps = currentMusclePercent
		EndIf
		
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
				growVal = growVal + 0.02
				If growVal >= growStage * 0.1
					goingUp = false
					;Debug.Trace("SNU - growVal is "+growVal+", going back down")
					
					;ToDo- Instead of hard apply the normals, add an overlay with the final normal map and apply an alpha override
					;      with growVal as value. When the TF finishes, first apply the actual normal map as a skin override,
					;      wait for a second and then remove the overlay.
					
					;TLALOC- Update normals if needed
					currentStage = switchMuscleNormals(akTarget, currentStage, growVal * 100 )
						
					snusnuMain.changeSpineBoneScale(akTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[0]))
					snusnuMain.changeForearmBoneScale(akTarget, snusnuMain.getBoneSize(growVal, bonesValuesFMG[1]))
				EndIf
			Else
				growVal = growVal - 0.01
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
		
		If currentMusclePercent == 1.0
			applyMuscleNormals(akTarget, 5)
			snusnuMain.ClearMorphs(false)
		EndIf
		
		If !akTarget.isInCombat()
			Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
		EndIf
		
		akTarget.ResetExpressionOverrides()
		akTarget.ClearExpressionOverride()
	Else
		Float maxGrowth = 1.0
		If snusnuMain.applyMoreChangesOvertime
			If GetDuration() >= 8940 ;2 days ingame plus 5 real minutes overhead
				currentMusclePercent = 0.5
			ElseIf GetDuration() >= 4620 ;1 days ingame plus 5 real minutes overhead
				currentMusclePercent = 0.75
			EndIf
			
			maxGrowth = currentMusclePercent
		EndIf
		
		removeNormalMuscle(akTarget, maxGrowth)
		muscleChange(akTarget, maxGrowth )
		
		snusnuMain.changeSpineBoneScale(akTarget, snusnuMain.getBoneSize(maxGrowth, bonesValuesFMG[0]))
		snusnuMain.changeForearmBoneScale(akTarget, snusnuMain.getBoneSize(maxGrowth, bonesValuesFMG[1]))
		
		switchMuscleNormals(akTarget, 4, 100 )
	EndIf
	
	;Ultra punching strength
	;ToDo- Have 3 different levels of FistsOfRage depending on currentMusclePercent
	updateFistsPower(currentMusclePercent)
	akTarget.AddItem(snusnuMain.FistsOfRage, 1, True)
	akTarget.EquipItem(snusnuMain.FistsOfRage, True, True)
	
	If currentMusclePercent == 1.0
		;Improved jump height
		Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
		
		If snusnuMain.useDynamicPhysics ;ToDo- Check for other instances of updateBoobsPhysics
			snusnuMain.updateBoobsPhysics(true, 1)
		EndIf
	
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
	Else
		If snusnuMain.useDynamicPhysics
			snusnuMain.updateBoobsPhysics(true, 2)
		EndIf
	EndIf
	
	If snusnuMain.heavyItemsEquiped && snusnuMain.PlayerRef.GetActorValue("CarryWeight") < -100
		Debug.Trace("SNU - All heavy items were removed. Restoring carryWeight")
		snusnuMain.PlayerRef.ModActorValue("CarryWeight", snusnuMain.actualCarryWeight + 500)
	EndIf
	
	Utility.wait(1.0)
	
	;CarryWeight Boost
	akTarget.ModActorValue("CarryWeight", 400*currentMusclePercent)
	
	tfTime = snusnuMain.GameDaysPassed.GetValue()
	
	Debug.Trace("SNU - Finished applying transformation effect")
	Debug.Notification("My body has stopped growing")
	registerForSingleUpdate(10)
	
	snusnuMain.isTransforming = false
EndEvent

Event OnPlayerLoadGame()
	Debug.Trace("SNU - OnPlayerLoadGame()")
	
	Debug.Trace("SNU - Stored TF Time is: "+tfTime)
	
	reloadUpdate = true
	registerForSingleUpdate(12)
EndEvent

Event OnUpdate()
	If reloadUpdate
		snusnuMain.changeSpineBoneScale(snusnuMain.PlayerRef, snusnuMain.getBoneSize(1.0, bonesValuesFMG[0]))
		snusnuMain.changeForearmBoneScale(snusnuMain.PlayerRef, snusnuMain.getBoneSize(1.0, bonesValuesFMG[1]))
		
		If currentMusclePercent == 0.5
			applyMuscleNormals(snusnuMain.PlayerRef, 2)
			snusnuMain.updateBoobsPhysics(false, 2)
		ElseIf currentMusclePercent == 0.75
			applyMuscleNormals(snusnuMain.PlayerRef, 3)
			snusnuMain.updateBoobsPhysics(false, 1)
			If snusnuMain.applyMoreChangesOvertime
				applyBarbarianSkin(snusnuMain.PlayerRef, 1)
			EndIf
		Else
			applyMuscleNormals(snusnuMain.PlayerRef, 5)
			snusnuMain.updateBoobsPhysics(false, 1)
			If snusnuMain.applyMoreChangesOvertime && moreChangesCount == 2
				applyBarbarianSkin(snusnuMain.PlayerRef, 2)
			EndIf
			
			;Jump height fix
			If Game.GetGameSettingFloat("fJumpHeightMin") < 180.0
				Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
			EndIf
		EndIf
	
		reloadUpdate = false
	EndIf
	
	;Debug.Trace("SNU - tfTime="+tfTime+", Days passed: "+(snusnuMain.GameDaysPassed.GetValue() - tfTime))
	If snusnuMain.applyMoreChangesOvertime && tfTime > 0.0
		If snusnuMain.GameDaysPassed.GetValue() - tfTime >= snusnuMain.moreChangesInterval && moreChangesCount == 0
			If currentMusclePercent < 1.0
				Float newCarryWeight = 400*currentMusclePercent
				currentMusclePercent += 0.25
				
				snusnuMain.PlayerRef.ModActorValue("CarryWeight", -newCarryWeight)
				Utility.wait(0.2)
				snusnuMain.PlayerRef.ModActorValue("CarryWeight", 400*currentMusclePercent)
				
				;Apply more muscle morphs
				Debug.Notification("Is my body growing again!?")
				applyQuickGrowthAnim(snusnuMain.PlayerRef, currentMusclePercent)
				applyMuscleNormals(snusnuMain.PlayerRef, 3)
				
				If currentMusclePercent == 1.0
					snusnuMain.ClearMorphs(false)
					
					;Improved jump height
					Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
				EndIf
				
				snusnuMain.updateBoobsPhysics(true, 1)
				snusnuMain.updateAnimations(4)
				
				snusnuMain.PlayerRef.unequipItem(snusnuMain.FistsOfRage)
				updateFistsPower(currentMusclePercent)
				Utility.wait(0.1)
				snusnuMain.PlayerRef.equipItem(snusnuMain.FistsOfRage)
				
				;We need to save the original head now!
				ActorBase akTargetBase = snusnuMain.PlayerRef.getActorBase()
				Int headIndex = akTargetBase.GetIndexOfHeadPartByType(1)
				snusnuMain.originalHead = akTargetBase.GetNthHeadPart(headIndex)
				Debug.Trace("SNU - Original head: "+snusnuMain.originalHead)
			EndIf
			
			;Apply tan skin
			;Barbarian skin cannot be applied if head cannot be changed
			Debug.Notification("Im getting a nice tan")
			applyBarbarianSkin(snusnuMain.PlayerRef, 1)
			moreChangesCount += 1
		ElseIf snusnuMain.GameDaysPassed.GetValue() - tfTime >= snusnuMain.moreChangesInterval*2 && moreChangesCount == 1
			If currentMusclePercent < 1.0
				Float newCarryWeight = 400*currentMusclePercent
				currentMusclePercent += 0.25
				
				snusnuMain.PlayerRef.ModActorValue("CarryWeight", -newCarryWeight)
				Utility.wait(0.5)
				snusnuMain.PlayerRef.ModActorValue("CarryWeight", 400*currentMusclePercent)
				
				;Apply more muscle morphs
				Debug.Notification("Gods i'm getting huge!")
				applyQuickGrowthAnim(snusnuMain.PlayerRef, currentMusclePercent)
				snusnuMain.ClearMorphs(false)
				applyMuscleNormals(snusnuMain.PlayerRef, 5)
				
				;Improved jump height
				Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
				
				snusnuMain.PlayerRef.unequipItem(snusnuMain.FistsOfRage)
				updateFistsPower(currentMusclePercent)
				Utility.wait(0.1)
				snusnuMain.PlayerRef.equipItem(snusnuMain.FistsOfRage)
			EndIf
			
			Debug.Notification("Is my skin getting darker?")
			applyBarbarianSkin(snusnuMain.PlayerRef, 2)
			moreChangesCount += 1
		ElseIf moreChangesCount == 2
			;Break condition
			Debug.Trace("SNU - More Changes Break condition!")
			tfTime = -1.0
		EndIf
	EndIf
	
	If StorageUtil.GetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle") == 2
		;Changes were made!
		If !loadFMGMorphs()
			Debug.Trace("SNU - Could not load the FMG morphs!")
		Else
			muscleChange(snusnuMain.PlayerRef, currentMusclePercent )
			snusnuMain.changeSpineBoneScale(snusnuMain.PlayerRef, snusnuMain.getBoneSize(currentMusclePercent, bonesValuesFMG[0]))
			snusnuMain.changeForearmBoneScale(snusnuMain.PlayerRef, snusnuMain.getBoneSize(currentMusclePercent, bonesValuesFMG[1]))
			
			Debug.Notification("FMG shape has been updated")
			Debug.Trace("SNU - FMG shape has been updated")
		EndIf
		StorageUtil.SetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 1)
	EndIf
	
	registerForSingleUpdate(10)
EndEvent

Event OnObjectUnequipped(Form type, ObjectReference ref)
	if type == snusnuMain.handsFix && moreChangesCount >= 1
		Utility.wait(0.4)
		Debug.Trace("SNU - Apply fix over hand fix. tfTime="+tfTime)
		applyBarbarianSkin(snusnuMain.PlayerRef, moreChangesCount, false)
	endIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	snusnuMain.isTransforming = true
	
	StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 0)
	
	Debug.Trace("SNU - Starting removal of transformation effect")
	Debug.Notification("The muscle spell is starting to wear off!")
	
	;Add some muscle
	snusnuMain.updateMuscleScore(snusnuMain.muscleScoreMax * snusnuMain.addWerewolfStrength)
	
	If snusnuMain.isWeightMorphsLoaded
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If WMCM != none && snusnuMain.removeWeightMorphs
			If !WMCM.WMorphs.Enabled && wasWMEnabled
				
				If wmWeight < 0.0
					wmWeight = wmWeight + 0.05
					If wmWeight > 0.0
						wmWeight = 0.0
					EndIf
				ElseIf wmWeight > 0.0
					wmWeight = wmWeight - 0.05
					If wmWeight < 0.0
						wmWeight = 0.0
					EndIf
				EndIf
				
				WMCM.WMorphs.tempWeight = wmWeight
				;WMCM.WMorphs.Enabled = true
				wasWMEnabled = false
				WMCM.WMorphs.RegisterEvents(true)
			EndIf
		EndIf
	EndIf
	
	
	If snusnuMain.tfAnimation
		float deflateVal = 1.0
		while deflateVal > 0.0
			removeNormalMuscle(akTarget, deflateVal)
			
			muscleChange(akTarget, deflateVal)
			
			If (deflateVal * 100) as Int % 16 == 0
				snusnuMain.changeSpineBoneScale(akTarget, snusnuMain.getBoneSize(deflateVal, bonesValuesFMG[0]))
				snusnuMain.changeForearmBoneScale(akTarget, snusnuMain.getBoneSize(deflateVal, bonesValuesFMG[1]))
			endIf
			
			deflateVal -= 0.02
			Utility.wait(0.04)
		endWhile
		
		snusnuMain.changeSpineBoneScale(akTarget, snusnuMain.getBoneSize(0, bonesValuesFMG[0]))
		snusnuMain.changeForearmBoneScale(akTarget, snusnuMain.getBoneSize(0, bonesValuesFMG[1]))
		
		clearMuscleMorphs(akTarget)
		snusnuMain.clearBoneScales(akTarget)
	Else
		clearMuscleMorphs(akTarget)
		snusnuMain.clearBoneScales(akTarget)
	EndIf
	
	;TLALOC-ToDo- Remove normals overlay
	;AddNodeOverrideFloat(akTarget, true, overlaySlot, 8, -1, growVal, true)
	;RemoveSkinOverride(akTarget, true, false, 0x04, 9, 1)
	RemoveAllReferenceSkinOverrides(akTarget);For the custom normals
	;ApplySkinOverrides(akTarget)
	If !akTarget.IsOnMount()
		akTarget.QueueNiNodeUpdate()
	EndIf
	
	If snusnuMain.useAltAnims
		;We need to check for the actual muscle level which is already done in checkBodyNormalsState()
		snusnuMain.checkBodyNormalsState()
	EndIf
	
	akTarget.RemoveItem(snusnuMain.FistsOfRage, akTarget.GetItemCount(snusnuMain.FistsOfRage), True)
	
	;TLALOC-ToDo- Change hair?
	;switchBarbarianHair()
	
	;TLALOC-ToDo- Change skin?
	;If snusnuMain.applyMoreChangesOvertime
	;	applyBarbarianSkin(akTarget, true)
	;EndIf
	
	If snusnuMain.changeHeadPart && snusnuMain.originalHead != none
			akTarget.ChangeHeadPart(snusnuMain.originalHead)
			akTarget.RegenerateHead()
	EndIf
	
	Game.SetGameSettingFloat("fJumpHeightMin", 76.0)
	
	;CarryWeight Boost
	akTarget.ModActorValue("CarryWeight", -400)
	
	Utility.wait(1.0)
	
	If snusnuMain.itemsEquipedWeight > snusnuMain.allowedItemsEquipedWeight
		snusnuMain.actualCarryWeight = snusnuMain.PlayerRef.GetActorValue("CarryWeight")
		Float modWeight = snusnuMain.actualCarryWeight + 500.0
		Debug.Trace("SNU - actualCarryWeight="+snusnuMain.actualCarryWeight)
		
		snusnuMain.PlayerRef.ModActorValue("CarryWeight", -modWeight)
		snusnuMain.heavyItemsEquiped = 1
		snusnuMain.IsOverwhelmed.setValue(1)
	EndIf
	
	Debug.Trace("SNU - Finished removal of transformation effect")
	Debug.Notification("My body is now back to normal")
	
	snusnuMain.isTransforming = false
EndEvent

Function applyQuickGrowthAnim(Actor tfActor, Float magnitude)
	Debug.Trace("applyQuickGrowthAnim("+magnitude+")")
	If snusnuMain.tfAnimation
		float growthVal = magnitude - 0.25
		while growthVal < magnitude
			removeNormalMuscle(tfActor, growthVal)
			
			muscleChange(tfActor, growthVal)
			
			If (growthVal * 100) as Int % 16 == 0
				snusnuMain.changeSpineBoneScale(tfActor, snusnuMain.getBoneSize(growthVal, bonesValuesFMG[0]))
				snusnuMain.changeForearmBoneScale(tfActor, snusnuMain.getBoneSize(growthVal, bonesValuesFMG[1]))
			endIf
			
			growthVal += 0.02
			Utility.wait(0.04)
		endWhile
	EndIf
	
	removeNormalMuscle(tfActor, magnitude)
	muscleChange(tfActor, magnitude )
	
	snusnuMain.changeSpineBoneScale(tfActor, snusnuMain.getBoneSize(magnitude, bonesValuesFMG[0]))
	snusnuMain.changeForearmBoneScale(tfActor, snusnuMain.getBoneSize(magnitude, bonesValuesFMG[1]))
	
	Debug.Trace("SNU - Finished growing to "+magnitude)
	;Debug.Notification("Finished growing to "+(magnitude*100)+"%")
EndFunction

Function applyBoobsPhysics()
	;We should have a dedicated code for this given the ammount of calculations we are doing for the physics
EndFunction

Function updateFistsPower(Float magnitude)
	Enchantment fistEffects = snusnuMain.FistsOfRage.GetEnchantment()
	
	Int counter = 0
	While counter < fistEffects.GetNumEffects()
		Debug.Trace("SNU - Fists effect "+counter+" magnitude: "+fistEffects.GetNthEffectMagnitude(counter))
		Float newMagnitude = fistEffects.GetNthEffectMagnitude(counter) * magnitude
		fistEffects.SetNthEffectMagnitude(counter, newMagnitude)
		counter += 1
	endWhile
EndFunction

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
	Int totalSliders = IntListCount(none, SNUSNU_BUFF_KEY)
	Int slidersLoop = 0
	while slidersLoop < totalSliders
		Int currentSliderIndex = IntListGet(none, SNUSNU_BUFF_KEY, slidersLoop)
		SetBodyMorph(buffTarget, snusnuMain.getSliderString(currentSliderIndex), SNUSNU_BUFF_KEY, changePercent * getSliderValue(currentSliderIndex))
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
	
	Bool hasHandFix = false
	Armor handsArmor = buffTarget.GetWornForm(0x00000008) as Armor
	if !handsArmor
		Debug.Trace("SNU - Attempting to apply hands fix!")
		buffTarget.equipItem(snusnuMain.handsFix, true, true)
		Utility.wait(0.2)
		hasHandFix = true
	endIf
	
	AddSkinOverrideString(buffTarget, true, false, 0x04, 9, 1, tempNormalsPath, true)
	AddSkinOverrideString(buffTarget, true, true, 0x04, 9, 1, tempNormalsPath, true)
	
	if hasHandFix
		Debug.Trace("SNU - Finishing to apply hands fix!")
		Utility.wait(0.2)
		buffTarget.unequipItemslot(33)
		buffTarget.removeitem(snusnuMain.handsFix, 1, true)
	endIf
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
			newOverlayID = "[Ovl" + i + "]"
		endIf
		i += 1
	endWhile
	
	If newOverlayID == "x"
		Debug.Trace("SNU - ERROR: No free slot was found to apply muscle overlays")
	;/Else
		;TLALOC-ToDo- Don't assume actor is female in all of niOverride calls
		AddNodeOverrideString(buffTarget, true, "Body "+newOverlayID, 9, 0, normalsPath+"tan.dds", true)
		AddNodeOverrideString(buffTarget, true, "Body "+newOverlayID, 9, 1, normalsPath+"ultra.dds", true)
		Debug.Trace("SNU - overlay slot was found: "+newOverlayID)/;
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

Function applyOverlayStrings(Actor target, String slot)
	;string overlayID = "[Ovl" + index + "]"
	String normalsPath = "textures\\Snusnu\\Normals\\Ultra\\"
	;TLALOC-ToDo- We need to find free slots for all the other body parts!!!!!!
	AddNodeOverrideString(target, true, "Body "+slot, 9, 0, normalsPath+"Body.dds", true)
	AddNodeOverrideString(target, true, "Body "+slot, 9, 1, normalsPath+"Ultra.dds", true)

	AddNodeOverrideString(target, true, "Face "+slot, 9, 0, normalsPath+"Face.dds", true)
	AddNodeOverrideString(target, true, "Face "+slot, 9, 1, normalsPath+"FaceMSN.dds", true)
	
	AddNodeOverrideString(target, true, "Hands "+slot, 9, 0, normalsPath+"Hands.dds", true)
	
	AddNodeOverrideString(target, true, "Feet "+slot, 9, 0, normalsPath+"Feet.dds", true)
	
EndFunction

Function applyBarbarianSkin(Actor target, Int skinIndex, Bool applyFix = true)
	Debug.Trace("SNU - applyBarbarianSkin()")
	Bool hasHandFix = false
	Armor handsArmor = target.GetWornForm(0x00000008) as Armor
	if !handsArmor && applyFix
		Debug.Trace("SNU - Attempting to apply hands fix!")
		target.equipItem(snusnuMain.handsFix, true, true)
		Utility.wait(0.2)
		hasHandFix = true
	endIf
	
	If skinIndex > 0
		String tempNormalsPath = "textures\\Snusnu\\Normals\\Ultra"+skinIndex+"\\"
		
		;Body
		If !applyFix ;Fix for body textures messing up when trying to apply the hands fix on OnObjectUnequipped()
			AddSkinOverrideString(target, true, false, 0x04, 9, 0, tempNormalsPath+"Body.dds", true)
			AddSkinOverrideString(target, true, true, 0x04, 9, 0, tempNormalsPath+"Body.dds", true)
		EndIf
		
		;Face
		;AddSkinOverrideString(target, true, false, 0x04, 9, 0, tempNormalsPath+"Face.dds", true)
		;AddSkinOverrideString(target, true, true, 0x04, 9, 0, tempNormalsPath+"Face.dds", true)
		If skinIndex == 1
			target.ChangeHeadPart(snusnuMain.MuscleHeadTan)
		ElseIf skinIndex == 2
			target.ChangeHeadPart(snusnuMain.MuscleHeadTan2)
		EndIf
		target.RegenerateHead()
		
		;Hands
		AddSkinOverrideString(target, true, false, 0x08, 9, 0, tempNormalsPath+"Hands.dds", true)
		AddSkinOverrideString(target, true, true, 0x08, 9, 0, tempNormalsPath+"Hands.dds", true)
		
		;Feet
		AddSkinOverrideString(target, true, false, 0x80, 9, 0, tempNormalsPath+"Body.dds", true)
		AddSkinOverrideString(target, true, true, 0x80, 9, 0, tempNormalsPath+"Body.dds", true)
	Else
		RemoveAllReferenceSkinOverrides(target)
		;ApplySkinOverrides(target)
		If !target.IsOnMount()
			target.QueueNiNodeUpdate()
		EndIf
	EndIf
	
	
	if hasHandFix && applyFix
		Debug.Trace("SNU - Finishing to apply hands fix!")
		Utility.wait(0.2)
		target.unequipItemslot(33)
		target.removeitem(snusnuMain.handsFix, 1, true)
	endIf
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
