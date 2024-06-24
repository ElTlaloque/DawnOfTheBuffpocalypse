Scriptname SnusnuMusclePowerScript extends ActiveMagicEffect  

String Property SNUSNU_BUFF_KEY = "Snusnu.esp_BUFF" AutoReadOnly

Snusnu Property snusnuMain Auto
Bool Property wasWMEnabled = false Auto
Float Property wmWeight = 0.0 Auto
Int Property originalSkinTint = 0 Auto
Int Property moreChangesCount = 0 Auto
Float Property tfTime = 0.0 Auto
Float Property currentMusclePercent = 1.0 Auto
Bool Property hasVampirism = false Auto ;Vampire race fix
Race Property vampireRace Auto ;Vampire race fix

;FMG Morphs
Float[] cbbeValuesFMG
Float[] uunpValuesFMG
Float[] bhunpValuesFMG
Float[] cbbeSEValuesFMG
Float[] cbbe3BAValuesFMG
Float[] bonesValuesFMG
Float[] maleValuesFMG

Bool reloadUpdate = false
Bool alreadyTransformed = false

;Moving all of the TF animation variables here to be used with the onUpdate flow
float growSteps
float growVal
int growStage
bool goingUp
int currentStage
Int tfSoundInstance


event OnEffectStart(Actor akTarget, Actor akCaster)
	If StorageUtil.GetIntValue(akTarget, "SNU_UltraMuscle", 0) > 0
		Debug.Notification("Removing FMG spell!")
		alreadyTransformed = true
		Dispel()
		return
	EndIf

	If snusnuMain.isTransforming
		Debug.Notification("Already transforming!")
		alreadyTransformed = true
		Dispel()
		return
	EndIf
	snusnuMain.isTransforming = true
		
	;ToDo- Test this spell on male characters
	;/If snusnuMain.PlayerRef.GetActorBase().GetSex() == 0
		Debug.Notification("This spell only works on female characters")
		alreadyTransformed = true
		Dispel()
		return
	EndIf/;
	
	initFMGSliders()
	If !loadFMGMorphs(snusnuMain.PlayerRef)
		Debug.Notification("Could not load the FMG morphs!")
		alreadyTransformed = true
		Dispel()
		return
	EndIf
	
	removeSpells(snusnuMain.PlayerRef)
	Utility.wait(1.0)
	
	If snusnuMain.PlayerRef.hasKeyword(snusnuMain.isVampire) && snusnuMain.applyVampireFix
		;Change to original race for the duration of the spell to avoid head texture mishaps
		hasVampirism = true
		
		vampireRace = snusnuMain.getVampireRace(akTarget)
		If vampireRace
			Race notVampRace = snusnuMain.getNonVampireRace(vampireRace)
			If notVampRace
				akTarget.SetRace(notVampRace)
			EndIf
		EndIf
	EndIf
	
	snusnuMain.originalHead = none
	snusnuMain.totalMuscleToAdd = 0.01
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
	snusnuMain.currentMusclePercent = 1.0
	If snusnuMain.applyMoreChangesOvertime
		If snusnuMain.dynamicChangesCalculation
			Float intervalSeconds = snusnuMain.moreChangesInterval * 86400 ;Number of seconds in a day
			intervalSeconds = intervalSeconds / 20
			
			If GetDuration() >= (intervalSeconds * 2) + 300 ;2 days ingame plus 5 real minutes overhead
				snusnuMain.currentMusclePercent = 1.0 - (snusnuMain.moreChangesIncrements * 2)
			Else ;If GetDuration() >= intervalSeconds + 300 ;1 days ingame plus 5 real minutes overhead
				;We never want to start at 100%, so we start at the next stage even if there is not enough time to reach 100%. Otherwise
				;we might as well not use More Changes Overtime at all.
				snusnuMain.currentMusclePercent = 1.0 - snusnuMain.moreChangesIncrements
			EndIf
		Else
			snusnuMain.currentMusclePercent = 1.0 - (snusnuMain.moreChangesIncrements * 2)
		EndIf
	EndIf
			
	If snusnuMain.tfAnimation
		; 0 - Dialogue Anger		8 - Mood Anger		15 - Combat Anger
		akTarget.SetExpressionOverride(8, 65)
		akTarget.SetExpressionPhoneme(0, 0.4)
		
		If snusnuMain.playTFSound
			tfSoundInstance = snusnuMain.snusnuTFSound.Play(akTarget)
		EndIf
		
		If Snusnu.canPlayAnimation(akTarget)
			;Unequip weapons
			akTarget.SheatheWeapon()
			Utility.wait(0.5)
			Debug.SendAnimationEvent(akTarget, "Snu_idle1")
		EndIf
		
		;TLALOC- First we check if overlay slot is available
		;String overlaySlot = initOverlaySlot(akTarget)
		
		If snusnuMain.useAltBody
			;ToDo- Also add this to the NPC spell. For now we will skip this as there might a big problem 
			;      with the head of NPCs not being updated correctly
			Utility.wait(8)
			swapBodyMesh(akTarget)
		Else
			;ToDo- Move this loop to onUpdate(). Make functions to apply stuff before and after this animation. Call the after anim
			;      function here if anim is disabled or in onUpdate if anim is enabled. Do the same with WeightMorphs
			growSteps = snusnuMain.currentMusclePercent
			growVal = 0.01
			growStage = 1
			goingUp = true
			currentStage = snusnuMain.currentBuildStage
			;/
			Debug.Trace("SNU - Initial TF Anim vars:")
			Debug.Trace("SNU -      growSteps="+growSteps)
			Debug.Trace("SNU -      growVal="+growVal)
			Debug.Trace("SNU -      growStage="+growStage)
			Debug.Trace("SNU -      goingUp="+goingUp)
			Debug.Trace("SNU -      currentStage="+currentStage)
			/;
			registerForSingleUpdate(0.1)
			return
		EndIf
		
		;All this is for useAltBody only
		If snusnuMain.currentMusclePercent >= 1.0 - snusnuMain.moreChangesIncrements
			If snusnuMain.useAltAnims
				If snusnuMain.currentMusclePercent != 1.0
					snusnuMain.updateAnimations(4) ;Was 3
				Else
					snusnuMain.updateAnimations(4)
				EndIf
				Utility.wait(1)
			EndIf
		EndIf
		
		If Snusnu.canPlayAnimation(akTarget)
			Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
		EndIf
		
		If snusnuMain.playTFSound
			Utility.wait(2)
			Sound.StopInstance(tfSoundInstance)
		EndIf
		
		akTarget.ResetExpressionOverrides()
		akTarget.ClearExpressionOverride()
	Else
		Float maxGrowth = snusnuMain.currentMusclePercent
		
		If snusnuMain.useAltBody
			swapBodyMesh(akTarget)
		Else
			snusnuMain.removeNormalMuscle(akTarget, maxGrowth)
			muscleChange(akTarget, maxGrowth )
			updateBones(akTarget, maxGrowth, False)
			
			switchMuscleNormals(akTarget, 4, 100 )
		EndIf
		
		If snusnuMain.currentMusclePercent >= 1.0 - snusnuMain.moreChangesIncrements
			If snusnuMain.useAltAnims
				If snusnuMain.currentMusclePercent != 1.0
					snusnuMain.updateAnimations(4) ;Was 3
					
					;If currentMusclePercent is other than 1.0 its safe to assume applyMoreChangesOvertime option is active 
					applyBarbarianSkin(snusnuMain.PlayerRef, 1)
				Else
					snusnuMain.updateAnimations(4)
				EndIf
			EndIf
		EndIf
	EndIf
	
	applyFMGBuffs(akTarget)
	
	registerForSingleUpdate(10)
	RegisterForSleep()
	
	snusnuMain.isTransforming = false
