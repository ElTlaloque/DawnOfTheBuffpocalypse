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
Int _myStamina
Int _mySpeed
Int _myCombatProficiency
Int _myMaxWeight
Int _myFightingScore
Int _myStoredScore
Int _myRemoveWeightMorphs
Int _mytfAnimation
Int _mytfAnimationNPC
Int _myuseAltAnims
Int _myuseAltAnimsNPC
Int _mychangeHeadPart
Int _myplayTFSound
Int _myUseWeightSlider
Int _myDisableNormals
Int _myBoostCarryWeight
;Int _mySelectedBody

Int _myZeroSliders
Int _myApplyDefault
Int _myFoceScore
Int _myMalnourishment
Int _myPushupException
Int _myNPCMuscleScore

Int _mySaveOptions
Int _myLoadOptions
Int _mySaveMorphs
Int _myLoadMorphs
Int _mySaveMorphsProfile
Int _myLoadMorphsProfile

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

; Male morphs
Int _myMultSamuel
Int _myMultSamson

Int selectedDefaultMorphs = 1

Event OnConfigInit()
	Pages = new String[7]
	Pages[0] = "$SNUSNU_OPTIONS"
	If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
		Pages[1] = "$SNUSNU_MORPHS_CBBE"
		Pages[2] = "$SNUSNU_MORPHS_UUNP"
		Pages[3] = "$SNUSNU_MORPHS_BHUNP"
	ElseIf snusnuMain.selectedBody == 1 ;CBBE
		Pages[1] = "CBBE Morphs Page 1"
		Pages[2] = "CBBE Morphs Page 2"
		Pages[3] = "CBBE Special Morphs"
	EndIf
	
	If snusnuMain.selectedBody != 2
		Pages[4] = "$SNUSNU_MORPHS_MALE"
		Pages[5] = "SAVE & LOAD"
		Pages[6] = "$SNUSNU_INFO"
	Else
		Pages[1] = "$SNUSNU_MORPHS_MALE"
		Pages[2] = "SAVE & LOAD"
		Pages[3] = "$SNUSNU_INFO"
	EndIf
	
	cbbeSliders = new Int[52]
	uunpSliders = new Int[74]
	bhunpSliders = new Int[43]
	cbbeSESliders = new Int[27]
	cbbe3BASliders = new Int[40]
	
	cbbeStrings = new String[52]
	uunpStrings = new String[74]
	bhunpStrings = new String[43]
	cbbeSEStrings = new String[27]
	cbbe3BAStrings = new String[40]
	
	initStringArrays()
EndEvent

Event OnVersionUpdate(Int NewVersion)
	;Not functional
EndEvent

