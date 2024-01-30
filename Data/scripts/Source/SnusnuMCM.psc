ScriptName SnusnuMCM Extends SKI_ConfigBase

Import StorageUtil

; Version data
Int Property SKEE_VERSION = 1 AutoReadOnly
Int Property NIOVERRIDE_SCRIPT_VERSION = 6 AutoReadOnly

Actor Property PlayerRef Auto
Snusnu Property snusnuMain Auto

Int _myEnabled
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
;Int _mySelectedBody

;CBBE Sliders
Int _myMultBreasts
Int _myMultBreastsSmall
Int _myMultBreastsSH
Int _myMultBreastsSSH
Int _myMultBreastsFantasy
Int _myMultDoubleMelon
Int _myMultBreastCleavage
Int _myMultBreastFlatness
Int _myMultBreastGravity
Int _myMultPushUp
Int _myMultBreastHeight
Int _myMultBreastPerkiness
Int _myMultBreastWidth

Int _myMultNippleDistance
Int _myMultNipplePerkiness
Int _myMultNippleLength
Int _myMultNippleSize
Int _myMultNippleAreola
Int _myMultNippleUp
Int _myMultNippleDown
Int _myMultNippleTip

Int _myMultArms
Int _myMultChubbyArms
Int _myMultShoulderSmooth
Int _myMultShoulderWidth

Int _myMultBelly
Int _myMultBigBelly
Int _myMultPregnancyBelly
Int _myMultTummyTuck

Int _myMultBigTorso
Int _myMultWaist
Int _myMultWideWaistLine
Int _myMultChubbyWaist
Int _myMultBack

Int _myMultHipbone
Int _myMultHips

Int _myMultButtCrack
Int _myMultButt
Int _myMultButtSmall
Int _myMultButtShape2
Int _myMultBigButt
Int _myMultChubbyButt
Int _myMultAppleCheeks
Int _myMultRoundAss
Int _myMultGroin

Int _myMultSlimThighs
Int _myMultThighs
Int _myMultChubbyLegs
Int _myMultLegs
Int _myMultKneeHeight
Int _myMultCalfSize
Int _myMultCalfSmooth

;TLALOC - Bone sliders
Int _myMultSpineBone
Int _myMultForearmBone

;TLALOC - UUNP sliders
Int _myMult7BLow
Int _myMult7BHigh
Int _myMult7BBombshellLow
Int _myMult7BBombshellHigh
Int _myMult7BNaturalLow
Int _myMult7BNaturalHigh
Int _myMult7BCleavageLow
Int _myMult7BCleavageHigh
Int _myMult7BBCupLow
Int _myMult7BBCupHigh
Int _myMult7BUNPLow
Int _myMult7BUNPHigh
Int _myMult7BCHLow
Int _myMult7BCHHigh
Int _myMult7BOppaiLow
Int _myMult7BOppaiHigh
Int _myMultUNPLow
Int _myMultUNPHigh
Int _myMultUNPPushupLow
Int _myMultUNPPushupHigh
Int _myMultUNPSkinnyLow
Int _myMultUNPSkinnyHigh
Int _myMultUNPPerkyLow
Int _myMultUNPPerkyHigh
Int _myMultUNPBLow
Int _myMultUNPBHigh
Int _myMultUNPBChapi
Int _myMultUNPBOppaiv1
Int _myMultUNPBOppaiv3Low
Int _myMultUNPBOppaiv3High
Int _myMultUNPetiteLow
Int _myMultUNPetiteHigh
Int _myMultUNPCLow
Int _myMultUNPCHigh
Int _myMultUNPCMLow
Int _myMultUNPCMHigh
Int _myMultUNPSHLow
Int _myMultUNPSHHigh
Int _myMultUNPKLow
Int _myMultUNPKHigh
Int _myMultUNPKBonusLow
Int _myMultUNPKBonusHigh
Int _myMultUN7BLow
Int _myMultUN7BHigh
Int _myMultUNPBBLow
Int _myMultUNPBBHigh
Int _myMultSeraphimLow
Int _myMultSeraphimHigh
Int _myMultDemonfetLow
Int _myMultDemonfetHigh
Int _myMultDreamGirlLow
Int _myMultDreamGirlHigh
Int _myMultTopModelLow
Int _myMultTopModelHigh
Int _myMultLeitoLow
Int _myMultLeitoHigh
Int _myMultUNPFLow
Int _myMultUNPFHigh
Int _myMultUNPFxLow
Int _myMultUNPFxHigh
Int _myMultCNHFLow
Int _myMultCNHFHigh
Int _myMultCNHFBonusLow
Int _myMultCNHFBonusHigh
Int _myMultMCBMLow
Int _myMultMCBMHigh
Int _myMultVenusLow
Int _myMultVenusHigh
Int _myMultZGGBR2Low
Int _myMultZGGBR2High
Int _myMultMangaLow
Int _myMultMangaHigh
Int _myMultCHSBHCLow
Int _myMultCHSBHCHigh

;BHUNP Sliders
Int _myMultBreastsTogether
Int _myMultBreastCenter
Int _myMultBreastCenterBig
Int _myMultTopSlope
Int _myMultBreastConverge
Int _myMultBreastsGone
Int _myMultBreastsPressed
Int _myMultNipplePuffyAreola
Int _myMultNipBGone
Int _myMultNippleInverted
Int _myMultChestDepth
Int _myMultChestWidth
Int _myMultRibsProminance
Int _myMultSternumDepth
Int _myMultSternumHeight
Int _myMultWaistHeight
Int _myMultBackArch
Int _myMultCrotchBack
Int _myMultLegsThin
Int _myMultKneeShape
Int _myMultKneeSlim
Int _myMultMuscleAbs
Int _myMultMuscleArms
Int _myMultMuscleButt
Int _myMultMuscleLegs
Int _myMultMusclePecs
Int _myMultHipForward
Int _myMultHipUpperWidth
Int _myMultForearmSize
Int _myMultShoulderTweak
Int _myMultBotePregnancy
Int _myMultBellyFatLower
Int _myMultBellyFatUpper
Int _myMultBellyObesity
Int _myMultBellyPressed
Int _myMultBellyLowerSwell1
Int _myMultBellyLowerSwell2
Int _myMultBellyLowerSwell3
Int _myMultBellyCenterProtrude
Int _myMultBellyCenterUpperProtrude
Int _myMultBellyBalls
Int _myMultAruru6DuckLow
Int _myMultAruru6DuckHigh

;CBBE SE Sliders
Int _myMultBreastsSmall2
Int _myMultBreastsNewSH
Int _myMultBreastsNewSHSymmetry
Int _myMultBreastTopSlope
Int _myMultBreastFlatness2
Int _myMultBreastGravity2
Int _myMultBreastSideShape
Int _myMultBreastUnderDepth
Int _myMultAreolaSize
Int _myMultNippleManga
Int _myMultNipplePerkManga
Int _myMultNippleTipManga
Int _myMultNippleDip
Int _myMultNavelEven
Int _myMultButtClassic
Int _myMultButtDimples
Int _myMultButtUnderFold
Int _myMultHipCarved
Int _myMultLegShapeClassic
Int _myMultFeetFeminine
Int _myMultAnkleSize
Int _myMultWristSize
Int _myMultVanillaSSELo
Int _myMultVanillaSSEHi
Int _myMultOldBaseShape
Int _myMult7BLower
Int _myMult7BUpper

; Male morphs
Int _myMultSamuel
Int _myMultSamson