EndEvent

Event OnPlayerLoadGame()
	Debug.Trace("SNU - OnPlayerLoadGame()")
	
	Debug.Trace("SNU - Stored TF Time is: "+tfTime)
		
	reloadUpdate = true
	If snusnuMain.isTransforming
		registerForSingleUpdate(4)
	Else
		registerForSingleUpdate(12)
	EndIf
	RegisterForSleep()
EndEvent

Event OnUpdate()
	If alreadyTransformed
		return
	EndIf
	
	If snusnuMain.isTransforming
		If snusnuMain.tfAnimation && !snusnuMain.useAltBody && (growVal != growSteps || goingUp)
			If reloadUpdate
				;Restore anims and facial expression
				snusnuMain.PlayerRef.SetExpressionOverride(8, 65)
				snusnuMain.PlayerRef.SetExpressionPhoneme(0, 0.4)
				
				If Snusnu.canPlayAnimation(snusnuMain.PlayerRef)
					;Unequip weapons
					snusnuMain.PlayerRef.SheatheWeapon()
					Utility.wait(0.5)
					Debug.SendAnimationEvent(snusnuMain.PlayerRef, "Snu_idle1")
				EndIf
			EndIf
			
			If goingUp
				;TLALOC- Gradually remove normal muscle
				snusnuMain.removeNormalMuscle(snusnuMain.PlayerRef, growVal)
			EndIf
			muscleChange(snusnuMain.PlayerRef, growVal );NOTE- growVal should be a value between 0 and 1
			
			If goingUp
				growVal = growVal + 0.04
				If growVal >= growStage * 0.1
					goingUp = false
					;Debug.Trace("SNU - growVal is "+growVal+", going back down")
					
					;TLALOC- Update normals if needed
					currentStage = switchMuscleNormals(snusnuMain.PlayerRef, currentStage, growVal * 100 )
					
					;ToDo- We NEED to check for the changes the bones already have. Otherwise it will look
					;      like the body does a big jump in size if the character already has a high muscle score
					updateBones(snusnuMain.PlayerRef, growVal)
				EndIf
			Else
				growVal = growVal - 0.02
				If growVal >= growSteps - 0.01 && growVal <= growSteps + 0.01
					;Debug.Trace("SNU - growVal has rested on "+growVal)
					
					growVal = growSteps ;TLALOC - Break condition
					
					updateBones(snusnuMain.PlayerRef, growVal, True, True)
				ElseIf growVal <= (growStage * 0.1) - 0.05
					If !((growStage * 0.1) - 0.05 > growSteps) ;TLALOC - Fix for special case where the target size is skipped
						goingUp = true
						growStage = growStage + 1
						;Debug.Trace("SNU - growVal is "+growVal+", going back up")
					EndIf
				EndIf
			EndIf
			
			;Debug.Trace("SNU - growSteps="+growSteps+", growVal="+growVal+", growStage="+growStage+", goingUp="+goingUp+", currentStage="+currentStage)
			
			If growVal == growSteps && !goingUp
				;Finishing TF steps
				If snusnuMain.currentMusclePercent == 1.0
					applyMuscleNormals(snusnuMain.PlayerRef, 5)
					;snusnuMain.ClearMorphs(false)
					NiOverride.ClearBodyMorphKeys(snusnuMain.PlayerRef, snusnuMain.SNUSNU_KEY)
				EndIf
				
				If snusnuMain.currentMusclePercent >= 1.0 - snusnuMain.moreChangesIncrements
					If snusnuMain.useAltAnims
						If snusnuMain.currentMusclePercent != 1.0
							snusnuMain.updateAnimations(4) ;Was 3
							
							;If currentMusclePercent is other than 1.0 its safe to assume applyMoreChangesOvertime option is active 
							applyBarbarianSkin(snusnuMain.PlayerRef, 1)
						Else
							snusnuMain.updateAnimations(4)
							
							;As far as i know we dont need to apply barbarian skin here because maximum muscle percent
							;is not possible at the begining when applyMoreChangesOvertime option is active
						EndIf
						Utility.wait(1)
					EndIf
				EndIf
				
				If Snusnu.canPlayAnimation(snusnuMain.PlayerRef)
					Debug.SendAnimationEvent(snusnuMain.PlayerRef,"IdleForceDefaultState")
				EndIf
				
				If snusnuMain.playTFSound
					Utility.wait(2)
					Sound.StopInstance(tfSoundInstance)
				EndIf
				
				snusnuMain.PlayerRef.ResetExpressionOverrides()
				snusnuMain.PlayerRef.ClearExpressionOverride()
				
				applyFMGBuffs(snusnuMain.PlayerRef)
				
				registerForSingleUpdate(10)
				RegisterForSleep()
				
				snusnuMain.isTransforming = false
			Else
				If goingUp
					registerForSingleUpdate(0.04)
				Else
					registerForSingleUpdate(0.2)
				EndIf
			EndIf
		Else
			registerForSingleUpdate(5)
		EndIf
		
		return
	EndIf
	
	If reloadUpdate && !snusnuMain.isWerewolf ;ToDo- Check if this change works well with werewolf TF
		If !snusnuMain.useAltBody
			If !loadFMGMorphs(snusnuMain.PlayerRef)
				Debug.Notification("Could not load the FMG morphs!")
			EndIf
			updateBones(snusnuMain.PlayerRef, snusnuMain.currentMusclePercent, False, True)
				
			If snusnuMain.currentMusclePercent == 1.0 - (snusnuMain.moreChangesIncrements * 2)
				applyMuscleNormals(snusnuMain.PlayerRef, 2)
				snusnuMain.updateBoobsPhysics(false, 2)
			Else
				If snusnuMain.currentMusclePercent < 1.0
					applyMuscleNormals(snusnuMain.PlayerRef, 3)
				Else
					applyMuscleNormals(snusnuMain.PlayerRef, 5)
					
					;Jump height fix
					If Game.GetGameSettingFloat("fJumpHeightMin") < 180.0
						Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
					EndIf
				EndIf
				
				snusnuMain.updateBoobsPhysics(false, 1)
				If snusnuMain.applyMoreChangesOvertime
					If snusnuMain.currentMusclePercent == 1.0
						applyBarbarianSkin(snusnuMain.PlayerRef, 2)
					ElseIf snusnuMain.currentMusclePercent == 1.0 - snusnuMain.moreChangesIncrements
						applyBarbarianSkin(snusnuMain.PlayerRef, 1)
					EndIf
				EndIf
				
			EndIf
		EndIf
		
		snusnuMain.updateAllowedItemsEquipedWeight()
		snusnuMain.needEquipWeightUpdate = true
	
		reloadUpdate = false
	EndIf
	
	If !snusnuMain.useAltBody
		If StorageUtil.GetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 0) == 12
			;Changes were made!
			If !loadFMGMorphs(snusnuMain.PlayerRef)
				Debug.Trace("SNU - Could not load the FMG morphs!")
			Else
				muscleChange(snusnuMain.PlayerRef, snusnuMain.currentMusclePercent )
				updateBones(snusnuMain.PlayerRef, snusnuMain.currentMusclePercent, False, True)
				
				If snusnuMain.hardcoreMode
					snusnuMain.updateAllowedItemsEquipedWeight()
					snusnuMain.needEquipWeightUpdate = true
				EndIf
				
				snusnuMain.showInfoNotification("FMG shape has been updated")
				Debug.Trace("SNU - FMG shape has been updated")
			EndIf
			StorageUtil.SetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 1+moreChangesCount)
		EndIf
		
		Debug.Trace("SNU - tfTime="+tfTime+", Days passed: "+(snusnuMain.GameDaysPassed.GetValue() - tfTime))
		If snusnuMain.applyMoreChangesOvertime && tfTime > 0.0 && snusnuMain.GameDaysPassed.GetValue() - tfTime >= snusnuMain.moreChangesInterval && !snusnuMain.isWerewolf ;ToDo- Check if this change works well with werewolf TF
			Debug.Trace("SNU - Starting more changes stage "+moreChangesCount)
			If snusnuMain.currentMusclePercent < 1.0
				Float newCarryWeight = 400*snusnuMain.currentMusclePercent
				
				snusnuMain.currentMusclePercent += snusnuMain.moreChangesIncrements
				
				If snusnuMain.hardcoreMode
					snusnuMain.updateAllowedItemsEquipedWeight()
					snusnuMain.needEquipWeightUpdate = true
				EndIf
				
				If snusnuMain.currentMusclePercent == 1.0
					Debug.Notification("Gods i'm getting huge!")
				ElseIf snusnuMain.currentMusclePercent == 1.0 - snusnuMain.moreChangesIncrements
					Debug.Notification("Is my body growing again!?")
				EndIf
				
				snusnuMain.PlayerRef.ModActorValue("CarryWeight", -newCarryWeight)
				Utility.wait(1.0)
				snusnuMain.PlayerRef.ModActorValue("CarryWeight", 400*snusnuMain.currentMusclePercent)
				
				;Apply more muscle morphs
				applyQuickGrowthAnim(snusnuMain.PlayerRef, snusnuMain.currentMusclePercent)
				
				If snusnuMain.currentMusclePercent == 1.0
					applyMuscleNormals(snusnuMain.PlayerRef, 5)
					;snusnuMain.ClearMorphs(false)
					NiOverride.ClearBodyMorphKeys(snusnuMain.PlayerRef, snusnuMain.SNUSNU_KEY)
					
					;Improved jump height
					Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
					
					snusnuMain.updateAnimations(4)
					
					applyBarbarianSkin(snusnuMain.PlayerRef, 2)
				ElseIf snusnuMain.currentMusclePercent == 1.0 - snusnuMain.moreChangesIncrements
					applyMuscleNormals(snusnuMain.PlayerRef, 3)
					
					snusnuMain.updateBoobsPhysics(true, 1)
					snusnuMain.updateAnimations(4) ;Was 3
					
					applyBarbarianSkin(snusnuMain.PlayerRef, 1)
				EndIf
				
				
				snusnuMain.PlayerRef.unequipItem(snusnuMain.FistsOfRage)
				updateFistsPower(snusnuMain.currentMusclePercent)
				Utility.wait(0.1)
				snusnuMain.PlayerRef.equipItem(snusnuMain.FistsOfRage)
			EndIf
			
			moreChangesCount += 1
			StorageUtil.SetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 1+moreChangesCount)
			If snusnuMain.currentMusclePercent < 1.0
				tfTime = snusnuMain.GameDaysPassed.GetValue()
			Else
				;Break condition
				Debug.Trace("SNU - More Changes Break condition!")
				tfTime = -1.0
			EndIf
		EndIf
	EndIf
	
	registerForSingleUpdate(10)
	RegisterForSleep()
