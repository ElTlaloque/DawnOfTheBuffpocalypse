ScriptName SnusnuMCM Extends SKI_ConfigBase

Import StorageUtil

; Version data
Int Property SKEE_VERSION = 1 AutoReadOnly
Int Property NIOVERRIDE_SCRIPT_VERSION = 6 AutoReadOnly

Actor Property PlayerRef Auto
Snusnu Property snusnuMain Auto

Int _myEnabled
Int _myHardcoreMode
Int _myMultLoss
Int _myMultGainFight
Int _myMultGainArmor
Int _myMultGainMisc
Int _myMultGainWufwuf
Int _myVampGains
Int _myStamina
Int _mySpeed
Int _myCombatProficiency
Int _myMaxWeight
Int _myFightingScore
Int _myStoredScore
Int _myRemoveWeightMorphs
Int _myCustomizeFMG
Int _mytfAnimation
Int _mytfAnimationNPC
Int _myuseAltAnims
Int _myuseAltAnimsNPC
Int _mychangeHeadPart
Int _myplayTFSound
Int _myUseWeightSlider
Int _myDisableNormals
Int _myApplyMoreChanges
Int _myDynamicChanges
Int _myChangesInterval
Int _myChangesIncrements
Int _myUseAltBody

Int _myZeroSliders
Int _myApplyDefault
Int _myFoceScore
Int _myMalnourishment
Int _myPushupException
Int _myNPCMuscleScore
Int _myBoostCarryWeight

Int _myDynamicPhysics
Int _myChangeAnims
Int _myUseDARAnims
Int _myMuscleAnimsLevel

Int _mySaveOptions
Int _myLoadOptions
Int _mySaveMorphs
Int _myLoadMorphs
Int _mySaveMorphsProfile
Int _myLoadMorphsProfile

String[] savedProfilesList

Int[] cbbeSliders
Int[] uunpSliders
Int[] bhunpSliders
Int[] cbbeSESliders
Int[] cbbe3BASliders

String[] cbbeStrings
String[] uunpStrings
String[] bhunpStrings
String[] cbbeSEStrings
String[] cbbe3BAStrings

;TLALOC - Bone sliders
Int _myMultSpineBone
Int _myMultForearmBone
Int[] boneSliders
String[] boneStrings

; Male morphs
Int _myMultSamuel
Int _myMultSamson

String[] pageNames
Int selectedDefaultMorphs = 1
Bool editFMGMorphs = False


Function setMenuPages()
	Pages = new String[7]
	String fmgString = ""
	
	If editFMGMorphs
		fmgString = "FMG "
	EndIf
	
	Pages[0] = "$SNUSNU_OPTIONS"
	If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
		Pages[1] = fmgString+pageNames[3]
		Pages[2] = fmgString+pageNames[4]
		Pages[3] = fmgString+pageNames[5]
	ElseIf snusnuMain.selectedBody == 1 ;CBBE
		Pages[1] = fmgString+pageNames[6]
		Pages[2] = fmgString+pageNames[7]
		Pages[3] = fmgString+pageNames[8]
	EndIf
	
	If snusnuMain.selectedBody != 2
		Pages[4] = fmgString+pageNames[9]
		Pages[5] = pageNames[1]
		Pages[6] = pageNames[2]
	Else
		Pages[1] = fmgString+pageNames[9]
		Pages[2] = pageNames[1]
		Pages[3] = pageNames[2]
	EndIf
EndFunction

Event OnConfigInit()
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) > 0 && !snusnuMain.isTransforming
		editFMGMorphs = True
		switchFMGMorphs(True)
	EndIf
	
	initPageNames()
	setMenuPages()
	
	cbbeSliders = new Int[52]
	uunpSliders = new Int[74]
	bhunpSliders = new Int[43]
	cbbeSESliders = new Int[27]
	cbbe3BASliders = new Int[40]
	boneSliders = new Int[68]
	
	cbbeStrings = new String[52]
	uunpStrings = new String[74]
	bhunpStrings = new String[43]
	cbbeSEStrings = new String[27]
	cbbe3BAStrings = new String[40]
	boneStrings = new String[68]
	
	initStringArrays()
EndEvent

Event OnVersionUpdate(Int NewVersion)
	;Not functional
EndEvent

Event OnConfigOpen()
	self.OnConfigInit()
EndEvent

Event OnConfigClose()
	If editFMGMorphs
		;Save FMG morphs profile and load the previous morphs
		String loadErrorMsg = switchFMGMorphs(False)
		If loadErrorMsg
			ShowMessage(loadErrorMsg, false)
		EndIf
				
		;Update body if PC is currently transformed
		If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) != 0
			StorageUtil.SetIntValue(PlayerRef, "SNU_UltraMuscle", 12)
			snusnuMain.RegisterForSingleUpdate(1)
		EndIf
		
		editFMGMorphs = False
	Else
		snusnuMain.UpdateWeight() ;Fix for bone morphs
	EndIf
EndEvent

