Scriptname SnusnuMusclePowerScript extends ActiveMagicEffect  

import NiOverride

String Property SNUSNU_BUFF_KEY = "Snusnu.esp_BUFF" AutoReadOnly

Snusnu Property snusnuMain Auto
Bool Property wasWMEnabled = false Auto
Float originalMuscleScore

event OnEffectStart(Actor akTarget, Actor akCaster)
	If snusnuMain.PlayerRef.GetActorBase().GetSex() == 0
		Debug.Notification("This spell only works on female characters")
		return
	EndIf
	
	If StorageUtil.GetIntValue(akTarget, "PSQ_HasMuscle") <= 0
		;StorageUtil.SetIntValue(akTarget, "PSQ_HasMuscle", 1)
		StorageUtil.SetIntValue(akTarget, "SNU_UltraMuscle", 1)
;/
		If snusnuMain.isWeightMorphsLoaded
			WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
			If WMCM != none && snusnuMain.removeWeightMorphs
				If WMCM.WMorphs.Enabled
					wasWMEnabled = true
					WMCM.WMorphs.Enabled = false
					WMCM.WMorphs.ClearMorphs()
					WMCM.WMorphs.RegisterEvents(false)
				EndIf
			EndIf
		EndIf
/;		
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
				
				;Apply the pulsating animation: Muscles will suddently grow a lot, then will shrink a little, 
				;                               then grow again, then shrink again, until desired size is achieved
				If goingUp
					growVal = growVal + 0.01
					If growVal >= growStage * 0.1
						goingUp = false
						;Debug.Trace("SNU - growVal is "+growVal+", going back down")
						
						;TLALOC- Update normals if needed
						currentStage = switchMuscleNormals(akTarget, currentStage, growVal * 100 )
						
						snusnuMain.changeSpineBoneScale(akTarget, growVal * 0.125)
						snusnuMain.changeForearmBoneScale(akTarget, growVal * 0.125)
					EndIf
				Else
					growVal = growVal - 0.005
					If growVal >= growSteps - 0.01 && growVal <= growSteps + 0.01
						;Debug.Trace("SNU - growVal has rested on "+growVal)
						
						growVal = growSteps ;TLALOC - Break condition
						snusnuMain.changeSpineBoneScale(akTarget, growVal * 0.125)
						snusnuMain.changeForearmBoneScale(akTarget, growVal * 0.125)
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
			snusnuMain.changeSpineBoneScale(akTarget, 0.125)
			snusnuMain.changeForearmBoneScale(akTarget, 0.125)
			switchMuscleNormals(akTarget, 4, 100 )
		EndIf
		
		If snusnuMain.useAltAnims
			snusnuMain.setMuscleAnimations(akTarget)
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
		
;/		;TLALOC - Updating HDT preset stored in BodyChange specific shape
		If akTarget == snusnuMain.PlayerRef
			;ToDo - Add configuration option to choose which BodyChange slots we will use
			BodyChangeConfigMenu bodyChangeMenu = Game.GetFormFromFile(0x010048BC, "BodyChange.esp") as BodyChangeConfigMenu
			If bodyChangeMenu != None
				Int newBodyIndex = 2 ;Default boobs weight/collision shape
				
				If bodyChangeMenu.BodyChangeShapeFlag != newBodyIndex
					Debug.Trace("SNU - Updating body shape to "+newBodyIndex)
					bodyChangeMenu.changeBodyChangeShapeFlag(newBodyIndex)
					bodyChangeMenu.BodyChangeSpell.Cast(akTarget as objectreference, none)
				EndIf
			EndIf
		EndIf
/;
		;TLALOC- Instad of changing the full body with BodyChange, we use our own muscular head with the appropiate HDT preset
		If snusnuMain.changeHeadPart
			ActorBase akTargetBase = akTarget.getActorBase()
			Int headIndex = akTargetBase.GetIndexOfHeadPartByType(1)
			snusnuMain.originalHead = akTargetBase.GetNthHeadPart(headIndex)
			Debug.Trace("SNU - Original head: "+snusnuMain.originalHead)
			
			akTarget.ChangeHeadPart(snusnuMain.MuscleHead)
			akTarget.RegenerateHead()
		EndIf
	EndIf
	
	Debug.Trace("SNU - Finished applying transformation effect")
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
;/	
	If snusnuMain.isWeightMorphsLoaded
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If WMCM != none && snusnuMain.removeWeightMorphs
			If !WMCM.WMorphs.Enabled && wasWMEnabled
				WMCM.WMorphs.Enabled = true
				wasWMEnabled = false
				WMCM.WMorphs.RegisterEvents(true)
			EndIf
		EndIf
	EndIf
/;	
	;TLALOC-ToDo- Make a deflate animation for this
	clearMuscleMorphs(akTarget)
	snusnuMain.clearBoneScales(akTarget)
	
	;TLALOC-ToDo- Remove normals overlay
	;AddNodeOverrideFloat(akTarget, true, overlaySlot, 8, -1, growVal, true)
	RemoveAllReferenceSkinOverrides(akTarget);For the custom normals
	;RemoveSkinOverride(akTarget, true, false, 0x04, 9, 1)
	
	If snusnuMain.useAltAnims
		snusnuMain.setMuscleAnimations(akTarget, true)
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
endevent

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
	AddSkinOverrideString(buffTarget, true, true, 0x04, 9, 1, tempNormalsPath, true)
EndFunction

;TLALOC- Blatantly ripped from Blush When Aroused
string Function initOverlaySlot(Actor buffTarget)
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

string Function getCurrentOverlayString(Actor target, int index)
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