EndEvent

Event OnSleepStop(bool abInterrupted)
	If snusnuMain.hardcoreMode
		;Cleanup equipped item weights
		snusnuMain.showInfoNotification("Refreshing hardcore weights")
		snusnuMain.updateAllowedItemsEquipedWeight()
		snusnuMain.getEquipedFullWeight()
	EndIf
EndEvent

Event OnObjectUnequipped(Form type, ObjectReference ref)
	;/
	if !snusnuMain.useAltBody && snusnuMain.applyMoreChangesOvertime && !snusnuMain.isTransforming && \
	type == snusnuMain.handsFix && moreChangesCount >= 1 && !snusnuMain.isWerewolf ;ToDo- Check if this change works well with werewolf TF
		Utility.wait(0.4)
		Debug.Trace("SNU - Apply fix over hand fix. tfTime="+tfTime)
		
		If snusnuMain.currentMusclePercent == 1.0
			applyBarbarianSkin(snusnuMain.PlayerRef, 2, false)
		ElseIf snusnuMain.currentMusclePercent == 1.0 - snusnuMain.moreChangesIncrements
			applyBarbarianSkin(snusnuMain.PlayerRef, 1, false)
		EndIf
	EndIf
	/;
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	If alreadyTransformed
		return
	EndIf
	
	;ToDo- Check what happens if player is currently a werewolf
	
	;We really don't want to revert back during a fight
	;ToDo- Maybe it would be a good idea to have a toggle option for this
	While akTarget.isInCombat() || reloadUpdate
		Utility.wait(4)
	EndWhile
	
	snusnuMain.isTransforming = true
	
	StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 0)
	
	Debug.Trace("SNU - Starting removal of transformation effect")
	Debug.Notification("The muscle spell is starting to wear off!")
	
	;Add some muscle
	snusnuMain.updateMuscleScore(snusnuMain.muscleScoreMax * snusnuMain.totalMuscleToAdd)
	Debug.Notification("You get "+(snusnuMain.totalMuscleToAdd * 100)+"% extra muscle")
	
	If snusnuMain.isWeightMorphsLoaded
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If WMCM != none && snusnuMain.removeWeightMorphs
			If !WMCM.WMorphs.Enabled && wasWMEnabled
				
				If wmWeight < 0.08
					wmWeight = wmWeight + 0.05
					If wmWeight > 0.08
						wmWeight = 0.08
					EndIf
				ElseIf wmWeight > 0.08
					wmWeight = wmWeight - 0.05
					If wmWeight < 0.08
						wmWeight = 0.08
					EndIf
				EndIf
				
				WMCM.WMorphs.tempWeight = wmWeight
				;WMCM.WMorphs.Enabled = true
				wasWMEnabled = false
				WMCM.WMorphs.RegisterEvents(true)
			EndIf
		EndIf
	EndIf
	
	If !snusnuMain.useAltBody
		If snusnuMain.tfAnimation
			Int normalsStage = 5
			float deflateVal = snusnuMain.currentMusclePercent
			while deflateVal > 0.0
				snusnuMain.removeNormalMuscle(akTarget, deflateVal)
				muscleChange(akTarget, deflateVal)
				
				If (deflateVal * 100) as Int % 16 == 0 ;Was % 16
					updateBones(akTarget, deflateVal, False)
					
					normalsStage -= 1
					If normalsStage >= snusnuMain.currentBuildStage
						applyMuscleNormals(akTarget, normalsStage)
					EndIf
				EndIf
				
				deflateVal -= 0.02
				Utility.wait(0.04)
			endWhile
			
			updateBones(akTarget, 0, False, True)
			
			clearMuscleMorphs(akTarget)
			snusnuMain.clearBoneScales(akTarget)
		Else
			clearMuscleMorphs(akTarget)
			snusnuMain.clearBoneScales(akTarget)
			snusnuMain.UpdateWeight(true)
		EndIf
	EndIf
	
	;TLALOC-ToDo- Remove normals overlay
	;AddNodeOverrideFloat(akTarget, true, overlaySlot, 8, -1, growVal, true)
	;RemoveAllReferenceSkinOverrides(akTarget);For the custom normals
	;ApplySkinOverrides(akTarget)
	If !snusnuMain.useAltBody && snusnuMain.currentBuildStage <= 1
		Bool isFemale = akTarget.GetActorBase().GetSex() != 0
		NiOverride.RemoveSkinOverride(akTarget, isFemale, false, 0x04, 9, 1)
		NiOverride.RemoveSkinOverride(akTarget, isFemale, true, 0x04, 9, 1)
		If !akTarget.IsOnMount()
			akTarget.QueueNiNodeUpdate()
		EndIf
	EndIf
	
	If snusnuMain.useAltAnims
		;We need to check for the actual muscle level which is already done in checkBodyNormalsState()
		snusnuMain.checkBodyNormalsState()
	EndIf
	
	akTarget.RemoveItem(snusnuMain.FistsOfRage, akTarget.GetItemCount(snusnuMain.FistsOfRage), True)
	
	;TLALOC-ToDo- Change hair?
	;switchBarbarianHair()
	
	;TLALOC- Change skin?
	If !snusnuMain.useAltBody
		applyBarbarianSkin(akTarget, 0)
	Else
		swapBodyMesh(akTarget, false)
	EndIf
	
	Game.SetGameSettingFloat("fJumpHeightMin", 76.0)
	
	;CarryWeight Boost
	Float newCarryWeight = 400*snusnuMain.currentMusclePercent
	akTarget.ModActorValue("CarryWeight", -newCarryWeight)
	
	Utility.wait(1.0)
	
	If snusnuMain.hardcoreMode
		snusnuMain.updateAllowedItemsEquipedWeight()
		snusnuMain.needEquipWeightUpdate = true
	EndIf
	
	;Debug.Trace("SNU - vampireRace="+vampireRace+", hasVampirism="+hasVampirism)
	If vampireRace && hasVampirism && !snusnuMain.isVampireLord
		Debug.Trace("SNU - Reverting back to vampire race")
		snusnuMain.PlayerRef.SetRace(vampireRace)
	EndIf
	
	reAddSpells(snusnuMain.PlayerRef)
	
	Debug.Trace("SNU - Finished removal of transformation effect")
	Debug.Notification("My body is now back to normal")
	
	snusnuMain.isTransforming = false