Event OnPageReset(String a_page)
	If snusnuMain.showUpdateMessage
		String Msg
		Msg = "This mod now has support for CBBE, UUNP/BHUNP and Vanilla bodies. To get the best experience out of it, you need to set the \"Current body installed\" option to the body you are currently using."
		ShowMessage(Msg, False)
		snusnuMain.showUpdateMessage = false
	EndIf
	
	; Load custom logo in DDS format
	If (a_page == "")
		; Image size 256x256
		; X offset = 376 - (height / 2) = 258
		; Y offset = 223 - (width / 2) = 95
		LoadCustomContent("Snusnu/res/mcm_logo.dds", 258, 95)
		Return
	Else
		UnloadCustomContent()
	EndIf

	If (a_page == Pages[0])
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$SNUSNU_OPTIONS")
		AddEmptyOption()
		
		_myEnabled = AddToggleOption("$SNUSNU_ENABLED", snusnuMain.Enabled)
		_myHardcoreMode = AddToggleOption("Hardcore Mode", snusnuMain.hardcoreMode)
		AddEmptyOption()
		AddEmptyOption()
		
		;_mySelectedBody = AddToggleOption("$SNUSNU_SELECTEDBODY", snusnuMain.selectedBody)
		AddMenuOptionST("InstalledBody", "$SNUSNU_SELECTEDBODY", GetConditionalString(snusnuMain.selectedBody))
		;_myUseWeightSlider = AddToggleOption("$SNUSNU_USEWEIGHTSLIDER", snusnuMain.useWeightSlider)
		_myDisableNormals = AddToggleOption("$SNUSNU_DISABLENORMALS", snusnuMain.disableNormals)
		AddMenuOptionST("LoadDefaults", "Load default morphs", GetDefaultMorphString(selectedDefaultMorphs))
		_myDynamicPhysics = AddToggleOption("Dynamic Breasts Physics", snusnuMain.useDynamicPhysics)
		_myChangeAnims = AddToggleOption("Change to muscular anims", snusnuMain.useMuscleAnims)
		_myUseDARAnims = AddToggleOption("Use DAR for animations", snusnuMain.useDARAnims)
		_myMuscleAnimsLevel = AddSliderOption("Muscular level anims", snusnuMain.muscleAnimsLevel.getValue() as Float, "{0}")
		
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		
		_myStamina = AddSliderOption("$SNUSNU_STAMINA", snusnuMain.Stamina, "{0}")
		_mySpeed = AddSliderOption("$SNUSNU_SPEED", snusnuMain.Speed, "{0}")
		_myCombatProficiency = AddSliderOption("$SNUSNU_COMBAT", snusnuMain.combatProficiency, "{0}")
		_myBoostCarryWeight = AddSliderOption("Boost carry weight", snusnuMain.carryWeightBoost, "{0}")
		_myMaxWeight = AddSliderOption("$SNUSNU_MAXWEIGHT", snusnuMain.muscleScoreMax, "{2}")
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		
		_myFightingScore = AddTextOption("$SNUSNU_MUSCLE", snusnuMain.getMuscleValuePercent(snusnuMain.muscleScore)+"%", OPTION_FLAG_DISABLED)
		_myStoredScore = AddTextOption("$SNUSNU_MUSCLE_STORED", snusnuMain.getMuscleValuePercent(snusnuMain.storedMuscle)+"%", OPTION_FLAG_DISABLED)
		AddEmptyOption()
		AddEmptyOption()
		
		_myMultLoss = AddSliderOption("$SNUSNU_MULTLOSS", snusnuMain.MultLoss, "{2}")
		_myMultGainFight = AddSliderOption("$SNUSNU_MULTGAINFIGHT", snusnuMain.MultGainFight, "{2}")
		_myMultGainArmor = AddSliderOption("$SNUSNU_MULTGAINARMOR", snusnuMain.MultGainArmor, "{2}")
		_myMultGainMisc = AddSliderOption("$SNUSNU_MULTGAINMISC", snusnuMain.MultGainMisc, "{2}")
		_myMultGainWufwuf = AddSliderOption("$SNUSNU_MULTGAINWUF", snusnuMain.addWerewolfStrength*100, "{0}%")
		_myVampGains = AddSliderOption("Vampire Feed Gains", snusnuMain.addVampireStrength*100, "{1}%")
		AddEmptyOption()
		AddEmptyOption()
		
		_myZeroSliders = AddToggleOption("Zero all sliders", False)
		_myApplyDefault = AddToggleOption("Default slider values", False)
		;_myPushupException = AddToggleOption("Add push-up exception", False)
		If snusnuMain.isWeightMorphsLoaded
			_myMalnourishment = AddSliderOption("Malnourishment", snusnuMain.malnourishmentValue, "{2}")
			AddEmptyOption()
		EndIf
		
		AddEmptyOption()
		AddEmptyOption()
		
		AddKeyMapOptionST("SnusnuDumpInfo","$SNUSNU_DUMPINFO", snusnuMain.getInfoKey)
		
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		
		AddHeaderOption("$SNUSNU_TRANSFORMATION")
		AddEmptyOption()
		If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0
			_myUseAltBody = AddToggleOption("Use alternate body mesh", snusnuMain.useAltBody)
		Else
			_myUseAltBody = AddToggleOption("Use alternate body mesh", snusnuMain.useAltBody, OPTION_FLAG_DISABLED)
		EndIf
		Int altBodyFlag = OPTION_FLAG_NONE
		If snusnuMain.useAltBody
			altBodyFlag = OPTION_FLAG_DISABLED
		EndIf
		AddEmptyOption()
		_myCustomizeFMG = AddToggleOption("Customize FMG Morphs", editFMGMorphs, altBodyFlag)
		If snusnuMain.isWeightMorphsLoaded
			_myRemoveWeightMorphs = AddToggleOption("$SNUSNU_NOWEIGHTMORPHS", snusnuMain.removeWeightMorphs)
		Else
			_myRemoveWeightMorphs = AddToggleOption("$SNUSNU_NOWEIGHTMORPHS", snusnuMain.removeWeightMorphs, OPTION_FLAG_DISABLED)
		EndIf
		_mytfAnimation = AddToggleOption("$SNUSNU_USETFANIM", snusnuMain.tfAnimation)
		_mytfAnimationNPC = AddToggleOption("$SNUSNU_USETFANIMNPC", snusnuMain.tfAnimationNPC)
		_myuseAltAnims = AddToggleOption("$SNUSNU_USEALTANIMS", snusnuMain.useAltAnims)
		_myuseAltAnimsNPC = AddToggleOption("$SNUSNU_USEALTANIMSNPC", snusnuMain.useAltAnimsNPC)
		_mychangeHeadPart = AddToggleOption("$SNUSNU_CHANGEHEAD", snusnuMain.changeHeadPart, altBodyFlag)
		_myplayTFSound = AddToggleOption("$SNUSNU_PLAYTFSOUND", snusnuMain.playTFSound)
		_myApplyMoreChanges = AddToggleOption("More changes while TF", snusnuMain.applyMoreChangesOvertime, altBodyFlag)
		_myChangesInterval = AddSliderOption("More changes interval", snusnuMain.moreChangesInterval, "{2}", altBodyFlag)
		_myChangesIncrements = AddSliderOption("More changes growth increments", snusnuMain.moreChangesIncrements, "{2}", altBodyFlag)
		_myDynamicChanges = AddToggleOption("Dynamic changes calculation", snusnuMain.dynamicChangesCalculation, altBodyFlag)
		_myNPCMuscleScore = AddSliderOption("NPC Custom Muscle", snusnuMain.npcMuscleScore*100, "{0}%")
		AddKeyMapOptionST("SnusnuNPCMuscle","Reload NPC muscles", snusnuMain.npcMuscleKey)
		
	ElseIf (a_page == Pages[1] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption(pageNames[3])
			AddEmptyOption()
			
			Int counter = 0
			while counter < 52
				cbbeSliders[counter] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[counter])+cbbeStrings[counter], snusnuMain.cbbeValues[counter], "{2}")
				counter += 1
			endWhile
		Else ;CBBE SE
			AddHeaderOption(pageNames[6])
			AddEmptyOption()
			AddHeaderOption("BREASTS")
			AddEmptyOption()
			cbbeSliders[0] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[0])+"Size (Inverted)", snusnuMain.cbbeValues[0], "{2}")
			cbbeSliders[1] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[1])+"Smaller 1 (Inverted)", snusnuMain.cbbeValues[1], "{2}")
			cbbeSESliders[0] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[0])+"Smaller 2", snusnuMain.cbbeSEValues[0], "{2}")
			cbbeSESliders[1] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[1])+"Silly Huge", snusnuMain.cbbeSEValues[1], "{2}")
			cbbeSESliders[2] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[2])+"Silly Huge Symmetry", snusnuMain.cbbeSEValues[2], "{2}")
			cbbeSliders[4] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[4])+"Fantasy", snusnuMain.cbbeValues[4], "{2}")
			cbbeSliders[5] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[5])+"Melons", snusnuMain.cbbeValues[5], "{2}")
			bhunpSliders[0] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[0])+"Push Together", snusnuMain.bhunpValues[0], "{2}")
			cbbe3BASliders[0] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[0])+"Converge", snusnuMain.cbbe3BAValues[0], "{2}")
			bhunpSliders[1] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[1])+"Center", snusnuMain.bhunpValues[1], "{2}")
			bhunpSliders[2] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[2])+"Center Big", snusnuMain.bhunpValues[2], "{2}")
			cbbeSESliders[3] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[3])+"Top Slope", snusnuMain.cbbeSEValues[3], "{2}")
			cbbeSliders[6] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[6])+"Cleavage", snusnuMain.cbbeValues[6], "{2}")
			cbbeSESliders[4] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[4])+"Flatness", snusnuMain.cbbeSEValues[4], "{2}")
			cbbeSliders[7] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[7])+"More Flatness", snusnuMain.cbbeValues[7], "{2}")
			bhunpSliders[5] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[5])+"Gone", snusnuMain.bhunpValues[5], "{2}")
			cbbeSESliders[5] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[5])+"Gravity", snusnuMain.cbbeSEValues[5], "{2}")
			cbbeSliders[9] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[9])+"Push Up", snusnuMain.cbbeValues[9], "{2}")
			cbbeSliders[10] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[10])+"Height", snusnuMain.cbbeValues[10], "{2}")
			cbbeSliders[11] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[11])+"Perkiness", snusnuMain.cbbeValues[11], "{2}")
			cbbeSliders[12] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[12])+"Width", snusnuMain.cbbeValues[12], "{2}")
			cbbeSESliders[6] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[6])+"Side Shape", snusnuMain.cbbeSEValues[6], "{2}")
			cbbeSESliders[7] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[7])+"Under Depth", snusnuMain.cbbeSEValues[7], "{2}")
			cbbe3BASliders[1] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[1])+"Pressed", snusnuMain.cbbe3BAValues[1], "{2}")
			AddHeaderOption("NIPPLES")
			AddEmptyOption()
			cbbeSESliders[8] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[8])+"Areola Size", snusnuMain.cbbeSEValues[8], "{2}")
			cbbe3BASliders[2] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[2])+"Areola Pull", snusnuMain.cbbe3BAValues[2], "{2}")
			cbbeSliders[18] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[18])+"Point Up", snusnuMain.cbbeValues[18], "{2}")
			cbbeSliders[19] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[19])+"Point Down", snusnuMain.cbbeValues[19], "{2}")
			cbbeSliders[16] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[16])+"Size (Inverted)", snusnuMain.cbbeValues[16], "{2}")
			cbbeSliders[15] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[15])+"Length", snusnuMain.cbbeValues[15], "{2}")
			cbbe3BASliders[3] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[3])+"Squash Vertical", snusnuMain.cbbe3BAValues[3], "{2}")
			cbbe3BASliders[4] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[4])+"Squash Horizontal", snusnuMain.cbbe3BAValues[4], "{2}")
			cbbeSESliders[9] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[9])+"Defined", snusnuMain.cbbeSEValues[9], "{2}")
			cbbeSliders[14] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[14])+"Perky", snusnuMain.cbbeValues[14], "{2}")
			cbbeSESliders[10] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[10])+"Puffy", snusnuMain.cbbeSEValues[10], "{2}")
			
			cbbe3BASliders[5] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[5])+"More Puffy", snusnuMain.cbbe3BAValues[5], "{2}")
			cbbe3BASliders[6] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[6])+"Shy", snusnuMain.cbbe3BAValues[6], "{2}")
			cbbe3BASliders[7] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[7])+"Thick", snusnuMain.cbbe3BAValues[7], "{2}")
			cbbe3BASliders[8] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[8])+"Tube", snusnuMain.cbbe3BAValues[8], "{2}")
			cbbe3BASliders[9] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[9])+"Crease", snusnuMain.cbbe3BAValues[9], "{2}")
			cbbe3BASliders[10] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[10])+"Crumpled", snusnuMain.cbbe3BAValues[10], "{2}")
			cbbe3BASliders[11] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[11])+"Bump", snusnuMain.cbbe3BAValues[11], "{2}")
			cbbe3BASliders[12] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[12])+"Invert", snusnuMain.cbbe3BAValues[12], "{2}")

			cbbeSliders[20] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[20])+"Nipple Tip", snusnuMain.cbbeValues[20], "{2}")
			cbbeSESliders[11] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[11])+"Twist", snusnuMain.cbbeSEValues[11], "{2}")
			cbbeSliders[13] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[13])+"Distance (Inverted)", snusnuMain.cbbeValues[13], "{2}")
			cbbeSESliders[12] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[12])+"Dip", snusnuMain.cbbeSEValues[12], "{2}")
			bhunpSliders[8] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[8])+"NipBGone", snusnuMain.bhunpValues[8], "{2}")
			
			AddHeaderOption("TORSO")
			AddEmptyOption()
			bhunpSliders[10] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[10])+"Chest Depth", snusnuMain.bhunpValues[10], "{2}")
			bhunpSliders[11] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[11])+"Chest Width", snusnuMain.bhunpValues[11], "{2}")
			cbbe3BASliders[13] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[13])+"Clavicle", snusnuMain.cbbe3BAValues[13], "{2}")
			bhunpSliders[12] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[12])+"Ribs", snusnuMain.bhunpValues[12], "{2}")
			cbbe3BASliders[14] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[14])+"Protruded Ribs", snusnuMain.cbbe3BAValues[14], "{2}")
			bhunpSliders[13] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[13])+"Sternum Depth", snusnuMain.bhunpValues[13], "{2}")
			bhunpSliders[14] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[14])+"Sternum Height", snusnuMain.bhunpValues[14], "{2}")
			cbbeSliders[29] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[29])+"Size", snusnuMain.cbbeValues[29], "{2}")
			cbbeSliders[33] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[33])+"Back Size", snusnuMain.cbbeValues[33], "{2}")
			bhunpSliders[16] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[16])+"Back Arch", snusnuMain.bhunpValues[16], "{2}")
			cbbe3BASliders[15] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[15])+"Back Valley", snusnuMain.cbbe3BAValues[15], "{2}")
			cbbe3BASliders[16] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[16])+"Back Wing", snusnuMain.cbbe3BAValues[16], "{2}")
			cbbeSESliders[13] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[13])+"Navel Even", snusnuMain.cbbeSEValues[13], "{2}")
			cbbeSliders[30] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[30])+"Waist Size (Inverted)", snusnuMain.cbbeValues[30], "{2}")
			bhunpSliders[15] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[15])+"Waist Height", snusnuMain.bhunpValues[15], "{2}")
			cbbeSliders[31] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[31])+"Waist Line", snusnuMain.cbbeValues[31], "{2}")
			cbbeSliders[32] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[32])+"Chubby Waist", snusnuMain.cbbeValues[32], "{2}")
		EndIf
	ElseIf (a_page == Pages[2] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption(pageNames[4])
			AddEmptyOption()
			
			Int counter = 0
			while counter < 74
				uunpSliders[counter] = AddSliderOption(sliderHasValue(snusnuMain.uunpValues[counter])+uunpStrings[counter], snusnuMain.uunpValues[counter], "{2}")
				counter += 1
			endWhile
		Else ;CBBE SE
			AddHeaderOption(pageNames[7])
			AddEmptyOption()
			AddHeaderOption("BUTT")
			AddEmptyOption()
			cbbeSESliders[14] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[14])+"Shape Classic", snusnuMain.cbbeSEValues[14], "{2}")
			cbbeSliders[37] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[37])+"Shape Lower", snusnuMain.cbbeValues[37], "{2}")
			cbbeSliders[34] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[34])+"Crack (Inverted)", snusnuMain.cbbeValues[34], "{2}")
			cbbeSliders[35] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[35])+"Size (Inverted)", snusnuMain.cbbeValues[35], "{2}")
			cbbeSliders[36] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[36])+"Smaller (Inverted)", snusnuMain.cbbeValues[36], "{2}")
			cbbeSliders[38] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[38])+"Big", snusnuMain.cbbeValues[38], "{2}")
			cbbeSliders[39] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[39])+"Chubby", snusnuMain.cbbeValues[39], "{2}")
			cbbeSliders[40] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[40])+"Apple", snusnuMain.cbbeValues[40], "{2}")
			cbbe3BASliders[17] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[17])+"Saggy", snusnuMain.cbbe3BAValues[17], "{2}")
			cbbe3BASliders[18] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[18])+"Pressed", snusnuMain.cbbe3BAValues[18], "{2}")
			cbbe3BASliders[19] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[19])+"Narrow", snusnuMain.cbbe3BAValues[19], "{2}")
			cbbeSESliders[15] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[15])+"Dimples", snusnuMain.cbbeSEValues[15], "{2}")
			cbbeSESliders[16] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[16])+"Under Fold", snusnuMain.cbbeSEValues[16], "{2}")
			cbbeSliders[41] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[41])+"Round", snusnuMain.cbbeValues[41], "{2}")
			bhunpSliders[17] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[17])+"Move Crotch", snusnuMain.bhunpValues[17], "{2}")
			cbbeSliders[42] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[42])+"Groin", snusnuMain.cbbeValues[42], "{2}")
			
			AddHeaderOption("LEGS AND FEET")
			AddEmptyOption()
			cbbeSESliders[18] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[18])+"Shape Classic", snusnuMain.cbbeSEValues[18], "{2}")
			cbbe3BASliders[20] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[20])+"7B Legs", snusnuMain.cbbe3BAValues[20], "{2}")
			bhunpSliders[18] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[18])+"Thin", snusnuMain.bhunpValues[18], "{2}")
			cbbeSliders[45] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[45])+"Slim", snusnuMain.cbbeValues[45], "{2}")
			cbbeSliders[46] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[46])+"Thighs", snusnuMain.cbbeValues[46], "{2}")
			cbbe3BASliders[21] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[21])+"Outside", snusnuMain.cbbe3BAValues[21], "{2}")
			cbbe3BASliders[22] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[22])+"Inside", snusnuMain.cbbe3BAValues[22], "{2}")
			cbbe3BASliders[23] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[23])+"Front-Back", snusnuMain.cbbe3BAValues[23], "{2}")
			cbbeSliders[47] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[47])+"Chubby", snusnuMain.cbbeValues[47], "{2}")
			cbbeSliders[48] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[48])+"Size (Inverted)", snusnuMain.cbbeValues[48], "{2}")
			cbbe3BASliders[24] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[24])+"Leg Spread", snusnuMain.cbbe3BAValues[24], "{2}")
			cbbeSliders[49] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[49])+"Knee Height", snusnuMain.cbbeValues[49], "{2}")
			bhunpSliders[19] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[19])+"Knee Shape", snusnuMain.bhunpValues[19], "{2}")
			cbbe3BASliders[25] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[25])+"Knee Together", snusnuMain.cbbe3BAValues[25], "{2}")
			cbbeSliders[50] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[50])+"Calf Size", snusnuMain.cbbeValues[50], "{2}")
			cbbeSliders[51] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[51])+"Calf Smooth", snusnuMain.cbbeValues[51], "{2}")
			cbbe3BASliders[26] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[26])+"Calf Front-Back", snusnuMain.cbbe3BAValues[26], "{2}")
			cbbeSESliders[19] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[19])+"Feminine Feet", snusnuMain.cbbeSEValues[19], "{2}")
			AddHeaderOption("HIPS")
			AddEmptyOption()
			cbbe3BASliders[39] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[39])+"Hip bone", snusnuMain.cbbe3BAValues[39], "{2}")
			cbbeSliders[44] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[44])+"Size", snusnuMain.cbbeValues[44], "{2}")
			bhunpSliders[26] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[26])+"Forward", snusnuMain.bhunpValues[26], "{2}")
			bhunpSliders[27] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[27])+"Upper Width", snusnuMain.bhunpValues[27], "{2}")
			cbbeSESliders[17] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[17])+"Carved", snusnuMain.cbbeSEValues[17], "{2}")
			cbbe3BASliders[31] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[31])+"Hip Narrow", snusnuMain.cbbe3BAValues[31], "{2}")
			cbbe3BASliders[32] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[32])+"UNP Hip", snusnuMain.cbbe3BAValues[32], "{2}")
			AddEmptyOption()
			AddHeaderOption("ARMS")
			AddEmptyOption()
			cbbeSliders[21] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[21])+"Size (Inverted)", snusnuMain.cbbeValues[21], "{2}")
			bhunpSliders[28] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[28])+"Forearm Size", snusnuMain.bhunpValues[28], "{2}")
			cbbeSliders[22] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[22])+"Chubby", snusnuMain.cbbeValues[22], "{2}")
			cbbeSliders[23] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[23])+"Shoulder Smooth", snusnuMain.cbbeValues[23], "{2}")
			cbbeSliders[24] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[24])+"Shoulder Width (Inverted)", snusnuMain.cbbeValues[24], "{2}")
			bhunpSliders[29] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[29])+"Shoulder Tweak", snusnuMain.bhunpValues[29], "{2}")
			cbbe3BASliders[33] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[33])+"Armpit", snusnuMain.cbbe3BAValues[33], "{2}")
			AddEmptyOption()
			AddHeaderOption("BELLY")
			AddEmptyOption()
			cbbeSliders[25] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[25])+"Size", snusnuMain.cbbeValues[25], "{2}")
			cbbeSliders[26] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[26])+"Big", snusnuMain.cbbeValues[26], "{2}")
			cbbe3BASliders[34] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[34])+"Front Up Fat", snusnuMain.cbbe3BAValues[34], "{2}")
			cbbe3BASliders[35] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[35])+"Front Down Fat", snusnuMain.cbbe3BAValues[35], "{2}")
			cbbe3BASliders[36] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[36])+"Side Up Fat", snusnuMain.cbbe3BAValues[36], "{2}")
			cbbe3BASliders[37] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[37])+"Side Down Fat", snusnuMain.cbbe3BAValues[37], "{2}")
			cbbe3BASliders[38] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[38])+"Under", snusnuMain.cbbe3BAValues[38], "{2}")
			cbbeSliders[27] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[27])+"Pregnant", snusnuMain.cbbeValues[27], "{2}")
			cbbeSliders[28] = AddSliderOption(sliderHasValue(snusnuMain.cbbeValues[28])+"Tuck", snusnuMain.cbbeValues[28], "{2}")
		EndIf
	ElseIf (a_page == Pages[3] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption(pageNames[5])
			AddEmptyOption()
			
			Int counter = 0
			while counter < 43
				bhunpSliders[counter] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[counter])+bhunpStrings[counter], snusnuMain.bhunpValues[counter], "{2}")
				counter += 1
			endWhile
		Else ;CBBE SE
			AddHeaderOption(pageNames[8])
			AddEmptyOption()
			AddHeaderOption("MUSCLE DEFINITION")
			AddEmptyOption()
			bhunpSliders[21] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[21])+"Abs", snusnuMain.bhunpValues[21], "{2}")
			bhunpSliders[22] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[22])+"Arms", snusnuMain.bhunpValues[22], "{2}")
			bhunpSliders[23] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[23])+"Butt", snusnuMain.bhunpValues[23], "{2}")
			bhunpSliders[24] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[24])+"Legs", snusnuMain.bhunpValues[24], "{2}")
			bhunpSliders[25] = AddSliderOption(sliderHasValue(snusnuMain.bhunpValues[25])+"Pecs", snusnuMain.bhunpValues[25], "{2}")
			cbbe3BASliders[30] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[30])+"Back", snusnuMain.cbbe3BAValues[30], "{2}")
			cbbe3BASliders[27] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[27])+"More Abs", snusnuMain.cbbe3BAValues[27], "{2}")
			cbbe3BASliders[28] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[28])+"More Arms", snusnuMain.cbbe3BAValues[28], "{2}")
			cbbe3BASliders[29] = AddSliderOption(sliderHasValue(snusnuMain.cbbe3BAValues[29])+"More Legs", snusnuMain.cbbe3BAValues[29], "{2}")
			AddEmptyOption()
			AddHeaderOption("FULL BODY")
			AddEmptyOption()
			cbbeSESliders[22] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[22])+"VanillaSSELo", snusnuMain.cbbeSEValues[22], "{2}")
			cbbeSESliders[23] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[23])+"VanillaSSEHi", snusnuMain.cbbeSEValues[23], "{2}")
			cbbeSESliders[25] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[25])+"7B Lower", snusnuMain.cbbeSEValues[25], "{2}")
			cbbeSESliders[26] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[26])+"7B Upper", snusnuMain.cbbeSEValues[26], "{2}")
			cbbeSESliders[24] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[24])+"OldBaseShape", snusnuMain.cbbeSEValues[24], "{2}")
			AddEmptyOption()
			AddHeaderOption("SEAMS")
			AddEmptyOption()
			cbbeSESliders[20] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[20])+"Ankle Size", snusnuMain.cbbeSEValues[20], "{2}")
			cbbeSESliders[21] = AddSliderOption(sliderHasValue(snusnuMain.cbbeSEValues[21])+"Wrist Size", snusnuMain.cbbeSEValues[21], "{2}")
		EndIf
	ElseIf ((a_page == Pages[4] && snusnuMain.selectedBody != 2) || (a_page == Pages[1] && snusnuMain.selectedBody == 2))
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("BONE MORPHS")
		AddEmptyOption()
		AddHeaderOption("Legacy Bones")
		AddEmptyOption()
		boneSliders[0] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[0])+boneStrings[0], snusnuMain.bonesValues[0], "{3}");Upper spine
		boneSliders[1] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[1])+boneStrings[1], snusnuMain.bonesValues[1], "{3}");Advanced forearms
		AddEmptyOption()
		AddEmptyOption()
		AddHeaderOption("New Bones")
		AddEmptyOption()
		boneSliders[2] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[2])+boneStrings[2], snusnuMain.bonesValues[2], "{3}");Upperarms
		boneSliders[18] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[18])+boneStrings[18], snusnuMain.bonesValues[18], "{3}");Biceps
		boneSliders[19] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[19])+boneStrings[19], snusnuMain.bonesValues[19], "{3}");Biceps2
		boneSliders[4] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[4])+boneStrings[4], snusnuMain.bonesValues[4], "{3}");Clavicle
		boneSliders[3] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[3])+boneStrings[3], snusnuMain.bonesValues[3], "{3}");Hands
		boneSliders[9] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[9])+boneStrings[9], snusnuMain.bonesValues[9], "{3}");Thighs
		boneSliders[10] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[10])+boneStrings[10], snusnuMain.bonesValues[10], "{3}");Calfs
		boneSliders[11] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[11])+boneStrings[11], snusnuMain.bonesValues[11], "{3}");Feet
		boneSliders[5] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[5])+boneStrings[5], snusnuMain.bonesValues[5], "{3}");Pelvis
		boneSliders[6] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[6])+boneStrings[6], snusnuMain.bonesValues[6], "{3}");Waist
		boneSliders[7] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[7])+boneStrings[7], snusnuMain.bonesValues[7], "{3}");Lower Spine
		boneSliders[8] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[8])+boneStrings[8], snusnuMain.bonesValues[8], "{3}");Middle Spine
		boneSliders[17] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[17])+boneStrings[17], snusnuMain.bonesValues[17], "{3}");Head
		boneSliders[16] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[16])+boneStrings[16], snusnuMain.bonesValues[16], "{3}");Height
		AddEmptyOption()
		AddEmptyOption()
		;Female Only
		AddHeaderOption("Female only bones")
		AddEmptyOption()
		boneSliders[12] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[12])+boneStrings[12], snusnuMain.bonesValues[12], "{3}");Breasts (HDT)
		boneSliders[13] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[13])+boneStrings[13], snusnuMain.bonesValues[13], "{3}");Breast Fullness (3BBB)
		boneSliders[14] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[14])+boneStrings[14], snusnuMain.bonesValues[14], "{3}");Belly
		boneSliders[15] = AddSliderOption(boneSliderHasValue(snusnuMain.bonesValues[15])+boneStrings[15], snusnuMain.bonesValues[15], "{3}");Butt
	ElseIf ((a_page == Pages[5] && snusnuMain.selectedBody != 2) || (a_page == Pages[2] && snusnuMain.selectedBody == 2))
		Int currentFlag = OPTION_FLAG_NONE
		If editFMGMorphs
			currentFlag = OPTION_FLAG_DISABLED
		EndIf
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		_mySaveOptions = AddToggleOption("Save Settings", False, currentFlag)
		_myLoadOptions = AddToggleOption("Load Settings", False, currentFlag)
		AddEmptyOption()
		;AddEmptyOption()
		_mySaveMorphs = AddToggleOption("Save Morphs", False, currentFlag)
		_myLoadMorphs = AddToggleOption("Load Morphs", False, currentFlag)
		SetCursorPosition(1)
		_mySaveMorphsProfile = AddInputOption("Save Morphs Profile", "Default")
		
		If LoadSavedProfiles()
			_myLoadMorphsProfile = AddMenuOption("Load Morphs Profile", savedProfilesList[0])
		Else
			_myLoadMorphsProfile = AddMenuOption("Load Morphs Profile", "EMPTY", OPTION_FLAG_DISABLED)
		EndIf
	ElseIf ((a_page == Pages[6] && snusnuMain.selectedBody != 2) || (a_page == Pages[3] && snusnuMain.selectedBody == 2))
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("Mod Version: " + snusnuMain.GetVersion())
		AddEmptyOption()
		
		;SKSE
		AddHeaderOption("SKSE: " + GetSKSEVersion())
		If (CheckSKSEVersion(2, 0, 7) >= 0)
			AddToggleOption("$SNUSNU_VERSION_PASS", True, OPTION_FLAG_DISABLED)
		Else
			AddToggleOption("$SNUSNU_VERSION_FAIL", False, OPTION_FLAG_DISABLED)
		EndIf
		
		;NiOverride
		AddHeaderOption("NiOverride Script: " + NiOverride.GetScriptVersion())
		If (NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION)
			AddToggleOption("$SNUSNU_VERSION_PASS", True, OPTION_FLAG_DISABLED)
		Else
			AddToggleOption("$SNUSNU_VERSION_FAIL", False, OPTION_FLAG_DISABLED)
		EndIf
		AddHeaderOption("SKEE Plugin: " + SKSE.GetPluginVersion("skee"))
		If (SKSE.GetPluginVersion("skee") >= SKEE_VERSION)
			AddToggleOption("$SNUSNU_VERSION_PASS", True, OPTION_FLAG_DISABLED)
		Else
			AddToggleOption("$SNUSNU_VERSION_FAIL", False, OPTION_FLAG_DISABLED)
		EndIf
		
		AddEmptyOption()
		AddEmptyOption()
		snusnuMain.tempDebugSliders()
		AddToggleOption("Dumping sliders info into log file", True, OPTION_FLAG_DISABLED)
		_myFoceScore = AddSliderOption("Set muscle score", snusnuMain.muscleScore, "{3}")
		
		AddEmptyOption()
		AddEmptyOption()
		AddHeaderOption("NPCs with muscle:")
		AddEmptyOption()
		SetCursorFillMode(TOP_TO_BOTTOM)
		Int totalNPCs = FormListCount(none, "MUSCLE_NPCS")
		Int npcsLoop = 0
		while npcsLoop < totalNPCs
			Actor currentActor = FormListGet(none, "MUSCLE_NPCS", npcsLoop) as Actor
			Float muscleScoreNPC = GetFloatValue(currentActor, "hasMuscle", 0) * 100
			AddSliderOption(currentActor.GetBaseObject().getName(), muscleScoreNPC, "{0}%", OPTION_FLAG_DISABLED)
			npcsLoop += 1
		endWhile
	EndIf