Event OnConfigInit()
	Pages = new String[6]
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
		Pages[5] = "$SNUSNU_INFO"
	Else
		Pages[1] = "$SNUSNU_MORPHS_MALE"
		Pages[2] = "$SNUSNU_INFO"
	EndIf
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
		Msg = "This mod now has support for CBBE UUNP/BHUNP and Vanilla bodies. To get the best experience out of it, you need to set the \"Current body installed\" option to the body you are currently using."
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
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		
		;_mySelectedBody = AddToggleOption("$SNUSNU_SELECTEDBODY", snusnuMain.selectedBody)
		AddMenuOptionST("InstalledBody", "$SNUSNU_SELECTEDBODY", GetConditionalString(snusnuMain.selectedBody))
		;_myUseWeightSlider = AddToggleOption("$SNUSNU_USEWEIGHTSLIDER", snusnuMain.useWeightSlider)
		_myDisableNormals = AddToggleOption("$SNUSNU_DISABLENORMALS", snusnuMain.disableNormals)
		
		AddEmptyOption()
		AddEmptyOption()
		
		_myStamina = AddSliderOption("$SNUSNU_STAMINA", snusnuMain.Stamina, "{0}")
		_mySpeed = AddSliderOption("$SNUSNU_SPEED", snusnuMain.Speed, "{0}")
		_myCombatProficiency = AddSliderOption("$SNUSNU_COMBAT", snusnuMain.combatProficiency, "{0}")
		_myMaxWeight = AddSliderOption("$SNUSNU_MAXWEIGHT", snusnuMain.muscleScoreMax, "{2}")
		_myFightingScore = AddTextOption("$SNUSNU_MUSCLE", snusnuMain.muscleScore, OPTION_FLAG_DISABLED)
		_myStoredScore = AddTextOption("$SNUSNU_MUSCLE_STORED", snusnuMain.storedMuscle, OPTION_FLAG_DISABLED)
		AddEmptyOption()
		AddEmptyOption()
		
		_myMultLoss = AddSliderOption("$SNUSNU_MULTLOSS", snusnuMain.MultLoss, "{2}")
		_myMultGainFight = AddSliderOption("$SNUSNU_MULTGAINFIGHT", snusnuMain.MultGainFight, "{2}")
		_myMultGainArmor = AddSliderOption("$SNUSNU_MULTGAINARMOR", snusnuMain.MultGainArmor, "{2}")
		_myMultGainMisc = AddSliderOption("$SNUSNU_MULTGAINMISC", snusnuMain.MultGainMisc, "{2}")
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
	ElseIf (a_page == Pages[1] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption("$SNUSNU_MORPHS_CBBE")
			AddEmptyOption()
			
			_myMultBreasts = AddSliderOption("Breasts (Inverted)", snusnuMain.MultBreasts, "{2}")
			_myMultBreastsSmall = AddSliderOption("Breasts Small (Inverted)", snusnuMain.MultBreastsSmall, "{2}")
			_myMultBreastsSH = AddSliderOption("Breasts SH", snusnuMain.MultBreastsSH, "{2}")
			_myMultBreastsSSH = AddSliderOption("Breasts SSH", snusnuMain.MultBreastsSSH, "{2}")
			_myMultBreastsFantasy = AddSliderOption("Breasts Fantasy", snusnuMain.MultBreastsFantasy, "{2}")
			_myMultDoubleMelon = AddSliderOption("Double Melon", snusnuMain.MultDoubleMelon, "{2}")
			_myMultBreastCleavage = AddSliderOption("Breast Cleavage", snusnuMain.MultBreastCleavage, "{2}")
			_myMultBreastFlatness = AddSliderOption("Breast Flatness", snusnuMain.MultBreastFlatness, "{2}")
			_myMultBreastGravity = AddSliderOption("Breast Gravity", snusnuMain.MultBreastGravity, "{2}")
			_myMultPushUp = AddSliderOption("Pushup", snusnuMain.MultPushUp, "{2}")
			_myMultBreastHeight = AddSliderOption("Breast Height", snusnuMain.MultBreastHeight, "{2}")
			_myMultBreastPerkiness = AddSliderOption("Breast Perkiness", snusnuMain.MultBreastPerkiness, "{2}")
			_myMultBreastWidth = AddSliderOption("Breast Width", snusnuMain.MultBreastWidth, "{2}")
			
			_myMultNippleDistance = AddSliderOption("Nipple Distance (Inverted)", snusnuMain.MultNippleDistance, "{2}")
			_myMultNipplePerkiness = AddSliderOption("Nipple Perkiness", snusnuMain.MultNipplePerkiness, "{2}")
			_myMultNippleLength = AddSliderOption("Nipple Length", snusnuMain.MultNippleLength, "{2}")
			_myMultNippleSize = AddSliderOption("Nipple Size (Inverted)", snusnuMain.MultNippleSize, "{2}")
			_myMultNippleAreola = AddSliderOption("Nipple Areola", snusnuMain.MultNippleAreola, "{2}")
			_myMultNippleUp = AddSliderOption("Nipple Up", snusnuMain.MultNippleUp, "{2}")
			_myMultNippleDown = AddSliderOption("Nipple Down", snusnuMain.MultNippleDown, "{2}")
			_myMultNippleTip = AddSliderOption("Nipple Tip", snusnuMain.MultNippleTip, "{2}")
			
			_myMultArms = AddSliderOption("Arms (Inverted)", snusnuMain.MultArms, "{2}")
			_myMultChubbyArms = AddSliderOption("Chubby Arms", snusnuMain.MultChubbyArms, "{2}")
			_myMultShoulderSmooth = AddSliderOption("Shoulder Smooth", snusnuMain.MultShoulderSmooth, "{2}")
			_myMultShoulderWidth = AddSliderOption("Shoulder Width (Inverted)", snusnuMain.MultShoulderWidth, "{2}")
			
			_myMultBelly = AddSliderOption("Belly", snusnuMain.MultBelly, "{2}")
			_myMultBigBelly = AddSliderOption("Big Belly", snusnuMain.MultBigBelly, "{2}")
			_myMultPregnancyBelly = AddSliderOption("Pregnancy Belly", snusnuMain.MultPregnancyBelly, "{2}")
			_myMultTummyTuck = AddSliderOption("Tummy Tuck", snusnuMain.MultTummyTuck, "{2}")
			
			_myMultBigTorso = AddSliderOption("Big Torso", snusnuMain.MultBigTorso, "{2}")
			_myMultWaist = AddSliderOption("Waist (Inverted)", snusnuMain.MultWaist, "{2}")
			_myMultWideWaistLine = AddSliderOption("Wide Waist Line", snusnuMain.MultWideWaistLine, "{2}")
			_myMultChubbyWaist = AddSliderOption("Chubby Waist", snusnuMain.MultChubbyWaist, "{2}")
			_myMultBack = AddSliderOption("Back", snusnuMain.MultBack, "{2}")
			
			_myMultButtCrack = AddSliderOption("Butt Crack (Inverted)", snusnuMain.MultButtCrack, "{2}")
			_myMultButt = AddSliderOption("Butt (Inverted)", snusnuMain.MultButt, "{2}")
			_myMultButtSmall = AddSliderOption("Butt Small (Inverted)", snusnuMain.MultButtSmall, "{2}")
			_myMultButtShape2 = AddSliderOption("Butt Shape 2", snusnuMain.MultButtShape2, "{2}")
			_myMultBigButt = AddSliderOption("Big Butt", snusnuMain.MultBigButt, "{2}")
			_myMultChubbyButt = AddSliderOption("Chubby Butt", snusnuMain.MultChubbyButt, "{2}")
			_myMultAppleCheeks = AddSliderOption("Apple Cheeks", snusnuMain.MultAppleCheeks, "{2}")
			_myMultRoundAss = AddSliderOption("Round Ass", snusnuMain.MultRoundAss, "{2}")
			_myMultGroin = AddSliderOption("Groin", snusnuMain.MultGroin, "{2}")
			
			_myMultHipbone = AddSliderOption("Hipbone", snusnuMain.MultHipbone, "{2}")
			_myMultHips = AddSliderOption("Hips", snusnuMain.MultHips, "{2}")
			
			_myMultSlimThighs = AddSliderOption("Slim Thighs", snusnuMain.MultSlimThighs, "{2}")
			_myMultThighs = AddSliderOption("Thighs", snusnuMain.MultThighs, "{2}")
			_myMultChubbyLegs = AddSliderOption("Chubby Legs", snusnuMain.MultChubbyLegs, "{2}")
			_myMultLegs = AddSliderOption("Legs (Inverted)", snusnuMain.MultLegs, "{2}")
			_myMultKneeHeight = AddSliderOption("Knee Height", snusnuMain.MultKneeHeight, "{2}")
			_myMultCalfSize = AddSliderOption("Calf Size", snusnuMain.MultCalfSize, "{2}")
			_myMultCalfSmooth = AddSliderOption("Calf Smooth", snusnuMain.MultCalfSmooth, "{2}")
		Else ;CBBE SE
			AddHeaderOption("CBBE MORPHS PAGE 1")
			AddEmptyOption()
			AddHeaderOption("BREASTS")
			AddEmptyOption()
			_myMultBreasts = AddSliderOption("Size (Inverted)", snusnuMain.MultBreasts, "{2}")
			_myMultBreastsSmall = AddSliderOption("Smaller 1 (Inverted)", snusnuMain.MultBreastsSmall, "{2}")
			_myMultBreastsSmall2 = AddSliderOption("Smaller 2", snusnuMain.MultBreastsSmall2, "{2}")
			_myMultBreastsNewSH = AddSliderOption("Silly Huge", snusnuMain.MultBreastsNewSH, "{2}")
			_myMultBreastsNewSHSymmetry = AddSliderOption("Silly Huge Symmetry", snusnuMain.MultBreastsNewSHSymmetry, "{2}")
			_myMultBreastsFantasy = AddSliderOption("Fantasy", snusnuMain.MultBreastsFantasy, "{2}")
			_myMultDoubleMelon = AddSliderOption("Melons", snusnuMain.MultDoubleMelon, "{2}")
			_myMultBreastsTogether = AddSliderOption("Push Together", snusnuMain.MultBreastsTogether, "{2}")
			_myMultBreastCenter = AddSliderOption("Center", snusnuMain.MultBreastCenter, "{2}")
			_myMultBreastCenterBig = AddSliderOption("Center Big", snusnuMain.MultBreastCenterBig, "{2}")
			_myMultBreastTopSlope = AddSliderOption("Top Slope", snusnuMain.MultBreastTopSlope, "{2}")
			_myMultBreastCleavage = AddSliderOption("Cleavage", snusnuMain.MultBreastCleavage, "{2}")
			_myMultBreastFlatness2 = AddSliderOption("Flatness", snusnuMain.MultBreastFlatness, "{2}")
			_myMultBreastFlatness = AddSliderOption("More Flatness", snusnuMain.MultBreastFlatness, "{2}")
			_myMultBreastsGone = AddSliderOption("Gone", snusnuMain.MultBreastsGone, "{2}")
			_myMultBreastGravity2 = AddSliderOption("Gravity", snusnuMain.MultBreastGravity2, "{2}")
			_myMultPushUp = AddSliderOption("Push Up", snusnuMain.MultPushUp, "{2}")
			_myMultBreastHeight = AddSliderOption("Height", snusnuMain.MultBreastHeight, "{2}")
			_myMultBreastPerkiness = AddSliderOption("Perkiness", snusnuMain.MultBreastPerkiness, "{2}")
			_myMultBreastWidth = AddSliderOption("Width", snusnuMain.MultBreastWidth, "{2}")
			_myMultBreastSideShape = AddSliderOption("Side Shape", snusnuMain.MultBreastSideShape, "{2}")
			_myMultBreastUnderDepth = AddSliderOption("Under Depth", snusnuMain.MultBreastUnderDepth, "{2}")
			AddHeaderOption("NIPPLES")
			AddEmptyOption()
			_myMultAreolaSize = AddSliderOption("Areola Size", snusnuMain.MultAreolaSize, "{2}")
			_myMultNippleUp = AddSliderOption("Point Up", snusnuMain.MultNippleUp, "{2}")
			_myMultNippleDown = AddSliderOption("Point Down", snusnuMain.MultNippleDown, "{2}")
			_myMultNippleSize = AddSliderOption("Size (Inverted)", snusnuMain.MultNippleSize, "{2}")
			_myMultNippleLength = AddSliderOption("Length", snusnuMain.MultNippleLength, "{2}")
			_myMultNippleManga = AddSliderOption("Defined", snusnuMain.MultNippleManga, "{2}")
			_myMultNipplePerkiness = AddSliderOption("Perky", snusnuMain.MultNipplePerkiness, "{2}")
			_myMultNipplePerkManga = AddSliderOption("Puffy", snusnuMain.MultNipplePerkManga, "{2}")
			_myMultNippleTip = AddSliderOption("Nipple Tip", snusnuMain.MultNippleTip, "{2}")
			_myMultNippleTipManga = AddSliderOption("Twist", snusnuMain.MultNippleTipManga, "{2}")
			_myMultNippleDistance = AddSliderOption("Distance (Inverted)", snusnuMain.MultNippleDistance, "{2}")
			_myMultNippleDip = AddSliderOption("Dip", snusnuMain.MultNippleDip, "{2}")
			_myMultNipBGone = AddSliderOption("NipBGone", snusnuMain.MultNipBGone, "{2}")
			AddEmptyOption()
			AddHeaderOption("TORSO")
			AddEmptyOption()
			_myMultChestDepth = AddSliderOption("Chest Depth", snusnuMain.MultChestDepth, "{2}")
			_myMultChestWidth = AddSliderOption("Chest Width", snusnuMain.MultChestWidth, "{2}")
			_myMultRibsProminance = AddSliderOption("Ribs", snusnuMain.MultRibsProminance, "{2}")
			_myMultSternumDepth = AddSliderOption("Sternum Depth", snusnuMain.MultSternumDepth, "{2}")
			_myMultSternumHeight = AddSliderOption("Sternum Height", snusnuMain.MultSternumHeight, "{2}")
			_myMultBigTorso = AddSliderOption("Size", snusnuMain.MultBigTorso, "{2}")
			_myMultWaist = AddSliderOption("Waist Size (Inverted)", snusnuMain.MultWaist, "{2}")
			_myMultWaistHeight = AddSliderOption("Waist Height", snusnuMain.MultWaistHeight, "{2}")
			_myMultWideWaistLine = AddSliderOption("Waist Line", snusnuMain.MultWideWaistLine, "{2}")
			_myMultChubbyWaist = AddSliderOption("Chubby Waist", snusnuMain.MultChubbyWaist, "{2}")
			_myMultBack = AddSliderOption("Back Size", snusnuMain.MultBack, "{2}")
			_myMultBackArch = AddSliderOption("Back Arch", snusnuMain.MultBackArch, "{2}")
			_myMultNavelEven = AddSliderOption("Navel Even", snusnuMain.MultNavelEven, "{2}")
		EndIf
	ElseIf (a_page == Pages[2] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption("$SNUSNU_MORPHS_UUNP")
			AddEmptyOption()
			
			_myMult7BLow = AddSliderOption("7B Low", snusnuMain.Mult7BLow, "{2}")
			_myMult7BHigh = AddSliderOption("7B High", snusnuMain.Mult7BHigh, "{2}")
			_myMult7BBombshellLow = AddSliderOption("7B Bombshell Low", snusnuMain.Mult7BBombshellLow, "{2}")
			_myMult7BBombshellHigh = AddSliderOption("7B Bombshell High", snusnuMain.Mult7BBombshellHigh, "{2}")
			_myMult7BNaturalLow = AddSliderOption("7B Natural Low", snusnuMain.Mult7BNaturalLow, "{2}")
			_myMult7BNaturalHigh = AddSliderOption("7B Natural High", snusnuMain.Mult7BNaturalHigh, "{2}")
			_myMult7BCleavageLow = AddSliderOption("7B Cleavage Low", snusnuMain.Mult7BCleavageLow, "{2}")
			_myMult7BCleavageHigh = AddSliderOption("7B Cleavage High", snusnuMain.Mult7BCleavageHigh, "{2}")
			_myMult7BBCupLow = AddSliderOption("7B BCup Low", snusnuMain.Mult7BBCupLow, "{2}")
			_myMult7BBCupHigh = AddSliderOption("7B BCup High", snusnuMain.Mult7BBCupHigh, "{2}")
			_myMult7BUNPLow = AddSliderOption("7BUNP Low", snusnuMain.Mult7BUNPLow, "{2}")
			_myMult7BUNPHigh = AddSliderOption("7BUNP High", snusnuMain.Mult7BUNPHigh, "{2}")
			_myMult7BCHLow = AddSliderOption("7B CH Low", snusnuMain.Mult7BCHLow, "{2}")
			_myMult7BCHHigh = AddSliderOption("7B CH High", snusnuMain.Mult7BCHHigh, "{2}")
			_myMult7BOppaiLow = AddSliderOption("7B Oppai Low", snusnuMain.Mult7BOppaiLow, "{2}")
			_myMult7BOppaiHigh = AddSliderOption("7B Oppai High", snusnuMain.Mult7BOppaiHigh, "{2}")
			_myMultUNPLow = AddSliderOption("UNP Low", snusnuMain.MultUNPLow, "{2}")
			_myMultUNPHigh = AddSliderOption("UNP High", snusnuMain.MultUNPHigh, "{2}")
			_myMultUNPPushupLow = AddSliderOption("UNP Pushup Low", snusnuMain.MultUNPPushupLow, "{2}")
			_myMultUNPPushupHigh = AddSliderOption("UNP Pushup High", snusnuMain.MultUNPPushupHigh, "{2}")
			_myMultUNPSkinnyLow = AddSliderOption("UNP Skinny Low", snusnuMain.MultUNPSkinnyLow, "{2}")
			_myMultUNPSkinnyHigh = AddSliderOption("UNP Skinny High", snusnuMain.MultUNPSkinnyHigh, "{2}")
			_myMultUNPPerkyLow = AddSliderOption("UNP Perky Low", snusnuMain.MultUNPPerkyLow, "{2}")
			_myMultUNPPerkyHigh = AddSliderOption("UNP Perky High", snusnuMain.MultUNPPerkyHigh, "{2}")
			_myMultUNPBLow = AddSliderOption("UNPB Low", snusnuMain.MultUNPBLow, "{2}")
			_myMultUNPBHigh = AddSliderOption("UNPB High", snusnuMain.MultUNPBHigh, "{2}")
			_myMultUNPBChapi = AddSliderOption("UNPB Chapi", snusnuMain.MultUNPBChapi, "{2}")
			_myMultUNPBOppaiv1 = AddSliderOption("UNPB Oppai v1", snusnuMain.MultUNPBOppaiv1, "{2}")
			_myMultUNPBOppaiv3Low = AddSliderOption("UNPB Oppai v3.2 Low", snusnuMain.MultUNPBOppaiv3Low, "{2}")
			_myMultUNPBOppaiv3High = AddSliderOption("UNPB Oppai v3.2 High", snusnuMain.MultUNPBOppaiv3High, "{2}")
			_myMultUNPetiteLow = AddSliderOption("UNPetite Low", snusnuMain.MultUNPetiteLow, "{2}")
			_myMultUNPetiteHigh = AddSliderOption("UNPetite High", snusnuMain.MultUNPetiteHigh, "{2}")
			_myMultUNPCLow = AddSliderOption("UNPC Low", snusnuMain.MultUNPCLow, "{2}")
			_myMultUNPCHigh = AddSliderOption("UNPC High", snusnuMain.MultUNPCHigh, "{2}")
			_myMultUNPCMLow = AddSliderOption("UNPCM Low", snusnuMain.MultUNPCMLow, "{2}")
			_myMultUNPCMHigh = AddSliderOption("UNPCM High", snusnuMain.MultUNPCMHigh, "{2}")
			_myMultUNPSHLow = AddSliderOption("UNPSH Low", snusnuMain.MultUNPSHLow, "{2}")
			_myMultUNPSHHigh = AddSliderOption("UNPSH High", snusnuMain.MultUNPSHHigh, "{2}")
			_myMultUNPKLow = AddSliderOption("UNPK Low", snusnuMain.MultUNPKLow, "{2}")
			_myMultUNPKHigh = AddSliderOption("UNPK High", snusnuMain.MultUNPKHigh, "{2}")
			_myMultUNPKBonusLow = AddSliderOption("UNPK Bonus Low", snusnuMain.MultUNPKBonusLow, "{2}")
			_myMultUNPKBonusHigh = AddSliderOption("UNPK Bonus High", snusnuMain.MultUNPKBonusHigh, "{2}")
			_myMultUN7BLow = AddSliderOption("UN7B Low", snusnuMain.MultUN7BLow, "{2}")
			_myMultUN7BHigh = AddSliderOption("UN7B High", snusnuMain.MultUN7BHigh, "{2}")
			_myMultUNPBBLow = AddSliderOption("UNPBB Low", snusnuMain.MultUNPBBLow, "{2}")
			_myMultUNPBBHigh = AddSliderOption("UNPBB High", snusnuMain.MultUNPBBHigh, "{2}")
			_myMultSeraphimLow = AddSliderOption("Seraphim Low", snusnuMain.MultSeraphimLow, "{2}")
			_myMultSeraphimHigh = AddSliderOption("Seraphim High", snusnuMain.MultSeraphimHigh, "{2}")
			_myMultDemonfetLow = AddSliderOption("Demonfet Low", snusnuMain.MultDemonfetLow, "{2}")
			_myMultDemonfetHigh = AddSliderOption("Demonfet High", snusnuMain.MultDemonfetHigh, "{2}")
			_myMultDreamGirlLow = AddSliderOption("Dream Girl Low", snusnuMain.MultDreamGirlLow, "{2}")
			_myMultDreamGirlHigh = AddSliderOption("Dream Girl High", snusnuMain.MultDreamGirlHigh, "{2}")
			_myMultTopModelLow = AddSliderOption("Top Model Low", snusnuMain.MultTopModelLow, "{2}")
			_myMultTopModelHigh = AddSliderOption("Top Model High", snusnuMain.MultTopModelHigh, "{2}")
			_myMultLeitoLow = AddSliderOption("Leito Low", snusnuMain.MultLeitoLow, "{2}")
			_myMultLeitoHigh = AddSliderOption("Leito High", snusnuMain.MultLeitoHigh, "{2}")
			_myMultUNPFLow = AddSliderOption("UNPF Low", snusnuMain.MultUNPFLow, "{2}")
			_myMultUNPFHigh = AddSliderOption("UNPF High", snusnuMain.MultUNPFHigh, "{2}")
			_myMultUNPFxLow = AddSliderOption("UNPFx Low", snusnuMain.MultUNPFxLow, "{2}")
			_myMultUNPFxHigh = AddSliderOption("UNPFx High", snusnuMain.MultUNPFxHigh, "{2}")
			_myMultCNHFLow = AddSliderOption("CNHF Low", snusnuMain.MultCNHFLow, "{2}")
			_myMultCNHFHigh = AddSliderOption("CNHF High", snusnuMain.MultCNHFHigh, "{2}")
			_myMultCNHFBonusLow = AddSliderOption("CNHF Bonus Low", snusnuMain.MultCNHFBonusLow, "{2}")
			_myMultCNHFBonusHigh = AddSliderOption("CNHF Bonus High", snusnuMain.MultCNHFBonusHigh, "{2}")
			_myMultMCBMLow = AddSliderOption("MCBM Low", snusnuMain.MultMCBMLow, "{2}")
			_myMultMCBMHigh = AddSliderOption("MCBM High", snusnuMain.MultMCBMHigh, "{2}")
			_myMultVenusLow = AddSliderOption("Venus Low", snusnuMain.MultVenusLow, "{2}")
			_myMultVenusHigh = AddSliderOption("Venus High", snusnuMain.MultVenusHigh, "{2}")
			_myMultZGGBR2Low = AddSliderOption("ZGGB-R2 Low", snusnuMain.MultZGGBR2Low, "{2}")
			_myMultZGGBR2High = AddSliderOption("ZGGB-R2 High", snusnuMain.MultZGGBR2High, "{2}")
			_myMultMangaLow = AddSliderOption("Manga Low", snusnuMain.MultMangaLow, "{2}")
			_myMultMangaHigh = AddSliderOption("Manga High", snusnuMain.MultMangaHigh, "{2}")
			_myMultCHSBHCLow = AddSliderOption("CHSBHC Low", snusnuMain.MultCHSBHCLow, "{2}")
			_myMultCHSBHCHigh = AddSliderOption("CHSBHC High", snusnuMain.MultCHSBHCHigh, "{2}")
		Else ;CBBE SE
			AddHeaderOption("CBBE MORPHS PAGE 2")
			AddEmptyOption()
			AddHeaderOption("BUTT")
			AddEmptyOption()
			_myMultButtClassic = AddSliderOption("Shape Classic", snusnuMain.MultButtClassic, "{2}")
			_myMultButtShape2 = AddSliderOption("Shape Lower", snusnuMain.MultButtShape2, "{2}")
			_myMultButtCrack = AddSliderOption("Crack (Inverted)", snusnuMain.MultButtCrack, "{2}")
			_myMultButt = AddSliderOption("Size (Inverted)", snusnuMain.MultButt, "{2}")
			_myMultButtSmall = AddSliderOption("Smaller (Inverted)", snusnuMain.MultButtSmall, "{2}")
			_myMultBigButt = AddSliderOption("Big", snusnuMain.MultBigButt, "{2}")
			_myMultChubbyButt = AddSliderOption("Chubby", snusnuMain.MultChubbyButt, "{2}")
			_myMultAppleCheeks = AddSliderOption("Apple", snusnuMain.MultAppleCheeks, "{2}")
			_myMultButtDimples = AddSliderOption("Dimples", snusnuMain.MultButtDimples, "{2}")
			_myMultButtUnderFold = AddSliderOption("Under Fold", snusnuMain.MultButtUnderFold, "{2}")
			_myMultRoundAss = AddSliderOption("Round", snusnuMain.MultRoundAss, "{2}")
			_myMultCrotchBack = AddSliderOption("Move Crotch", snusnuMain.MultCrotchBack, "{2}")
			_myMultGroin = AddSliderOption("Groin", snusnuMain.MultGroin, "{2}")
			AddEmptyOption()
			AddHeaderOption("LEGS AND FEET")
			AddEmptyOption()
			_myMultLegShapeClassic = AddSliderOption("Shape Classic", snusnuMain.MultLegShapeClassic, "{2}")
			_myMultLegsThin = AddSliderOption("Thin", snusnuMain.MultLegsThin, "{2}")
			_myMultSlimThighs = AddSliderOption("Slim", snusnuMain.MultSlimThighs, "{2}")
			_myMultThighs = AddSliderOption("Thighs", snusnuMain.MultThighs, "{2}")
			_myMultChubbyLegs = AddSliderOption("Chubby", snusnuMain.MultChubbyLegs, "{2}")
			_myMultLegs = AddSliderOption("Size (Inverted)", snusnuMain.MultLegs, "{2}")
			_myMultKneeHeight = AddSliderOption("Knee Height", snusnuMain.MultKneeHeight, "{2}")
			_myMultKneeShape = AddSliderOption("Knee Shape", snusnuMain.MultKneeShape, "{2}")
			_myMultCalfSize = AddSliderOption("Calf Size", snusnuMain.MultCalfSize, "{2}")
			_myMultCalfSmooth = AddSliderOption("Calf Smooth", snusnuMain.MultCalfSmooth, "{2}")
			_myMultFeetFeminine = AddSliderOption("Feminine Feet", snusnuMain.MultFeetFeminine, "{2}")
			AddEmptyOption()
			AddHeaderOption("HIPS")
			AddEmptyOption()
			;_myMultHipbone = AddSliderOption("Hipbone", snusnuMain.MultHipbone, "{2}")
			_myMultHips = AddSliderOption("Size", snusnuMain.MultHips, "{2}")
			_myMultHipForward = AddSliderOption("Forward", snusnuMain.MultHipForward, "{2}")
			_myMultHipUpperWidth = AddSliderOption("Upper Width", snusnuMain.MultHipUpperWidth, "{2}")
			_myMultHipCarved = AddSliderOption("Carved", snusnuMain.MultHipCarved, "{2}")
			AddHeaderOption("ARMS")
			AddEmptyOption()
			_myMultArms = AddSliderOption("Size (Inverted)", snusnuMain.MultArms, "{2}")
			_myMultForearmSize = AddSliderOption("Forearm Size", snusnuMain.MultForearmSize, "{2}")
			_myMultChubbyArms = AddSliderOption("Chubby", snusnuMain.MultChubbyArms, "{2}")
			_myMultShoulderSmooth = AddSliderOption("Shoulder Smooth", snusnuMain.MultShoulderSmooth, "{2}")
			_myMultShoulderWidth = AddSliderOption("Shoulder Width (Inverted)", snusnuMain.MultShoulderWidth, "{2}")
			_myMultShoulderTweak = AddSliderOption("Shoulder Tweak", snusnuMain.MultShoulderTweak, "{2}")
			AddHeaderOption("BELLY")
			AddEmptyOption()
			_myMultBelly = AddSliderOption("Size", snusnuMain.MultBelly, "{2}")
			_myMultBigBelly = AddSliderOption("Big", snusnuMain.MultBigBelly, "{2}")
			_myMultPregnancyBelly = AddSliderOption("Pregnant", snusnuMain.MultPregnancyBelly, "{2}")
			_myMultTummyTuck = AddSliderOption("Tuck", snusnuMain.MultTummyTuck, "{2}")
		EndIf
	ElseIf (a_page == Pages[3] && snusnuMain.selectedBody != 2)
		SetCursorFillMode(LEFT_TO_RIGHT)
		If snusnuMain.selectedBody == 0 ;UUNP/BHUNP
			AddHeaderOption("$SNUSNU_MORPHS_BHUNP")
			AddEmptyOption()
			
			_myMultBreastsTogether = AddSliderOption("BreastsTogether", snusnuMain.MultBreastsTogether, "{2}")
			_myMultBreastCenter = AddSliderOption("BreastCenter", snusnuMain.MultBreastCenter, "{2}")
			_myMultBreastCenterBig = AddSliderOption("BreastCenterBig", snusnuMain.MultBreastCenterBig, "{2}")
			_myMultTopSlope = AddSliderOption("Top Slope", snusnuMain.MultTopSlope, "{2}")
			_myMultBreastConverge = AddSliderOption("BreastConverge", snusnuMain.MultBreastConverge, "{2}")
			_myMultBreastsGone = AddSliderOption("BreastsGone", snusnuMain.MultBreastsGone, "{2}")
			_myMultBreastsPressed = AddSliderOption("BreastsPressed", snusnuMain.MultBreastsPressed, "{2}")
			_myMultNipplePuffyAreola = AddSliderOption("NipplePuffyAreola", snusnuMain.MultNipplePuffyAreola, "{2}")
			_myMultNipBGone = AddSliderOption("NipBGone", snusnuMain.MultNipBGone, "{2}")
			_myMultNippleInverted = AddSliderOption("NippleInverted", snusnuMain.MultNippleInverted, "{2}")
			_myMultChestDepth = AddSliderOption("ChestDepth", snusnuMain.MultChestDepth, "{2}")
			_myMultChestWidth = AddSliderOption("ChestWidth", snusnuMain.MultChestWidth, "{2}")
			_myMultRibsProminance = AddSliderOption("RibsProminance", snusnuMain.MultRibsProminance, "{2}")
			_myMultSternumDepth = AddSliderOption("SternumDepth", snusnuMain.MultSternumDepth, "{2}")
			_myMultSternumHeight = AddSliderOption("SternumHeight", snusnuMain.MultSternumHeight, "{2}")
			_myMultWaistHeight = AddSliderOption("WaistHeight", snusnuMain.MultWaistHeight, "{2}")
			_myMultBackArch = AddSliderOption("BackArch", snusnuMain.MultBackArch, "{2}")
			_myMultCrotchBack = AddSliderOption("CrotchBack", snusnuMain.MultCrotchBack, "{2}")
			_myMultLegsThin = AddSliderOption("LegsThin", snusnuMain.MultLegsThin, "{2}")
			_myMultKneeShape = AddSliderOption("KneeShape", snusnuMain.MultKneeShape, "{2}")
			_myMultKneeSlim = AddSliderOption("KneeSlim", snusnuMain.MultKneeSlim, "{2}")
			_myMultMuscleAbs = AddSliderOption("MuscleAbs", snusnuMain.MultMuscleAbs, "{2}")
			_myMultMuscleArms = AddSliderOption("MuscleArms", snusnuMain.MultMuscleArms, "{2}")
			_myMultMuscleButt = AddSliderOption("MuscleButt", snusnuMain.MultMuscleButt, "{2}")
			_myMultMuscleLegs = AddSliderOption("MuscleLegs", snusnuMain.MultMuscleLegs, "{2}")
			_myMultMusclePecs = AddSliderOption("MusclePecs", snusnuMain.MultMusclePecs, "{2}")
			_myMultHipForward = AddSliderOption("HipForward", snusnuMain.MultHipForward, "{2}")
			_myMultHipUpperWidth = AddSliderOption("HipUpperWidth", snusnuMain.MultHipUpperWidth, "{2}")
			_myMultForearmSize = AddSliderOption("ForearmSize", snusnuMain.MultForearmSize, "{2}")
			_myMultShoulderTweak = AddSliderOption("ShoulderTweak", snusnuMain.MultShoulderTweak, "{2}")
			_myMultBotePregnancy = AddSliderOption("BotePregnancy", snusnuMain.MultBotePregnancy, "{2}")
			_myMultBellyFatLower = AddSliderOption("BellyFatLower", snusnuMain.MultBellyFatLower, "{2}")
			_myMultBellyFatUpper = AddSliderOption("BellyFatUpper", snusnuMain.MultBellyFatUpper, "{2}")
			_myMultBellyObesity = AddSliderOption("BellyObesity", snusnuMain.MultBellyObesity, "{2}")
			_myMultBellyPressed = AddSliderOption("BellyPressed", snusnuMain.MultBellyPressed, "{2}")
			_myMultBellyLowerSwell1 = AddSliderOption("BellyLowerSwell1", snusnuMain.MultBellyLowerSwell1, "{2}")
			_myMultBellyLowerSwell2 = AddSliderOption("BellyLowerSwell2", snusnuMain.MultBellyLowerSwell2, "{2}")
			_myMultBellyLowerSwell3 = AddSliderOption("BellyLowerSwell3", snusnuMain.MultBellyLowerSwell3, "{2}")
			_myMultBellyCenterProtrude = AddSliderOption("BellyCenterProtrude", snusnuMain.MultBellyCenterProtrude, "{2}")
			_myMultBellyCenterUpperProtrude = AddSliderOption("BellyCenterUpperProtrude", snusnuMain.MultBellyCenterUpperProtrude, "{2}")
			_myMultBellyBalls = AddSliderOption("BellyBalls", snusnuMain.MultBellyBalls, "{2}")
			_myMultAruru6DuckLow = AddSliderOption("Aruru6Duck Low", snusnuMain.MultAruru6DuckLow, "{2}")
			_myMultAruru6DuckHigh = AddSliderOption("Aruru6Duck High", snusnuMain.MultAruru6DuckHigh, "{2}")
		Else ;CBBE SE
			AddHeaderOption("CBBE SPECIAL MORPHS")
			AddEmptyOption()
			AddHeaderOption("MUSCLE DEFINITION")
			AddEmptyOption()
			_myMultMuscleAbs = AddSliderOption("Abs", snusnuMain.MultMuscleAbs, "{2}")
			_myMultMuscleArms = AddSliderOption("Arms", snusnuMain.MultMuscleArms, "{2}")
			_myMultMuscleButt = AddSliderOption("Butt", snusnuMain.MultMuscleButt, "{2}")
			_myMultMuscleLegs = AddSliderOption("Legs", snusnuMain.MultMuscleLegs, "{2}")
			_myMultMusclePecs = AddSliderOption("Pecs", snusnuMain.MultMusclePecs, "{2}")
			AddEmptyOption()
			AddHeaderOption("FULL BODY")
			AddEmptyOption()
			_myMultVanillaSSELo = AddSliderOption("VanillaSSELo", snusnuMain.MultVanillaSSELo, "{2}")
			_myMultVanillaSSEHi = AddSliderOption("VanillaSSEHi", snusnuMain.MultVanillaSSEHi, "{2}")
			_myMultOldBaseShape = AddSliderOption("OldBaseShape", snusnuMain.MultOldBaseShape, "{2}")
			_myMult7BLower = AddSliderOption("7B Lower", snusnuMain.Mult7BLower, "{2}")
			_myMult7BUpper = AddSliderOption("7B Upper", snusnuMain.Mult7BUpper, "{2}")
			AddEmptyOption()
			AddHeaderOption("SEAMS")
			AddEmptyOption()
			_myMultAnkleSize = AddSliderOption("Ankle Size", snusnuMain.MultAnkleSize, "{2}")
			_myMultWristSize = AddSliderOption("Wrist Size", snusnuMain.MultWristSize, "{2}")
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
	EndIf
EndEvent

Event OnOptionHighlight(Int a_option)
	If a_option == _myEnabled
		SetInfoText("Enables/disables the mod and its registered events.")
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
	EndIf
EndEvent

Event OnOptionSelect(Int a_option)
	If a_option == _myEnabled
		snusnuMain.Enabled = !snusnuMain.Enabled
		SetToggleOptionValue(a_option, snusnuMain.Enabled)
		snusnuMain.ResetWeight(snusnuMain.Enabled)
		snusnuMain.RegisterEvents(snusnuMain.Enabled)
		SetTextOptionValue(_myFightingScore, snusnuMain.muscleScore)
		;SetToggleOptionValue(_myUseWeightSlider, snusnuMain.useWeightSlider)
		SetToggleOptionValue(_myDisableNormals, snusnuMain.disableNormals)
	ElseIf a_option ==  _mytfAnimation
		snusnuMain.tfAnimation = !snusnuMain.tfAnimation
		SetToggleOptionValue(a_option, snusnuMain.tfAnimation)
	ElseIf a_option ==  _mytfAnimationNPC
		snusnuMain.tfAnimationNPC = !snusnuMain.tfAnimationNPC
		SetToggleOptionValue(a_option, snusnuMain.tfAnimationNPC)
	ElseIf a_option ==  _myuseAltAnims
		snusnuMain.useAltAnims = !snusnuMain.useAltAnims
		SetToggleOptionValue(a_option, snusnuMain.useAltAnims)
	ElseIf a_option ==  _myuseAltAnimsNPC
		snusnuMain.useAltAnimsNPC = !snusnuMain.useAltAnimsNPC
		SetToggleOptionValue(a_option, snusnuMain.useAltAnimsNPC)
	ElseIf a_option ==  _mychangeHeadPart
		snusnuMain.changeHeadPart = !snusnuMain.changeHeadPart
		SetToggleOptionValue(a_option, snusnuMain.changeHeadPart)
	ElseIf a_option ==  _myplayTFSound
		snusnuMain.playTFSound = !snusnuMain.playTFSound
		SetToggleOptionValue(a_option, snusnuMain.playTFSound)
	ElseIf a_option ==  _myRemoveWeightMorphs
		snusnuMain.removeWeightMorphs = !snusnuMain.removeWeightMorphs
		SetToggleOptionValue(a_option, snusnuMain.removeWeightMorphs)
	ElseIf a_option ==  _myUseWeightSlider
		snusnuMain.useWeightSlider = !snusnuMain.useWeightSlider
		SetToggleOptionValue(a_option, snusnuMain.useWeightSlider)
	ElseIf a_option ==  _myDisableNormals
		snusnuMain.disableNormals = !snusnuMain.disableNormals
		
		If snusnuMain.disableNormals
			NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
		Else
			snusnuMain.checkBodyNormalsState()
		EndIf
		
		SetToggleOptionValue(a_option, snusnuMain.disableNormals)
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
		
	;CBBE SLIDERS
	ElseIf a_option == _myMultBreasts
		SetSliderDialogStartValue(snusnuMain.MultBreasts)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastsSmall
		SetSliderDialogStartValue(snusnuMain.MultBreastsSmall)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastsSH
		SetSliderDialogStartValue(snusnuMain.MultBreastsSH)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastsSSH
		SetSliderDialogStartValue(snusnuMain.MultBreastsSSH)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastsFantasy
		SetSliderDialogStartValue(snusnuMain.MultBreastsFantasy)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultDoubleMelon
		SetSliderDialogStartValue(snusnuMain.MultDoubleMelon)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastCleavage
		SetSliderDialogStartValue(snusnuMain.MultBreastCleavage)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastFlatness
		SetSliderDialogStartValue(snusnuMain.MultBreastFlatness)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastGravity
		SetSliderDialogStartValue(snusnuMain.MultBreastGravity)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultPushUp
		SetSliderDialogStartValue(snusnuMain.MultPushUp)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastHeight
		SetSliderDialogStartValue(snusnuMain.MultBreastHeight)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastPerkiness
		SetSliderDialogStartValue(snusnuMain.MultBreastPerkiness)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastWidth
		SetSliderDialogStartValue(snusnuMain.MultBreastWidth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
		
	ElseIf a_option == _myMultNippleDistance
		SetSliderDialogStartValue(snusnuMain.MultNippleDistance)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNipplePerkiness
		SetSliderDialogStartValue(snusnuMain.MultNipplePerkiness)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleLength
		SetSliderDialogStartValue(snusnuMain.MultNippleLength)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleSize
		SetSliderDialogStartValue(snusnuMain.MultNippleSize)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleAreola
		SetSliderDialogStartValue(snusnuMain.MultNippleAreola)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleUp
		SetSliderDialogStartValue(snusnuMain.MultNippleUp)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleDown
		SetSliderDialogStartValue(snusnuMain.MultNippleDown)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleTip
		SetSliderDialogStartValue(snusnuMain.MultNippleTip)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
		
	ElseIf a_option == _myMultArms
		SetSliderDialogStartValue(snusnuMain.MultArms)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultChubbyArms
		SetSliderDialogStartValue(snusnuMain.MultChubbyArms)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultShoulderSmooth
		SetSliderDialogStartValue(snusnuMain.MultShoulderSmooth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultShoulderWidth
		SetSliderDialogStartValue(snusnuMain.MultShoulderWidth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	
	ElseIf a_option == _myMultBelly
		SetSliderDialogStartValue(snusnuMain.MultBelly)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBigBelly
		SetSliderDialogStartValue(snusnuMain.MultBigBelly)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultPregnancyBelly
		SetSliderDialogStartValue(snusnuMain.MultPregnancyBelly)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultTummyTuck
		SetSliderDialogStartValue(snusnuMain.MultTummyTuck)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	
	ElseIf a_option == _myMultBigTorso
		SetSliderDialogStartValue(snusnuMain.MultBigTorso)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultWaist
		SetSliderDialogStartValue(snusnuMain.MultWaist)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultWideWaistLine
		SetSliderDialogStartValue(snusnuMain.MultWideWaistLine)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultChubbyWaist
		SetSliderDialogStartValue(snusnuMain.MultChubbyWaist)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBack
		SetSliderDialogStartValue(snusnuMain.MultBack)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	
	ElseIf a_option == _myMultButtCrack
		SetSliderDialogStartValue(snusnuMain.MultButtCrack)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultButt
		SetSliderDialogStartValue(snusnuMain.MultButt)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultButtSmall
		SetSliderDialogStartValue(snusnuMain.MultButtSmall)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultButtShape2
		SetSliderDialogStartValue(snusnuMain.MultButtShape2)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBigButt
		SetSliderDialogStartValue(snusnuMain.MultBigButt)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultChubbyButt
		SetSliderDialogStartValue(snusnuMain.MultChubbyButt)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultAppleCheeks
		SetSliderDialogStartValue(snusnuMain.MultAppleCheeks)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultRoundAss
		SetSliderDialogStartValue(snusnuMain.MultRoundAss)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultGroin
		SetSliderDialogStartValue(snusnuMain.MultGroin)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	
	ElseIf a_option == _myMultHipbone
		SetSliderDialogStartValue(snusnuMain.MultHipbone)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultHips
		SetSliderDialogStartValue(snusnuMain.MultHips)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	
	ElseIf a_option == _myMultSlimThighs
		SetSliderDialogStartValue(snusnuMain.MultSlimThighs)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultThighs
		SetSliderDialogStartValue(snusnuMain.MultThighs)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultChubbyLegs
		SetSliderDialogStartValue(snusnuMain.MultChubbyLegs)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultLegs
		SetSliderDialogStartValue(snusnuMain.MultLegs)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultKneeHeight
		SetSliderDialogStartValue(snusnuMain.MultKneeHeight)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCalfSize
		SetSliderDialogStartValue(snusnuMain.MultCalfSize)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCalfSmooth
		SetSliderDialogStartValue(snusnuMain.MultCalfSmooth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	
	
	;UUNP SLIDERS
	ElseIf a_option == _myMult7BLow
		SetSliderDialogStartValue(snusnuMain.Mult7BLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BHigh
		SetSliderDialogStartValue(snusnuMain.Mult7BHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BBombshellLow
		SetSliderDialogStartValue(snusnuMain.Mult7BBombshellLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BBombshellHigh
		SetSliderDialogStartValue(snusnuMain.Mult7BBombshellHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BNaturalLow
		SetSliderDialogStartValue(snusnuMain.Mult7BNaturalLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BNaturalHigh
		SetSliderDialogStartValue(snusnuMain.Mult7BNaturalHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BCleavageLow
		SetSliderDialogStartValue(snusnuMain.Mult7BCleavageLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BCleavageHigh
		SetSliderDialogStartValue(snusnuMain.Mult7BCleavageHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BBCupLow
		SetSliderDialogStartValue(snusnuMain.Mult7BBCupLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BBCupHigh
		SetSliderDialogStartValue(snusnuMain.Mult7BBCupHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BUNPLow
		SetSliderDialogStartValue(snusnuMain.Mult7BUNPLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BUNPHigh
		SetSliderDialogStartValue(snusnuMain.Mult7BUNPHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BCHLow
		SetSliderDialogStartValue(snusnuMain.Mult7BCHLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BCHHigh
		SetSliderDialogStartValue(snusnuMain.Mult7BCHHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BOppaiLow
		SetSliderDialogStartValue(snusnuMain.Mult7BOppaiLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BOppaiHigh
		SetSliderDialogStartValue(snusnuMain.Mult7BOppaiHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPLow
		SetSliderDialogStartValue(snusnuMain.MultUNPLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPPushupLow
		SetSliderDialogStartValue(snusnuMain.MultUNPPushupLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPPushupHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPPushupHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPSkinnyLow
		SetSliderDialogStartValue(snusnuMain.MultUNPSkinnyLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPSkinnyHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPSkinnyHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPPerkyLow
		SetSliderDialogStartValue(snusnuMain.MultUNPPerkyLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPPerkyHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPPerkyHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPBLow
		SetSliderDialogStartValue(snusnuMain.MultUNPBLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPBHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPBHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPBChapi
		SetSliderDialogStartValue(snusnuMain.MultUNPBChapi)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPBOppaiv1
		SetSliderDialogStartValue(snusnuMain.MultUNPBOppaiv1)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPBOppaiv3Low
		SetSliderDialogStartValue(snusnuMain.MultUNPBOppaiv3Low)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPBOppaiv3High
		SetSliderDialogStartValue(snusnuMain.MultUNPBOppaiv3High)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPetiteLow
		SetSliderDialogStartValue(snusnuMain.MultUNPetiteLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPetiteHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPetiteHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPCLow
		SetSliderDialogStartValue(snusnuMain.MultUNPCLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPCHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPCHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPCMLow
		SetSliderDialogStartValue(snusnuMain.MultUNPCMLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPCMHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPCMHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPSHLow
		SetSliderDialogStartValue(snusnuMain.MultUNPSHLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPSHHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPSHHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPKLow
		SetSliderDialogStartValue(snusnuMain.MultUNPKLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPKHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPKHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPKBonusLow
		SetSliderDialogStartValue(snusnuMain.MultUNPKBonusLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPKBonusHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPKBonusHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUN7BLow
		SetSliderDialogStartValue(snusnuMain.MultUN7BLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUN7BHigh
		SetSliderDialogStartValue(snusnuMain.MultUN7BHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPBBLow
		SetSliderDialogStartValue(snusnuMain.MultUNPBBLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPBBHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPBBHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultSeraphimLow
		SetSliderDialogStartValue(snusnuMain.MultSeraphimLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultSeraphimHigh
		SetSliderDialogStartValue(snusnuMain.MultSeraphimHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultDemonfetLow
		SetSliderDialogStartValue(snusnuMain.MultDemonfetLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultDemonfetHigh
		SetSliderDialogStartValue(snusnuMain.MultDemonfetHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultDreamGirlLow
		SetSliderDialogStartValue(snusnuMain.MultDreamGirlLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultDreamGirlHigh
		SetSliderDialogStartValue(snusnuMain.MultDreamGirlHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultTopModelLow
		SetSliderDialogStartValue(snusnuMain.MultTopModelLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultTopModelHigh
		SetSliderDialogStartValue(snusnuMain.MultTopModelHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultLeitoLow
		SetSliderDialogStartValue(snusnuMain.MultLeitoLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-2.0, 2.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultLeitoHigh
		SetSliderDialogStartValue(snusnuMain.MultLeitoHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPFLow
		SetSliderDialogStartValue(snusnuMain.MultUNPFLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPFHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPFHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPFxLow
		SetSliderDialogStartValue(snusnuMain.MultUNPFxLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultUNPFxHigh
		SetSliderDialogStartValue(snusnuMain.MultUNPFxHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCNHFLow
		SetSliderDialogStartValue(snusnuMain.MultCNHFLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCNHFHigh
		SetSliderDialogStartValue(snusnuMain.MultCNHFHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCNHFBonusLow
		SetSliderDialogStartValue(snusnuMain.MultCNHFBonusLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCNHFBonusHigh
		SetSliderDialogStartValue(snusnuMain.MultCNHFBonusHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMCBMLow
		SetSliderDialogStartValue(snusnuMain.MultMCBMLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMCBMHigh
		SetSliderDialogStartValue(snusnuMain.MultMCBMHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultVenusLow
		SetSliderDialogStartValue(snusnuMain.MultVenusLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultVenusHigh
		SetSliderDialogStartValue(snusnuMain.MultVenusHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultZGGBR2Low
		SetSliderDialogStartValue(snusnuMain.MultZGGBR2Low)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultZGGBR2High
		SetSliderDialogStartValue(snusnuMain.MultZGGBR2High)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMangaLow
		SetSliderDialogStartValue(snusnuMain.MultMangaLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMangaHigh
		SetSliderDialogStartValue(snusnuMain.MultMangaHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCHSBHCLow
		SetSliderDialogStartValue(snusnuMain.MultCHSBHCLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCHSBHCHigh
		SetSliderDialogStartValue(snusnuMain.MultCHSBHCHigh)
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
		
	
	;BHUNP SLIDERS
	ElseIf a_option == _myMultBreastsTogether
		SetSliderDialogStartValue(snusnuMain.MultBreastsTogether)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastCenter
		SetSliderDialogStartValue(snusnuMain.MultBreastCenter)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastCenterBig
		SetSliderDialogStartValue(snusnuMain.MultBreastCenterBig)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultTopSlope
		SetSliderDialogStartValue(snusnuMain.MultTopSlope)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastConverge
		SetSliderDialogStartValue(snusnuMain.MultBreastConverge)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastsGone
		SetSliderDialogStartValue(snusnuMain.MultBreastsGone)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastsPressed
		SetSliderDialogStartValue(snusnuMain.MultBreastsPressed)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNipplePuffyAreola
		SetSliderDialogStartValue(snusnuMain.MultNipplePuffyAreola)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNipBGone
		SetSliderDialogStartValue(snusnuMain.MultNipBGone)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleInverted
		SetSliderDialogStartValue(snusnuMain.MultNippleInverted)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultChestDepth
		SetSliderDialogStartValue(snusnuMain.MultChestDepth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultChestWidth
		SetSliderDialogStartValue(snusnuMain.MultChestWidth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultRibsProminance
		SetSliderDialogStartValue(snusnuMain.MultRibsProminance)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultSternumDepth
		SetSliderDialogStartValue(snusnuMain.MultSternumDepth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultSternumHeight
		SetSliderDialogStartValue(snusnuMain.MultSternumHeight)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultWaistHeight
		SetSliderDialogStartValue(snusnuMain.MultWaistHeight)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBackArch
		SetSliderDialogStartValue(snusnuMain.MultBackArch)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultCrotchBack
		SetSliderDialogStartValue(snusnuMain.MultCrotchBack)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultLegsThin
		SetSliderDialogStartValue(snusnuMain.MultLegsThin)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultKneeShape
		SetSliderDialogStartValue(snusnuMain.MultKneeShape)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultKneeSlim
		SetSliderDialogStartValue(snusnuMain.MultKneeSlim)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMuscleAbs
		SetSliderDialogStartValue(snusnuMain.MultMuscleAbs)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMuscleArms
		SetSliderDialogStartValue(snusnuMain.MultMuscleArms)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMuscleButt
		SetSliderDialogStartValue(snusnuMain.MultMuscleButt)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMuscleLegs
		SetSliderDialogStartValue(snusnuMain.MultMuscleLegs)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultMusclePecs
		SetSliderDialogStartValue(snusnuMain.MultMusclePecs)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultHipForward
		SetSliderDialogStartValue(snusnuMain.MultHipForward)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultHipUpperWidth
		SetSliderDialogStartValue(snusnuMain.MultHipUpperWidth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultForearmSize
		SetSliderDialogStartValue(snusnuMain.MultForearmSize)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultShoulderTweak
		SetSliderDialogStartValue(snusnuMain.MultShoulderTweak)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBotePregnancy
		SetSliderDialogStartValue(snusnuMain.MultBotePregnancy)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyFatLower
		SetSliderDialogStartValue(snusnuMain.MultBellyFatLower)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyFatUpper
		SetSliderDialogStartValue(snusnuMain.MultBellyFatUpper)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyObesity
		SetSliderDialogStartValue(snusnuMain.MultBellyObesity)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyPressed
		SetSliderDialogStartValue(snusnuMain.MultBellyPressed)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyLowerSwell1
		SetSliderDialogStartValue(snusnuMain.MultBellyLowerSwell1)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyLowerSwell2
		SetSliderDialogStartValue(snusnuMain.MultBellyLowerSwell2)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyLowerSwell3
		SetSliderDialogStartValue(snusnuMain.MultBellyLowerSwell3)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyCenterProtrude
		SetSliderDialogStartValue(snusnuMain.MultBellyCenterProtrude)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyCenterUpperProtrude
		SetSliderDialogStartValue(snusnuMain.MultBellyCenterUpperProtrude)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBellyBalls
		SetSliderDialogStartValue(snusnuMain.MultBellyBalls)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultAruru6DuckLow
		SetSliderDialogStartValue(snusnuMain.MultAruru6DuckLow)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultAruru6DuckHigh
		SetSliderDialogStartValue(snusnuMain.MultAruru6DuckHigh)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
		
	;CBBE SE SLIDERS
	ElseIf a_option == _myMultBreastsSmall2
		SetSliderDialogStartValue(snusnuMain.MultBreastsSmall2)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastsNewSH
		SetSliderDialogStartValue(snusnuMain.MultBreastsNewSH)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastsNewSHSymmetry
		SetSliderDialogStartValue(snusnuMain.MultBreastsNewSHSymmetry)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastTopSlope
		SetSliderDialogStartValue(snusnuMain.MultBreastTopSlope)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastFlatness2
		SetSliderDialogStartValue(snusnuMain.MultBreastFlatness2)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastGravity2
		SetSliderDialogStartValue(snusnuMain.MultBreastGravity2)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastSideShape
		SetSliderDialogStartValue(snusnuMain.MultBreastSideShape)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultBreastUnderDepth
		SetSliderDialogStartValue(snusnuMain.MultBreastUnderDepth)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultAreolaSize
		SetSliderDialogStartValue(snusnuMain.MultAreolaSize)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleManga
		SetSliderDialogStartValue(snusnuMain.MultNippleManga)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNipplePerkManga
		SetSliderDialogStartValue(snusnuMain.MultNipplePerkManga)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleTipManga
		SetSliderDialogStartValue(snusnuMain.MultNippleTipManga)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNippleDip
		SetSliderDialogStartValue(snusnuMain.MultNippleDip)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultNavelEven
		SetSliderDialogStartValue(snusnuMain.MultNavelEven)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultButtClassic
		SetSliderDialogStartValue(snusnuMain.MultButtClassic)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultButtDimples
		SetSliderDialogStartValue(snusnuMain.MultButtDimples)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultButtUnderFold
		SetSliderDialogStartValue(snusnuMain.MultButtUnderFold)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultHipCarved
		SetSliderDialogStartValue(snusnuMain.MultHipCarved)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultLegShapeClassic
		SetSliderDialogStartValue(snusnuMain.MultLegShapeClassic)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultFeetFeminine
		SetSliderDialogStartValue(snusnuMain.MultFeetFeminine)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultAnkleSize
		SetSliderDialogStartValue(snusnuMain.MultAnkleSize)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultWristSize
		SetSliderDialogStartValue(snusnuMain.MultWristSize)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultVanillaSSELo
		SetSliderDialogStartValue(snusnuMain.MultVanillaSSELo)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultVanillaSSEHi
		SetSliderDialogStartValue(snusnuMain.MultVanillaSSEHi)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMultOldBaseShape
		SetSliderDialogStartValue(snusnuMain.MultOldBaseShape)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BLower
		SetSliderDialogStartValue(snusnuMain.Mult7BLower)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf a_option == _myMult7BUpper
		SetSliderDialogStartValue(snusnuMain.Mult7BUpper)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1.0, 1.0)
		SetSliderDialogInterval(0.01)
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
		snusnuMain.muscleScoreMax = a_value
		SetSliderOptionValue(a_option, snusnuMain.muscleScoreMax, "{2}")
		If snusnuMain.muscleScoreMax < snusnuMain.muscleScore
			snusnuMain.updateMuscleScore(0)
			snusnuMain.UpdateWeight()
			snusnuMain.UpdateEffects()
			SetTextOptionValue(_myFightingScore, snusnuMain.muscleScore)
		EndIf
	
	;MALE SLIDERS - UNUSED FOR NOW
	ElseIf a_option == _myMultSamuel
		snusnuMain.MultSamuel = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSamuel, "{2}")
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultSamson
		snusnuMain.MultSamson = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSamson, "{2}")
		snusnuMain.UpdateWeight()
		
	;CBBE SLIDERS
	ElseIf a_option == _myMultBreasts
		snusnuMain.MultBreasts = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreasts, "{2}")
		
		snusnuMain.setSliderValue(0, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 0)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 0, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastsSmall
		snusnuMain.MultBreastsSmall = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsSmall, "{2}")
		
		snusnuMain.setSliderValue(1, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 1)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 1, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastsSH
		snusnuMain.MultBreastsSH = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsSH, "{2}")
		
		snusnuMain.setSliderValue(2, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 2)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 2, false)
		EndIf
		snusnuMain.UpdateWeight()	
	ElseIf a_option == _myMultBreastsSSH
		snusnuMain.MultBreastsSSH = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsSSH, "{2}")
		
		snusnuMain.setSliderValue(3, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 3)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 3, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastsFantasy
		snusnuMain.MultBreastsFantasy = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsFantasy, "{2}")
		
		snusnuMain.setSliderValue(4, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 4)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 4, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultDoubleMelon
		snusnuMain.MultDoubleMelon = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultDoubleMelon, "{2}")
		
		snusnuMain.setSliderValue(5, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 5)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 5, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastCleavage
		snusnuMain.MultBreastCleavage = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastCleavage, "{2}")
		
		snusnuMain.setSliderValue(6, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 6)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 6, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastFlatness
		snusnuMain.MultBreastFlatness = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastFlatness, "{2}")
		
		snusnuMain.setSliderValue(7, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 7)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 7, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastGravity
		snusnuMain.MultBreastGravity = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastGravity, "{2}")
		
		snusnuMain.setSliderValue(8, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 8)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 8, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultPushUp
		snusnuMain.MultPushUp = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultPushUp, "{2}")
		
		snusnuMain.setSliderValue(9, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 9)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 9, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastHeight
		snusnuMain.MultBreastHeight = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastHeight, "{2}")
		
		snusnuMain.setSliderValue(10, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 10)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 10, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastPerkiness
		snusnuMain.MultBreastPerkiness = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastPerkiness, "{2}")
		
		snusnuMain.setSliderValue(11, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 11)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 11, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastWidth
		snusnuMain.MultBreastWidth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastWidth, "{2}")
		
		snusnuMain.setSliderValue(12, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 12)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 12, false)
		EndIf
		snusnuMain.UpdateWeight()
		
	ElseIf a_option == _myMultNippleDistance
		snusnuMain.MultNippleDistance = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleDistance, "{2}")
		
		snusnuMain.setSliderValue(13, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 13)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 13, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNipplePerkiness
		snusnuMain.MultNipplePerkiness = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNipplePerkiness, "{2}")
		
		snusnuMain.setSliderValue(14, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 14)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 14, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleLength
		snusnuMain.MultNippleLength = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleLength, "{2}")
		
		snusnuMain.setSliderValue(15, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 15)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 15, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleSize
		snusnuMain.MultNippleSize = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleSize, "{2}")
		
		snusnuMain.setSliderValue(16, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 16)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 16, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleAreola
		snusnuMain.MultNippleAreola = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleAreola, "{2}")
		
		snusnuMain.setSliderValue(17, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 17)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 17, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleUp
		snusnuMain.MultNippleUp = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleUp, "{2}")
		
		snusnuMain.setSliderValue(18, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 18)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 18, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleDown
		snusnuMain.MultNippleDown = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleDown, "{2}")
		
		snusnuMain.setSliderValue(19, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 19)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 19, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleTip
		snusnuMain.MultNippleTip = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleTip, "{2}")
		
		snusnuMain.setSliderValue(20, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 20)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 20, false)
		EndIf
		snusnuMain.UpdateWeight()
		
	ElseIf a_option == _myMultArms
		snusnuMain.MultArms = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultArms, "{2}")
		
		snusnuMain.setSliderValue(21, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 21)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 21, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultChubbyArms
		snusnuMain.MultChubbyArms = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultChubbyArms, "{2}")
		
		snusnuMain.setSliderValue(22, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 22)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 22, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultShoulderSmooth
		snusnuMain.MultShoulderSmooth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultShoulderSmooth, "{2}")
		
		snusnuMain.setSliderValue(23, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 23)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 23, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultShoulderWidth
		snusnuMain.MultShoulderWidth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultShoulderWidth, "{2}")
		
		snusnuMain.setSliderValue(24, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 24)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 24, false)
		EndIf
		snusnuMain.UpdateWeight()
		
	ElseIf a_option == _myMultBelly
		snusnuMain.MultBelly = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBelly, "{2}")
		
		snusnuMain.setSliderValue(25, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 25)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 25, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBigBelly
		snusnuMain.MultBigBelly = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBigBelly, "{2}")
		
		snusnuMain.setSliderValue(26, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 26)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 26, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultPregnancyBelly
		snusnuMain.MultPregnancyBelly = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultPregnancyBelly, "{2}")
		
		snusnuMain.setSliderValue(27, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 27)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 27, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultTummyTuck
		snusnuMain.MultTummyTuck = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultTummyTuck, "{2}")
		
		snusnuMain.setSliderValue(28, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 28)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 28, false)
		EndIf
		snusnuMain.UpdateWeight()
		
	ElseIf a_option == _myMultBigTorso
		snusnuMain.MultBigTorso = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBigTorso, "{2}")
		
		snusnuMain.setSliderValue(29, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 29)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 29, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultWaist
		snusnuMain.MultWaist = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultWaist, "{2}")
		
		snusnuMain.setSliderValue(30, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 30)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 30, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultWideWaistLine
		snusnuMain.MultWideWaistLine = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultWideWaistLine, "{2}")
		
		snusnuMain.setSliderValue(31, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 31)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 31, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultChubbyWaist
		snusnuMain.MultChubbyWaist = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultChubbyWaist, "{2}")
		
		snusnuMain.setSliderValue(32, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 32)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 32, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBack
		snusnuMain.MultBack = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBack, "{2}")
		
		snusnuMain.setSliderValue(33, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 33)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 33, false)
		EndIf
		snusnuMain.UpdateWeight()
		
	ElseIf a_option == _myMultButtCrack
		snusnuMain.MultButtCrack = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultButtCrack, "{2}")
		
		snusnuMain.setSliderValue(34, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 34)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 34, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultButt
		snusnuMain.MultButt = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultButt, "{2}")
		
		snusnuMain.setSliderValue(35, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 35)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 35, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultButtSmall
		snusnuMain.MultButtSmall = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultButtSmall, "{2}")
		
		snusnuMain.setSliderValue(36, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 36)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 36, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultButtShape2
		snusnuMain.MultButtShape2 = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultButtShape2, "{2}")
		
		snusnuMain.setSliderValue(37, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 37)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 37, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultChubbyButt
		snusnuMain.MultChubbyButt = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultChubbyButt, "{2}")
		
		snusnuMain.setSliderValue(38, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 38)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 38, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBigButt
		snusnuMain.MultBigButt = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBigButt, "{2}")
		
		snusnuMain.setSliderValue(39, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 39)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 39, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultAppleCheeks
		snusnuMain.MultAppleCheeks = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultAppleCheeks, "{2}")
		
		snusnuMain.setSliderValue(40, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 40)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 40, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultRoundAss
		snusnuMain.MultRoundAss = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultRoundAss, "{2}")
		
		snusnuMain.setSliderValue(41, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 41)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 41, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultGroin
		snusnuMain.MultGroin = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultGroin, "{2}")
		
		snusnuMain.setSliderValue(42, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 42)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 42, false)
		EndIf
		snusnuMain.UpdateWeight()
		
	ElseIf a_option == _myMultHipbone
		snusnuMain.MultHipbone = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultHipbone, "{2}")
		
		snusnuMain.setSliderValue(43, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 43)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 43, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultHips
		snusnuMain.MultHips = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultHips, "{2}")
		
		snusnuMain.setSliderValue(44, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 44)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 44, false)
		EndIf
		snusnuMain.UpdateWeight()
		
	ElseIf a_option == _myMultSlimThighs
		snusnuMain.MultSlimThighs = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSlimThighs, "{2}")
		
		snusnuMain.setSliderValue(45, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 45)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 45, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultThighs
		snusnuMain.MultThighs = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultThighs, "{2}")
		
		snusnuMain.setSliderValue(46, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 46)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 46, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultChubbyLegs
		snusnuMain.MultChubbyLegs = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultChubbyLegs, "{2}")
		
		snusnuMain.setSliderValue(47, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 47)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 47, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultLegs
		snusnuMain.MultLegs = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultLegs, "{2}")
		
		snusnuMain.setSliderValue(48, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 48)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 48, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultKneeHeight
		snusnuMain.MultKneeHeight = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultKneeHeight, "{2}")
		
		snusnuMain.setSliderValue(49, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 49)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 49, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCalfSize
		snusnuMain.MultCalfSize = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCalfSize, "{2}")
		
		snusnuMain.setSliderValue(50, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 50)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 50, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCalfSmooth
		snusnuMain.MultCalfSmooth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCalfSmooth, "{2}")
		
		snusnuMain.setSliderValue(51, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 51)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 51, false)
		EndIf
		snusnuMain.UpdateWeight()
	
	;UUNP SLIDERS
	ElseIf a_option == _myMult7BLow
		snusnuMain.Mult7BLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BLow, "{2}")
		
		snusnuMain.setSliderValue(52, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 52)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 52, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BHigh
		snusnuMain.Mult7BHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BHigh, "{2}")
		
		snusnuMain.setSliderValue(53, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 53)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 53, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BBombshellLow
		snusnuMain.Mult7BBombshellLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BBombshellLow, "{2}")
		
		snusnuMain.setSliderValue(54, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 54)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 54, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BBombshellHigh
		snusnuMain.Mult7BBombshellHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BBombshellHigh, "{2}")
		
		snusnuMain.setSliderValue(55, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 55)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 55, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BNaturalLow
		snusnuMain.Mult7BNaturalLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BNaturalLow, "{2}")
		
		snusnuMain.setSliderValue(56, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 56)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 56, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BNaturalHigh
		snusnuMain.Mult7BNaturalHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BNaturalHigh, "{2}")
		
		snusnuMain.setSliderValue(57, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 57)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 57, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BCleavageLow
		snusnuMain.Mult7BCleavageLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BCleavageLow, "{2}")
		
		snusnuMain.setSliderValue(58, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 58)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 58, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BCleavageHigh
		snusnuMain.Mult7BCleavageHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BCleavageHigh, "{2}")
		
		snusnuMain.setSliderValue(59, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 59)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 59, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BBCupLow
		snusnuMain.Mult7BBCupLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BBCupLow, "{2}")
		
		snusnuMain.setSliderValue(60, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 60)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 60, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BBCupHigh
		snusnuMain.Mult7BBCupHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BBCupHigh, "{2}")
		
		snusnuMain.setSliderValue(61, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 61)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 61, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BUNPLow
		snusnuMain.Mult7BUNPLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BUNPLow, "{2}")
		
		snusnuMain.setSliderValue(62, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 62)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 62, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BUNPHigh
		snusnuMain.Mult7BUNPHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BUNPHigh, "{2}")
		
		snusnuMain.setSliderValue(63, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 63)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 63, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BCHLow
		snusnuMain.Mult7BCHLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BCHLow, "{2}")
		
		snusnuMain.setSliderValue(64, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 64)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 64, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BCHHigh
		snusnuMain.Mult7BCHHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BCHHigh, "{2}")
		
		snusnuMain.setSliderValue(65, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 65)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 65, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BOppaiLow
		snusnuMain.Mult7BOppaiLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BOppaiLow, "{2}")
		
		snusnuMain.setSliderValue(66, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 66)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 66, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BOppaiHigh
		snusnuMain.Mult7BOppaiHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BOppaiHigh, "{2}")
		
		snusnuMain.setSliderValue(67, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 67)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 67, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPLow
		snusnuMain.MultUNPLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPLow, "{2}")
		
		snusnuMain.setSliderValue(68, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 68)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 68, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPHigh
		snusnuMain.MultUNPHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPHigh, "{2}")
		
		snusnuMain.setSliderValue(69, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 69)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 69, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPPushupLow
		snusnuMain.MultUNPPushupLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPPushupLow, "{2}")
		
		snusnuMain.setSliderValue(70, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 70)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 70, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPPushupHigh
		snusnuMain.MultUNPPushupHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPPushupHigh, "{2}")
		
		snusnuMain.setSliderValue(71, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 71)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 71, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPSkinnyLow
		snusnuMain.MultUNPSkinnyLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPSkinnyLow, "{2}")
		
		snusnuMain.setSliderValue(72, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 72)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 72, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPSkinnyHigh
		snusnuMain.MultUNPSkinnyHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPSkinnyHigh, "{2}")
		
		snusnuMain.setSliderValue(73, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 73)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 73, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPPerkyLow
		snusnuMain.MultUNPPerkyLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPPerkyLow, "{2}")
		
		snusnuMain.setSliderValue(74, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 74)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 74, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPPerkyHigh
		snusnuMain.MultUNPPerkyHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPPerkyHigh, "{2}")
		
		snusnuMain.setSliderValue(75, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 75)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 75, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPBLow
		snusnuMain.MultUNPBLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPBLow, "{2}")
		
		snusnuMain.setSliderValue(76, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 76)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 76, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPBHigh
		snusnuMain.MultUNPBHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPBHigh, "{2}")
		
		snusnuMain.setSliderValue(77, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 77)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 77, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPBChapi
		snusnuMain.MultUNPBChapi = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPBChapi, "{2}")
		
		snusnuMain.setSliderValue(78, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 78)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 78, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPBOppaiv1
		snusnuMain.MultUNPBOppaiv1 = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPBOppaiv1, "{2}")
		
		snusnuMain.setSliderValue(79, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 79)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 79, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPBOppaiv3Low
		snusnuMain.MultUNPBOppaiv3Low = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPBOppaiv3Low, "{2}")
		
		snusnuMain.setSliderValue(80, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 80)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 80, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPBOppaiv3High
		snusnuMain.MultUNPBOppaiv3High = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPBOppaiv3High, "{2}")
		
		snusnuMain.setSliderValue(81, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 81)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 81, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPetiteLow
		snusnuMain.MultUNPetiteLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPetiteLow, "{2}")
		
		snusnuMain.setSliderValue(82, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 82)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 82, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPetiteHigh
		snusnuMain.MultUNPetiteHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPetiteHigh, "{2}")
		
		snusnuMain.setSliderValue(83, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 83)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 83, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPCLow
		snusnuMain.MultUNPCLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPCLow, "{2}")
		
		snusnuMain.setSliderValue(84, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 84)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 84, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPCHigh
		snusnuMain.MultUNPCHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPCHigh, "{2}")
		
		snusnuMain.setSliderValue(85, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 85)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 85, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPCMLow
		snusnuMain.MultUNPCMLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPCMLow, "{2}")
		
		snusnuMain.setSliderValue(86, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 86)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 86, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPCMHigh
		snusnuMain.MultUNPCMHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPCMHigh, "{2}")
		
		snusnuMain.setSliderValue(87, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 87)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 87, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPSHLow
		snusnuMain.MultUNPSHLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPSHLow, "{2}")
		
		snusnuMain.setSliderValue(88, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 88)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 88, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPSHHigh
		snusnuMain.MultUNPSHHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPSHHigh, "{2}")
		
		snusnuMain.setSliderValue(89, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 89)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 89, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPKLow
		snusnuMain.MultUNPKLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPKLow, "{2}")
		
		snusnuMain.setSliderValue(90, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 90)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 90, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPKHigh
		snusnuMain.MultUNPKHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPKHigh, "{2}")
		
		snusnuMain.setSliderValue(91, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 91)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 91, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPKBonusLow
		snusnuMain.MultUNPKBonusLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPKBonusLow, "{2}")
		
		snusnuMain.setSliderValue(92, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 92)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 92, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPKBonusHigh
		snusnuMain.MultUNPKBonusHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPKBonusHigh, "{2}")
		
		snusnuMain.setSliderValue(93, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 93)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 93, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUN7BLow
		snusnuMain.MultUN7BLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUN7BLow, "{2}")
		
		snusnuMain.setSliderValue(94, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 94)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 94, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUN7BHigh
		snusnuMain.MultUN7BHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUN7BHigh, "{2}")
		
		snusnuMain.setSliderValue(95, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 95)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 95, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPBBLow
		snusnuMain.MultUNPBBLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPBBLow, "{2}")
		
		snusnuMain.setSliderValue(96, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 96)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 96, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPBBHigh
		snusnuMain.MultUNPBBHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPBBHigh, "{2}")
		
		snusnuMain.setSliderValue(97, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 97)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 97, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultSeraphimLow
		snusnuMain.MultSeraphimLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSeraphimLow, "{2}")
		
		snusnuMain.setSliderValue(98, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 98)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 98, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultSeraphimHigh
		snusnuMain.MultSeraphimHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSeraphimHigh, "{2}")
		
		snusnuMain.setSliderValue(99, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 99)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 99, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultDemonfetLow
		snusnuMain.MultDemonfetLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultDemonfetLow, "{2}")
		
		snusnuMain.setSliderValue(100, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 100)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 100, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultDemonfetHigh
		snusnuMain.MultDemonfetHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultDemonfetHigh, "{2}")
		
		snusnuMain.setSliderValue(101, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 101)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 101, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultDreamGirlLow
		snusnuMain.MultDreamGirlLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultDreamGirlLow, "{2}")
		
		snusnuMain.setSliderValue(102, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 102)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 102, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultDreamGirlHigh
		snusnuMain.MultDreamGirlHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultDreamGirlHigh, "{2}")
		
		snusnuMain.setSliderValue(103, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 103)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 103, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultTopModelLow
		snusnuMain.MultTopModelLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultTopModelLow, "{2}")
		
		snusnuMain.setSliderValue(104, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 104)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 104, false)
		EndIf
		snusnuMain.UpdateWeight()
	;TLALOC - Adding missing ones
	ElseIf a_option == _myMultTopModelHigh
		snusnuMain.MultTopModelHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultTopModelHigh, "{2}")
		
		snusnuMain.setSliderValue(105, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 105)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 105, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultLeitoLow
		snusnuMain.MultLeitoLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultLeitoLow, "{2}")
		
		snusnuMain.setSliderValue(106, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 106)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 106, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultLeitoHigh
		snusnuMain.MultLeitoHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultLeitoHigh, "{2}")
		
		snusnuMain.setSliderValue(107, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 107)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 107, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPFLow
		snusnuMain.MultUNPFLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPFLow, "{2}")
		
		snusnuMain.setSliderValue(108, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 108)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 108, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPFHigh
		snusnuMain.MultUNPFHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPFHigh, "{2}")
		
		snusnuMain.setSliderValue(109, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 109)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 109, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPFxLow
		snusnuMain.MultUNPFxLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPFxLow, "{2}")
		
		snusnuMain.setSliderValue(110, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 110)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 110, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultUNPFxHigh
		snusnuMain.MultUNPFxHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultUNPFxHigh, "{2}")
		
		snusnuMain.setSliderValue(111, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 111)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 111, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCNHFLow
		snusnuMain.MultCNHFLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCNHFLow, "{2}")
		
		snusnuMain.setSliderValue(112, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 112)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 112, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCNHFHigh
		snusnuMain.MultCNHFHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCNHFHigh, "{2}")
		
		snusnuMain.setSliderValue(113, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 113)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 113, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCNHFBonusLow
		snusnuMain.MultCNHFBonusLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCNHFBonusLow, "{2}")
		
		snusnuMain.setSliderValue(114, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 114)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 114, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCNHFBonusHigh
		snusnuMain.MultCNHFBonusHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCNHFBonusHigh, "{2}")
		
		snusnuMain.setSliderValue(115, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 115)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 115, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMCBMLow
		snusnuMain.MultMCBMLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMCBMLow, "{2}")
		
		snusnuMain.setSliderValue(116, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 116)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 116, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMCBMHigh
		snusnuMain.MultMCBMHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMCBMHigh, "{2}")
		
		snusnuMain.setSliderValue(117, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 117)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 117, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultVenusLow
		snusnuMain.MultVenusLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultVenusLow, "{2}")
		
		snusnuMain.setSliderValue(118, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 118)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 118, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultVenusHigh
		snusnuMain.MultVenusHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultVenusHigh, "{2}")
		
		snusnuMain.setSliderValue(119, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 119)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 119, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultZGGBR2Low
		snusnuMain.MultZGGBR2Low = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultZGGBR2Low, "{2}")
		
		snusnuMain.setSliderValue(120, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 120)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 120, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultZGGBR2High
		snusnuMain.MultZGGBR2High = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultZGGBR2High, "{2}")
		
		snusnuMain.setSliderValue(121, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 121)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 121, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMangaLow
		snusnuMain.MultMangaLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMangaLow, "{2}")
		
		snusnuMain.setSliderValue(122, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 122)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 122, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMangaHigh
		snusnuMain.MultMangaHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMangaHigh, "{2}")
		
		snusnuMain.setSliderValue(123, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 123)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 123, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCHSBHCLow
		snusnuMain.MultCHSBHCLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCHSBHCLow, "{2}")
		
		snusnuMain.setSliderValue(124, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 124)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 124, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCHSBHCHigh
		snusnuMain.MultCHSBHCHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCHSBHCHigh, "{2}")
		
		snusnuMain.setSliderValue(125, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 125)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 125, false)
		EndIf
		snusnuMain.UpdateWeight()
		
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
		
		
	;BHUNP SLIDERS
	ElseIf a_option == _myMultBreastsTogether
		snusnuMain.MultBreastsTogether = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsTogether, "{2}")
		
		snusnuMain.setSliderValue(126, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 126)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 126, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastCenter
		snusnuMain.MultBreastCenter = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastCenter, "{2}")
		
		snusnuMain.setSliderValue(127, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 127)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 127, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastCenterBig
		snusnuMain.MultBreastCenterBig = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastCenterBig, "{2}")
		
		snusnuMain.setSliderValue(128, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 128)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 128, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultTopSlope
		snusnuMain.MultTopSlope = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultTopSlope, "{2}")
		
		snusnuMain.setSliderValue(129, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 129)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 129, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastConverge
		snusnuMain.MultBreastConverge = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastConverge, "{2}")
		
		snusnuMain.setSliderValue(130, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 130)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 130, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastsGone
		snusnuMain.MultBreastsGone = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsGone, "{2}")
		
		snusnuMain.setSliderValue(131, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 131)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 131, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastsPressed
		snusnuMain.MultBreastsPressed = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsPressed, "{2}")
		
		snusnuMain.setSliderValue(132, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 132)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 132, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNipplePuffyAreola
		snusnuMain.MultNipplePuffyAreola = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNipplePuffyAreola, "{2}")
		
		snusnuMain.setSliderValue(133, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 133)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 133, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNipBGone
		snusnuMain.MultNipBGone = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNipBGone, "{2}")
		
		snusnuMain.setSliderValue(134, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 134)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 134, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleInverted
		snusnuMain.MultNippleInverted = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleInverted, "{2}")
		
		snusnuMain.setSliderValue(135, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 135)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 135, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultChestDepth
		snusnuMain.MultChestDepth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultChestDepth, "{2}")
		
		snusnuMain.setSliderValue(136, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 136)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 136, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultChestWidth
		snusnuMain.MultChestWidth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultChestWidth, "{2}")
		
		snusnuMain.setSliderValue(137, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 137)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 137, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultRibsProminance
		snusnuMain.MultRibsProminance = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultRibsProminance, "{2}")
		
		snusnuMain.setSliderValue(138, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 138)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 138, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultSternumDepth
		snusnuMain.MultSternumDepth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSternumDepth, "{2}")
		
		snusnuMain.setSliderValue(139, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 139)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 139, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultSternumHeight
		snusnuMain.MultSternumHeight = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultSternumHeight, "{2}")
		
		snusnuMain.setSliderValue(140, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 140)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 140, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultWaistHeight
		snusnuMain.MultWaistHeight = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultWaistHeight, "{2}")
		
		snusnuMain.setSliderValue(141, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 141)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 141, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBackArch
		snusnuMain.MultBackArch = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBackArch, "{2}")
		
		snusnuMain.setSliderValue(142, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 142)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 142, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultCrotchBack
		snusnuMain.MultCrotchBack = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultCrotchBack, "{2}")
		
		snusnuMain.setSliderValue(143, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 143)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 143, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultLegsThin
		snusnuMain.MultLegsThin = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultLegsThin, "{2}")
		
		snusnuMain.setSliderValue(144, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 144)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 144, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultKneeShape
		snusnuMain.MultKneeShape = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultKneeShape, "{2}")
		
		snusnuMain.setSliderValue(145, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 145)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 145, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultKneeSlim
		snusnuMain.MultKneeSlim = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultKneeSlim, "{2}")
		
		snusnuMain.setSliderValue(146, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 146)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 146, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMuscleAbs
		snusnuMain.MultMuscleAbs = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMuscleAbs, "{2}")
		
		snusnuMain.setSliderValue(147, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 147)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 147, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMuscleArms
		snusnuMain.MultMuscleArms = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMuscleArms, "{2}")
		
		snusnuMain.setSliderValue(148, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 148)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 148, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMuscleButt
		snusnuMain.MultMuscleButt = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMuscleButt, "{2}")
		
		snusnuMain.setSliderValue(149, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 149)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 149, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMuscleLegs
		snusnuMain.MultMuscleLegs = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMuscleLegs, "{2}")
		
		snusnuMain.setSliderValue(150, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 150)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 150, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultMusclePecs
		snusnuMain.MultMusclePecs = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultMusclePecs, "{2}")
		
		snusnuMain.setSliderValue(151, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 151)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 151, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultHipForward
		snusnuMain.MultHipForward = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultHipForward, "{2}")
		
		snusnuMain.setSliderValue(152, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 152)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 152, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultHipUpperWidth
		snusnuMain.MultHipUpperWidth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultHipUpperWidth, "{2}")
		
		snusnuMain.setSliderValue(153, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 153)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 153, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultForearmSize
		snusnuMain.MultForearmSize = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultForearmSize, "{2}")
		
		snusnuMain.setSliderValue(154, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 154)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 154, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultShoulderTweak
		snusnuMain.MultShoulderTweak = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultShoulderTweak, "{2}")
		
		snusnuMain.setSliderValue(155, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 155)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 155, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBotePregnancy
		snusnuMain.MultBotePregnancy = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBotePregnancy, "{2}")
		
		snusnuMain.setSliderValue(156, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 156)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 156, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyFatLower
		snusnuMain.MultBellyFatLower = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyFatLower, "{2}")
		
		snusnuMain.setSliderValue(157, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 157)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 157, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyFatUpper
		snusnuMain.MultBellyFatUpper = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyFatUpper, "{2}")
		
		snusnuMain.setSliderValue(158, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 158)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 158, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyObesity
		snusnuMain.MultBellyObesity = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyObesity, "{2}")
		
		snusnuMain.setSliderValue(159, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 159)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 159, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyPressed
		snusnuMain.MultBellyPressed = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyPressed, "{2}")
		
		snusnuMain.setSliderValue(160, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 160)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 160, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyLowerSwell1
		snusnuMain.MultBellyLowerSwell1 = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyLowerSwell1, "{2}")
		
		snusnuMain.setSliderValue(161, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 161)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 161, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyLowerSwell2
		snusnuMain.MultBellyLowerSwell2 = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyLowerSwell2, "{2}")
		
		snusnuMain.setSliderValue(162, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 162)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 162, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyLowerSwell3
		snusnuMain.MultBellyLowerSwell3 = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyLowerSwell3, "{2}")
		
		snusnuMain.setSliderValue(163, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 163)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 163, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyCenterProtrude
		snusnuMain.MultBellyCenterProtrude = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyCenterProtrude, "{2}")
		
		snusnuMain.setSliderValue(164, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 164)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 164, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyCenterUpperProtrude
		snusnuMain.MultBellyCenterUpperProtrude = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyCenterUpperProtrude, "{2}")
		
		snusnuMain.setSliderValue(165, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 165)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 165, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBellyBalls
		snusnuMain.MultBellyBalls = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBellyBalls, "{2}")
		
		snusnuMain.setSliderValue(166, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 166)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 166, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultAruru6DuckLow
		snusnuMain.MultAruru6DuckLow = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultAruru6DuckLow, "{2}")
		
		snusnuMain.setSliderValue(167, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 167)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 167, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultAruru6DuckHigh
		snusnuMain.MultAruru6DuckHigh = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultAruru6DuckHigh, "{2}")
		
		snusnuMain.setSliderValue(168, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, 168)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, 168, false)
		EndIf
		snusnuMain.UpdateWeight()
		
	;CBBE SE SLIDERS
	ElseIf a_option == _myMultBreastsSmall2
		snusnuMain.MultBreastsSmall2 = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsSmall2, "{2}")
		
		int sliderIndex = 169
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastsNewSH
		snusnuMain.MultBreastsNewSH = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsNewSH, "{2}")
		
		int sliderIndex = 170
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastsNewSHSymmetry
		snusnuMain.MultBreastsNewSHSymmetry = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastsNewSHSymmetry, "{2}")
		
		int sliderIndex = 171
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastTopSlope
		snusnuMain.MultBreastTopSlope = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastTopSlope, "{2}")
		
		int sliderIndex = 172
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastFlatness2
		snusnuMain.MultBreastFlatness2 = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastFlatness2, "{2}")
		
		int sliderIndex = 173
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastGravity2
		snusnuMain.MultBreastGravity2 = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastGravity2, "{2}")
		
		int sliderIndex = 174
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastSideShape
		snusnuMain.MultBreastSideShape = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastSideShape, "{2}")
		
		int sliderIndex = 175
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultBreastUnderDepth
		snusnuMain.MultBreastUnderDepth = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultBreastUnderDepth, "{2}")
		
		int sliderIndex = 176
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultAreolaSize
		snusnuMain.MultAreolaSize = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultAreolaSize, "{2}")
		
		int sliderIndex = 177
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleManga
		snusnuMain.MultNippleManga = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleManga, "{2}")
		
		int sliderIndex = 178
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNipplePerkManga
		snusnuMain.MultNipplePerkManga = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNipplePerkManga, "{2}")
		
		int sliderIndex = 179
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleTipManga
		snusnuMain.MultNippleTipManga = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleTipManga, "{2}")
		
		int sliderIndex = 180
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNippleDip
		snusnuMain.MultNippleDip = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNippleDip, "{2}")
		
		int sliderIndex = 181
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultNavelEven
		snusnuMain.MultNavelEven = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultNavelEven, "{2}")
		
		int sliderIndex = 182
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultButtClassic
		snusnuMain.MultButtClassic = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultButtClassic, "{2}")
		
		int sliderIndex = 183
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultButtDimples
		snusnuMain.MultButtDimples = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultButtDimples, "{2}")
		
		int sliderIndex = 184
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultButtUnderFold
		snusnuMain.MultButtUnderFold = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultButtUnderFold, "{2}")
		
		int sliderIndex = 185
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultHipCarved
		snusnuMain.MultHipCarved = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultHipCarved, "{2}")
		
		int sliderIndex = 186
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultLegShapeClassic
		snusnuMain.MultLegShapeClassic = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultLegShapeClassic, "{2}")
		
		int sliderIndex = 187
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultFeetFeminine
		snusnuMain.MultFeetFeminine = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultFeetFeminine, "{2}")
		
		int sliderIndex = 188
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultAnkleSize
		snusnuMain.MultAnkleSize = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultAnkleSize, "{2}")
		
		int sliderIndex = 189
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultWristSize
		snusnuMain.MultWristSize = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultWristSize, "{2}")
		
		int sliderIndex = 190
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultVanillaSSELo
		snusnuMain.MultVanillaSSELo = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultVanillaSSELo, "{2}")
		
		int sliderIndex = 191
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultVanillaSSEHi
		snusnuMain.MultVanillaSSEHi = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultVanillaSSEHi, "{2}")
		
		int sliderIndex = 192
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMultOldBaseShape
		snusnuMain.MultOldBaseShape = a_value
		SetSliderOptionValue(a_option, snusnuMain.MultOldBaseShape, "{2}")
		
		int sliderIndex = 193
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BLower
		snusnuMain.Mult7BLower = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BLower, "{2}")
		
		int sliderIndex = 194
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
	ElseIf a_option == _myMult7BUpper
		snusnuMain.Mult7BUpper = a_value
		SetSliderOptionValue(a_option, snusnuMain.Mult7BUpper, "{2}")
		
		int sliderIndex = 195
		snusnuMain.setSliderValue(sliderIndex, a_value)
		If a_value == 0.0
			IntListRemove(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex)
		Else
			IntListAdd(PlayerRef, snusnuMain.SNUSNU_KEY, sliderIndex, false)
		EndIf
		snusnuMain.UpdateWeight()
		
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
		Return "Vanilla"
	EndIf
	Return ""
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
		Msg = "Please exit this menu for the changes to be correctly applied."
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