EndEvent

Function removeSpells(Actor magicActor)
	If magicActor.hasSpell(snusnuMain.MusclePowerSpell)
		snusnuMain.hadMusclePowerSpell = true
		magicActor.UnequipSpell(snusnuMain.MusclePowerSpell, 0)
		magicActor.UnequipSpell(snusnuMain.MusclePowerSpell, 1)
		magicActor.removeSpell(snusnuMain.MusclePowerSpell)
	EndIf
	If magicActor.hasSpell(snusnuMain.UltraMusclePowerSpell)
		snusnuMain.hadUltraMusclePowerSpell = true
		magicActor.UnequipSpell(snusnuMain.UltraMusclePowerSpell, 0)
		magicActor.UnequipSpell(snusnuMain.UltraMusclePowerSpell, 1)
		magicActor.removeSpell(snusnuMain.UltraMusclePowerSpell)
	EndIf
EndFunction

Function reAddSpells(Actor magicActor)
	If snusnuMain.hadMusclePowerSpell
		snusnuMain.hadMusclePowerSpell = false
		magicActor.addSpell(snusnuMain.MusclePowerSpell)
	EndIf
	If snusnuMain.hadUltraMusclePowerSpell
		snusnuMain.hadUltraMusclePowerSpell = false
		magicActor.addSpell(snusnuMain.UltraMusclePowerSpell)
	EndIf