EndEvent

Event OnOptionHighlight(Int a_option)
	If a_option == _myEnabled
		SetInfoText("Enables/disables the mod and its registered events.")
	ElseIf a_option == _myHardcoreMode
		SetInfoText("Toggles hardcore mode on or off.")
	ElseIf a_option == _myStamina
		SetInfoText("How much stamina gets boosted by muscle gain.")
	ElseIf a_option == _mySpeed
		SetInfoText("How much the movement speed gets boosted by muscle gain.")
	ElseIf a_option == _myCombatProficiency
		SetInfoText("How much combat related skills (One Handed, Two Handed, Archery and Blocking) get boosted by muscle gain. Boost will start at half of max muscle score. Below that it will affect the skills negatively")
	ElseIf a_option == _myMaxWeight
		SetInfoText("Maximum muscle score that can be reached.")
	ElseIf a_option == _myFightingScore
		SetInfoText("Current muscular score")
	ElseIf a_option == _myStoredScore
		SetInfoText("Stored muscular score to be regained during sleep")
	ElseIf a_option == _myMultGainFight
		SetInfoText("Multiplier for how much muscle is gained by combat actions (weapon swinging and power attacks). 2 means you will get twice as much, while 0.5 will give you only half of default value")
	ElseIf a_option == _myMultGainArmor
		SetInfoText("Multiplier for how much extra muscle is gained by using heavy armor. 2 means you will get twice as much, while 0.5 will give you only half of default value")
	ElseIf a_option == _myMultGainMisc
		SetInfoText("Multiplier for how much muscle is gained by other miscellaneous actions (Swimming, Wood chopping and Mining). 2 means you will get twice as much, while 0.5 will give you only half of default value")
	ElseIf a_option == _myMultGainWufwuf
		SetInfoText("Multiplier for how much muscle is gained by transforming into a Werewolf. Value is a percent for maximum muscle score.")
	ElseIf a_option == _myVampGains
		SetInfoText("Multiplier for how much muscle is gained by feeding blood as a vampire. Consuming blood potions will not grant any gains though. Setting it to cero will disable this feature and muscle gains will work the same for vampires.")
	ElseIf a_option == _myBoostCarryWeight
		SetInfoText("Maximum carry weight boost by getting more muscular. It will change depending on Muscle Score.")
	ElseIf a_option == _mytfAnimation
		SetInfoText("$SNUSNU_USETFANIM_DESC")
	ElseIf a_option == _mytfAnimationNPC
		SetInfoText("$SNUSNU_USETFANIMNPC_DESC")
	ElseIf a_option == _myuseAltAnims
		SetInfoText("$SNUSNU_USEALTANIMS_DESC")
	ElseIf a_option == _myuseAltAnimsNPC
		SetInfoText("$SNUSNU_USEALTANIMSNPC_DESC")
	ElseIf a_option == _myApplyMoreChanges
		SetInfoText("Apply gradual changes during FMG transformation. Muscle mass will start at 50% and it will grow in increments of 25% until it reaches 100%. Darker skin textures will also be applied every time a new increment is reached.")
	ElseIf a_option == _myDynamicChanges
		SetInfoText("Use dynamic calculations for gradual changes. Gradual changes will be applied only if spell duration is longh enough. If it's not, then apply the full transformation since the begining.")
	ElseIf a_option == _myChangesInterval
		SetInfoText("How much to wait for the next change increment to be applied, in in-game days.")
	ElseIf a_option == _myChangesIncrements
		SetInfoText("How much muscles will grow with each change interval. Changes go in two stages, so if you choose 0.25 then the initial FMG muscle will be at 50%, then the first change stage will be to 75% and the final stage will always be to 100%")
	ElseIf a_option == _myCustomizeFMG
		SetInfoText("Toggle FMG morphs customization.")
	ElseIf a_option == _myUseAltBody
		SetInfoText("Use a different body mesh for FMG transformation instead of body morphs. A proper body mesh and textures need to be added to their respective folders.")
	ElseIf a_option == _myRemoveWeightMorphs
		SetInfoText("$SNUSNU_NOWEIGHTMORPHS_DESC")
	ElseIf a_option == _myUseWeightSlider
		SetInfoText("$SNUSNU_USEWEIGHTSLIDER_DESC")
	ElseIf a_option == _myDisableNormals
		SetInfoText("$SNUSNU_DISABLENORMALS_DESC")
	ElseIf a_option == _myDynamicPhysics
		SetInfoText("Change breasts physics depending on muscle score (CBPC needed). This will reduce breast bounciness to simulate muscular \"firmness\".")