Event OnConfigOpen()
	self.OnConfigInit()
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
		
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		
		_myStamina = AddSliderOption("$SNUSNU_STAMINA", snusnuMain.Stamina, "{0}")
		_mySpeed = AddSliderOption("$SNUSNU_SPEED", snusnuMain.Speed, "{0}")
		_myCombatProficiency = AddSliderOption("$SNUSNU_COMBAT", snusnuMain.combatProficiency, "{0}")
		_myBoostCarryWeight = AddSliderOption("Boost carry weight", snusnuMain.carryWeightBoost, "{2}") ;ToDo- WE NEED TO FIX THIS OPTION ASAP
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
		AddEmptyOption()
		AddEmptyOption()
		
		;AddHeaderOption("$SNUSNU_TRANSFORMATION")
		_mytfAnimation = AddToggleOption("$SNUSNU_USETFANIM", snusnuMain.tfAnimation)
		_mytfAnimationNPC = AddToggleOption("$SNUSNU_USETFANIMNPC", snusnuMain.tfAnimationNPC)
		_myuseAltAnims = AddToggleOption("$SNUSNU_USEALTANIMS", snusnuMain.useAltAnims)
		_myuseAltAnimsNPC = AddToggleOption("$SNUSNU_USEALTANIMSNPC", snusnuMain.useAltAnimsNPC)
		_mychangeHeadPart = AddToggleOption("$SNUSNU_CHANGEHEAD", snusnuMain.changeHeadPart)
		_myplayTFSound = AddToggleOption("$SNUSNU_PLAYTFSOUND", snusnuMain.playTFSound)
		If snusnuMain.isWeightMorphsLoaded
			_myRemoveWeightMorphs = AddToggleOption("$SNUSNU_NOWEIGHTMORPHS", snusnuMain.removeWeightMorphs)
		Else
			_myRemoveWeightMorphs = AddToggleOption("$SNUSNU_NOWEIGHTMORPHS", snusnuMain.removeWeightMorphs, OPTION_FLAG_DISABLED)
		EndIf
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		
		AddKeyMapOptionST("SnusnuDumpInfo","$SNUSNU_DUMPINFO", snusnuMain.getInfoKey)
		_myNPCMuscleScore = AddSliderOption("NPC Custom Muscle", (snusnuMain.npcMuscleScore/snusnuMain.muscleScoreMax)*100, "{0}%")
	ElseIf (a_page == Pages[1] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption("$SNUSNU_MORPHS_CBBE")
			AddEmptyOption()
			
			Int counter = 0
			while counter < 52
				cbbeSliders[counter] = AddSliderOption(cbbeStrings[counter], snusnuMain.cbbeValues[counter], "{2}")
				counter += 1
			endWhile
		Else ;CBBE SE
			AddHeaderOption("CBBE MORPHS PAGE 1")
			AddEmptyOption()
			AddHeaderOption("BREASTS")
			AddEmptyOption()
			cbbeSliders[0] = AddSliderOption("Size (Inverted)", snusnuMain.cbbeValues[0], "{2}")
			cbbeSliders[1] = AddSliderOption("Smaller 1 (Inverted)", snusnuMain.cbbeValues[1], "{2}")
			cbbeSESliders[0] = AddSliderOption("Smaller 2", snusnuMain.cbbeSEValues[0], "{2}")
			cbbeSESliders[1] = AddSliderOption("Silly Huge", snusnuMain.cbbeSEValues[1], "{2}")
			cbbeSESliders[2] = AddSliderOption("Silly Huge Symmetry", snusnuMain.cbbeSEValues[2], "{2}")
			cbbeSliders[4] = AddSliderOption("Fantasy", snusnuMain.cbbeValues[4], "{2}")
			cbbeSliders[5] = AddSliderOption("Melons", snusnuMain.cbbeValues[5], "{2}")
			bhunpSliders[0] = AddSliderOption("Push Together", snusnuMain.bhunpValues[0], "{2}")
			cbbe3BASliders[0] = AddSliderOption("Converge", snusnuMain.cbbe3BAValues[0], "{2}")
			bhunpSliders[1] = AddSliderOption("Center", snusnuMain.bhunpValues[1], "{2}")
			bhunpSliders[2] = AddSliderOption("Center Big", snusnuMain.bhunpValues[2], "{2}")
			cbbeSESliders[3] = AddSliderOption("Top Slope", snusnuMain.cbbeSEValues[3], "{2}")
			cbbeSliders[6] = AddSliderOption("Cleavage", snusnuMain.cbbeValues[6], "{2}")
			cbbeSESliders[4] = AddSliderOption("Flatness", snusnuMain.cbbeSEValues[4], "{2}")
			cbbeSliders[7] = AddSliderOption("More Flatness", snusnuMain.cbbeValues[7], "{2}")
			bhunpSliders[5] = AddSliderOption("Gone", snusnuMain.bhunpValues[5], "{2}")
			cbbeSESliders[5] = AddSliderOption("Gravity", snusnuMain.cbbeSEValues[5], "{2}")
			cbbeSliders[9] = AddSliderOption("Push Up", snusnuMain.cbbeValues[9], "{2}")
			cbbeSliders[10] = AddSliderOption("Height", snusnuMain.cbbeValues[10], "{2}")
			cbbeSliders[11] = AddSliderOption("Perkiness", snusnuMain.cbbeValues[11], "{2}")
			cbbeSliders[12] = AddSliderOption("Width", snusnuMain.cbbeValues[12], "{2}")
			cbbeSESliders[6] = AddSliderOption("Side Shape", snusnuMain.cbbeSEValues[6], "{2}")
			cbbeSESliders[7] = AddSliderOption("Under Depth", snusnuMain.cbbeSEValues[7], "{2}")
			cbbe3BASliders[1] = AddSliderOption("Pressed", snusnuMain.cbbe3BAValues[1], "{2}")
			AddHeaderOption("NIPPLES")
			AddEmptyOption()
			cbbeSESliders[8] = AddSliderOption("Areola Size", snusnuMain.cbbeSEValues[8], "{2}")
			cbbe3BASliders[2] = AddSliderOption("Areola Pull", snusnuMain.cbbe3BAValues[2], "{2}")
			cbbeSliders[18] = AddSliderOption("Point Up", snusnuMain.cbbeValues[18], "{2}")
			cbbeSliders[19] = AddSliderOption("Point Down", snusnuMain.cbbeValues[19], "{2}")
			cbbeSliders[16] = AddSliderOption("Size (Inverted)", snusnuMain.cbbeValues[16], "{2}")
			cbbeSliders[15] = AddSliderOption("Length", snusnuMain.cbbeValues[15], "{2}")
			cbbe3BASliders[3] = AddSliderOption("Squash Vertical", snusnuMain.cbbe3BAValues[3], "{2}")
			cbbe3BASliders[4] = AddSliderOption("Squash Horizontal", snusnuMain.cbbe3BAValues[4], "{2}")
			cbbeSESliders[9] = AddSliderOption("Defined", snusnuMain.cbbeSEValues[9], "{2}")
			cbbeSliders[14] = AddSliderOption("Perky", snusnuMain.cbbeValues[14], "{2}")
			cbbeSESliders[10] = AddSliderOption("Puffy", snusnuMain.cbbeSEValues[10], "{2}")
			
			cbbe3BASliders[5] = AddSliderOption("More Puffy", snusnuMain.cbbe3BAValues[5], "{2}")
			cbbe3BASliders[6] = AddSliderOption("Shy", snusnuMain.cbbe3BAValues[6], "{2}")
			cbbe3BASliders[7] = AddSliderOption("Thick", snusnuMain.cbbe3BAValues[7], "{2}")
			cbbe3BASliders[8] = AddSliderOption("Tube", snusnuMain.cbbe3BAValues[8], "{2}")
			cbbe3BASliders[9] = AddSliderOption("Crease", snusnuMain.cbbe3BAValues[9], "{2}")
			cbbe3BASliders[10] = AddSliderOption("Crumpled", snusnuMain.cbbe3BAValues[10], "{2}")
			cbbe3BASliders[11] = AddSliderOption("Bump", snusnuMain.cbbe3BAValues[11], "{2}")
			cbbe3BASliders[12] = AddSliderOption("Invert", snusnuMain.cbbe3BAValues[12], "{2}")

			cbbeSliders[20] = AddSliderOption("Nipple Tip", snusnuMain.cbbeValues[20], "{2}")
			cbbeSESliders[11] = AddSliderOption("Twist", snusnuMain.cbbeSEValues[11], "{2}")
			cbbeSliders[13] = AddSliderOption("Distance (Inverted)", snusnuMain.cbbeValues[13], "{2}")
			cbbeSESliders[12] = AddSliderOption("Dip", snusnuMain.cbbeSEValues[12], "{2}")
			bhunpSliders[8] = AddSliderOption("NipBGone", snusnuMain.bhunpValues[8], "{2}")
			
			AddHeaderOption("TORSO")
			AddEmptyOption()
			bhunpSliders[10] = AddSliderOption("Chest Depth", snusnuMain.bhunpValues[10], "{2}")
			bhunpSliders[11] = AddSliderOption("Chest Width", snusnuMain.bhunpValues[11], "{2}")
			cbbe3BASliders[13] = AddSliderOption("Clavicle", snusnuMain.cbbe3BAValues[13], "{2}")
			bhunpSliders[12] = AddSliderOption("Ribs", snusnuMain.bhunpValues[12], "{2}")
			cbbe3BASliders[14] = AddSliderOption("Protruded Ribs", snusnuMain.cbbe3BAValues[14], "{2}")
			bhunpSliders[13] = AddSliderOption("Sternum Depth", snusnuMain.bhunpValues[13], "{2}")
			bhunpSliders[14] = AddSliderOption("Sternum Height", snusnuMain.bhunpValues[14], "{2}")
			cbbeSliders[29] = AddSliderOption("Size", snusnuMain.cbbeValues[29], "{2}")
			cbbeSliders[33] = AddSliderOption("Back Size", snusnuMain.cbbeValues[33], "{2}")
			bhunpSliders[16] = AddSliderOption("Back Arch", snusnuMain.bhunpValues[16], "{2}")
			cbbe3BASliders[15] = AddSliderOption("Back Valley", snusnuMain.cbbe3BAValues[15], "{2}")
			cbbe3BASliders[16] = AddSliderOption("Back Wing", snusnuMain.cbbe3BAValues[16], "{2}")
			cbbeSESliders[13] = AddSliderOption("Navel Even", snusnuMain.cbbeSEValues[13], "{2}")
			cbbeSliders[30] = AddSliderOption("Waist Size (Inverted)", snusnuMain.cbbeValues[30], "{2}")
			bhunpSliders[15] = AddSliderOption("Waist Height", snusnuMain.bhunpValues[15], "{2}")
			cbbeSliders[31] = AddSliderOption("Waist Line", snusnuMain.cbbeValues[31], "{2}")
			cbbeSliders[32] = AddSliderOption("Chubby Waist", snusnuMain.cbbeValues[32], "{2}")
		EndIf
	ElseIf (a_page == Pages[2] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption("$SNUSNU_MORPHS_UUNP")
			AddEmptyOption()
			
			Int counter = 0
			while counter < 74
				uunpSliders[counter] = AddSliderOption(uunpStrings[counter], snusnuMain.uunpValues[counter], "{2}")
				counter += 1
			endWhile
		Else ;CBBE SE
			AddHeaderOption("CBBE MORPHS PAGE 2")
			AddEmptyOption()
			AddHeaderOption("BUTT")
			AddEmptyOption()
			cbbeSESliders[14] = AddSliderOption("Shape Classic", snusnuMain.cbbeSEValues[14], "{2}")
			cbbeSliders[37] = AddSliderOption("Shape Lower", snusnuMain.cbbeValues[37], "{2}")
			cbbeSliders[34] = AddSliderOption("Crack (Inverted)", snusnuMain.cbbeValues[34], "{2}")
			cbbeSliders[35] = AddSliderOption("Size (Inverted)", snusnuMain.cbbeValues[34], "{2}")
			cbbeSliders[36] = AddSliderOption("Smaller (Inverted)", snusnuMain.cbbeValues[36], "{2}")
			cbbeSliders[38] = AddSliderOption("Big", snusnuMain.cbbeValues[38], "{2}")
			cbbeSliders[39] = AddSliderOption("Chubby", snusnuMain.cbbeValues[39], "{2}")
			cbbeSliders[40] = AddSliderOption("Apple", snusnuMain.cbbeValues[40], "{2}")
			cbbe3BASliders[17] = AddSliderOption("Saggy", snusnuMain.cbbe3BAValues[17], "{2}")
			cbbe3BASliders[18] = AddSliderOption("Pressed", snusnuMain.cbbe3BAValues[18], "{2}")
			cbbe3BASliders[19] = AddSliderOption("Narrow", snusnuMain.cbbe3BAValues[19], "{2}")
			cbbeSESliders[15] = AddSliderOption("Dimples", snusnuMain.cbbeSEValues[15], "{2}")
			cbbeSESliders[16] = AddSliderOption("Under Fold", snusnuMain.cbbeSEValues[16], "{2}")
			cbbeSliders[41] = AddSliderOption("Round", snusnuMain.cbbeValues[41], "{2}")
			bhunpSliders[17] = AddSliderOption("Move Crotch", snusnuMain.bhunpValues[17], "{2}")
			cbbeSliders[42] = AddSliderOption("Groin", snusnuMain.cbbeValues[42], "{2}")
			
			AddHeaderOption("LEGS AND FEET")
			AddEmptyOption()
			cbbeSESliders[18] = AddSliderOption("Shape Classic", snusnuMain.cbbeSEValues[18], "{2}")
			cbbe3BASliders[20] = AddSliderOption("7B Legs", snusnuMain.cbbe3BAValues[20], "{2}")
			bhunpSliders[18] = AddSliderOption("Thin", snusnuMain.bhunpValues[18], "{2}")
			cbbeSliders[45] = AddSliderOption("Slim", snusnuMain.cbbeValues[45], "{2}")
			cbbeSliders[46] = AddSliderOption("Thighs", snusnuMain.cbbeValues[46], "{2}")
			cbbe3BASliders[21] = AddSliderOption("Outside", snusnuMain.cbbe3BAValues[21], "{2}")
			cbbe3BASliders[22] = AddSliderOption("Inside", snusnuMain.cbbe3BAValues[22], "{2}")
			cbbe3BASliders[23] = AddSliderOption("Front-Back", snusnuMain.cbbe3BAValues[23], "{2}")
			cbbeSliders[47] = AddSliderOption("Chubby", snusnuMain.cbbeValues[47], "{2}")
			cbbeSliders[48] = AddSliderOption("Size (Inverted)", snusnuMain.cbbeValues[48], "{2}")
			cbbe3BASliders[24] = AddSliderOption("Leg Spread", snusnuMain.cbbe3BAValues[24], "{2}")
			cbbeSliders[49] = AddSliderOption("Knee Height", snusnuMain.cbbeValues[49], "{2}")
			bhunpSliders[19] = AddSliderOption("Knee Shape", snusnuMain.bhunpValues[19], "{2}")
			cbbe3BASliders[25] = AddSliderOption("Knee Together", snusnuMain.cbbe3BAValues[25], "{2}")
			cbbeSliders[50] = AddSliderOption("Calf Size", snusnuMain.cbbeValues[50], "{2}")
			cbbeSliders[51] = AddSliderOption("Calf Smooth", snusnuMain.cbbeValues[51], "{2}")
			cbbe3BASliders[26] = AddSliderOption("Calf Front-Back", snusnuMain.cbbe3BAValues[26], "{2}")
			cbbeSESliders[19] = AddSliderOption("Feminine Feet", snusnuMain.cbbeSEValues[19], "{2}")
			AddHeaderOption("HIPS")
			AddEmptyOption()
			cbbe3BASliders[39] = AddSliderOption("Hip bone", snusnuMain.cbbe3BAValues[39], "{2}")
			cbbeSliders[44] = AddSliderOption("Size", snusnuMain.cbbeValues[44], "{2}")
			bhunpSliders[26] = AddSliderOption("Forward", snusnuMain.bhunpValues[26], "{2}")
			bhunpSliders[27] = AddSliderOption("Upper Width", snusnuMain.bhunpValues[27], "{2}")
			cbbeSESliders[17] = AddSliderOption("Carved", snusnuMain.cbbeSEValues[17], "{2}")
			cbbe3BASliders[31] = AddSliderOption("Hip Narrow", snusnuMain.cbbe3BAValues[31], "{2}")
			cbbe3BASliders[32] = AddSliderOption("UNP Hip", snusnuMain.cbbe3BAValues[32], "{2}")
			AddEmptyOption()
			AddHeaderOption("ARMS")
			AddEmptyOption()
			cbbeSliders[21] = AddSliderOption("Size (Inverted)", snusnuMain.cbbeValues[21], "{2}")
			bhunpSliders[28] = AddSliderOption("Forearm Size", snusnuMain.bhunpValues[28], "{2}")
			cbbeSliders[22] = AddSliderOption("Chubby", snusnuMain.cbbeValues[22], "{2}")
			cbbeSliders[23] = AddSliderOption("Shoulder Smooth", snusnuMain.cbbeValues[23], "{2}")
			cbbeSliders[24] = AddSliderOption("Shoulder Width (Inverted)", snusnuMain.cbbeValues[24], "{2}")
			bhunpSliders[29] = AddSliderOption("Shoulder Tweak", snusnuMain.bhunpValues[29], "{2}")
			cbbe3BASliders[33] = AddSliderOption("Armpit", snusnuMain.cbbe3BAValues[33], "{2}")
			AddEmptyOption()
			AddHeaderOption("BELLY")
			AddEmptyOption()
			cbbeSliders[25] = AddSliderOption("Size", snusnuMain.cbbeValues[25], "{2}")
			cbbeSliders[26] = AddSliderOption("Big", snusnuMain.cbbeValues[26], "{2}")
			cbbe3BASliders[34] = AddSliderOption("Front Up Fat", snusnuMain.cbbe3BAValues[34], "{2}")
			cbbe3BASliders[35] = AddSliderOption("Front Down Fat", snusnuMain.cbbe3BAValues[35], "{2}")
			cbbe3BASliders[36] = AddSliderOption("Side Up Fat", snusnuMain.cbbe3BAValues[36], "{2}")
			cbbe3BASliders[37] = AddSliderOption("Side Down Fat", snusnuMain.cbbe3BAValues[37], "{2}")
			cbbe3BASliders[38] = AddSliderOption("Under", snusnuMain.cbbe3BAValues[38], "{2}")
			cbbeSliders[27] = AddSliderOption("Pregnant", snusnuMain.cbbeValues[27], "{2}")
			cbbeSliders[28] = AddSliderOption("Tuck", snusnuMain.cbbeValues[28], "{2}")
		EndIf
	ElseIf (a_page == Pages[3] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption("$SNUSNU_MORPHS_BHUNP")
			AddEmptyOption()
			
			Int counter = 0
			while counter < 43
				bhunpSliders[counter] = AddSliderOption(bhunpStrings[counter], snusnuMain.bhunpValues[counter], "{2}")
				counter += 1
			endWhile
		Else ;CBBE SE
			AddHeaderOption("CBBE SPECIAL MORPHS")
			AddEmptyOption()
			AddHeaderOption("MUSCLE DEFINITION")
			AddEmptyOption()
			bhunpSliders[21] = AddSliderOption("Abs", snusnuMain.bhunpValues[21], "{2}")
			bhunpSliders[22] = AddSliderOption("Arms", snusnuMain.bhunpValues[22], "{2}")
			bhunpSliders[23] = AddSliderOption("Butt", snusnuMain.bhunpValues[23], "{2}")
			bhunpSliders[24] = AddSliderOption("Legs", snusnuMain.bhunpValues[24], "{2}")
			bhunpSliders[25] = AddSliderOption("Pecs", snusnuMain.bhunpValues[25], "{2}")
			cbbe3BASliders[30] = AddSliderOption("Back", snusnuMain.cbbe3BAValues[30], "{2}")
			cbbe3BASliders[27] = AddSliderOption("More Abs", snusnuMain.cbbe3BAValues[27], "{2}")
			cbbe3BASliders[28] = AddSliderOption("More Arms", snusnuMain.cbbe3BAValues[28], "{2}")
			cbbe3BASliders[29] = AddSliderOption("More Legs", snusnuMain.cbbe3BAValues[29], "{2}")
			AddEmptyOption()
			AddHeaderOption("FULL BODY")
			AddEmptyOption()
			cbbeSESliders[22] = AddSliderOption("VanillaSSELo", snusnuMain.cbbeSEValues[22], "{2}")
			cbbeSESliders[23] = AddSliderOption("VanillaSSEHi", snusnuMain.cbbeSEValues[23], "{2}")
			cbbeSESliders[25] = AddSliderOption("7B Lower", snusnuMain.cbbeSEValues[25], "{2}")
			cbbeSESliders[26] = AddSliderOption("7B Upper", snusnuMain.cbbeSEValues[26], "{2}")
			cbbeSESliders[24] = AddSliderOption("OldBaseShape", snusnuMain.cbbeSEValues[24], "{2}")
			AddEmptyOption()
			AddHeaderOption("SEAMS")
			AddEmptyOption()
			cbbeSESliders[20] = AddSliderOption("Ankle Size", snusnuMain.cbbeSEValues[20], "{2}")
			cbbeSESliders[21] = AddSliderOption("Wrist Size", snusnuMain.cbbeSEValues[21], "{2}")
		EndIf
	ElseIf ((a_page == Pages[4] && snusnuMain.selectedBody != 2) || (a_page == Pages[1] && snusnuMain.selectedBody == 2))
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$SNUSNU_MORPHS_MALE")
		AddEmptyOption()
		
		_myMultSamuel = AddSliderOption("Samuel", snusnuMain.MultSamuel, "{2}")
		_myMultSamson = AddSliderOption("Samson", snusnuMain.MultSamson, "{2}")
		
		AddEmptyOption()
		AddEmptyOption()
		AddHeaderOption("$SNUSNU_MORPHS_BONES")
		AddEmptyOption()
		_myMultSpineBone = AddSliderOption("Upper Spine", snusnuMain.MultSpineBone, "{3}")
		_myMultForearmBone = AddSliderOption("Forearms", snusnuMain.MultForearmBone, "{3}")
	ElseIf ((a_page == Pages[5] && snusnuMain.selectedBody != 2) || (a_page == Pages[2] && snusnuMain.selectedBody == 2))
		_mySaveOptions = AddToggleOption("Save Settings", False)
		_myLoadOptions = AddToggleOption("Load Settings", False)
		AddEmptyOption()
		AddEmptyOption()
		_mySaveMorphs = AddToggleOption("Save Morphs", False)
		_myLoadMorphs = AddToggleOption("Load Morphs", False)
		AddEmptyOption()
		AddEmptyOption()
		_mySaveMorphsProfile = AddToggleOption("Save Morphs Profile", False)
		_myLoadMorphsProfile = AddToggleOption("Load Morphs Profile", False)
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
	ElseIf a_option == _myBoostCarryWeight
		SetInfoText("How much to boost carry weight by getting more muscular")
	ElseIf a_option == _mytfAnimation
		SetInfoText("$SNUSNU_USETFANIM_DESC")
	ElseIf a_option == _mytfAnimationNPC
		SetInfoText("$SNUSNU_USETFANIMNPC_DESC")
	ElseIf a_option == _myuseAltAnims
		SetInfoText("$SNUSNU_USEALTANIMS_DESC")
	ElseIf a_option == _myuseAltAnimsNPC
		SetInfoText("$SNUSNU_USEALTANIMSNPC_DESC")
	ElseIf a_option == _myRemoveWeightMorphs
		SetInfoText("$SNUSNU_NOWEIGHTMORPHS_DESC")
	ElseIf a_option == _myUseWeightSlider
		SetInfoText("$SNUSNU_USEWEIGHTSLIDER_DESC")
	ElseIf a_option == _myDisableNormals
		SetInfoText("$SNUSNU_DISABLENORMALS_DESC")
;	ElseIf a_option == _mySelectedBody
;		SetInfoText("$SNUSNU_SELECTEDBODY_DESC")
	ElseIf a_option == _myZeroSliders
		SetInfoText("Set all slider values to 0.0")
	ElseIf a_option == _myApplyDefault
		SetInfoText("Apply recommended default morph values")
	ElseIf a_option == _myFoceScore
		SetInfoText("Force muscle score value. Only for debug purposes!!")
	ElseIf a_option == _myNPCMuscleScore
		SetInfoText("Muscle to apply to NPCs")
	ElseIf a_option == _myMalnourishment
		SetInfoText("At which WeightMorphs weigh value would the character be considered malnourished. Being malnourished greately reduces the muscle gain rate.")
	ElseIf a_option == _myPushupException
		SetInfoText("Add current equiped gear to push-up exceptions list.")
	
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
		SetToggleOptionValue(a_option, snusnuMain.Enabled)
		
		If snusnuMain.Enabled && ShowMessage("Enable Hardcore Mode?\n\nIn Hardcore Mode your initial muscle score will be set depending on your race\n(Orc: 50%, Nord: 35%, WoodElf/Redguard/Khajiit/Imperial: 25%, HighElf/DarkElf/Breton/Argonian: 0%),\nand it also restricts the usage of armor and weapons depending on your muscle score.", true, "Activate", "Don't")
			snusnuMain.hardcoreMode = true
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
	ElseIf a_option == _myHardcoreMode
		snusnuMain.hardcoreMode = !snusnuMain.hardcoreMode
		SetToggleOptionValue(a_option, snusnuMain.hardcoreMode)
		
		If !snusnuMain.hardcoreMode
			snusnuMain.cleanupHardcoreMode()
		EndIf
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
	ElseIf a_option == _myRemoveWeightMorphs
		snusnuMain.removeWeightMorphs = !snusnuMain.removeWeightMorphs
		SetToggleOptionValue(a_option, snusnuMain.removeWeightMorphs)
	ElseIf a_option == _myUseWeightSlider
		snusnuMain.useWeightSlider = !snusnuMain.useWeightSlider
		SetToggleOptionValue(a_option, snusnuMain.useWeightSlider)
	ElseIf a_option == _myDisableNormals
		snusnuMain.disableNormals = !snusnuMain.disableNormals
		
		If snusnuMain.disableNormals
			NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
		Else
			snusnuMain.checkBodyNormalsState()
		EndIf
		
		SetToggleOptionValue(a_option, snusnuMain.disableNormals)
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
			if saveSettings()
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
		
	ElseIf a_option == _myLoadMorphs
		
	ElseIf a_option == _mySaveMorphsProfile
		
	ElseIf a_option == _myLoadMorphsProfile
		
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
		SetSliderDialogStartValue((snusnuMain.npcMuscleScore/snusnuMain.muscleScoreMax)*100)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ElseIf a_option == _myMalnourishment
		SetSliderDialogStartValue(snusnuMain.malnourishmentValue)
		SetSliderDialogDefaultValue(-0.9)
		SetSliderDialogRange(-1.0, 0.0)
		SetSliderDialogInterval(0.02)
	
	;MALE SLIDERS - UNUSED FOR NOW
	ElseIf a_option == _myMultSamuel
		SetSliderDialogStartValue(snusnuMain.MultSamuel)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultSamson
		SetSliderDialogStartValue(snusnuMain.MultSamson)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
			
	ElseIf a_option == _myMultSpineBone
		SetSliderDialogStartValue(snusnuMain.MultSpineBone)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 2.0)
		SetSliderDialogInterval(0.001)
	ElseIf a_option == _myMultForearmBone
		SetSliderDialogStartValue(snusnuMain.MultForearmBone)
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
	ElseIf a_option == _myBoostCarryWeight
		snusnuMain.carryWeightBoost = a_value
		snusnuMain.updateCarryWeight()
		SetSliderOptionValue(a_option, snusnuMain.carryWeightBoost, "{2}")
	ElseIf a_option == _myStamina
		snusnuMain.Stamina = a_value
		SetSliderOptionValue(a_option, snusnuMain.Stamina, "{0}")
		snusnuMain.UpdateEffects()
	ElseIf a_option == _mySpeed
		snusnuMain.Speed = a_value
		SetSliderOptionValue(a_option, snusnuMain.Speed, "{0}")
		snusnuMain.UpdateEffects()
	ElseIf a_option == _myCombatProficiency
		snusnuMain.combatProficiency = a_value
		SetSliderOptionValue(a_option, snusnuMain.combatProficiency, "{0}")
		snusnuMain.UpdateEffects()
	ElseIf a_option == _myMaxWeight
		Float difference = a_value / snusnuMain.muscleScoreMax
		snusnuMain.muscleScoreMax = a_value
		SetSliderOptionValue(a_option, snusnuMain.muscleScoreMax, "{2}")
		;If snusnuMain.muscleScoreMax < snusnuMain.muscleScore
			;snusnuMain.updateMuscleScore(0)
			snusnuMain.recalculateAllMuscleVars(difference)
			snusnuMain.UpdateWeight()
			snusnuMain.UpdateEffects()
			;SetTextOptionValue(_myFightingScore, snusnuMain.getMuscleValuePercent(snusnuMain.muscleScore)+"%")
		;EndIf
	ElseIf a_option == _myFoceScore
		snusnuMain.ForceNewWeight(a_value)
		SetSliderOptionValue(a_option, a_value, "{3}")
	ElseIf a_option == _myNPCMuscleScore
		snusnuMain.npcMuscleScore = (a_value/100)*snusnuMain.muscleScoreMax
		Debug.Notification("New npcMuscleScore value is "+snusnuMain.npcMuscleScore)
		SetSliderOptionValue(a_option, a_value, "{0}%")
	ElseIf a_option == _myMalnourishment	
		snusnuMain.malnourishmentValue = a_value
		SetSliderOptionValue(a_option, snusnuMain.malnourishmentValue, "{2}")
		
	;MALE SLIDERS - UNUSED FOR NOW
	ElseIf a_option == _myMultSamuel
		snusnuMain.MultSamuel = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSamuel, "{2}")
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultSamson
		snusnuMain.MultSamson = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSamson, "{2}")
		snusnuMain.UpdateWeight()
		
	;GENERIC BONES MORPHS
	ElseIf a_option == _myMultSpineBone
		snusnuMain.MultSpineBone = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSpineBone, "{3}")
		;TLALOC-ToDo: Do we need to add this to an array?
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultForearmBone
		snusnuMain.MultForearmBone = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultForearmBone, "{3}")
		;TLALOC-ToDo: Do we need to add this to an array?
		snusnuMain.UpdateWeight()
		
	Else
		int sliderIndex = 0
		
		bool found=false
		int counter = 0
		
		;CBBE SLIDERS
		while(counter < 52 && !found)
			If a_option == cbbeSliders[counter]
				SetSliderOptionValue(a_option, a_value, "{2}")
				
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
					
					snusnuMain.setSliderValue(sliderIndex, a_value)
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
	EndIf
	snusnuMain.ReloadHotkeys()