EndFunction

Function applyFMGBuffs(Actor akTarget)
	;Ultra punching strength
	updateFistsPower(snusnuMain.currentMusclePercent)
	akTarget.AddItem(snusnuMain.FistsOfRage, 1, True)
	akTarget.EquipItem(snusnuMain.FistsOfRage, True, True)
	
	If snusnuMain.currentMusclePercent == 1.0 - (snusnuMain.moreChangesIncrements * 2)
		If !snusnuMain.useAltBody
			snusnuMain.updateBoobsPhysics(true, 2)
			switchHeads(akTarget, 1)
		EndIf
	Else
		If !snusnuMain.useAltBody
			snusnuMain.updateBoobsPhysics(true, 1)
		EndIf
	EndIf
	
	If !snusnuMain.applyMoreChangesOvertime
		switchHeads(akTarget, 1)
	EndIf
	
	If snusnuMain.currentMusclePercent == 1.0
		;Improved jump height
		Game.SetGameSettingFloat("fJumpHeightMin", 180.0)
	EndIf
	
	If snusnuMain.hardcoreMode
		snusnuMain.updateAllowedItemsEquipedWeight()
		snusnuMain.needEquipWeightUpdate = true
	EndIf
	
	Utility.wait(1.0)
	
	;CarryWeight Boost
	akTarget.ModActorValue("CarryWeight", 400*snusnuMain.currentMusclePercent)
	
	tfTime = snusnuMain.GameDaysPassed.GetValue()
	
	snusnuMain.muscleMightAffinity += 0.02
	
	Debug.Trace("SNU - Finished applying transformation effect")
	Debug.Notification("My body has stopped growing")