;	ElseIf a_option == _mySelectedBody
;		SetInfoText("$SNUSNU_SELECTEDBODY_DESC")
	ElseIf a_option == _myZeroSliders
		SetInfoText("Set all slider values to 0.0")
	ElseIf a_option == _myApplyDefault
		SetInfoText("Apply recommended default morph values")
	ElseIf a_option == _myFoceScore
		SetInfoText("Force muscle score value. Only for debug purposes!!")
	ElseIf a_option == _myNPCMuscleScore
		SetInfoText("How much FMG muscle to apply to NPCs")
	ElseIf a_option == _myMalnourishment
		SetInfoText("At which WeightMorphs weigh value would the character be considered malnourished. Being malnourished greately reduces the muscle gain rate.")
	ElseIf a_option == _myPushupException
		SetInfoText("Add current equiped gear to push-up exceptions list.")
	ElseIf a_option == _myChangeAnims
		SetInfoText("Change to more muscular animations on high muscle score.")
	ElseIf a_option == _myUseDARAnims
		SetInfoText("Use DAR instead of FNIS/Nemesis for animations")
	ElseIf a_option == _myMuscleAnimsLevel
		SetInfoText("Muscular level at which to apply muscular animations (0=Civilian, 1=Athletic, 2=Muscular, 3=Very Muscular)")
	
	;LOAD AND SAVE
	ElseIf a_option == _mySaveOptions
		SetInfoText("Save settings to an external file.")
	ElseIf a_option == _myLoadOptions
		SetInfoText("Load settings from an external file.")
	ElseIf a_option == _mySaveMorphs
		SetInfoText("Save all morphs to an external file.")
	ElseIf a_option == _myLoadMorphs
		SetInfoText("Load all morphs to an external file.")
	ElseIf a_option == _mySaveMorphsProfile
		SetInfoText("Save morphs to an specific profile file.")
	ElseIf a_option == _myLoadMorphsProfile
		SetInfoText("Load morphs from an specific profile file.")
	EndIf
EndEvent

Event OnOptionSelect(Int a_option)
	If a_option == _myEnabled
		snusnuMain.Enabled = !snusnuMain.Enabled
		applyEnabledOption(true)
	ElseIf a_option == _myHardcoreMode
		snusnuMain.hardcoreMode = !snusnuMain.hardcoreMode
		applyHardcoreOption()
	ElseIf a_option == _mytfAnimation
		snusnuMain.tfAnimation = !snusnuMain.tfAnimation
		SetToggleOptionValue(a_option, snusnuMain.tfAnimation)
	ElseIf a_option == _mytfAnimationNPC
		snusnuMain.tfAnimationNPC = !snusnuMain.tfAnimationNPC
		SetToggleOptionValue(a_option, snusnuMain.tfAnimationNPC)
	ElseIf a_option == _myuseAltAnims
		snusnuMain.useAltAnims = !snusnuMain.useAltAnims
		SetToggleOptionValue(a_option, snusnuMain.useAltAnims)
	ElseIf a_option == _myuseAltAnimsNPC
		snusnuMain.useAltAnimsNPC = !snusnuMain.useAltAnimsNPC
		SetToggleOptionValue(a_option, snusnuMain.useAltAnimsNPC)
	ElseIf a_option == _mychangeHeadPart
		snusnuMain.changeHeadPart = !snusnuMain.changeHeadPart
		SetToggleOptionValue(a_option, snusnuMain.changeHeadPart)
	ElseIf a_option == _myplayTFSound
		snusnuMain.playTFSound = !snusnuMain.playTFSound
		SetToggleOptionValue(a_option, snusnuMain.playTFSound)
	ElseIf a_option == _myApplyMoreChanges
		snusnuMain.applyMoreChangesOvertime = !snusnuMain.applyMoreChangesOvertime
		SetToggleOptionValue(a_option, snusnuMain.applyMoreChangesOvertime)
	ElseIf a_option == _myDynamicChanges
		snusnuMain.dynamicChangesCalculation = !snusnuMain.dynamicChangesCalculation
		SetToggleOptionValue(a_option, snusnuMain.dynamicChangesCalculation)
	ElseIf a_option == _myUseAltBody
		snusnuMain.useAltBody = !snusnuMain.useAltBody
		SetToggleOptionValue(a_option, snusnuMain.useAltBody)
		
		If snusnuMain.useAltBody
			snusnuMain.changeHeadPart = false
			snusnuMain.applyMoreChangesOvertime = false
			snusnuMain.dynamicChangesCalculation = false
			
			Self.SetOptionFlags(_myCustomizeFMG, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_mychangeHeadPart, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myApplyMoreChanges, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myChangesInterval, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myChangesIncrements, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myDynamicChanges, Self.OPTION_FLAG_DISABLED, True)
		Else
			Self.SetOptionFlags(_myCustomizeFMG, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_mychangeHeadPart, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myApplyMoreChanges, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myChangesInterval, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myChangesIncrements, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myDynamicChanges, Self.OPTION_FLAG_NONE, True)
		EndIf
		
		ForcePageReset()
	ElseIf a_option == _myCustomizeFMG
		editFMGMorphs = !editFMGMorphs
		SetToggleOptionValue(a_option, editFMGMorphs)
		
		String Msg
		If editFMGMorphs
			If !snusnuMain.isTransforming
				Msg = "All morph changes you do while this option is selected will only affect the FMG body shape. To go back to normal muscle morphs just disable this option."
				ShowMessage(Msg, False)
				
				;Load FMG morphs profile here. All changes to the morphs must be saved after this
				;option is disabled or user exits this menu.
				;NOTICE! Previous morphs should be saved to a temporal profile file!
				snusnuMain.UpdateWeight() ;Fix for bone morphs
				String loadErrorMsg = switchFMGMorphs(True)
				If loadErrorMsg
					ShowMessage(loadErrorMsg, false)
				EndIf
			Else
				Msg = "You can not edit the FMG morphs while a FMG transformation is currently ongoing!"
				ShowMessage(Msg, False)
				editFMGMorphs = !editFMGMorphs
				SetToggleOptionValue(a_option, editFMGMorphs)
			EndIf
		Else
			Msg = "Going back to normal muscle morphs customization"
			ShowMessage(Msg, False)
			
			;Save morphs to a FMG profile file and load the previous morphs
			String loadErrorMsg = switchFMGMorphs(False)
			If loadErrorMsg
				ShowMessage(loadErrorMsg, false)
			EndIf
			
			;Update body if PC is currently transformed
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) != 0
				StorageUtil.SetIntValue(PlayerRef, "SNU_UltraMuscle", 12)
				snusnuMain.RegisterForSingleUpdate(1)
			EndIf
		EndIf
		
		OpenConfig()
		setPage(Pages[0], 0)
	ElseIf a_option == _myRemoveWeightMorphs
		snusnuMain.removeWeightMorphs = !snusnuMain.removeWeightMorphs
		SetToggleOptionValue(a_option, snusnuMain.removeWeightMorphs)
	ElseIf a_option == _myUseWeightSlider
		snusnuMain.useWeightSlider = !snusnuMain.useWeightSlider
		SetToggleOptionValue(a_option, snusnuMain.useWeightSlider)
	ElseIf a_option == _myDisableNormals
		snusnuMain.disableNormals = !snusnuMain.disableNormals
		applyNormalsOption()
	ElseIf a_option == _myDynamicPhysics
		snusnuMain.useDynamicPhysics = !snusnuMain.useDynamicPhysics
		applyDynamicPhysicsOption()
	ElseIf a_option == _myZeroSliders
		snusnuMain.ClearMorphs()
		SetToggleOptionValue(a_option, true)
		
		String Msg
		Msg = "All body sliders have been set to 0.0"
		ShowMessage(Msg, False)
	ElseIf a_option == _myApplyDefault
		snusnuMain.initDefaultSliders()
		SetToggleOptionValue(a_option, true)
		
		String Msg
		Msg = "All body sliders have been set to their initial default values"
		ShowMessage(Msg, False)
	ElseIf a_option == _myPushupException
		Armor mainArmor = PlayerRef.GetWornForm(0x00000004) as Armor
		If mainArmor
			String Msg
			If snusnuMain.PushupExceptions.find(mainArmor) != -1
				snusnuMain.PushupExceptions.RemoveAddedForm(mainArmor)
				Msg = "Item "+mainArmor.getName()+" has been removed from the push-up exceptions list."
			Else
				snusnuMain.PushupExceptions.AddForm(mainArmor)
				Msg = "Item "+mainArmor.getName()+" has been added to the push-up exceptions list."
			EndIf
			ShowMessage(Msg, False)
		EndIf
	ElseIf a_option == _myChangeAnims
		snusnuMain.useMuscleAnims = !snusnuMain.useMuscleAnims
		applyChangeAnimsOption()
	ElseIf a_option == _myUseDARAnims
		snusnuMain.useDARAnims = !snusnuMain.useDARAnims
		applyDARAnimsOption()
		
	;SAVE AND LOAD
	ElseIf a_option == _mySaveOptions
		bool allowSave = true
		
		if JsonUtil.JsonExists("SnusnuSettings")
			if !ShowMessage("WARNING: Saved user settings already present. Do you want to override them?", true)
				allowSave = false
			endIf
		endIf
		
		if allowSave
			Self.SetOptionFlags(_mySaveOptions, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myLoadOptions, Self.OPTION_FLAG_DISABLED, True)
			
			Self.SetOptionFlags(_mySaveMorphs, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myLoadMorphs, Self.OPTION_FLAG_DISABLED, True)
			
			Self.SetOptionFlags(_mySaveMorphsProfile, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myLoadMorphsProfile, Self.OPTION_FLAG_DISABLED, True)
			if saveSettings(); && savePushupExceptions()
				ShowMessage("Settings have been saved successfully", false)
				ForcePageReset()
			else
				ShowMessage("ERROR: settings could not be saved properly", false)
			endIf
			Self.SetOptionFlags(_mySaveOptions, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myLoadOptions, Self.OPTION_FLAG_NONE, True)
			
			Self.SetOptionFlags(_mySaveMorphs, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myLoadMorphs, Self.OPTION_FLAG_NONE, True)
			
			Self.SetOptionFlags(_mySaveMorphsProfile, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myLoadMorphsProfile, Self.OPTION_FLAG_NONE, True)
		endIf
	ElseIf a_option == _myLoadOptions
		if ShowMessage("Do you want to load previously saved settings?\n\nWARNING: All your current settings will be overriden.", true)
			Self.SetOptionFlags(_mySaveOptions, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myLoadOptions, Self.OPTION_FLAG_DISABLED, True)
			
			Self.SetOptionFlags(_mySaveMorphs, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myLoadMorphs, Self.OPTION_FLAG_DISABLED, True)
			
			Self.SetOptionFlags(_mySaveMorphsProfile, Self.OPTION_FLAG_DISABLED, True)
			Self.SetOptionFlags(_myLoadMorphsProfile, Self.OPTION_FLAG_DISABLED, True)
			
			
			if loadSettings()
				ShowMessage("All settings have been loaded successfully", false)
				ForcePageReset()
			else
				ShowMessage("ERROR: settings could not be loaded", false)
			endIf
			Self.SetOptionFlags(_mySaveOptions, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myLoadOptions, Self.OPTION_FLAG_NONE, True)
			
			Self.SetOptionFlags(_mySaveMorphs, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myLoadMorphs, Self.OPTION_FLAG_NONE, True)
			
			Self.SetOptionFlags(_mySaveMorphsProfile, Self.OPTION_FLAG_NONE, True)
			Self.SetOptionFlags(_myLoadMorphsProfile, Self.OPTION_FLAG_NONE, True)
		endIf
	ElseIf a_option == _mySaveMorphs
		applySaveMorphs()
	ElseIf a_option == _myLoadMorphs
		applyLoadMorphs()
	EndIf
EndEvent