EndEvent

Bool function KeyConflict(Int KeyCode, String ConflictControl, String ConflictName)
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
	JsonUtil.SetFloatValue(fileName, "malnourishmentValue", snusnuMain.malnourishmentValue)
	JsonUtil.SetIntValue(fileName, "tfAnimation", snusnuMain.tfAnimation as Int)
	JsonUtil.SetIntValue(fileName, "tfAnimationNPC", snusnuMain.tfAnimationNPC as Int)
	JsonUtil.SetIntValue(fileName, "useAltAnims", snusnuMain.useAltAnims as Int)
	JsonUtil.SetIntValue(fileName, "useAltAnimsNPC", snusnuMain.useAltAnimsNPC as Int)
	JsonUtil.SetIntValue(fileName, "changeHeadPart", snusnuMain.changeHeadPart as Int)
	JsonUtil.SetIntValue(fileName, "playTFSound", snusnuMain.playTFSound as Int)
	JsonUtil.SetIntValue(fileName, "removeWeightMorphs", snusnuMain.removeWeightMorphs as Int)
	JsonUtil.SetIntValue(fileName, "getInfoKey", snusnuMain.getInfoKey)
	JsonUtil.SetFloatValue(fileName, "npcMuscleScore", snusnuMain.npcMuscleScore)
	
	Return JsonUtil.Save(fileName, False)