EndFunction

Function applyQuickGrowthAnim(Actor tfActor, Float magnitude)
	Debug.Trace("applyQuickGrowthAnim("+magnitude+")")
	If snusnuMain.tfAnimation
		If snusnuMain.playTFSound
			tfSoundInstance = snusnuMain.snusnuTFSoundShort.Play(tfActor)
		EndIf
		
		float growthVal = magnitude - snusnuMain.moreChangesIncrements
		while growthVal < magnitude
			snusnuMain.removeNormalMuscle(tfActor, growthVal)
			
			muscleChange(tfActor, growthVal)
			
			If (growthVal * 100) as Int % 16 == 0
				updateBones(tfActor, growthVal)
			endIf
			
			growthVal += 0.02
			Utility.wait(0.04)
		endWhile
		
		If snusnuMain.playTFSound
			Utility.wait(3.0)
			Sound.StopInstance(tfSoundInstance)
		EndIf
	EndIf
	
	snusnuMain.removeNormalMuscle(tfActor, magnitude)
	muscleChange(tfActor, magnitude )
	
	updateBones(tfActor, magnitude, True, True)
	
	Debug.Trace("SNU - Finished growing to "+magnitude)
	;snusnuMain.showInfoNotification("Finished growing to "+(magnitude*100)+"%")
EndFunction

Bool Function updateBones(Actor theActor, Float magnitude, Bool growingUp = true, Bool forceUpdate = false)
	
	;ToDo- WE NEED TO CHECK FOR CHANGES ON AN INDIVIDUAL BONE BASIS!!!!!!
	
	;Check if the current bone scale is actually bigger or smaller than what we want to change it to
	;/Int changedBone = snusnuMain.findFirstActiveBoneMorph(theActor)
	If changedBone != -1 && !forceUpdate
		Bool actorIsFemale = theActor.GetActorBase().GetSex()
		Float changedBoneVal = NiOverride.GetNodeTransformScale(theActor, false, actorIsFemale, snusnuMain.getBoneMorphName(changedBone), snusnuMain.SNUSNU_KEY)
		If growingUp && changedBoneVal >= snusnuMain.getBoneSize(magnitude, bonesValuesFMG[changedBone])
			Debug.Trace("SNU - Bone is already bigger, bailing out!!")
			return false
		ElseIf !growingUp && changedBoneVal <= snusnuMain.getBoneSize(magnitude, bonesValuesFMG[changedBone])
			Debug.Trace("SNU - Bone is already smaller, bailing out!!")
			return false
		EndIf
	EndIf
	/;
	Debug.Trace("SNU - Updating all bones! magnitude="+magnitude+", growingUp="+growingUp)
	Int boneCounter = 0
	While boneCounter < snusnuMain.totalCurrentBones
		snusnuMain.changeBoneScale(theActor, boneCounter, snusnuMain.getBoneSize(magnitude, bonesValuesFMG[boneCounter]))
		boneCounter += 1
	EndWhile
	
	return true
EndFunction

;Head index: 0=Original, 1=Muscle, 2=Muscle tan, 3=Muscle tan 2
Function switchHeads(Actor headOwner, Int newHeadIndex)
	If !snusnuMain.changeHeadPart || snusnuMain.useAltBody || snusnuMain.isWerewolf
		return
	EndIf
	
	If !snusnuMain.originalHead
		;We need to save the original head now!
		ActorBase akTargetBase = headOwner.getActorBase()
		Int headIndex = akTargetBase.GetIndexOfHeadPartByType(1)
		snusnuMain.originalHead = akTargetBase.GetNthHeadPart(headIndex)
		Debug.Trace("SNU - Original head: "+snusnuMain.originalHead)
	EndIf
	
	If newHeadIndex == 0
		Debug.Trace("SNU - Changing head to: "+snusnuMain.originalHead)
		headOwner.ChangeHeadPart(snusnuMain.originalHead)
	ElseIf newHeadIndex == 1
		Debug.Trace("SNU - Changing head to: "+snusnuMain.MuscleHead)
		headOwner.ChangeHeadPart(snusnuMain.MuscleHead)
	ElseIf newHeadIndex == 2
		If StringUtil.Find(snusnuMain.getNormalsByBodyType(headOwner), "CBBE") != -1
			Debug.Trace("SNU - Changing head to: "+snusnuMain.MuscleHeadTan)
			headOwner.ChangeHeadPart(snusnuMain.MuscleHeadTan)
		ElseIf StringUtil.Find(snusnuMain.getNormalsByBodyType(headOwner), "UNP") != -1
			Debug.Trace("SNU - Changing head to: "+snusnuMain.MuscleHeadTanUNP)
			headOwner.ChangeHeadPart(snusnuMain.MuscleHeadTanUNP)
		EndIf
	ElseIf newHeadIndex == 3
		If StringUtil.Find(snusnuMain.getNormalsByBodyType(headOwner), "CBBE") != -1
			Debug.Trace("SNU - Changing head to: "+snusnuMain.MuscleHeadTan2)
			headOwner.ChangeHeadPart(snusnuMain.MuscleHeadTan2)
		ElseIf StringUtil.Find(snusnuMain.getNormalsByBodyType(headOwner), "UNP") != -1
			Debug.Trace("SNU - Changing head to: "+snusnuMain.MuscleHeadTan2UNP)
			headOwner.ChangeHeadPart(snusnuMain.MuscleHeadTan2UNP)
		EndIf
	EndIf
	
	headOwner.RegenerateHead()
	Utility.wait(1)
	headOwner.QueueNiNodeUpdate() ;Cleans previous head mesh. ToDo- Needs to be tested