Event OnOptionSliderOpen(Int a_option)
	If a_option == _myMultLoss
		SetSliderDialogStartValue(snusnuMain.MultLoss)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.05)
	ElseIf a_option == _myMultGainFight
		SetSliderDialogStartValue(snusnuMain.MultGainFight)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.05)
	ElseIf a_option == _myMultGainArmor
		SetSliderDialogStartValue(snusnuMain.MultGainArmor)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.05)
	ElseIf a_option == _myMultGainMisc
		SetSliderDialogStartValue(snusnuMain.MultGainMisc)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.05)
	ElseIf a_option == _myMultGainWufwuf
		SetSliderDialogStartValue(snusnuMain.addWerewolfStrength*100)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(1.0)
	ElseIf a_option == _myVampGains
		SetSliderDialogStartValue(snusnuMain.addVampireStrength*100)
		SetSliderDialogDefaultValue(12.5)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(0.5)
	ElseIf a_option == _myBoostCarryWeight
		SetSliderDialogStartValue(snusnuMain.carryWeightBoost)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(10.0)
	ElseIf a_option == _myStamina
		SetSliderDialogStartValue(snusnuMain.Stamina)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-500.0, 500.0)
		SetSliderDialogInterval(5.0)
	ElseIf a_option == _mySpeed
		SetSliderDialogStartValue(snusnuMain.Speed)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-80.0, 80.0)
		SetSliderDialogInterval(5.0)
	ElseIf a_option == _myCombatProficiency
		SetSliderDialogStartValue(snusnuMain.combatProficiency)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(5.0)
	ElseIf a_option == _myMaxWeight
		SetSliderDialogStartValue(snusnuMain.muscleScoreMax)
		SetSliderDialogDefaultValue(1000.0)
		SetSliderDialogRange(100.0, 10000.0)
		SetSliderDialogInterval(20.0)
	ElseIf a_option == _myFoceScore
		SetSliderDialogStartValue(snusnuMain.muscleScore)
		SetSliderDialogDefaultValue(snusnuMain.muscleScoreMax/2)
		SetSliderDialogRange(0.0, snusnuMain.muscleScoreMax)
		SetSliderDialogInterval(10.0)
	ElseIf a_option == _myNPCMuscleScore
		SetSliderDialogStartValue(snusnuMain.npcMuscleScore*100)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ElseIf a_option == _myMalnourishment
		SetSliderDialogStartValue(snusnuMain.malnourishmentValue)
		SetSliderDialogDefaultValue(-0.9)
		SetSliderDialogRange(-1.0, 0.0)
		SetSliderDialogInterval(0.02)
	ElseIf a_option == _myChangesInterval
		SetSliderDialogStartValue(snusnuMain.moreChangesInterval)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.1, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myChangesIncrements
		SetSliderDialogStartValue(snusnuMain.moreChangesIncrements)
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.05, 0.45)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMuscleAnimsLevel
		SetSliderDialogStartValue(snusnuMain.muscleAnimsLevel.getValue())
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 4.0)
		SetSliderDialogInterval(1.0)
	
	;MALE SLIDERS - UNUSED FOR NOW
	ElseIf a_option == _myMultSamuel
		SetSliderDialogStartValue(snusnuMain.maleValues[0])
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultSamson
		SetSliderDialogStartValue(snusnuMain.maleValues[1])
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
			
	ElseIf a_option == _myMultSpineBone
		SetSliderDialogStartValue(snusnuMain.bonesValues[0])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 2.0)
		SetSliderDialogInterval(0.001)
	ElseIf a_option == _myMultForearmBone
		SetSliderDialogStartValue(snusnuMain.bonesValues[1])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 2.0)
		SetSliderDialogInterval(0.001)
		
	Else 
		bool found=false
		int counter = 0
		;CBBE SLIDERS
		while(counter < 52 && !found)
			if a_option == cbbeSliders[counter]
				SetSliderDialogStartValue(snusnuMain.cbbeValues[counter])
				SetSliderDialogDefaultValue(0.0)
				SetSliderDialogRange(-2.0, 2.0)
				SetSliderDialogInterval(0.01)
				;Debug.Trace("SNU - Changing value for slider: "+cbbeStrings[counter])
				found = true
			endIf
			counter += 1
		endWhile
		if !found
			counter = 0
			;UUNP SLIDERS
			while(counter < 74 && !found)
				if a_option == uunpSliders[counter]
					SetSliderDialogStartValue(snusnuMain.uunpValues[counter])
					SetSliderDialogDefaultValue(0.0)
					SetSliderDialogRange(-2.0, 2.0)
					SetSliderDialogInterval(0.01)
					found = true
				endIf
				counter += 1
			endWhile
		endIf
		if !found
			counter = 0
			;BHUNP SLIDERS
			while(counter < 43 && !found)
				if a_option == bhunpSliders[counter]
					SetSliderDialogStartValue(snusnuMain.bhunpValues[counter])
					SetSliderDialogDefaultValue(0.0)
					SetSliderDialogRange(-2.0, 2.0)
					SetSliderDialogInterval(0.01)
					found = true
				endIf
				counter += 1
			endWhile
		endIf
		if !found
			counter = 0
			;CBBE SE SLIDERS
			while(counter < 27 && !found)
				if a_option == cbbeSESliders[counter]
					SetSliderDialogStartValue(snusnuMain.cbbeSEValues[counter])
					SetSliderDialogDefaultValue(0.0)
					SetSliderDialogRange(-2.0, 2.0)
					SetSliderDialogInterval(0.01)
					found = true
				endIf
				counter += 1
			endWhile
		endIf
		if !found
			counter = 0
			;CBBE 3BA SLIDERS
			while(counter < 40 && !found)
				if a_option == cbbe3BASliders[counter]
					SetSliderDialogStartValue(snusnuMain.cbbe3BAValues[counter])
					SetSliderDialogDefaultValue(0.0)
					SetSliderDialogRange(-2.0, 2.0)
					SetSliderDialogInterval(0.01)
					found = true
				endIf
				counter += 1
			endWhile
		endIf
		if !found
			counter = 0
			;BONE SLIDERS
			while(counter < snusnuMain.totalCurrentBones && !found)
				if a_option == boneSliders[counter]
					SetSliderDialogStartValue(snusnuMain.bonesValues[counter])
					SetSliderDialogDefaultValue(1.0)
					SetSliderDialogRange(0.01, 2.0)
					SetSliderDialogInterval(0.005)
					found = true
				endIf
				counter += 1
			endWhile
		endIf
	EndIf
EndEvent

Event OnOptionSliderAccept(Int a_option, Float a_value)
	If a_option == _myMultLoss
		snusnuMain.MultLoss = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultLoss, "{2}")
	ElseIf a_option == _myMultGainFight
		snusnuMain.MultGainFight = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultGainFight, "{2}")
	ElseIf a_option == _myMultGainArmor
		snusnuMain.MultGainArmor = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultGainArmor, "{2}")
	ElseIf a_option == _myMultGainMisc
		snusnuMain.MultGainMisc = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultGainMisc, "{2}")
	ElseIf a_option == _myMultGainWufwuf
		snusnuMain.addWerewolfStrength = a_value/100
		SetSliderOptionValue(a_option, a_value, "{0}%")
	ElseIf a_option == _myVampGains
		snusnuMain.addVampireStrength = a_value/100
		SetSliderOptionValue(a_option, a_value, "{1}%")
	ElseIf a_option == _myBoostCarryWeight
		If snusnuMain.carryWeightBoost != a_value
			applyCarryWeightValue(a_value)
		EndIf
	ElseIf a_option == _myStamina
		applyStaminaValue(a_value)
	ElseIf a_option == _mySpeed
		applySpeedValue(a_value)
	ElseIf a_option == _myCombatProficiency
		applyProficiencyValue(a_value)
	ElseIf a_option == _myMaxWeight
		applymuscleScoreMaxValue(a_value)
	ElseIf a_option == _myFoceScore
		snusnuMain.ForceNewWeight(a_value)
		SetSliderOptionValue(a_option, a_value, "{3}")
	ElseIf a_option == _myNPCMuscleScore
		applyNPCMuscleValue(a_value/100)
		SetSliderOptionValue(_myNPCMuscleScore, a_value, "{0}%")
	ElseIf a_option == _myMalnourishment	
		snusnuMain.malnourishmentValue = a_value
		SetSliderOptionValue(a_option, snusnuMain.malnourishmentValue, "{2}")
	ElseIf a_option == _myChangesInterval	
		snusnuMain.moreChangesInterval = a_value
		SetSliderOptionValue(a_option, snusnuMain.moreChangesInterval, "{2}")
	ElseIf a_option == _myChangesIncrements
		snusnuMain.moreChangesIncrements = a_value
		SetSliderOptionValue(a_option, snusnuMain.moreChangesIncrements, "{2}")
	ElseIf a_option == _myMuscleAnimsLevel
		applyMuscleAnimsLevelValue(a_value)
		
	;MALE SLIDERS - UNUSED FOR NOW
	ElseIf a_option == _myMultSamuel
		snusnuMain.maleValues[0] = a_value
		SetSliderOptionValue(a_option, snusnuMain.maleValues[0], "{2}")
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultSamson
		snusnuMain.maleValues[1] = a_value
		SetSliderOptionValue(a_option, snusnuMain.maleValues[1], "{2}")
		snusnuMain.UpdateWeight()
		
	;GENERIC BONES MORPHS
	ElseIf a_option == _myMultSpineBone
		snusnuMain.bonesValues[0] = a_value
		SetSliderOptionValue(a_option, snusnuMain.bonesValues[0], "{3}")
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultForearmBone
		snusnuMain.bonesValues[1] = a_value
		SetSliderOptionValue(a_option, snusnuMain.bonesValues[1], "{3}")
		snusnuMain.UpdateWeight()
		
	Else
		int sliderIndex = 0
		
		bool found=false
		int counter = 0
		
		;CBBE SLIDERS
		while(counter < 52 && !found)
			If a_option == cbbeSliders[counter]
				SetSliderOptionValue(a_option, a_value, "{2}")
				;ForcePageReset()
				snusnuMain.setSliderValue(sliderIndex, a_value)
				found = true
			EndIf
			counter += 1
			sliderIndex += 1
		endWhile
		if !found
			counter = 0
			;UUNP SLIDERS
			while(counter < 74 && !found)
				If a_option == uunpSliders[counter]
					SetSliderOptionValue(a_option, a_value, "{2}")
					;ForcePageReset()
					snusnuMain.setSliderValue(sliderIndex, a_value)
					found = true
				EndIf
				counter += 1
				sliderIndex += 1
			endWhile
		EndIf
		if !found
			counter = 0
			;BHUNP SLIDERS
			while(counter < 43 && !found)
				If a_option == bhunpSliders[counter]
					SetSliderOptionValue(a_option, a_value, "{2}")
					;ForcePageReset()
					snusnuMain.setSliderValue(sliderIndex, a_value)
					found = true
				EndIf
				counter += 1
				sliderIndex += 1
			endWhile
		EndIf
		if !found
			counter = 0
			;CBBE SE SLIDERS
			while(counter < 27 && !found)
				If a_option == cbbeSESliders[counter]
					SetSliderOptionValue(a_option, a_value, "{2}")
					;ForcePageReset()
					snusnuMain.setSliderValue(sliderIndex, a_value)
					found = true
				EndIf
				counter += 1
				sliderIndex += 1
			endWhile
		EndIf
		if !found
			counter = 0
			;CBBE 3BA SLIDERS
			while(counter < 40 && !found)
				If a_option == cbbe3BASliders[counter]
					SetSliderOptionValue(a_option, a_value, "{2}")
					;ForcePageReset()
					snusnuMain.setSliderValue(sliderIndex, a_value)
					found = true
				EndIf
				counter += 1
				sliderIndex += 1
			endWhile
		EndIf
		if !found
			counter = 0
			;BONE SLIDERS
			while(counter < snusnuMain.totalCurrentBones && !found)
				If a_option == boneSliders[counter]
					SetSliderOptionValue(a_option, a_value, "{3}")
					;ForcePageReset()
					snusnuMain.bonesValues[counter] = a_value
					found = true
				EndIf
				counter += 1
				sliderIndex += 1
			endWhile
		EndIf	
	EndIf
EndEvent

Event OnKeyMapChangeST(Int KeyCode, String ConflictControl, String ConflictName)
	String Option = GetState()
	If Option == "SnusnuDumpInfo"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			snusnuMain.getInfoKey = KeyCode
			SetKeyMapOptionValueST(snusnuMain.getInfoKey)
		EndIf
	ElseIf Option == "SnusnuNPCMuscle"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			snusnuMain.npcMuscleKey = KeyCode
			SetKeyMapOptionValueST(snusnuMain.npcMuscleKey)
		EndIf
	EndIf
	snusnuMain.ReloadHotkeys()
EndEvent

Bool Function KeyConflict(Int KeyCode, String ConflictControl, String ConflictName)
	Bool Continue = True
	If ConflictControl != ""
		String Msg
		If ConflictName != ""
			Msg = "This key is already mapped to: \n'" + ConflictControl + "'\n(" + ConflictName + ")\n\nAre you sure you want to continue?"
		Else
			Msg = "This key is already mapped to: \n'" + ConflictControl + "'\n\nAre you sure you want to continue?"
		EndIf
		Continue = ShowMessage(Msg, True, "$Yes", "$No")
	EndIf
	Return !Continue
EndFunction


String Function GetSKSEVersion()
	Return SKSE.GetVersion() as String + "." + SKSE.GetVersionMinor() as String  + "." + SKSE.GetVersionBeta() as String
EndFunction

Int Function CheckSKSEVersion(Int major, Int minor, Int beta)
	Int skseMajor = SKSE.GetVersion()
	Int skseMinor = SKSE.GetVersionMinor()
	Int skseBeta  = SKSE.GetVersionBeta()

	If skseMajor == major
		If skseMinor == minor
			If skseBeta == beta
				Return 0
			ElseIf skseBeta > beta
				Return 1
			Else
				Return -1
			EndIf
		ElseIf skseMinor > minor
			Return 1
		Else
			Return -1
		EndIf
	ElseIf skseMajor > major
		Return 1
	Else
		Return -1
	EndIf
EndFunction

String Function GetConditionalString(Int Cond)
	If Cond == 0
		Return "UUNP/BHUNP Body"
	ElseIf Cond == 1
		Return "CBBE Body"
	ElseIf Cond == 2
		Return "CBBE 3BA Body"
	ElseIf Cond == 3
		Return "Vanilla"
	EndIf
	Return ""
EndFunction

String Function GetDefaultMorphString(Int Cond)
	If Cond == 1
		Return "UUNP Morphs"
	ElseIf Cond == 2
		Return "CBBE SE Morphs"
	ElseIf Cond == 3
		Return "CBBE SE Pecs Morphs"
	EndIf
	Return ""
EndFunction

String Function sliderHasValue(Float sliderVal)
	If sliderVal != 0.0
		Return "*"
	Else
		Return ""
	EndIf
EndFunction

String Function boneSliderHasValue(Float sliderVal)
	If sliderVal != 1.0
		Return "*"
	Else
		Return ""
	EndIf
EndFunction

Function initPageNames()
	pageNames = new String[10]
	
	pageNames[0] = "Main Options"
	pageNames[1] = "Save & Load"
	pageNames[2] = "Info"
	pageNames[3] = "UUNP/BHUNP Morphs 1"
	pageNames[4] = "UUNP/BHUNP Morphs 2"
	pageNames[5] = "Extra BHUNP Morphs"
	pageNames[6] = "CBBE Morphs Page 1"
	pageNames[7] = "CBBE Morphs Page 2"
	pageNames[8] = "CBBE Special Morphs"
	pageNames[9] = "Unisex Bones"
EndFunction