EndFunction

bool Function loadSettings()
	String fileName = "SnusnuSettings"
	
	if JsonUtil.JsonExists(fileName)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.Enabled = JsonUtil.GetIntValue(fileName, "Enabled", snusnuMain.Enabled as Int)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.hardcoreMode = JsonUtil.GetIntValue(fileName, "hardcoreMode", snusnuMain.hardcoreMode as Int)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.selectedBody = JsonUtil.GetIntValue(fileName, "selectedBody", snusnuMain.selectedBody)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.disableNormals = JsonUtil.GetIntValue(fileName, "disableNormals", snusnuMain.disableNormals as Int)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.Stamina = JsonUtil.GetFloatValue(fileName, "Stamina", snusnuMain.Stamina)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.Speed = JsonUtil.GetFloatValue(fileName, "Speed", snusnuMain.Speed)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.combatProficiency = JsonUtil.GetFloatValue(fileName, "combatProficiency", snusnuMain.combatProficiency)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.carryWeightBoost = JsonUtil.GetFloatValue(fileName, "carryWeightBoost", snusnuMain.carryWeightBoost)
		;NEEDS PROPER HANDLING!! ----> snusnuMain.muscleScoreMax = JsonUtil.GetFloatValue(fileName, "muscleScoreMax", snusnuMain.muscleScoreMax)
		snusnuMain.MultLoss = JsonUtil.GetFloatValue(fileName, "MultLoss", snusnuMain.MultLoss)
		snusnuMain.MultGainFight = JsonUtil.GetFloatValue(fileName, "MultGainFight", snusnuMain.MultGainFight)
		snusnuMain.MultGainArmor = JsonUtil.GetFloatValue(fileName, "MultGainArmor", snusnuMain.MultGainArmor)
		snusnuMain.MultGainMisc = JsonUtil.GetFloatValue(fileName, "MultGainMisc", snusnuMain.MultGainMisc)
		snusnuMain.malnourishmentValue = JsonUtil.GetFloatValue(fileName, "malnourishmentValue", snusnuMain.malnourishmentValue)
		snusnuMain.tfAnimation = JsonUtil.GetIntValue(fileName, "tfAnimation", snusnuMain.tfAnimation as Int)
		snusnuMain.tfAnimationNPC = JsonUtil.GetIntValue(fileName, "tfAnimationNPC", snusnuMain.tfAnimationNPC as Int)
		snusnuMain.useAltAnims = JsonUtil.GetIntValue(fileName, "useAltAnims", snusnuMain.useAltAnims as Int)
		snusnuMain.useAltAnimsNPC = JsonUtil.GetIntValue(fileName, "useAltAnimsNPC", snusnuMain.useAltAnimsNPC as Int)
		snusnuMain.changeHeadPart = JsonUtil.GetIntValue(fileName, "changeHeadPart", snusnuMain.changeHeadPart as Int)
		snusnuMain.playTFSound = JsonUtil.GetIntValue(fileName, "playTFSound", snusnuMain.playTFSound as Int)
		snusnuMain.removeWeightMorphs = JsonUtil.GetIntValue(fileName, "removeWeightMorphs", snusnuMain.removeWeightMorphs as Int)
		snusnuMain.getInfoKey = JsonUtil.GetIntValue(fileName, "getInfoKey", snusnuMain.getInfoKey)
		snusnuMain.npcMuscleScore = JsonUtil.GetFloatValue(fileName, "npcMuscleScore", snusnuMain.npcMuscleScore)
		
		return true
	EndIf
	
	return false
EndFunction

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
		
		if snusnuMain.selectedBody == 2
			snusnuMain.useWeightSlider = true
		Else
			snusnuMain.useWeightSlider = false
		EndIf
		
		String Msg
		Msg = "Please exit this menu and enter again for the changes to be correctly applied."
		ShowMessage(Msg, False)
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
		
		if selectedDefaultMorphs == 2
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