EndFunction

Function swapBodyMesh(Actor victim, Bool applyFMGBody = true)
	Armor SkinToChange
	HeadPart FaceToChange
	TextureSet FaceTextureSetToChange
	
	;victim.UnequipItemSlot(32)
	;Utility.wait(0.5)
	victim.UnequipAll()
	Utility.wait(0.5)
	
	If applyFMGBody
		Bool isFemale = victim.GetActorBase().GetSex() != 0
		NiOverride.RemoveSkinOverride(victim, isFemale, false, 0x04, 9, 1)
		NiOverride.RemoveSkinOverride(victim, isFemale, true, 0x04, 9, 1)
		If !victim.IsOnMount()
			victim.QueueNiNodeUpdate()
			Utility.wait(0.5)
		EndIf
		
		ActorBase akTargetBase = victim.getActorBase()
		Int headIndex = akTargetBase.GetIndexOfHeadPartByType(1)
		snusnuMain.originalHead = akTargetBase.GetNthHeadPart(headIndex)
		Debug.Trace("SNU - Original head: "+snusnuMain.originalHead)
		
		snusnuMain.originalBody = akTargetBase.GetSkin()
		snusnuMain.originalFace = akTargetBase.GetFaceTextureSet()

		
		SkinToChange = snusnuMain.AltFMGBody
		FaceToChange = snusnuMain.AltFMGHead
		FaceTextureSetToChange = snusnuMain.AltFMGFace
	Else
		SkinToChange = snusnuMain.originalBody
		FaceToChange = snusnuMain.originalHead
		FaceTextureSetToChange = snusnuMain.originalFace
	EndIf
	
	victim.ChangeHeadPart(FaceToChange)
	victim.GetActorBase().SetSkin(SkinToChange)
	victim.GetActorBase().SetFaceTextureSet(FaceTextureSetToChange)
	victim.QueueNiNodeUpdate()
	victim.RegenerateHead()
EndFunction

Function updateFistsPower(Float magnitude)
	Enchantment fistEffects = snusnuMain.FistsOfRage.GetEnchantment()
	
	Int counter = 0
	While counter < fistEffects.GetNumEffects()
		;Debug.Trace("SNU - Fists effect "+counter+" magnitude: "+fistEffects.GetNthEffectMagnitude(counter))
		
		If counter == 0
			fistEffects.SetNthEffectMagnitude(counter, 150 * magnitude)
		Else
			fistEffects.SetNthEffectMagnitude(counter, 100 * magnitude)
		EndIf
		
		counter += 1
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

Int Function switchMuscleNormals(Actor buffTarget, Int muscleStage, Float newWeight)
	Int newStage = muscleStage

	If muscleStage == 1 && newWeight >= 30.0 && newWeight < 55.0
		newStage = 2
	ElseIf muscleStage == 2 && newWeight >= 55.0 && newWeight < 75.0
		newStage = 3
	ElseIf muscleStage == 3 && newWeight >= 75.0 && newWeight < 100.0
		newStage = 5
	ElseIf muscleStage == 4 && newWeight == 100.0
		newStage = 5
	EndIf
	
	;Debug.Trace("SNU - Going to switch normals? muscleStage="+muscleStage+", newStage="+newStage+", newWeight="+newWeight)
	If newStage != muscleStage
		applyMuscleNormals(buffTarget, newStage)
	EndIf
	return newStage
EndFunction

Function applyMuscleNormals(Actor buffTarget, int stage)
	String tempNormalsPath = snusnuMain.normalsPath+snusnuMain.getNormalsByBodyType(buffTarget)
	;Debug.Trace("SNU - Normals path is now "+tempNormalsPath)
	
	If stage == 1
		tempNormalsPath = tempNormalsPath + "civilian"
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
	Debug.Trace("SNU - Switching to normals: "+tempNormalsPath)
	
	Bool hasHandFix = false
	Armor handsArmor = buffTarget.GetWornForm(0x00000008) as Armor
	if !handsArmor
		Debug.Trace("SNU - Attempting to apply hands fix!")
		buffTarget.equipItem(snusnuMain.handsFix, true, true)
		Utility.wait(0.2)
		hasHandFix = true
	endIf
	
	Bool isFemale = buffTarget.GetActorBase().GetSex() != 0
	NiOverride.AddSkinOverrideString(buffTarget, isFemale, false, 0x04, 9, 1, tempNormalsPath, true)
	NiOverride.AddSkinOverrideString(buffTarget, isFemale, true, 0x04, 9, 1, tempNormalsPath, true)
	
	if hasHandFix
		Debug.Trace("SNU - Finishing to apply hands fix!")
		Utility.wait(0.2)
		buffTarget.unequipItemslot(33)
		buffTarget.removeitem(snusnuMain.handsFix, 1, true)
	endIf
EndFunction

;TLALOC- Blatantly ripped from Blush When Aroused
string Function initOverlaySlot(Actor buffTarget) Global
	;String normalsPath = snusnuMain.normalsPath+snusnuMain.getNormalsByBodyType(buffTarget)
	string deftex = "Actors\\Character\\Overlays\\Default.dds"
	string newOverlayID = "x"
	int i = 0
	int maxOverlays = NiOverride.GetNumBodyOverlays()
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
		;TLALOC- Don't assume actor is female in all of niOverride calls
		NiOverride.AddNodeOverrideString(buffTarget, true, "Body "+newOverlayID, 9, 0, normalsPath+"tan.dds", true)
		NiOverride.AddNodeOverrideString(buffTarget, true, "Body "+newOverlayID, 9, 1, normalsPath+"ultra.dds", true)
		Debug.Trace("SNU - overlay slot was found: "+newOverlayID)/;
	EndIf
	
	return newOverlayID