Function initStringArrays()
	cbbeStrings[0] = "Breasts"
	cbbeStrings[1] = "BreastsSmall"
	cbbeStrings[2] = "BreastsSH"
	cbbeStrings[3] = "BreastsSSH"
	cbbeStrings[4] = "BreastsFantasy"
	cbbeStrings[5] = "DoubleMelon"
	cbbeStrings[6] = "BreastCleavage"
	cbbeStrings[7] = "BreastFlatness"
	cbbeStrings[8] = "BreastGravity"
	cbbeStrings[9] = "PushUp"
	cbbeStrings[10] = "BreastHeight"
	cbbeStrings[11] = "BreastPerkiness"
	cbbeStrings[12] = "BreastWidth"
	cbbeStrings[13] = "NippleDistance"
	cbbeStrings[14] = "NipplePerkiness"
	cbbeStrings[15] = "NippleLength"
	cbbeStrings[16] = "NippleSize"
	cbbeStrings[17] = "NippleAreola"
	cbbeStrings[18] = "NippleUp"
	cbbeStrings[19] = "NippleDown"
	cbbeStrings[20] = "NippleTip"
	cbbeStrings[21] = "Arms"
	cbbeStrings[22] = "ChubbyArms"
	cbbeStrings[23] = "ShoulderSmooth"
	cbbeStrings[24] = "ShoulderWidth"
	cbbeStrings[25] = "Belly"
	cbbeStrings[26] = "BigBelly"
	cbbeStrings[27] = "PregnancyBelly"
	cbbeStrings[28] = "TummyTuck"
	cbbeStrings[29] = "BigTorso"
	cbbeStrings[30] = "Waist"
	cbbeStrings[31] = "WideWaistLine"
	cbbeStrings[32] = "ChubbyWaist"
	cbbeStrings[33] = "Back"
	cbbeStrings[34] = "ButtCrack"
	cbbeStrings[35] = "Butt"
	cbbeStrings[36] = "ButtSmall"
	cbbeStrings[37] = "ButtShape2"
	cbbeStrings[38] = "BigButt"
	cbbeStrings[39] = "ChubbyButt"
	cbbeStrings[40] = "AppleCheeks"
	cbbeStrings[41] = "RoundAss"
	cbbeStrings[42] = "Groin"
	cbbeStrings[43] = "Hipbone"
	cbbeStrings[44] = "Hips"
	cbbeStrings[45] = "SlimThighs"
	cbbeStrings[46] = "Thighs"
	cbbeStrings[47] = "ChubbyLegs"
	cbbeStrings[48] = "Legs"
	cbbeStrings[49] = "KneeHeight"
	cbbeStrings[50] = "CalfSize"
	cbbeStrings[51] = "CalfSmooth"
	
	uunpStrings[0] = "7B Low"
	uunpStrings[1] = "7B High"
	uunpStrings[2] = "7B Bombshell Low"
	uunpStrings[3] = "7B Bombshell High"
	uunpStrings[4] = "7B Natural Low"
	uunpStrings[5] = "7B Natural High"
	uunpStrings[6] = "7B Cleavage Low"
	uunpStrings[7] = "7B Cleavage High"
	uunpStrings[8] = "7B BCup Low"
	uunpStrings[9] = "7B BCup High"
	uunpStrings[10] = "7BUNP Low"
	uunpStrings[11] = "7BUNP High"
	uunpStrings[12] = "7B CH Low"
	uunpStrings[13] = "7B CH High"
	uunpStrings[14] = "7B Oppai Low"
	uunpStrings[15] = "7B Oppai High"
	uunpStrings[16] = "UNP Low"
	uunpStrings[17] = "UNP High"
	uunpStrings[18] = "UNP Pushup Low"
	uunpStrings[19] = "UNP Pushup High"
	uunpStrings[20] = "UNP Skinny Low"
	uunpStrings[21] = "UNP Skinny High"
	uunpStrings[22] = "UNP Perky Low"
	uunpStrings[23] = "UNP Perky High"
	uunpStrings[24] = "UNPB Low"
	uunpStrings[25] = "UNPB High"
	uunpStrings[26] = "UNPB Chapi"
	uunpStrings[27] = "UNPB Oppai v1"
	uunpStrings[28] = "UNPB Oppai v3.2 Low"
	uunpStrings[29] = "UNPB Oppai v3.2 High"
	uunpStrings[30] = "UNPetite Low"
	uunpStrings[31] = "UNPetite High"
	uunpStrings[32] = "UNPC Low"
	uunpStrings[33] = "UNPC High"
	uunpStrings[34] = "UNPCM Low"
	uunpStrings[35] = "UNPCM High"
	uunpStrings[36] = "UNPSH Low"
	uunpStrings[37] = "UNPSH High"
	uunpStrings[38] = "UNPK Low"
	uunpStrings[39] = "UNPK High"
	uunpStrings[40] = "UNPK Bonus Low"
	uunpStrings[41] = "UNPK Bonus High"
	uunpStrings[42] = "UN7B Low"
	uunpStrings[43] = "UN7B High"
	uunpStrings[44] = "UNPBB Low"
	uunpStrings[45] = "UNPBB High"
	uunpStrings[46] = "Seraphim Low"
	uunpStrings[47] = "Seraphim High"
	uunpStrings[48] = "Demonfet Low"
	uunpStrings[49] = "Demonfet High"
	uunpStrings[50] = "Dream Girl Low"
	uunpStrings[51] = "Dream Girl High"
	uunpStrings[52] = "Top Model Low"
	uunpStrings[53] = "Top Model High"
	uunpStrings[54] = "Leito Low"
	uunpStrings[55] = "Leito High"
	uunpStrings[56] = "UNPF Low"
	uunpStrings[57] = "UNPF High"
	uunpStrings[58] = "UNPFx Low"
	uunpStrings[59] = "UNPFx High"
	uunpStrings[60] = "CNHF Low"
	uunpStrings[61] = "CNHF High"
	uunpStrings[62] = "CNHF Bonus Low"
	uunpStrings[63] = "CNHF Bonus High"
	uunpStrings[64] = "MCBM Low"
	uunpStrings[65] = "MCBM High"
	uunpStrings[66] = "Venus Low"
	uunpStrings[67] = "Venus High"
	uunpStrings[68] = "ZGGB-R2 Low"
	uunpStrings[69] = "ZGGB-R2 High"
	uunpStrings[70] = "Manga Low"
	uunpStrings[71] = "Manga High"
	uunpStrings[72] = "CHSBHC Low"
	uunpStrings[73] = "CHSBHC High"
	
	bhunpStrings[0] = "BreastsTogether"
	bhunpStrings[1] = "BreastCenter"
	bhunpStrings[2] = "BreastCenterBig"
	bhunpStrings[3] = "Top Slope"
	bhunpStrings[4] = "BreastConverge"
	bhunpStrings[5] = "BreastsGone"
	bhunpStrings[6] = "BreastsPressed"
	bhunpStrings[7] = "NipplePuffyAreola"
	bhunpStrings[8] = "NipBGone"
	bhunpStrings[9] = "NippleInverted"
	bhunpStrings[10] = "ChestDepth"
	bhunpStrings[11] = "ChestWidth"
	bhunpStrings[12] = "RibsProminance"
	bhunpStrings[13] = "SternumDepth"
	bhunpStrings[14] = "SternumHeight"
	bhunpStrings[15] = "WaistHeight"
	bhunpStrings[16] = "BackArch"
	bhunpStrings[17] = "CrotchBack"
	bhunpStrings[18] = "LegsThin"
	bhunpStrings[19] = "KneeShape"
	bhunpStrings[20] = "KneeSlim"
	bhunpStrings[21] = "MuscleAbs"
	bhunpStrings[22] = "MuscleArms"
	bhunpStrings[23] = "MuscleButt"
	bhunpStrings[24] = "MuscleLegs"
	bhunpStrings[25] = "MusclePecs"
	bhunpStrings[26] = "HipForward"
	bhunpStrings[27] = "HipUpperWidth"
	bhunpStrings[28] = "ForearmSize"
	bhunpStrings[29] = "ShoulderTweak"
	bhunpStrings[30] = "BotePregnancy"
	bhunpStrings[31] = "BellyFatLower"
	bhunpStrings[32] = "BellyFatUpper"
	bhunpStrings[33] = "BellyObesity"
	bhunpStrings[34] = "BellyPressed"
	bhunpStrings[35] = "BellyLowerSwell1"
	bhunpStrings[36] = "BellyLowerSwell2"
	bhunpStrings[37] = "BellyLowerSwell3"
	bhunpStrings[38] = "BellyCenterProtrude"
	bhunpStrings[39] = "BellyCenterUpperProtrude"
	bhunpStrings[40] = "BellyBalls"
	bhunpStrings[41] = "Aruru6Duck Low"
	bhunpStrings[42] = "Aruru6Duck High"
	
	cbbeSEStrings[0] = "BreastsSmall2"
	cbbeSEStrings[1] = "BreastsNewSH"
	cbbeSEStrings[2] = "BreastsNewSHSymmetry"
	cbbeSEStrings[3] = "BreastTopSlope"
	cbbeSEStrings[4] = "BreastFlatness2"
	cbbeSEStrings[5] = "BreastGravity2"
	cbbeSEStrings[6] = "BreastSideShape"
	cbbeSEStrings[7] = "BreastUnderDepth"
	cbbeSEStrings[8] = "AreolaSize"
	cbbeSEStrings[9] = "NippleManga"
	cbbeSEStrings[10] = "NipplePerkManga"
	cbbeSEStrings[11] = "NippleTipManga"
	cbbeSEStrings[12] = "NippleDip"
	cbbeSEStrings[13] = "NavelEven"
	cbbeSEStrings[14] = "ButtClassic"
	cbbeSEStrings[15] = "ButtDimples"
	cbbeSEStrings[16] = "ButtUnderFold"
	cbbeSEStrings[17] = "HipCarved"
	cbbeSEStrings[18] = "LegShapeClassic"
	cbbeSEStrings[19] = "FeetFeminine"
	cbbeSEStrings[20] = "AnkleSize"
	cbbeSEStrings[21] = "WristSize"
	cbbeSEStrings[22] = "VanillaSSELo"
	cbbeSEStrings[23] = "VanillaSSEHi"
	cbbeSEStrings[24] = "OldBaseShape"
	cbbeSEStrings[25] = "7B Lower"
	cbbeSEStrings[26] = "7B Upper"
	
	cbbe3BAStrings[0] = "BreastsConverage_v2"
	cbbe3BAStrings[1] = "BreastsPressed_v2"
	cbbe3BAStrings[2] = "AreolaPull_v2"
	cbbe3BAStrings[3] = "NippleSquash1_v2"
	cbbe3BAStrings[4] = "NippleSquash2_v2"
	cbbe3BAStrings[5] = "NipplePuffy_v2"
	cbbe3BAStrings[6] = "NippleShy_v2"
	cbbe3BAStrings[7] = "NippleThicc_v2"
	cbbe3BAStrings[8] = "NippleTube_v2"
	cbbe3BAStrings[9] = "NippleCrease_v2"
	cbbe3BAStrings[10] = "NippleCrumpled_v2"
	cbbe3BAStrings[11] = "NippleBump_v2"
	cbbe3BAStrings[12] = "NippleInvert_v2"
	cbbe3BAStrings[13] = "Clavicle_v2"
	cbbe3BAStrings[14] = "RibsMore_v2"
	cbbe3BAStrings[15] = "BackValley_v2"
	cbbe3BAStrings[16] = "BackWing_v2"
	cbbe3BAStrings[17] = "ButtSaggy_v2"
	cbbe3BAStrings[18] = "ButtPressed_v2"
	cbbe3BAStrings[19] = "ButtNarrow_v2"
	cbbe3BAStrings[20] = "7BLeg_v2"
	cbbe3BAStrings[21] = "ThighOutsideThicc_v2"
	cbbe3BAStrings[22] = "ThighInsideThicc_v2"
	cbbe3BAStrings[23] = "ThighFBThicc_v2"
	cbbe3BAStrings[24] = "LegSpread_v2"
	cbbe3BAStrings[25] = "KneeTogether_v2"
	cbbe3BAStrings[26] = "CalfFBThicc_v2"
	cbbe3BAStrings[27] = "MuscleMoreAbs_v2"
	cbbe3BAStrings[28] = "MuscleMoreArms_v2"
	cbbe3BAStrings[29] = "MuscleMoreLegs_v2"
	cbbe3BAStrings[30] = "MuscleBack_v2"
	cbbe3BAStrings[31] = "HipNarrow_v2"
	cbbe3BAStrings[32] = "UNPHip_v2"
	cbbe3BAStrings[33] = "ArmpitShape_v2"
	cbbe3BAStrings[34] = "BellyFrontUpFat_v2"
	cbbe3BAStrings[35] = "BellyFrontDownFat_v2"
	cbbe3BAStrings[36] = "BellySideUpFat_v2"
	cbbe3BAStrings[37] = "BellySideDownFat_v2"
	cbbe3BAStrings[38] = "BellyUnder_v2"
	cbbe3BAStrings[39] = "HipBone"
	
	boneStrings[0] = "Upper spine"
	boneStrings[1] = "Advanced forearms"
	boneStrings[2] = "Upperarms"
	boneStrings[3] = "Hands"
	boneStrings[4] = "Clavicle"
	boneStrings[5] = "Pelvis"
	boneStrings[6] = "Waist"
	boneStrings[7] = "Lower Spine"
	boneStrings[8] = "Middle Spine"
	boneStrings[9] = "Thighs"
	boneStrings[10] = "Calfs"
	boneStrings[11] = "Feet"
	boneStrings[12] = "Breasts (HDT)"
	boneStrings[13] = "Breast Fullness (3BBB)"
	boneStrings[14] = "Belly"
	boneStrings[15] = "Butt"
	boneStrings[16] = "Height"
	boneStrings[17] = "Head"
	boneStrings[18] = "Biceps"
	boneStrings[19] = "Biceps2"
EndFunction

;SAVE & LOAD
Bool Function saveSettings()
	String fileName = "SnusnuSettings"
		
	JsonUtil.SetIntValue(fileName, "Enabled", snusnuMain.Enabled as Int)
	JsonUtil.SetIntValue(fileName, "hardcoreMode", snusnuMain.hardcoreMode as Int)
	JsonUtil.SetIntValue(fileName, "selectedBody", snusnuMain.selectedBody)
	JsonUtil.SetIntValue(fileName, "disableNormals", snusnuMain.disableNormals as Int)
	JsonUtil.SetFloatValue(fileName, "Stamina", snusnuMain.Stamina)
	JsonUtil.SetFloatValue(fileName, "Speed", snusnuMain.Speed)
	JsonUtil.SetFloatValue(fileName, "combatProficiency", snusnuMain.combatProficiency)
	JsonUtil.SetFloatValue(fileName, "carryWeightBoost", snusnuMain.carryWeightBoost)
	JsonUtil.SetFloatValue(fileName, "muscleScoreMax", snusnuMain.muscleScoreMax)
	JsonUtil.SetFloatValue(fileName, "MultLoss", snusnuMain.MultLoss)
	JsonUtil.SetFloatValue(fileName, "MultGainFight", snusnuMain.MultGainFight)
	JsonUtil.SetFloatValue(fileName, "MultGainArmor", snusnuMain.MultGainArmor)
	JsonUtil.SetFloatValue(fileName, "MultGainMisc", snusnuMain.MultGainMisc)
	JsonUtil.SetFloatValue(fileName, "addWerewolfStrength", snusnuMain.addWerewolfStrength)
	JsonUtil.SetFloatValue(fileName, "addVampireStrength", snusnuMain.addVampireStrength)
	JsonUtil.SetFloatValue(fileName, "malnourishmentValue", snusnuMain.malnourishmentValue)
	JsonUtil.SetIntValue(fileName, "tfAnimation", snusnuMain.tfAnimation as Int)
	JsonUtil.SetIntValue(fileName, "tfAnimationNPC", snusnuMain.tfAnimationNPC as Int)
	JsonUtil.SetIntValue(fileName, "useAltAnims", snusnuMain.useAltAnims as Int)
	JsonUtil.SetIntValue(fileName, "useAltAnimsNPC", snusnuMain.useAltAnimsNPC as Int)
	JsonUtil.SetIntValue(fileName, "changeHeadPart", snusnuMain.changeHeadPart as Int)
	JsonUtil.SetIntValue(fileName, "playTFSound", snusnuMain.playTFSound as Int)
	JsonUtil.SetIntValue(fileName, "removeWeightMorphs", snusnuMain.removeWeightMorphs as Int)
	JsonUtil.SetIntValue(fileName, "applyMoreChangesOvertime", snusnuMain.applyMoreChangesOvertime as Int)
	JsonUtil.SetIntValue(fileName, "dynamicChangesCalculation", snusnuMain.dynamicChangesCalculation as Int)
	JsonUtil.SetFloatValue(fileName, "moreChangesInterval", snusnuMain.moreChangesInterval)
	JsonUtil.SetFloatValue(fileName, "moreChangesIncrements", snusnuMain.moreChangesIncrements)
	JsonUtil.SetIntValue(fileName, "getInfoKey", snusnuMain.getInfoKey)
	JsonUtil.SetIntValue(fileName, "npcMuscleKey", snusnuMain.npcMuscleKey)
	JsonUtil.SetFloatValue(fileName, "npcMuscleScore", snusnuMain.npcMuscleScore)
	JsonUtil.SetIntValue(fileName, "useAltBody", snusnuMain.useAltBody as Int)
	
	JsonUtil.SetIntValue(fileName, "useDynamicPhysics", snusnuMain.useDynamicPhysics as Int)
	JsonUtil.SetIntValue(fileName, "useMuscleAnims", snusnuMain.useMuscleAnims as Int)
	JsonUtil.SetIntValue(fileName, "useDARAnims", snusnuMain.useDARAnims as Int)
	JsonUtil.SetFloatValue(fileName, "muscleAnimsLevel", snusnuMain.muscleAnimsLevel.getValue())
	
	Return JsonUtil.Save(fileName, False)
EndFunction

Bool Function savePushupExceptions()
	String fileName = "MCPushupExceptions"
	
	If snusnuMain.PushupExceptions.getSize() > 128
		Debug.Trace("SNU - ERROR: Exceptions array is too big to be passed as an array! -->"+snusnuMain.PushupExceptions.getSize())
		Return false
	EndIf
	
	If !JsonUtil.FormListCopy(fileName, "PushupExceptions", snusnuMain.PushupExceptions.toArray())
		Debug.Trace("SNU - ERROR: Exceptions array could not be saved!!")
		Return false
	EndIf
	
	Return JsonUtil.Save(fileName, False)
EndFunction

bool Function loadSettings()
	String fileName = "SnusnuSettings"
	
	if JsonUtil.JsonExists(fileName)
		If snusnuMain.Enabled != JsonUtil.GetIntValue(fileName, "Enabled", snusnuMain.Enabled as Int)
			snusnuMain.Enabled = JsonUtil.GetIntValue(fileName, "Enabled", snusnuMain.Enabled as Int)
			applyEnabledOption(false)
		EndIf
		If snusnuMain.hardcoreMode != JsonUtil.GetIntValue(fileName, "hardcoreMode", snusnuMain.hardcoreMode as Int)
			snusnuMain.hardcoreMode = JsonUtil.GetIntValue(fileName, "hardcoreMode", snusnuMain.hardcoreMode as Int)
			applyHardcoreOption()
		EndIf
		If snusnuMain.selectedBody != JsonUtil.GetIntValue(fileName, "selectedBody", snusnuMain.selectedBody)
			snusnuMain.selectedBody = JsonUtil.GetIntValue(fileName, "selectedBody", snusnuMain.selectedBody)
			applyBodyOption(false)
		EndIf
		If snusnuMain.disableNormals != JsonUtil.GetIntValue(fileName, "disableNormals", snusnuMain.disableNormals as Int)
			snusnuMain.disableNormals = JsonUtil.GetIntValue(fileName, "disableNormals", snusnuMain.disableNormals as Int)
			applyNormalsOption()
		EndIf
		If snusnuMain.Stamina != JsonUtil.GetFloatValue(fileName, "Stamina", snusnuMain.Stamina)
			applyStaminaValue(JsonUtil.GetFloatValue(fileName, "Stamina", snusnuMain.Stamina))
		EndIf
		If snusnuMain.Speed != JsonUtil.GetFloatValue(fileName, "Speed", snusnuMain.Speed)
			applySpeedValue(JsonUtil.GetFloatValue(fileName, "Speed", snusnuMain.Speed))
		EndIf
		If snusnuMain.combatProficiency != JsonUtil.GetFloatValue(fileName, "combatProficiency", snusnuMain.combatProficiency)
			applyProficiencyValue(JsonUtil.GetFloatValue(fileName, "combatProficiency", snusnuMain.combatProficiency))
		EndIf
		If snusnuMain.carryWeightBoost != JsonUtil.GetFloatValue(fileName, "carryWeightBoost", snusnuMain.carryWeightBoost)
			applyCarryWeightValue(JsonUtil.GetFloatValue(fileName, "carryWeightBoost", snusnuMain.carryWeightBoost))
		EndIf
		If snusnuMain.muscleScoreMax != JsonUtil.GetFloatValue(fileName, "muscleScoreMax", snusnuMain.muscleScoreMax)
			applymuscleScoreMaxValue(JsonUtil.GetFloatValue(fileName, "muscleScoreMax", snusnuMain.muscleScoreMax))
		EndIf
		
		snusnuMain.MultLoss = JsonUtil.GetFloatValue(fileName, "MultLoss", snusnuMain.MultLoss)
		snusnuMain.MultGainFight = JsonUtil.GetFloatValue(fileName, "MultGainFight", snusnuMain.MultGainFight)
		snusnuMain.MultGainArmor = JsonUtil.GetFloatValue(fileName, "MultGainArmor", snusnuMain.MultGainArmor)
		snusnuMain.MultGainMisc = JsonUtil.GetFloatValue(fileName, "MultGainMisc", snusnuMain.MultGainMisc)
		snusnuMain.addWerewolfStrength = JsonUtil.GetFloatValue(fileName, "addWerewolfStrength", snusnuMain.addWerewolfStrength)
		snusnuMain.addVampireStrength = JsonUtil.GetFloatValue(fileName, "addVampireStrength", snusnuMain.addVampireStrength)
		snusnuMain.malnourishmentValue = JsonUtil.GetFloatValue(fileName, "malnourishmentValue", snusnuMain.malnourishmentValue)
		snusnuMain.tfAnimation = JsonUtil.GetIntValue(fileName, "tfAnimation", snusnuMain.tfAnimation as Int)
		snusnuMain.tfAnimationNPC = JsonUtil.GetIntValue(fileName, "tfAnimationNPC", snusnuMain.tfAnimationNPC as Int)
		snusnuMain.useAltAnims = JsonUtil.GetIntValue(fileName, "useAltAnims", snusnuMain.useAltAnims as Int)
		snusnuMain.useAltAnimsNPC = JsonUtil.GetIntValue(fileName, "useAltAnimsNPC", snusnuMain.useAltAnimsNPC as Int)
		snusnuMain.changeHeadPart = JsonUtil.GetIntValue(fileName, "changeHeadPart", snusnuMain.changeHeadPart as Int)
		snusnuMain.playTFSound = JsonUtil.GetIntValue(fileName, "playTFSound", snusnuMain.playTFSound as Int)
		snusnuMain.removeWeightMorphs = JsonUtil.GetIntValue(fileName, "removeWeightMorphs", snusnuMain.removeWeightMorphs as Int)
		snusnuMain.applyMoreChangesOvertime = JsonUtil.GetIntValue(fileName, "applyMoreChangesOvertime", snusnuMain.applyMoreChangesOvertime as Int)
		snusnuMain.dynamicChangesCalculation = JsonUtil.GetIntValue(fileName, "dynamicChangesCalculation", snusnuMain.dynamicChangesCalculation as Int)
		snusnuMain.moreChangesInterval = JsonUtil.GetFloatValue(fileName, "moreChangesInterval", snusnuMain.moreChangesInterval as Float)
		snusnuMain.moreChangesIncrements = JsonUtil.GetFloatValue(fileName, "moreChangesIncrements", snusnuMain.moreChangesIncrements as Float)
		snusnuMain.useAltBody = JsonUtil.GetIntValue(fileName, "useAltBody", snusnuMain.useAltBody as Int)
		
		If snusnuMain.getInfoKey != JsonUtil.GetIntValue(fileName, "getInfoKey", snusnuMain.getInfoKey)
			snusnuMain.getInfoKey = JsonUtil.GetIntValue(fileName, "getInfoKey", snusnuMain.getInfoKey)
			SetKeyMapOptionValueST(snusnuMain.getInfoKey)
		EndIf
		If snusnuMain.npcMuscleKey != JsonUtil.GetIntValue(fileName, "npcMuscleKey", snusnuMain.npcMuscleKey)
			snusnuMain.npcMuscleKey = JsonUtil.GetIntValue(fileName, "npcMuscleKey", snusnuMain.npcMuscleKey)
			SetKeyMapOptionValueST(snusnuMain.npcMuscleKey)
		EndIf
		If snusnuMain.npcMuscleScore != JsonUtil.GetFloatValue(fileName, "npcMuscleScore", snusnuMain.npcMuscleScore)
			applyNPCMuscleValue(JsonUtil.GetFloatValue(fileName, "npcMuscleScore", snusnuMain.npcMuscleScore))
		EndIf
		
		If snusnuMain.useDynamicPhysics != JsonUtil.GetIntValue(fileName, "useDynamicPhysics", snusnuMain.useDynamicPhysics as Int)
			snusnuMain.useDynamicPhysics = JsonUtil.GetIntValue(fileName, "useDynamicPhysics", snusnuMain.useDynamicPhysics as Int)
			applyDynamicPhysicsOption()
		EndIf
		If snusnuMain.useMuscleAnims != JsonUtil.GetIntValue(fileName, "useMuscleAnims", snusnuMain.useMuscleAnims as Int)
			snusnuMain.useMuscleAnims = JsonUtil.GetIntValue(fileName, "useMuscleAnims", snusnuMain.useMuscleAnims as Int)
			applyChangeAnimsOption()
		EndIf
		If snusnuMain.useDARAnims != JsonUtil.GetIntValue(fileName, "useDARAnims", snusnuMain.useDARAnims as Int)
			snusnuMain.useDARAnims = JsonUtil.GetIntValue(fileName, "useDARAnims", snusnuMain.useDARAnims as Int)
			applyDARAnimsOption()
		EndIf
		If snusnuMain.muscleAnimsLevel.getValue() != JsonUtil.GetFloatValue(fileName, "muscleAnimsLevel", snusnuMain.muscleAnimsLevel.getValue())
			applyMuscleAnimsLevelValue(JsonUtil.GetFloatValue(fileName, "muscleAnimsLevel", snusnuMain.muscleAnimsLevel.getValue()))
		EndIf
		
		return true
	EndIf
	
	return false
EndFunction

Bool Function LoadSavedProfiles()
	Debug.Trace("SNU- Searching for current profile files")
	savedProfilesList = MiscUtil.FilesInFolder("./Data/SKSE/Plugins/StorageUtilData/SnuSnuProfiles", "json")
	If savedProfilesList.length > 0
		Debug.Trace(" ")
		Debug.Trace("SNU- Detected files in SnusnuProfiles directory: ")
		Debug.Trace(savedProfilesList)
		Debug.Trace(" ")
		Return true
	Else
		Return false
	EndIf
EndFunction

Event OnOptionInputOpen(Int Option)
	If Option == _mySaveMorphsProfile
		SetInputDialogStartText("Default")
	EndIf
EndEvent

Event OnOptionInputAccept(int option, string value)
	If Option == _mySaveMorphsProfile
		SetInputOptionValue(_mySaveMorphsProfile, value)
		applySaveMorphs("SnuSnuProfiles/"+value)
    EndIf 
EndEvent

Event OnOptionMenuOpen(int Option)
	If Option == _myLoadMorphsProfile
		SetMenuDialogOptions(savedProfilesList)
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
	EndIf