EndFunction

string Function getCurrentOverlayString(Actor target, int index) Global
	string overlayID = "Body [Ovl" + index + "]"
	string tx = ""

	if NetImmerse.HasNode(target, overlayID, false)
		tx = NiOverride.GetNodepropertyString(target, false, overlayID, 9, 0)
	else
		tx = NiOverride.GetNodeOverrideString(target, true, overlayID, 9, 0)
	endIf

	return tx
EndFunction

Function applyOverlayStrings(Actor target, String slot)
	;string overlayID = "[Ovl" + index + "]"
	String normalsPath = snusnuMain.normalsPath+snusnuMain.getNormalsByBodyType(target)+"Ultra2\\"
	Bool isFemale = target.GetActorBase().GetSex() != 0
	;TLALOC-ToDo- We need to find free slots for all the other body parts!!!!!!
	NiOverride.AddNodeOverrideString(target, isFemale, "Body "+slot, 9, 0, normalsPath+"Body.dds", true)
	NiOverride.AddNodeOverrideString(target, isFemale, "Body "+slot, 9, 1, normalsPath+"Ultra.dds", true)

	NiOverride.AddNodeOverrideString(target, isFemale, "Face "+slot, 9, 0, normalsPath+"Face.dds", true)
	NiOverride.AddNodeOverrideString(target, isFemale, "Face "+slot, 9, 1, normalsPath+"FaceMSN.dds", true)
	
	NiOverride.AddNodeOverrideString(target, isFemale, "Hands "+slot, 9, 0, normalsPath+"Hands.dds", true)
	
	NiOverride.AddNodeOverrideString(target, isFemale, "Feet "+slot, 9, 0, normalsPath+"Feet.dds", true)
	
EndFunction

Function applyBarbarianSkin(Actor target, Int skinIndex, Bool applyFix = true)
	Bool isFemale = target.GetActorBase().GetSex() != 0
	;Due to restrictions on original textures usage, skin switching will be disabled for males
	If snusnuMain.isVampireLord || !isFemale
		return
	EndIf
	
	Debug.Trace("SNU - applyBarbarianSkin(skinIndex="+skinIndex+")")
	Bool hasHandFix = false
	Armor handsArmor = target.GetWornForm(0x00000008) as Armor
	if !handsArmor && applyFix
		Debug.Trace("SNU - Attempting to apply hands fix!")
		target.equipItem(snusnuMain.handsFix, true, true)
		Utility.wait(0.2)
		hasHandFix = true
	endIf
	
	If skinIndex > 0 && (!snusnuMain.PlayerRef.hasKeyword(snusnuMain.isVampire) || snusnuMain.applyVampireFix)
		String tempNormalsPath = snusnuMain.normalsPath+snusnuMain.getNormalsByBodyType(target)+"Ultra"+skinIndex+"\\"
		
		;Body
		NiOverride.AddSkinOverrideString(target, isFemale, false, 0x04, 9, 0, tempNormalsPath+"Body.dds", true)
		NiOverride.AddSkinOverrideString(target, isFemale, true, 0x04, 9, 0, tempNormalsPath+"Body.dds", true)
		
		;Face
		;NiOverride.AddSkinOverrideString(target, isFemale, false, 0x04, 9, 0, tempNormalsPath+"Face.dds", true)
		;NiOverride.AddSkinOverrideString(target, isFemale, true, 0x04, 9, 0, tempNormalsPath+"Face.dds", true)
		If skinIndex == 1
			Debug.Notification("Im getting a nice tan")
			switchHeads(target, 2)
		ElseIf skinIndex == 2
			Debug.Notification("My skin is getting very rough!")
			switchHeads(target, 3)
		EndIf
		
		;Hands
		NiOverride.AddSkinOverrideString(target, isFemale, false, 0x08, 9, 0, tempNormalsPath+"Hands.dds", true)
		NiOverride.AddSkinOverrideString(target, isFemale, true, 0x08, 9, 0, tempNormalsPath+"Hands.dds", true)
		
		;Feet
		NiOverride.AddSkinOverrideString(target, isFemale, false, 0x80, 9, 0, tempNormalsPath+"Body.dds", true)
		NiOverride.AddSkinOverrideString(target, isFemale, true, 0x80, 9, 0, tempNormalsPath+"Body.dds", true)
	Else
		;RemoveAllReferenceSkinOverrides(target)
		;Body
		NiOverride.RemoveSkinOverride(target, isFemale, false, 0x04, 9, 0)
		NiOverride.RemoveSkinOverride(target, isFemale, true, 0x04, 9, 0)
		;Hands
		NiOverride.RemoveSkinOverride(target, isFemale, false, 0x08, 9, 0)
		NiOverride.RemoveSkinOverride(target, isFemale, true, 0x08, 9, 0)
		;Feet
		NiOverride.RemoveSkinOverride(target, isFemale, false, 0x80, 9, 0)
		NiOverride.RemoveSkinOverride(target, isFemale, true, 0x80, 9, 0)
		
		switchHeads(target, 0)
		
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
	bonesValuesFMG = new Float[68]
	maleValuesFMG = new Float[2]
EndFunction

Bool Function loadFMGMorphs(Actor buffedActor)
	String fileName = "SnuSnuProfiles/SnuDefaultFMG_" + snusnuMain.getNormalsByBodyType(buffedActor, false)
	
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
		Debug.Trace("SNU - ERROR: FMG Morphs could not be loaded!!")
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