EndEvent

Event OnOptionMenuAccept(int option, int index)
	If option == _myLoadMorphsProfile
		SetMenuOptionValue(_myLoadMorphsProfile, savedProfilesList[index])
		applyLoadMorphs("SnuSnuProfiles/"+savedProfilesList[index])
	EndIf
EndEvent

State InstalledBody
	Event OnMenuOpenST()
		String[] Option = New String[3]
		Option[0] = "UUNP/BHUNP Body"
		Option[1] = "CBBE Body"
		Option[2] = "Vanilla"
		SetMenuDialogStartIndex(snusnuMain.selectedBody)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Option)
	EndEvent
	Event OnMenuAcceptST(Int i)
		String[] Option = New String[3]
		Option[0] = "UUNP/BHUNP Body"
		Option[1] = "CBBE Body"
		Option[2] = "Vanilla"
		snusnuMain.selectedBody = i
		SetMenuOptionValueST(Option[i])
		applyBodyOption()
	EndEvent
	Event OnHighlightST()
		If snusnuMain.selectedBody == 0
			SetInfoText("The body you have installed in Skyrim is UUNP or BHUNP")
		ElseIf snusnuMain.selectedBody == 1
			SetInfoText("The body you have installed in Skyrim is CBBE")
		ElseIf snusnuMain.selectedBody == 2
			SetInfoText("You don't have a custom body shape installed")
		EndIf
	EndEvent
EndState

State LoadDefaults
	Event OnMenuOpenST()
		String[] Option = New String[3]
		Option[0] = GetDefaultMorphString(1)
		Option[1] = GetDefaultMorphString(2)
		Option[2] = GetDefaultMorphString(3)
		SetMenuDialogStartIndex(selectedDefaultMorphs - 1)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Option)
	EndEvent
	Event OnMenuAcceptST(Int i)
		String[] Option = New String[3]
		Option[0] = GetDefaultMorphString(1)
		Option[1] = GetDefaultMorphString(2)
		Option[2] = GetDefaultMorphString(3)
		selectedDefaultMorphs = i+1
		SetMenuOptionValueST(Option[i])
		
		if selectedDefaultMorphs == 3
			snusnuMain.usePecs = true
		Else
			snusnuMain.usePecs = false
		EndIf
		
		snusnuMain.LoadDefaultProfile(selectedDefaultMorphs)
		
		String Msg
		Msg = "Selected morphs profile has been applied."
		ShowMessage(Msg, False)
	EndEvent
	Event OnHighlightST()
		If selectedDefaultMorphs == 1
			SetInfoText("Set all morphs for UUNP/BHUNP recommended body shape")
		ElseIf selectedDefaultMorphs == 2
			SetInfoText("Set all morphs for CBBE SE recommended body shape")
		ElseIf selectedDefaultMorphs == 3
			SetInfoText("Set all morphs for alternative CBBE SE body shape with enphasis on pectorals")
		EndIf
	EndEvent
EndState


;-------------------------------------------------------------------------------------
;TLALOC- New structure to avoid reusing code on loading values from Json
;-------------------------------------------------------------------------------------

Function applyEnabledOption(Bool askHardcore)
	SetToggleOptionValue(_myEnabled, snusnuMain.Enabled)
	
	If snusnuMain.Enabled && askHardcore && ShowMessage("Enable Hardcore Mode?\n\nIn Hardcore Mode your initial muscle score will be set depending on your race\n(Orc: 50%, Nord: 35%, WoodElf/Redguard/Khajiit/Imperial: 25%, HighElf/DarkElf/Breton/Argonian: 0%),\nand it also restricts the usage of armor and weapons depending on your muscle score.", true, "Activate", "Don't")
		snusnuMain.hardcoreMode = true
		applyHardcoreOption()
		SetToggleOptionValue(_myHardcoreMode, snusnuMain.hardcoreMode)
	EndIf
	
	snusnuMain.initSliderArrays()
	snusnuMain.ResetWeight(snusnuMain.Enabled)
	snusnuMain.RegisterEvents(snusnuMain.Enabled)
	SetTextOptionValue(_myFightingScore, snusnuMain.getMuscleValuePercent(snusnuMain.muscleScore)+"%")
	SetTextOptionValue(_myStoredScore, snusnuMain.getMuscleValuePercent(snusnuMain.storedMuscle)+"%")
	;SetToggleOptionValue(_myUseWeightSlider, snusnuMain.useWeightSlider)
	SetToggleOptionValue(_myDisableNormals, snusnuMain.disableNormals)
	SetSliderOptionValue(_myMaxWeight, snusnuMain.muscleScoreMax, "{2}")
EndFunction

Function applyHardcoreOption()
	SetToggleOptionValue(_myHardcoreMode, snusnuMain.hardcoreMode)
	
	If snusnuMain.hardcoreMode
		;ToDo- Hardcoded value. We need to add a MCM option to set this
		;      Temporarly reducing it to 100. Maximum vanilla equipment is 138, but skills will bring that down to 50%, so
		;      it would be a nice incentive to keep improving the relevant skills.
		snusnuMain.maxItemsEquipedWeight = 100.0 ;140.0
		
		snusnuMain.updateAllowedItemsEquipedWeight()
		snusnuMain.getEquipedFullWeight()
	Else
		snusnuMain.cleanupHardcoreMode()
	EndIf
EndFunction

Function applyBodyOption(Bool showMSG = true)
	if snusnuMain.selectedBody == 2 ;Vanilla
		snusnuMain.usePecs = false
		snusnuMain.useWeightSlider = true
	Else
		snusnuMain.useWeightSlider = false
		If snusnuMain.selectedBody == 0 ;UNP
			snusnuMain.usePecs = false
			snusnuMain.LoadDefaultProfile(1)
		ElseIf snusnuMain.selectedBody == 1 ;CBBE
			snusnuMain.usePecs = true
			snusnuMain.LoadDefaultProfile(3)
		EndIf
	EndIf
	
	If showMSG
		String Msg
		Msg = "Doing a full menu reset."
		ShowMessage(Msg, False)
	EndIf
	
	OpenConfig()
	setPage(Pages[0], 0)
EndFunction

Function applyNormalsOption()
	SetToggleOptionValue(_myDisableNormals, snusnuMain.disableNormals)

	If snusnuMain.disableNormals
		Bool isFemale = PlayerRef.GetActorBase().GetSex() != 0
		;NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
		NiOverride.RemoveSkinOverride(PlayerRef, isFemale, false, 0x04, 9, 1)
		NiOverride.RemoveSkinOverride(PlayerRef, isFemale, true, 0x04, 9, 1)
	Else
		snusnuMain.checkBodyNormalsState()
	EndIf
EndFunction

Function applyDynamicPhysicsOption()
	SetToggleOptionValue(_myDynamicPhysics, snusnuMain.useDynamicPhysics)
		
	If snusnuMain.useDynamicPhysics
		snusnuMain.checkBodyNormalsState()
	Else
		snusnuMain.updateBoobsPhysics(true, 4)
	EndIf
EndFunction
Function applyChangeAnimsOption()
	SetToggleOptionValue(_myChangeAnims, snusnuMain.useMuscleAnims)
	snusnuMain.checkBodyNormalsState()
EndFunction

Function applyDARAnimsOption()
	SetToggleOptionValue(_myUseDARAnims, snusnuMain.useDARAnims)
	;Remove FNIS anims if any
	If snusnuMain.useDARAnims && snusnuMain.isUsingFNIS
		snusnuMain.setMuscleAnimations(PlayerRef, true)
	EndIf
EndFunction

Function applyStaminaValue(Float theValue)
	snusnuMain.Stamina = theValue
	SetSliderOptionValue(_myStamina, snusnuMain.Stamina, "{0}")
	snusnuMain.UpdateEffects()
EndFunction

Function applySpeedValue(Float theValue)
	snusnuMain.Speed = theValue
	SetSliderOptionValue(_mySpeed, snusnuMain.Speed, "{0}")
	snusnuMain.UpdateEffects()
EndFunction

Function applyProficiencyValue(Float theValue)
	snusnuMain.combatProficiency = theValue
	SetSliderOptionValue(_myCombatProficiency, snusnuMain.combatProficiency, "{0}")
	snusnuMain.UpdateEffects()
EndFunction

Function applyCarryWeightValue(Float theValue)
	snusnuMain.carryWeightBoost = theValue
	SetSliderOptionValue(_myBoostCarryWeight, snusnuMain.carryWeightBoost, "{0}")
	snusnuMain.updateCarryWeight()
EndFunction

Function applyMuscleAnimsLevelValue(Float theValue)
	snusnuMain.muscleAnimsLevel.setValue(theValue as Int)
	SetSliderOptionValue(_myMuscleAnimsLevel, snusnuMain.muscleAnimsLevel.getValue() as Float, "{0}")
	snusnuMain.checkBodyNormalsState()
EndFunction

Function applymuscleScoreMaxValue(Float theValue)
	Float difference = theValue / snusnuMain.muscleScoreMax
	snusnuMain.muscleScoreMax = theValue
	SetSliderOptionValue(_myMaxWeight, snusnuMain.muscleScoreMax, "{2}")
	;If snusnuMain.muscleScoreMax < snusnuMain.muscleScore
		;snusnuMain.updateMuscleScore(0)
		snusnuMain.recalculateAllMuscleVars(difference)
		snusnuMain.UpdateWeight()
		snusnuMain.UpdateEffects()
		;SetTextOptionValue(_myFightingScore, snusnuMain.getMuscleValuePercent(snusnuMain.muscleScore)+"%")
	;EndIf
EndFunction

Function applyNPCMuscleValue(Float theValue)
	snusnuMain.npcMuscleScore = theValue
	Debug.Notification("NPC Muscle has been set to "+snusnuMain.npcMuscleScore)
EndFunction

Function applySaveMorphs(String profileName = "")
	Self.SetOptionFlags(_mySaveOptions, Self.OPTION_FLAG_DISABLED, True)
	Self.SetOptionFlags(_myLoadOptions, Self.OPTION_FLAG_DISABLED, True)
	
	Self.SetOptionFlags(_mySaveMorphs, Self.OPTION_FLAG_DISABLED, True)
	Self.SetOptionFlags(_myLoadMorphs, Self.OPTION_FLAG_DISABLED, True)
	
	Self.SetOptionFlags(_mySaveMorphsProfile, Self.OPTION_FLAG_DISABLED, True)
	Self.SetOptionFlags(_myLoadMorphsProfile, Self.OPTION_FLAG_DISABLED, True)
	ShowMessage("Saving morph values", false)
	If snusnuMain.saveAllMorphs(profileName)
		ShowMessage("Morphs have been saved successfully", false)
	Else
		ShowMessage("ERROR! Morph values could not be saved!!", false)
	EndIf
	ForcePageReset()
	Self.SetOptionFlags(_mySaveOptions, Self.OPTION_FLAG_NONE, True)
	Self.SetOptionFlags(_myLoadOptions, Self.OPTION_FLAG_NONE, True)
	
	Self.SetOptionFlags(_mySaveMorphs, Self.OPTION_FLAG_NONE, True)
	Self.SetOptionFlags(_myLoadMorphs, Self.OPTION_FLAG_NONE, True)
	
	Self.SetOptionFlags(_mySaveMorphsProfile, Self.OPTION_FLAG_NONE, True)
	Self.SetOptionFlags(_myLoadMorphsProfile, Self.OPTION_FLAG_NONE, True)
EndFunction

Function applyLoadMorphs(String profileName = "")
	Self.SetOptionFlags(_mySaveOptions, Self.OPTION_FLAG_DISABLED, True)
	Self.SetOptionFlags(_myLoadOptions, Self.OPTION_FLAG_DISABLED, True)
	
	Self.SetOptionFlags(_mySaveMorphs, Self.OPTION_FLAG_DISABLED, True)
	Self.SetOptionFlags(_myLoadMorphs, Self.OPTION_FLAG_DISABLED, True)
	
	Self.SetOptionFlags(_mySaveMorphsProfile, Self.OPTION_FLAG_DISABLED, True)
	Self.SetOptionFlags(_myLoadMorphsProfile, Self.OPTION_FLAG_DISABLED, True)
	ShowMessage("Loading morph values", false)
	If snusnuMain.loadAllMorphs(profileName)
		ShowMessage("Morphs have been loaded successfully", false)
	Else
		ShowMessage("ERROR! Morph values could not be loaded!!", false)
	EndIf
	ForcePageReset()
	Self.SetOptionFlags(_mySaveOptions, Self.OPTION_FLAG_NONE, True)
	Self.SetOptionFlags(_myLoadOptions, Self.OPTION_FLAG_NONE, True)
	
	Self.SetOptionFlags(_mySaveMorphs, Self.OPTION_FLAG_NONE, True)
	Self.SetOptionFlags(_myLoadMorphs, Self.OPTION_FLAG_NONE, True)
	
	Self.SetOptionFlags(_mySaveMorphsProfile, Self.OPTION_FLAG_NONE, True)
	Self.SetOptionFlags(_myLoadMorphsProfile, Self.OPTION_FLAG_NONE, True)
EndFunction

String Function switchFMGMorphs(Bool loadFMG)
	String errorMSG
	If loadFMG
		If !snusnuMain.saveAllMorphs("SnuSnuProfiles/SnuTempMorphs")
			errorMSG = "There was an error while saving current morphs!"
		EndIf
		If !snusnuMain.loadAllMorphs("SnuSnuProfiles/SnuDefaultFMG")
			errorMSG = "There was an error while loading FMG morphs!"
		EndIf
	Else
		If !snusnuMain.saveAllMorphs("SnuSnuProfiles/SnuDefaultFMG")
			errorMSG = "There was an error while saving FMG morphs!"
		EndIf
		If !snusnuMain.loadAllMorphs("SnuSnuProfiles/SnuTempMorphs")
			errorMSG = "There was an error while loading current morphs!"
		EndIf
	EndIf
	
	Return errorMSG
EndFunction
