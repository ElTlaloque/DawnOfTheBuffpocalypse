ScriptName Snusnu Extends ReferenceAlias

Import StorageUtil

; Version data
Int Property SKEE_VERSION = 1 AutoReadOnly
Int Property NIOVERRIDE_SCRIPT_VERSION = 6 AutoReadOnly
Int Property SNUSNU_VERSION = 2 AutoReadOnly
Int Property Version = 0 Auto
Bool Property showUpdateMessage = false Auto
Bool HAS_NIOVERRIDE = false

String Property SNUSNU_KEY = "Snusnu.esp" AutoReadOnly

Actor Property PlayerRef Auto

SPELL Property AbilityStamina  Auto  
SPELL Property AbilitySpeed  Auto  
SPELL Property AbilityCombat  Auto  
SPELL Property DecreaseCombat  Auto  

GlobalVariable Property GameDaysPassed  Auto  

Bool Property Enabled = False Auto
Bool Property useWeightSlider = False Auto
Bool Property disableNormals = False Auto

Float Property MultLoss = 1.0 Auto
Float Property MultGainFight = 1.0 Auto
Float Property MultGainArmor = 1.0 Auto
Float Property MultGainMisc = 1.0 Auto

Float Property Stamina = 0.0 Auto
Float Property Speed = 0.0 Auto
Float Property combatProficiency = 0.0 Auto

Float Property LastDegradationTime = 0.0 Auto
Float Property startSleepTime = 0.0 Auto
Float Property totalSleepTime = 0.0 Auto
Bool Property justWakeUp = false Auto

Float Property lostMuscle = 0.0 Auto
Float Property storedMuscle = 0.0 Auto
Float Property muscleScore = 500.0 Auto
Float Property muscleScoreMax = 1000.0 Auto
Float Property normalsScore = 450.0 Auto ;This will change along with muscleScore, but with a faster pace.

;TLALOC - Normals related values
Int Property currentBuildStage = 1 Auto
Int Property currentPregStage = 0 Auto
Int Property currentSlimStage = 0 Auto
String finalNormalsPath = "EMPTY"
String normalsPath = "textures\\Snusnu\\Normals\\"
String buildCivilianString = "civilian"
String buildAthleticString = "athletic"
String buildCrusherString = "boneCrusher"
String pregStageString = "_PREG"
String slimStageString = "_SLIM"
Bool musclePeakReached = False

Bool effectsChanged = False

Int Property getInfoKey = 52 Auto ;Period
Int Property selectedBody = 0 Auto ;0=UUNP, 1=CBBE SE, 2=Vanilla

;TLALOC- WeightMorphs related values
Bool Property isWeightMorphsLoaded Auto
Bool Property removeWeightMorphs = true Auto
;PlayerSuccubusMenu PSQM
;WeightMorphsMCM WMCM

;TLALOC- TF related stuff
SPELL Property MusclePowerSpell  Auto  
SPELL Property UltraMusclePowerSpell  Auto  
Armor Property FistsOfRage  Auto 
Bool Property tfAnimation = true Auto
Bool Property useAltAnims = true Auto
Bool Property tfAnimationNPC = true Auto
Bool Property useAltAnimsNPC = true Auto
Bool Property changeHeadPart = true Auto
Bool Property playTFSound = true Auto
HeadPart Property MuscleHead  Auto 
HeadPart Property originalHead Auto
Sound Property snusnuTFSound  Auto  

float prevPositionZ = 0.0
Bool cleavageRemoved = False

;TLALOC- Custom animations
int Property snuModID Auto
int Property snuMtBase Auto
int Property snuMtxBase Auto
int Property snuIdleBase Auto
int Property snuSneakBase Auto
int Property snuSneakIdleBase Auto
int Property snuSprintBase Auto
int Property snuCRC Auto

String[] cbbeSliders
String[] uunpSliders
String[] bhunpSliders
String[] cbbeSESliders

Float[] cbbeValues
Float[] uunpValues
Float[] bhunpValues
Float[] cbbeSEValues

;CBBE Morphs (52)
Float Property MultBreasts = 0.0 Auto
Float Property MultBreastsSmall = 0.0 Auto
Float Property MultBreastsSH = 0.0 Auto
Float Property MultBreastsSSH = -0.8 Auto
Float Property MultBreastsFantasy = -1.0 Auto
Float Property MultDoubleMelon = 0.7 Auto
Float Property MultBreastCleavage = 0.0 Auto
Float Property MultBreastFlatness = -0.1 Auto
Float Property MultBreastGravity = 1.1 Auto
Float Property MultPushUp = -0.4 Auto
Float Property MultBreastHeight = 1.6 Auto
Float Property MultBreastPerkiness = -1.2 Auto
Float Property MultBreastWidth = 1.2 Auto

Float Property MultNippleDistance = -0.6 Auto
Float Property MultNipplePerkiness = 0.0 Auto
Float Property MultNippleLength = -0.4 Auto
Float Property MultNippleSize = 0.0 Auto
Float Property MultNippleAreola = 0.0 Auto
Float Property MultNippleUp = -1.0 Auto
Float Property MultNippleDown = 0.2 Auto
Float Property MultNippleTip = 0.0 Auto

Float Property MultArms = 0.0 Auto
Float Property MultChubbyArms = 1.1 Auto
Float Property MultShoulderSmooth = 0.1 Auto
Float Property MultShoulderWidth = 0.5 Auto

Float Property MultBelly = 0.0 Auto
Float Property MultBigBelly = 0.0 Auto
Float Property MultPregnancyBelly = 0.0 Auto
Float Property MultTummyTuck = 0.0 Auto

Float Property MultBigTorso = 0.5 Auto
Float Property MultWaist = -0.45 Auto
Float Property MultWideWaistLine = 0.05 Auto
Float Property MultChubbyWaist = -0.6 Auto
Float Property MultBack = 0.4 Auto

Float Property MultButtCrack = 0.0 Auto
Float Property MultButt = -0.1 Auto
Float Property MultButtSmall = 0.0 Auto
Float Property MultButtShape2 = 0.4 Auto
Float Property MultBigButt = 0.8 Auto
Float Property MultChubbyButt = 0.0 Auto
Float Property MultAppleCheeks = -0.6 Auto
Float Property MultRoundAss = 0.0 Auto
Float Property MultGroin = 0.0 Auto

Float Property MultHipbone = 0.0 Auto
Float Property MultHips = 0.0 Auto

Float Property MultSlimThighs = 0.7 Auto
Float Property MultThighs = -0.5 Auto
Float Property MultChubbyLegs = 0.2 Auto
Float Property MultLegs = 0.0 Auto
Float Property MultKneeHeight = 0.0 Auto
Float Property MultCalfSize = -0.25 Auto
Float Property MultCalfSmooth = -0.25 Auto

;TLALOC - UUNP sliders (74)
Float Property Mult7BLow = 0.0 Auto
Float Property Mult7BHigh = 0.0 Auto
Float Property Mult7BBombshellLow = 0.0 Auto
Float Property Mult7BBombshellHigh = 0.0 Auto
Float Property Mult7BNaturalLow = 0.0 Auto
Float Property Mult7BNaturalHigh = 0.0 Auto
Float Property Mult7BCleavageLow = 0.0 Auto
Float Property Mult7BCleavageHigh = 0.0 Auto
Float Property Mult7BBCupLow = 0.0 Auto
Float Property Mult7BBCupHigh = 0.0 Auto
Float Property Mult7BUNPLow = 0.0 Auto
Float Property Mult7BUNPHigh = 0.0 Auto
Float Property Mult7BCHLow = 0.0 Auto
Float Property Mult7BCHHigh = 0.0 Auto
Float Property Mult7BOppaiLow = 0.0 Auto
Float Property Mult7BOppaiHigh = 0.0 Auto
Float Property MultUNPLow = 0.0 Auto
Float Property MultUNPHigh = 0.0 Auto
Float Property MultUNPPushupLow = 0.0 Auto
Float Property MultUNPPushupHigh = 0.0 Auto
Float Property MultUNPSkinnyLow = 0.0 Auto
Float Property MultUNPSkinnyHigh = 0.0 Auto
Float Property MultUNPPerkyLow = 0.0 Auto
Float Property MultUNPPerkyHigh = 0.0 Auto
Float Property MultUNPBLow = 0.0 Auto
Float Property MultUNPBHigh = 0.0 Auto
Float Property MultUNPBChapi = 0.0 Auto
Float Property MultUNPBOppaiv1 = 0.0 Auto
Float Property MultUNPBOppaiv3Low = 0.0 Auto
Float Property MultUNPBOppaiv3High = 0.0 Auto
Float Property MultUNPetiteLow = 0.0 Auto
Float Property MultUNPetiteHigh = 0.0 Auto
Float Property MultUNPCLow = 0.0 Auto
Float Property MultUNPCHigh = 0.0 Auto
Float Property MultUNPCMLow = 0.0 Auto
Float Property MultUNPCMHigh = 0.0 Auto
Float Property MultUNPSHLow = 0.0 Auto
Float Property MultUNPSHHigh = 0.5 Auto
Float Property MultUNPKLow = 0.0 Auto
Float Property MultUNPKHigh = 0.0 Auto
Float Property MultUNPKBonusLow = 0.0 Auto
Float Property MultUNPKBonusHigh = 0.0 Auto
Float Property MultUN7BLow = 0.0 Auto
Float Property MultUN7BHigh = 0.0 Auto
Float Property MultUNPBBLow = 0.0 Auto
Float Property MultUNPBBHigh = 0.0 Auto
Float Property MultSeraphimLow = 0.0 Auto
Float Property MultSeraphimHigh = 0.0 Auto
Float Property MultDemonfetLow = 0.0 Auto
Float Property MultDemonfetHigh = 0.0 Auto
Float Property MultDreamGirlLow = 0.0 Auto
Float Property MultDreamGirlHigh = 0.0 Auto
Float Property MultTopModelLow = 0.0 Auto
Float Property MultTopModelHigh = 0.0 Auto
Float Property MultLeitoLow = 0.0 Auto
Float Property MultLeitoHigh = 0.0 Auto
Float Property MultUNPFLow = 0.0 Auto
Float Property MultUNPFHigh = 0.0 Auto
Float Property MultUNPFxLow = 0.0 Auto
Float Property MultUNPFxHigh = 0.0 Auto
Float Property MultCNHFLow = 0.0 Auto
Float Property MultCNHFHigh = 0.0 Auto
Float Property MultCNHFBonusLow = 0.0 Auto
Float Property MultCNHFBonusHigh = 0.0 Auto
Float Property MultMCBMLow = 0.0 Auto
Float Property MultMCBMHigh = 0.5 Auto
Float Property MultVenusLow = 0.0 Auto
Float Property MultVenusHigh = 0.0 Auto
Float Property MultZGGBR2Low = 0.0 Auto
Float Property MultZGGBR2High = 0.0 Auto
Float Property MultMangaLow = 0.0 Auto
Float Property MultMangaHigh = 0.0 Auto
Float Property MultCHSBHCLow = 0.0 Auto
Float Property MultCHSBHCHigh = 0.0 Auto

;Bone related sliders
Float Property MultSpineBone = 1.05 Auto
Float Property MultForearmBone = 1.05 Auto

;BHUNP Sliders (43)
Float Property MultBreastsTogether = 0.0 Auto
Float Property MultBreastCenter = 0.0 Auto
Float Property MultBreastCenterBig = 0.0 Auto
Float Property MultTopSlope = 0.0 Auto
Float Property MultBreastConverge = 0.0 Auto
Float Property MultBreastsGone = 0.0 Auto
Float Property MultBreastsPressed = 0.0 Auto
Float Property MultNipplePuffyAreola = 0.0 Auto
Float Property MultNipBGone = 0.0 Auto
Float Property MultNippleInverted = 0.0 Auto
Float Property MultChestDepth = 0.0 Auto
Float Property MultChestWidth = 0.0 Auto
Float Property MultRibsProminance = 0.0 Auto
Float Property MultSternumDepth = 0.0 Auto
Float Property MultSternumHeight = 0.0 Auto
Float Property MultWaistHeight = 0.0 Auto
Float Property MultBackArch = 0.0 Auto
Float Property MultCrotchBack = 0.0 Auto
Float Property MultLegsThin = 0.0 Auto
Float Property MultKneeShape = 0.0 Auto
Float Property MultKneeSlim = 0.0 Auto
Float Property MultMuscleAbs = 0.0 Auto
Float Property MultMuscleArms = 0.0 Auto
Float Property MultMuscleButt = 0.0 Auto
Float Property MultMuscleLegs = 0.0 Auto
Float Property MultMusclePecs = 0.0 Auto
Float Property MultHipForward = 0.0 Auto
Float Property MultHipUpperWidth = 0.0 Auto
Float Property MultForearmSize = 0.0 Auto
Float Property MultShoulderTweak = 0.0 Auto
Float Property MultBotePregnancy = 0.0 Auto
Float Property MultBellyFatLower = 0.0 Auto
Float Property MultBellyFatUpper = 0.0 Auto
Float Property MultBellyObesity = 0.0 Auto
Float Property MultBellyPressed = 0.0 Auto
Float Property MultBellyLowerSwell1 = 0.0 Auto
Float Property MultBellyLowerSwell2 = 0.0 Auto
Float Property MultBellyLowerSwell3 = 0.0 Auto
Float Property MultBellyCenterProtrude = 0.0 Auto
Float Property MultBellyCenterUpperProtrude = 0.0 Auto
Float Property MultBellyBalls = 0.0 Auto
Float Property MultAruru6DuckLow = 0.0 Auto
Float Property MultAruru6DuckHigh = 0.0 Auto

;CBBE SE (52 -> 27)
Float Property MultBreastsSmall2 = 0.0 Auto
Float Property MultBreastsNewSH = 0.0 Auto
Float Property MultBreastsNewSHSymmetry = 0.0 Auto
;Float Property MultBreastsTogether = 0.0 Auto
;Float Property MultBreastCenter = 0.0 Auto
;Float Property MultBreastCenterBig = 0.0 Auto
Float Property MultBreastTopSlope = 0.0 Auto
Float Property MultBreastFlatness2 = 0.0 Auto
;Float Property MultBreastsGone = 0.0 Auto
Float Property MultBreastGravity2 = 0.0 Auto
Float Property MultBreastSideShape = 0.0 Auto
Float Property MultBreastUnderDepth = 0.0 Auto
Float Property MultAreolaSize = 0.0 Auto
Float Property MultNippleManga = 0.0 Auto
Float Property MultNipplePerkManga = 0.0 Auto
Float Property MultNippleTipManga = 0.0 Auto
Float Property MultNippleDip = 0.0 Auto
;Float Property MultNipBGone = 0.0 Auto
;Float Property MultForearmSize = 0.0 Auto
;Float Property MultShoulderTweak = 0.0 Auto
;Float Property MultChestDepth = 0.0 Auto
;Float Property MultChestWidth = 0.0 Auto
;Float Property MultRibsProminance = 0.0 Auto
;Float Property MultSternumDepth = 0.0 Auto
;Float Property MultSternumHeight = 0.0 Auto
;Float Property MultWaistHeight = 0.0 Auto
;Float Property MultBackArch = 0.0 Auto
Float Property MultNavelEven = 0.0 Auto
Float Property MultButtClassic = 0.0 Auto
Float Property MultButtDimples = 0.0 Auto
Float Property MultButtUnderFold = 0.0 Auto
;Float Property MultCrotchBack = 0.0 Auto
;Float Property MultHipBoneNew = 0.0 Auto
;Float Property MultHipForward = 0.0 Auto
;Float Property MultHipUpperWidth = 0.0 Auto
Float Property MultHipCarved = 0.0 Auto
;Float Property MultKneeShape = 0.0 Auto
Float Property MultLegShapeClassic = 0.0 Auto
;Float Property MultLegsThin = 0.0 Auto
Float Property MultFeetFeminine = 0.0 Auto
;Float Property MultMuscleAbs = 0.0 Auto
;Float Property MultMuscleArms = 0.0 Auto
;Float Property MultMuscleButt = 0.0 Auto
;Float Property MultMuscleLegs = 0.0 Auto
;Float Property MultMusclePecs = 0.0 Auto
Float Property MultAnkleSize = 0.0 Auto
Float Property MultWristSize = 0.0 Auto
Float Property MultVanillaSSELo = 0.0 Auto
Float Property MultVanillaSSEHi = 0.0 Auto
Float Property MultOldBaseShape = 0.0 Auto
Float Property Mult7BLower = 0.0 Auto
Float Property Mult7BUpper = 0.0 Auto

; Male morphs
Float Property MultSamuel = 1.0 Auto
Float Property MultSamson = 0.0 Auto


Int Function GetVersion()
	Return Version
EndFunction

Bool Function CheckNiOverride()
	Return SKSE.GetPluginVersion("skee") >= SKEE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction


Event OnInit()
	;Debug.Trace("SNU - OnInit()")
	Version = SNUSNU_VERSION
	
	If PlayerRef == none
		PlayerRef = Game.getPlayer()
	EndIf
	
	ResetWeight(True)
	RegisterEvents(True)
	UpdateEffects()
	initFNISanims()
EndEvent

Event OnPlayerLoadGame()
	If Enabled
		;Debug.Trace("SNU - OnPlayerLoadGame()")
		HAS_NIOVERRIDE = CheckNiOverride()
		
		If !HAS_NIOVERRIDE
			Enabled = false
			return
		EndIf
				
		If PlayerRef == none
			PlayerRef = Game.getPlayer()
		EndIf
		
		isWeightMorphsLoaded = false
;/		
		isWeightMorphsLoaded = (Game.GetModByName("WeightMorphs.esp") != 255)
		If isWeightMorphsLoaded
			WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		EndIf
		
		If Game.GetModByName("PSQ PlayerSuccubusQuest.esm") != 255
			;PSQM = Game.GetFormFromFile(0x04000D63, "PSQ PlayerSuccubusQuest.esm") As PlayerSuccubusMenu
			;Debug.Trace("SNU - Found PSQ mod at index: "+Game.GetModByName("PSQ PlayerSuccubusQuest.esm"))
		Else
			;PSQM = none
			;Debug.Trace("SNU - PSQ mod was not found")
		EndIf
/;		
		initSliderArrays()
		RegisterEvents(True)
		UpdateEffects()
		
		finalNormalsPath = "EMPTY"
		checkBodyNormalsState()
		
		;TLALOC-ToDo- Add MCM option to choose a different key
		RegisterForKey(getInfoKey)
		
		If !snuCRC
			initFNISanims()
		EndIf
	EndIf
EndEvent

Event OnRaceSwitchComplete()
	If Enabled
		;Debug.Trace("SNU - OnRaceSwitchComplete()")
		RegisterEvents(True)
		UpdateEffects()
		checkBodyNormalsState()
	EndIf
EndEvent

Event OnUpdate()
	If Enabled
		;Debug.Trace("SNU - OnUpdate()")
		; Version Update
		If Version < SNUSNU_VERSION
			If Version <= 1
				showUpdateMessage = true
			EndIf
			Version = SNUSNU_VERSION
		EndIf
		
		If PlayerRef == none
			PlayerRef = Game.getPlayer()
		EndIf
		
;		If !PlayerRef.hasSpell(UltraMusclePowerSpell) && !PlayerRef.hasSpell(MusclePowerSpell)
			Float degradationBase = -42
			
			If StorageUtil.GetIntValue(PlayerRef, "PRG_IsPregnant") == 1
				;Sadly, UNPSH slide doesn't go well with Preg slide, so we will reduce this value while PC is pregnant
				degradationBase = degradationBase * 2
			Else
				if StorageUtil.GetIntValue(PlayerRef, "PSQ_SuccubusON") == 0 && StorageUtil.GetIntValue(PlayerRef, "Exercise_Anim") == 0
					;Noting to do
				Else
					If StorageUtil.GetIntValue(PlayerRef, "Exercise_Anim") == 1
						;TLALOC- Apply when exercising animations are playing
						degradationBase = -degradationBase * 10 ;Will add around 1400 points per session
					EndIf
					if StorageUtil.GetIntValue(PlayerRef, "PSQ_SuccubusON") == 1
						;TLALOC- PC will gradually gain muscle while transformed, even if she does not excercise at all
						degradationBase = -degradationBase
					EndIf
				EndIf
			EndIf
			
			;TLALOC- Muscle score degradation
			;ToDo- Make it time based instead of loop based (Use getCurrentTime)
			Float DegradationTimer = GameDaysPassed.GetValue() - LastDegradationTime
			;updateMuscleScore(-0.1 * MultLoss)
			Float totalDegradation = degradationBase * MultLoss * DegradationTimer
			If justWakeUp
				Debug.Trace("SNU - justWakeUp, totalDegradation="+totalDegradation)
				Float sleepBonus = getSleepBonus()
				Debug.Notification("You got back "+sleepBonus+" muscle score points")
				totalDegradation = totalDegradation + sleepBonus
				Debug.Trace("SNU -             finalDegradation="+totalDegradation)
			EndIf
			updateMuscleScore(totalDegradation)
			justWakeUp = false
			;Debug.Trace("SNU - DegradationTimer="+DegradationTimer)
			LastDegradationTime = GameDaysPassed.GetValue()
			
			If StorageUtil.GetIntValue(PlayerRef, "PSQ_HasMuscle") == 0 && StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
				UpdateWeight(true)
				checkBodyNormalsState()
				
				If effectsChanged
					UpdateEffects()
					effectsChanged = False
				EndIf
			ElseIf finalNormalsPath != "EMPTY"
				;Clean all morphs so that MuscleSpell can apply their own
				finalNormalsPath = "EMPTY"
				UpdateEffects()
				If !disableNormals
					NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
				EndIf
				If StorageUtil.GetIntValue(PlayerRef, "PSQ_HasMuscle") != 0
					;TLALOC- PSQ still needs this to be called
					ClearMorphs()
				EndIf
			EndIf
;		Else
;			LastDegradationTime = GameDaysPassed.GetValue()
;		EndIf
		
		RegisterForSingleUpdate(10) ;Was 6
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	If Enabled && akSource == PlayerRef && StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
		;Debug.Trace("SNU - OnAnimationEvent("+asEventName+")")
		Float scoreAddition = 0.0
		Bool isRunningUp = false
		If asEventName == "FootSprintLeft" || asEventName == "weaponSwing" || asEventName == "weaponLeftSwing" || \
		asEventName == "SoundPlay.NPCHumanWoodChopDistant" || asEventName == "SoundPlay.NPCHumanPickAxe"
			If asEventName == "weaponSwing" || asEventName == "weaponLeftSwing"
				scoreAddition = scoreAddition + (0.25 * MultGainFight)
			ElseIf asEventName == "SoundPlay.NPCHumanWoodChopDistant" || asEventName == "SoundPlay.NPCHumanPickAxe"
				scoreAddition = scoreAddition + (0.25 * MultGainMisc)
				If asEventName == "SoundPlay.NPCHumanWoodChopDistant"
					Debug.Notification("Chopping wood makes me feel a little stronger")
				ElseIf asEventName == "SoundPlay.NPCHumanPickAxe"
					Debug.Notification("Minning makes me feel a little stronger")
				EndIf
			ElseIf PlayerRef.GetPositionZ() > prevPositionZ + 40.0 ;Was 30.0
				;Debug.Notification("Running up!")
				isRunningUp = true
				prevPositionZ = PlayerRef.GetPositionZ()
				return
			Else
				prevPositionZ = PlayerRef.GetPositionZ()
			EndIf
			
			Armor mainArmor = PlayerRef.GetWornForm(0x00000004) as Armor
			If mainArmor && ( mainArmor.IsHeavyArmor() || mainArmor.GetWeightClass() == 1 )
				If isRunningUp
					scoreAddition = scoreAddition + (0.3 * MultGainArmor)
				Else
					scoreAddition = scoreAddition + (0.05 * MultGainArmor) ;Sprinting while wearing heavy armor sure would lead to some muscle development
				EndIf
				;Debug.Trace("SNU - Sprinting extra muscle development for wearing heavy armor")
			EndIf
		ElseIf asEventName == "JumpUp" || asEventName == "PowerAttack_Start_end" || asEventName == "PowerAttackStop"
			;Debug.Trace("SNU- "+asEventName+" reduces the most of calories!")
			prevPositionZ = PlayerRef.GetPositionZ()
			
			If asEventName == "JumpUp"
				Armor mainArmor = PlayerRef.GetWornForm(0x00000004) as Armor
				If mainArmor && ( mainArmor.IsHeavyArmor() || mainArmor.GetWeightClass() == 1 )
					scoreAddition = scoreAddition + (0.3 * MultGainArmor) ;Jumping while wearing heavy armor sure would lead to some muscle development
					;Debug.Trace("SNU - Jumping extra muscle development for wearing heavy armor")
				EndIf
			Else
				scoreAddition = scoreAddition + (0.5 * MultGainFight) ;16
			EndIf
		ElseIf asEventName == "SoundPlay.FSTSwimSwim"
			scoreAddition = scoreAddition + (0.2 * MultGainMisc)
			
			Armor mainArmor = PlayerRef.GetWornForm(0x00000004) as Armor
			If mainArmor && ( mainArmor.IsHeavyArmor() || mainArmor.GetWeightClass() == 1 )
				scoreAddition = scoreAddition + (0.3 * MultGainArmor) ;Swimming while wearing heavy armor sure would lead to some muscle development
				;Debug.Trace("SNU - Swimming extra muscle development for wearing heavy armor")
			EndIf
		EndIf
		
		If scoreAddition != 0.0
			updateMuscleScore(scoreAddition)
		EndIf
	EndIf
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	;Debug.Trace("SNU - OnSleepStart()")
	startSleepTime = GameDaysPassed.GetValue()
EndEvent

Event OnSleepStop(bool abInterrupted)
	;Debug.Trace("SNU - OnSleepStop()")
	
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") != 0
		return
	EndIf
	;TLALOC-ToDo- Check if sleep time was enough (7 hrs. could be configurable) and restore muscleScore with 
	;           previously stored value (Around 0.291748 GameDaysPassed for 7 hrs)
	
	;LOGIC: storedMuscle records all of muscle gain on a day, but gets degraded over time so that if PC doesn't sleep regurarly
	;       stored muscle will be lost. recoveredMuscle records how much muscle was lost and we use it so that we cannot recover
	;       more muscle than what we lost
	totalSleepTime = GameDaysPassed.GetValue() - startSleepTime
	justWakeUp = true
EndEvent

Float Function getSleepBonus()
	Float sleepBonus = 0.0
	If storedMuscle > 0.0
		Float recoveredMuscle = storedMuscle * totalSleepTime * 2.5
		If recoveredMuscle > lostMuscle
			recoveredMuscle = lostMuscle
		EndIf
		Debug.Trace("SNU - totalSleepTime="+totalSleepTime+", storedMuscle="+storedMuscle+", lostMuscle="+lostMuscle+", recoveredMuscle="+recoveredMuscle)
		sleepBonus = recoveredMuscle
	EndIf
	storedMuscle = 0.0
	lostMuscle = 0.0
	
	return sleepBonus
EndFunction

Event OnKeyDown(Int KeyCode)
	If KeyCode == getInfoKey
;		If isWeightMorphsLoaded
;			Debug.Notification("WeightMorphs Weight="+WMCM.WMorphs.Weight)
;		EndIf
		Debug.Notification("muscleScore="+muscleScore+", normalsScore="+normalsScore)
		Debug.Notification("lostMuscle="+lostMuscle+", storedMuscle="+storedMuscle)
		If !disableNormals
			Debug.Notification("Normals="+getFinalNormalsPath())
		EndIf
	EndIf
EndEvent

Float Function getfightingMuscle()
	Int PlayerSex = PlayerRef.GetActorBase().GetSex()
	Float fightingMuscle = muscleScore / muscleScoreMax
;/		
	; Female
	If PlayerSex == 1	&& isWeightMorphsLoaded && WMCM.WMorphs.Weight > 0.2 ;There will be always at least 20% muscularity
		;TLALOC- If getting chubbier, muscle mass gets smaller (This is to avoid overly big arms and thighs on bigger muscleScore)
		;Debug.Trace("SNU - fightingMuscle="+fightingMuscle)
		fightingMuscle = fightingMuscle * ( 1.2 - WMCM.WMorphs.Weight )
		;Debug.Trace("SNU - chubbyMuscle="+fightingMuscle)
	EndIf
	
	;TLALOC- Disguise form should not be too muscular
	If fightingMuscle > 0.5 && PlayerRef.hasSpell(PSQM.PSQ.PSQDisguiseCastSpell)
		fightingMuscle = 0.5
	EndIf
/;	
	return fightingMuscle
EndFunction

Float Function getSpineSize()
	Float fightingMuscle = muscleScore / muscleScoreMax
;/	
	;TLALOC- Disguise form should not be too muscular
	If fightingMuscle > 0.5 && PlayerRef.hasSpell(PSQM.PSQ.PSQDisguiseCastSpell)
		;fightingMuscle = fightingMuscle / 2.0
		fightingMuscle = 0.5
	EndIf
/;	
	return fightingMuscle
EndFunction

Function UpdateWeight(Bool applyNow = True)
	If HAS_NIOVERRIDE
		;Debug.Trace("SNU - UpdateWeight()")
		Float fightingMuscle = getfightingMuscle()
		
		If useWeightSlider
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
				FLoat newWeight = fightingMuscle * 100
				Float tWeight = PlayerRef.GetLeveledActorBase().GetWeight()
				Float tNeckdelta = (tWeight/100) - (newWeight/100)
				
				;Debug.Trace("SNU - currentWeight="+tWeight+", newWeight="+newWeight)
				If newWeight - tWeight > 5.0 || newWeight - tWeight < -5.0
					;TLALOC- The following code can produce small lags
					PlayerRef.GetActorBase().SetWeight(newWeight)
					PlayerRef.QueueNiNodeUpdate()
					PlayerRef.UpdateWeight(tNeckdelta)
					;Debug.Trace("SNU - New weight was set")
				EndIf
				
				;TLALOC- Apply bone changes
				changeSpineBoneScale(PlayerRef, getSpineSize() * Math.abs( 1.0 - MultSpineBone ))
				changeForearmBoneScale(PlayerRef, getSpineSize() * Math.abs( 1.0 - MultForearmBone ))
			EndIf
		Else
			Int PlayerSex = PlayerRef.GetActorBase().GetSex()
			
			; Female
			If PlayerSex == 1	
				;removeCleavageEffect(fightingMuscle)
			
				If fightingMuscle > 0.0 && StorageUtil.GetIntValue(PlayerRef, "PSQ_HasMuscle") == 0 && \
				StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0 ;ToDo- PSQ_HasMuscle logic will be used for FMG spell
					Int totalSliders = IntListCount(PlayerRef, SNUSNU_KEY)
					;Debug.Trace("SNU - totalSliders="+totalSliders)
					;Debug.Trace("SNU - currentSliderIndex="+IntListGet(PlayerRef, SNUSNU_KEY, 0))
					;Debug.Trace("SNU - fightingMuscle="+fightingMuscle)
					Int slidersLoop = 0
					while slidersLoop < totalSliders
						Int currentSliderIndex = IntListGet(PlayerRef, SNUSNU_KEY, slidersLoop)
						NiOverride.SetBodyMorph(PlayerRef, getSliderString(currentSliderIndex), SNUSNU_KEY, fightingMuscle * getSliderValue(currentSliderIndex))
						slidersLoop += 1
					endWhile
					
					;TLALOC- Apply bone changes
					changeSpineBoneScale(PlayerRef, getSpineSize() * Math.abs( 1.0 - MultSpineBone ))
					changeForearmBoneScale(PlayerRef, getSpineSize() * Math.abs( 1.0 - MultForearmBone ))
				EndIf
				
			; Male
			ElseIf PlayerSex == 0
				If MultSamuel != 0.0
					NiOverride.SetBodyMorph(PlayerRef, "Samuel", SNUSNU_KEY, fightingMuscle * MultSamuel)
				Else
					NiOverride.ClearBodyMorph(PlayerRef, "Samuel", SNUSNU_KEY)
				EndIf
				If MultSamson != 0.0
					NiOverride.SetBodyMorph(PlayerRef, "Samson", SNUSNU_KEY, fightingMuscle * MultSamson)
				Else
					NiOverride.ClearBodyMorph(PlayerRef, "Samson", SNUSNU_KEY)
				EndIf
			EndIf
		EndIf
		
		If applyNow
			NiOverride.UpdateModelWeight(PlayerRef)
		EndIf
	EndIf
	
	effectsChanged = True
EndFunction

Function updateMuscleScore(float incValue)
	;Debug.Trace("SNU - updateMuscleScore()")
	If incValue < 0
		If muscleScore <= 0
			return
		EndIf
		
		If !justWakeUp
			lostMuscle = lostMuscle - incValue
			If storedMuscle > 0.0
				storedMuscle = storedMuscle + (incValue * 0.5) ;Was 1
			EndIf
		EndIf
	ElseIf incValue > 0
		;TLALOC-Original Idea: Check if PSQ is installed and then call updateMuscleScore depending on current succu energy value
		;                    (going from -4 at low energy to +2 at max)
		;TLALOC-Implementation: Multiply incValue by succubus energy factor (0.5 for succu energy < 10%, 2.0 for succu energy > 90%)
;/		If PSQM
			Float succuEnergy = PSQM.PSQ.SuccubusEnergy.GetValue() / PSQM.PSQ.MaxEnergy
			incValue = ( incValue * ( succuEnergy * 2.0 ) )
		EndIf
		
		;CFCU- If Weight is too low muscle can't grow much due to lack of carbs
		If isWeightMorphsLoaded
			If WMCM.WMorphs.Weight < -0.99
				incValue = incValue * 0.25
			EndIf
		EndIf
/;		
		
		storedMuscle = storedMuscle + incValue
	EndIf
	
	If normalsScore >= 0
		If normalsScore < muscleScore || incValue < 0
			normalsScore = normalsScore + (incValue * 2)
		Else
			normalsScore = normalsScore + incValue
		EndIf
	Else
		normalsScore = 0
	EndIf
	
	muscleScore = muscleScore + incValue
	
	If muscleScore > muscleScoreMax
		muscleScore = muscleScoreMax
	EndIf
	
	If normalsScore > muscleScore
		normalsScore = muscleScore
	EndIf
	
	If normalsScore == muscleScoreMax
		If !musclePeakReached
			Debug.Notification("I have reached my muscular peak!")
			musclePeakReached = true
		EndIf
	ElseIf musclePeakReached && normalsScore < muscleScoreMax - (muscleScoreMax * 0.01)
		musclePeakReached = false
	EndIf
EndFunction

;TLALOC- BUG FIX: changes applied to main bones will cause a one frame glitch in the character animation, so we need to avoid it
;         as much as we can and only apply it when the change difference is big enough
Function changeSpineBoneScale(Actor theActor, Float scaleValue)
	;Debug.Trace("SNU - changeSpineBoneScale()")
	Float currentScale = NiOverride.GetNodeTransformScale(theActor, false, true, "NPC Spine2 [Spn2]", SNUSNU_KEY)
	
	scaleValue = 1.0 + scaleValue
	
	;Debug.Trace("SNU - Going to update spine scale to: "+scaleValue+" (Prev value = "+currentScale+")")
	If scaleValue - currentScale > 0.001 || scaleValue - currentScale < -0.001
		;Debug.Trace("SNU - Updating spine scale")
		;Debug.Trace("SNU - Updating spine scale from: "+currentScale+" to: "+scaleValue)
		XPMSELib.SetNodeScale(theActor, true, "NPC Spine2 [Spn2]", scaleValue, SNUSNU_KEY)
		XPMSELib.SetNodeScale(theActor, true, "CME Spine2 [Spn2]", 1.0 / scaleValue, SNUSNU_KEY)
	EndIf
	
;/TLALOC-ToDo- Is not working, probably because the passed value is invalid. Check if need to be converted to radians
	;TLALOC- Rotate boobs so that they look more like pecs
	Float[] pos
	pos = NiOverride.GetNodeTransformRotation(theActor, false, true, "NPC L Breast", SNUSNU_KEY)
	pos[1] = pos[1] + (30 * scaleValue)
	XPMSELib.SetNodeRotation(theActor, true, "NPC L Breast", pos, SNUSNU_KEY)
	XPMSELib.SetNodeRotation(theActor, true, "NPC R Breast", pos, SNUSNU_KEY)
/;
EndFunction

Function changeForearmBoneScale(Actor theActor, Float scaleValue)
	;Debug.Trace("SNU - changeForearmBoneScale()")
	Float currentScale = NiOverride.GetNodeTransformScale(theActor, false, true, "NPC R Forearm [RLar]", SNUSNU_KEY)
	
	scaleValue = 1.0 + scaleValue
	
	;Debug.Trace("SNU - Going to update forearm scale to: "+scaleValue+" (Prev value = "+currentScale+")")
	If scaleValue - currentScale > 0.001 || scaleValue - currentScale < -0.001
		;Debug.Trace("SNU - Updating forearm scale")
		;TLALOC- BodySlide doesn't have slides for forearms, so we change the bones instead
		XPMSELib.SetNodeScale(theActor, true, "NPC L Forearm [LLar]", scaleValue, SNUSNU_KEY)
		XPMSELib.SetNodeScale(theActor, true, "CME L Forearm [LLar]", 1.0 / scaleValue, SNUSNU_KEY)
		XPMSELib.SetNodeScale(theActor, true, "NPC L Forearm [RLar]", scaleValue, SNUSNU_KEY)
		
		XPMSELib.SetNodeScale(theActor, true, "NPC R Forearm [RLar]", scaleValue, SNUSNU_KEY)
		XPMSELib.SetNodeScale(theActor, true, "CME R Forearm [RLar]", 1.0 / scaleValue, SNUSNU_KEY)
		
		XPMSELib.SetNodeScale(theActor, true, "NPC L ForearmTwist2 [LLt2]", scaleValue, SNUSNU_KEY)
		XPMSELib.SetNodeScale(theActor, true, "NPC R ForearmTwist2 [RLt2]", scaleValue, SNUSNU_KEY)
	EndIf
EndFunction

Function clearBoneScales(Actor theActor)
	;Debug.Trace("SNU - clearBoneScales()")
	XPMSELib.SetNodeScale(theActor, true, "NPC Spine2 [Spn2]", 1.0, SNUSNU_KEY)
	XPMSELib.SetNodeScale(theActor, true, "CME Spine2 [Spn2]", 1.0, SNUSNU_KEY)
	
	XPMSELib.SetNodeScale(theActor, true, "NPC L Clavicle [LClv]", 1.0, SNUSNU_KEY)
	XPMSELib.SetNodeScale(theActor, true, "CME L Clavicle [LClv]", 1.0, SNUSNU_KEY)
	XPMSELib.SetNodeScale(theActor, true, "NPC L Clavicle [RClv]", 1.0, SNUSNU_KEY)
	
	XPMSELib.SetNodeScale(theActor, true, "NPC R Clavicle [RClv]", 1.0, SNUSNU_KEY)
	XPMSELib.SetNodeScale(theActor, true, "CME R Clavicle [RClv]", 1.0, SNUSNU_KEY)
	
	XPMSELib.SetNodeScale(theActor, true, "NPC L Forearm [LLar]", 1.0, SNUSNU_KEY)
	XPMSELib.SetNodeScale(theActor, true, "CME L Forearm [LLar]", 1.0, SNUSNU_KEY)
	XPMSELib.SetNodeScale(theActor, true, "NPC L Forearm [RLar]", 1.0, SNUSNU_KEY)
	
	XPMSELib.SetNodeScale(theActor, true, "NPC R Forearm [RLar]", 1.0, SNUSNU_KEY)
	XPMSELib.SetNodeScale(theActor, true, "CME R Forearm [RLar]", 1.0, SNUSNU_KEY)
	
	XPMSELib.SetNodeScale(theActor, true, "NPC L ForearmTwist2 [LLt2]", 1.0, SNUSNU_KEY)
	XPMSELib.SetNodeScale(theActor, true, "NPC R ForearmTwist2 [RLt2]", 1.0, SNUSNU_KEY)
EndFunction


;TLALOC - This function controls how much cleavage effect should be removed from the current equiped
;       clothing depending on weight and muscle score.
;       NOTE: It is heavely linked with PSQ, therefore this will not work at all if PSQ is not installed
Function removeCleavageEffect(Float cleavageAmount)
	Float scoreReference = cleavageAmount
	Float WMorphsWeight = 0.0
	
	;Debug.Trace("SNU - removeCleavageEffect("+cleavageAmount+")")
;/	
	If isWeightMorphsLoaded
		WMorphsWeight = WMCM.WMorphs.Weight
	EndIf
	
	If WMorphsWeight < 0 && Math.abs(WMorphsWeight) > scoreReference
		scoreReference = Math.abs(WMorphsWeight)
	EndIf
	
	;TLALOC- Check if character actually has a piece of clothing with cleavage effect
	If PSQM
		If !PSQM.PSQ.cleavageMode
			scoreReference = 0.0
		EndIf
	Else
		return
	EndIf
	
	;TLALOC- Maybe keep a little cleave effect
	If WMorphsWeight > 0 && !(PSQM.PSQ.UseMuscularBuild && PSQM.PSQ.IsHenshined && !PlayerRef.hasSpell(PSQM.PSQ.PSQDisguiseCastSpell))
		scoreReference = scoreReference * 0.8
	EndIf
	
	;TLALOC- Bigger milky boobs need more cleavage effect
	If StorageUtil.GetFloatValue(PlayerRef, "PRG_MilkTotal") > 0.0
		scoreReference = scoreReference - (StorageUtil.GetFloatValue(PlayerRef, "PRG_MilkTotal") * 0.005)
	EndIf
/;	
	If scoreReference < 0
		scoreReference = 0.0
	EndIf
	If scoreReference == 0 && cleavageRemoved
		return
	EndIf
	
	;Debug.Trace("SNU - CleavageMorphValue="+scoreReference)
	
	If scoreReference > 0
		NiOverride.SetBodyMorph(PlayerRef, "BreastCleavage", "CleavageMorphs", -scoreReference * 0.6 )
		NiOverride.SetBodyMorph(PlayerRef, "BreastFlatness", "CleavageMorphs", -scoreReference * 0.1 )
		NiOverride.SetBodyMorph(PlayerRef, "BreastGravity", "CleavageMorphs", scoreReference * 0.3 )
		NiOverride.SetBodyMorph(PlayerRef, "BreastPerkiness", "CleavageMorphs", scoreReference * 0.24 )
		NiOverride.SetBodyMorph(PlayerRef, "BreastWidth", "CleavageMorphs", scoreReference * 0.4 )
		NiOverride.SetBodyMorph(PlayerRef, "Breasts", "CleavageMorphs", -scoreReference * 0.4 )
		NiOverride.SetBodyMorph(PlayerRef, "BreastsSSH", "CleavageMorphs", scoreReference * 0.18 )
		NiOverride.SetBodyMorph(PlayerRef, "DoubleMelon", "CleavageMorphs", -scoreReference * 1.0 )
		NiOverride.SetBodyMorph(PlayerRef, "NippleDown", "CleavageMorphs", -scoreReference * 0.2 )
		cleavageRemoved = false
	Else
		NiOverride.ClearBodyMorph(PlayerRef, "BreastCleavage", "CleavageMorphs")
		NiOverride.ClearBodyMorph(PlayerRef, "BreastFlatness", "CleavageMorphs")
		NiOverride.ClearBodyMorph(PlayerRef, "BreastGravity", "CleavageMorphs")
		NiOverride.ClearBodyMorph(PlayerRef, "BreastPerkiness", "CleavageMorphs")
		NiOverride.ClearBodyMorph(PlayerRef, "BreastWidth", "CleavageMorphs")
		NiOverride.ClearBodyMorph(PlayerRef, "Breasts", "CleavageMorphs")
		NiOverride.ClearBodyMorph(PlayerRef, "BreastsSSH", "CleavageMorphs")
		NiOverride.ClearBodyMorph(PlayerRef, "DoubleMelon", "CleavageMorphs")
		NiOverride.ClearBodyMorph(PlayerRef, "NippleDown", "CleavageMorphs")
		cleavageRemoved = true
	EndIf
EndFunction

Function tempDebugSliders()
	Int totalSliders = IntListCount(PlayerRef, SNUSNU_KEY)
	Debug.Trace("SNU - totalSliders="+totalSliders)
	Int slidersLoop = 0
	while slidersLoop < totalSliders
		Int currentSliderIndex = IntListGet(PlayerRef, SNUSNU_KEY, slidersLoop)
		Debug.Trace("SNU -     currentSlider="+currentSliderIndex+", sliderString="+getSliderString(currentSliderIndex)+", sliderValue="+getSliderValue(currentSliderIndex))
		slidersLoop += 1
	endWhile
	Debug.Trace("SNU - SpineBoneScale = "+MultSpineBone)
	Debug.Trace("SNU - ForearmBoneScale = "+MultForearmBone)
EndFunction

;     Muscle build stages = 1=Civilian, 2=Athletic, 3=Bone Crusher, 4=Extra Bone Crusher
;     Slim boobs stages = 0=Not slim, 1=Slim
;     Pregnancy stages = 0=Not preg, 1=Preg
Function checkBodyNormalsState()
	;Debug.Trace("SNU - checkBodyNormalsState()")
	If disableNormals || StorageUtil.GetIntValue(PlayerRef, "PSQ_HasMuscle") != 0 || StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") != 0
		return
	EndIf
	
	String tempNormalsPath = normalsPath
	Float stage4Score = muscleScoreMax - (muscleScoreMax * 0.1)
	Float stage3Score = muscleScoreMax - (muscleScoreMax * 0.3)
	Float stage2Score = muscleScoreMax - (muscleScoreMax * 0.5)
	
	
	;Debug.Trace("SNU - muscleScore value from Snusnu is: "+muscleScore)
	;Debug.Trace("SNU - normalsScore value from Snusnu is: "+normalsScore)
;/	
	;TLALOC- Expand the range of the changes if muscleScore is below 0.25 (This logic will allow to have a extreme muscular definition 
	;      even at that muscleScore, but only if score is high enough
	If isWeightMorphsLoaded && WMCM.WMorphs.Weight < 0.3
		Float changeDelta = (muscleScoreMax * 0.3)
		Float changeFactor = (WMCM.WMorphs.Weight * changeDelta)
		stage2Score = stage2Score + changeFactor
		stage3Score = (muscleScoreMax * 0.2) + (Math.abs(changeFactor) / 4)
		stage4Score = stage3Score * 2
		
		stage3Score = stage3Score + stage2Score
		stage4Score = stage4Score + stage2Score
		
		;Debug.Trace("SNU - New change ranges are: stage2="+stage2Score+", stage3="+stage3Score+", stage4="+stage4Score)
	EndIf
/;	
	;TLALOC - Logic to decide if the normals need to be changed
	If normalsScore >= stage4Score
		currentBuildStage = 4 ;Extra Bone Crusher
	ElseIf normalsScore >= stage3Score
		currentBuildStage = 3 ;Bone Crusher
	ElseIf normalsScore >= stage2Score || muscleScore >= stage2Score
		;TLALOC- Build will not go below Atlethic unless muscleScore is low enough. 
		;      This is to avoid having a very muscular shape but no definition at all
		currentBuildStage = 2 ;Athletic
	Else
		currentBuildStage = 1 ;Civilian
	EndIf
;/	
	If isWeightMorphsLoaded
		If currentBuildStage >= 2 && WMCM.WMorphs.Weight >= 0.35
			currentBuildStage = 1
		ElseIf currentBuildStage >= 3 && WMCM.WMorphs.Weight >= 0.30 && WMCM.WMorphs.Weight < 0.35
			currentBuildStage = 2
		EndIf
		
		If WMCM.WMorphs.Weight < -0.5
			currentSlimStage = 1
		Else
			currentSlimStage = 0
		EndIf
	EndIf
/;	
	If StorageUtil.GetFloatValue(PlayerRef, "PRG_SeedsTotal") > 3000 && currentBuildStage != 1 ;Civilian normals are already the same as preg
		currentPregStage = 1
	Else
		currentPregStage = 0
	EndIf
	
	
	;TLALOC - Start building the normals path string
	If currentBuildStage == 1
		tempNormalsPath = tempNormalsPath + buildCivilianString
	ElseIf currentBuildStage == 2
		tempNormalsPath = tempNormalsPath + buildAthleticString
	ElseIf currentBuildStage == 3
		tempNormalsPath = tempNormalsPath + buildCrusherString
	ElseIf currentBuildStage == 4
		tempNormalsPath = tempNormalsPath + buildCrusherString + "Extra"
	EndIf
	If currentSlimStage == 1
		tempNormalsPath = tempNormalsPath + slimStageString
	EndIf
	If currentPregStage == 1
		tempNormalsPath = tempNormalsPath + pregStageString
	EndIf
	
	
	tempNormalsPath = tempNormalsPath + ".dds"
	;Debug.Trace("SNU - Normals path is now "+tempNormalsPath)
	
	;Debug.Trace("SNU - Temp normals path: "+tempNormalsPath)
	;Debug.Trace("SNU - Final normals path: "+finalNormalsPath)
	;TLALOC - Apply new normals
	If finalNormalsPath == "" || StringUtil.Find(tempNormalsPath, finalNormalsPath) == -1
		finalNormalsPath = tempNormalsPath
		
		Debug.Trace("SNU - Updating normals path to "+finalNormalsPath)
		
		NiOverride.AddSkinOverrideString(PlayerRef, true, false, 0x04, 9, 1, finalNormalsPath, true)
		NiOverride.AddSkinOverrideString(PlayerRef, true, true, 0x04, 9, 1, finalNormalsPath, true)
	EndIf
EndFunction

String Function getFinalNormalsPath()
	return finalNormalsPath
EndFunction

Function UpdateEffects(Bool reAdd = True)
	PlayerRef.RemoveSpell(AbilityStamina)
	PlayerRef.RemoveSpell(AbilitySpeed)
	PlayerRef.RemoveSpell(AbilityCombat)
	PlayerRef.RemoveSpell(DecreaseCombat)
	
	If reAdd
		Float magStamina
		Float magSpeed
		
		If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
			magStamina = (muscleScore / muscleScoreMax) * Stamina
			magSpeed = (muscleScore / muscleScoreMax) * Speed
		Else
			magStamina = Stamina * 2
			magSpeed = Speed * 2
		EndIf
		
		If magStamina > 0.0
			AbilityStamina.SetNthEffectMagnitude(0, Math.abs(magStamina))
			PlayerRef.AddSpell(AbilityStamina, False)
		EndIf
		
		If magSpeed > 0.0
			AbilitySpeed.SetNthEffectMagnitude(0, Math.abs(magSpeed))
			PlayerRef.AddSpell(AbilitySpeed, False)
		EndIf
		
		If muscleScore > 10.0 && combatProficiency > 0.0
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
				Float halfMaxScore = muscleScoreMax / 2
				If muscleScore > halfMaxScore
					Float magCombat = ((muscleScore - halfMaxScore) / halfMaxScore) * combatProficiency
					;TLALOC-ToDo- Don't apply it all the time, instead do it like with the bones and check for a bigger difference
					;Debug.Trace("SNU - CombatMagnitude: "+magCombat)
					AbilityCombat.SetNthEffectMagnitude(0, Math.abs(magCombat))
					AbilityCombat.SetNthEffectMagnitude(1, Math.abs(magCombat))
					AbilityCombat.SetNthEffectMagnitude(2, Math.abs(magCombat))
					AbilityCombat.SetNthEffectMagnitude(3, Math.abs(magCombat))
					PlayerRef.AddSpell(AbilityCombat, False)
				Else
					Float magCombat = (1.0 - (muscleScore / halfMaxScore)) * combatProficiency
					;Debug.Trace("SNU - CombatDecrease: "+magCombat)
					DecreaseCombat.SetNthEffectMagnitude(0, Math.abs(magCombat))
					DecreaseCombat.SetNthEffectMagnitude(1, Math.abs(magCombat))
					DecreaseCombat.SetNthEffectMagnitude(2, Math.abs(magCombat))
					DecreaseCombat.SetNthEffectMagnitude(3, Math.abs(magCombat))
					PlayerRef.AddSpell(DecreaseCombat, False)
				EndIf
			Else
				Float magCombat = combatProficiency * 2
				AbilityCombat.SetNthEffectMagnitude(0, Math.abs(magCombat))
				AbilityCombat.SetNthEffectMagnitude(1, Math.abs(magCombat))
				AbilityCombat.SetNthEffectMagnitude(2, Math.abs(magCombat))
				AbilityCombat.SetNthEffectMagnitude(3, Math.abs(magCombat))
				PlayerRef.AddSpell(AbilityCombat, False)
			EndIf
		EndIf
	EndIf
EndFunction

Function RegisterEvents(Bool _enable)
	Debug.Trace("SNU - RegisterEvents("+_enable+")")
	If _enable
		RegisterForAnimationEvent(PlayerRef, "FootSprintLeft")
		RegisterForAnimationEvent(PlayerRef, "JumpUp")
		
		;TLALOC - Swinging a weapon should burn some calories!
		RegisterForAnimationEvent(PlayerRef, "weaponSwing")
		RegisterForAnimationEvent(PlayerRef, "weaponLeftSwing")
		
		;TLALOC - Power attacks should definitely burn more calories!
		RegisterForAnimationEvent(PlayerRef, "PowerAttack_Start_end")
		RegisterForAnimationEvent(PlayerRef, "PowerAttackStop")
		
		;TLALOC - Swimming is tyresome
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.FSTSwimSwim")
		
		;TLALOC - Chopping wood and mining should also burn calories
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanWoodChopDistant")
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanPickAxe")
		
		RegisterForSleep()
		RegisterForSingleUpdate(10)
	Else
		UnregisterForAnimationEvent(PlayerRef, "FootSprintLeft")
		UnregisterForAnimationEvent(PlayerRef, "JumpUp")
		
		UnregisterForAnimationEvent(PlayerRef, "weaponSwing")
		UnregisterForAnimationEvent(PlayerRef, "weaponLeftSwing")
		
		UnregisterForAnimationEvent(PlayerRef, "PowerAttack_Start_end")
		UnregisterForAnimationEvent(PlayerRef, "PowerAttackStop")
		
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.FSTSwimSwim")
		
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanWoodChopDistant")
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanPickAxe")
		
		UnRegisterForSleep()
		UnregisterForUpdate()
	EndIf
EndFunction

Function ResetWeight(Bool _enable)
	;Debug.Trace("SNU - ResetWeight()")
	MultLoss = 1.0
	MultGainFight = 1.0
	MultGainArmor = 1.0
	MultGainMisc = 1.0
	Stamina = 0.0
	Speed = 0.0
	storedMuscle = 0.0
	lostMuscle = 0.0
	muscleScore = 500.0
	muscleScoreMax = 1000.0
	normalsScore = 450.0
	
	LastDegradationTime = 0.0
	startSleepTime = 0.0
	totalSleepTime = 0.0
	justWakeUp = false

	currentBuildStage = 1
	currentPregStage = 0
	currentSlimStage = 0
	finalNormalsPath = "EMPTY"
	
	If _enable
		If PlayerRef.GetActorBase().GetSex() == 0
			;Player is Male
			;useWeightSlider = false
			disableNormals = true
		EndIf
		UpdateEffects()
		checkBodyNormalsState()
		initDefaultSliders()
		LastDegradationTime = GameDaysPassed.GetValue()
	Else
		UpdateEffects(False)
		NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
		ClearMorphs()
	EndIf
EndFunction

Function ClearMorphs(Bool clearBones = true)
	If HAS_NIOVERRIDE
		;Debug.Trace("SNU - ClearMorphs()")
		; CBBE
		Int cbbeLoop = 0
		while cbbeLoop < 52
			clearSliderData(1, cbbeLoop)
			cbbeLoop += 1
		endWhile
		
		;UUNP
		Int uunpLoop = 0
		while uunpLoop < 74
			clearSliderData(2, uunpLoop)
			uunpLoop += 1
		endWhile

		;BHUNP Sliders
		Int bhunpLoop = 0
		while bhunpLoop < 43
			clearSliderData(3, bhunpLoop)
			bhunpLoop += 1
		endWhile
		
		;CBBE SE Sliders
		Int cbbeSELoop = 0
		while cbbeSELoop < 27
			clearSliderData(4, cbbeSELoop)
			cbbeSELoop += 1
		endWhile
		
		;Bone changes
		If clearBones
			clearBoneScales(PlayerRef)
		EndIf
		
		; Male
		NiOverride.ClearBodyMorph(PlayerRef, "Samuel", SNUSNU_KEY)
		NiOverride.ClearBodyMorph(PlayerRef, "Samson", SNUSNU_KEY)
		
		NiOverride.UpdateModelWeight(PlayerRef)
	EndIf
EndFunction

Function initSliderArrays()
	;Debug.Trace("SNU - initSliderArrays()")
	cbbeSliders = new String[52]
	uunpSliders = new String[74]
	bhunpSliders = new String[43]
	cbbeSESliders = new String[27]
	
	cbbeValues = new Float[52]
	uunpValues = new Float[74]
	bhunpValues = new Float[43]
	cbbeSEValues = new Float[27]
	
	cbbeSliders[0] = "Breasts"
	cbbeSliders[1] = "BreastsSmall"
	cbbeSliders[2] = "BreastsSH"
	cbbeSliders[3] = "BreastsSSH"
	cbbeSliders[4] = "BreastsFantasy"
	cbbeSliders[5] = "DoubleMelon"
	cbbeSliders[6] = "BreastCleavage"
	cbbeSliders[7] = "BreastFlatness"
	cbbeSliders[8] = "BreastGravity"
	cbbeSliders[9] = "PushUp"
	cbbeSliders[10] = "BreastHeight"
	cbbeSliders[11] = "BreastPerkiness"
	cbbeSliders[12] = "BreastWidth"
	cbbeSliders[13] = "NippleDistance"
	cbbeSliders[14] = "NipplePerkiness"
	cbbeSliders[15] = "NippleLength"
	cbbeSliders[16] = "NippleSize"
	cbbeSliders[17] = "NippleAreola"
	cbbeSliders[18] = "NippleUp"
	cbbeSliders[19] = "NippleDown"
	cbbeSliders[20] = "NippleTip"
	cbbeSliders[21] = "Arms"
	cbbeSliders[22] = "ChubbyArms"
	cbbeSliders[23] = "ShoulderSmooth"
	cbbeSliders[24] = "ShoulderWidth"
	cbbeSliders[25] = "Belly"
	cbbeSliders[26] = "BigBelly"
	cbbeSliders[27] = "PregnancyBelly"
	cbbeSliders[28] = "TummyTuck"
	cbbeSliders[29] = "BigTorso"
	cbbeSliders[30] = "Waist"
	cbbeSliders[31] = "WideWaistLine"
	cbbeSliders[32] = "ChubbyWaist"
	cbbeSliders[33] = "Back"
	cbbeSliders[34] = "ButtCrack"
	cbbeSliders[35] = "Butt"
	cbbeSliders[36] = "ButtSmall"
	cbbeSliders[37] = "ButtShape2"
	cbbeSliders[38] = "BigButt"
	cbbeSliders[39] = "ChubbyButt"
	cbbeSliders[40] = "AppleCheeks"
	cbbeSliders[41] = "RoundAss"
	cbbeSliders[42] = "Groin"
	cbbeSliders[43] = "Hipbone"
	cbbeSliders[44] = "Hips"
	cbbeSliders[45] = "SlimThighs"
	cbbeSliders[46] = "Thighs"
	cbbeSliders[47] = "ChubbyLegs"
	cbbeSliders[48] = "Legs"
	cbbeSliders[49] = "KneeHeight"
	cbbeSliders[50] = "CalfSize"
	cbbeSliders[51] = "CalfSmooth"
	
	uunpSliders[0] = "7B Low"
	uunpSliders[1] = "7B High"
	uunpSliders[2] = "7B Bombshell Low"
	uunpSliders[3] = "7B Bombshell High"
	uunpSliders[4] = "7B Natural Low"
	uunpSliders[5] = "7B Natural High"
	uunpSliders[6] = "7B Cleavage Low"
	uunpSliders[7] = "7B Cleavage High"
	uunpSliders[8] = "7B BCup Low"
	uunpSliders[9] = "7B BCup High"
	uunpSliders[10] = "7BUNP Low"
	uunpSliders[11] = "7BUNP High"
	uunpSliders[12] = "7B CH Low"
	uunpSliders[13] = "7B CH High"
	uunpSliders[14] = "7B Oppai Low"
	uunpSliders[15] = "7B Oppai High"
	uunpSliders[16] = "UNP Low"
	uunpSliders[17] = "UNP High"
	uunpSliders[18] = "UNP Pushup Low"
	uunpSliders[19] = "UNP Pushup High"
	uunpSliders[20] = "UNP Skinny Low"
	uunpSliders[21] = "UNP Skinny High"
	uunpSliders[22] = "UNP Perky Low"
	uunpSliders[23] = "UNP Perky High"
	uunpSliders[24] = "UNPB Low"
	uunpSliders[25] = "UNPB High"
	uunpSliders[26] = "UNPB Chapi"
	uunpSliders[27] = "UNPB Oppai v1"
	uunpSliders[28] = "UNPB Oppai v3.2 Low"
	uunpSliders[29] = "UNPB Oppai v3.2 High"
	uunpSliders[30] = "UNPetite Low"
	uunpSliders[31] = "UNPetite High"
	uunpSliders[32] = "UNPC Low"
	uunpSliders[33] = "UNPC High"
	uunpSliders[34] = "UNPCM Low"
	uunpSliders[35] = "UNPCM High"
	uunpSliders[36] = "UNPSH Low"
	uunpSliders[37] = "UNPSH High"
	uunpSliders[38] = "UNPK Low"
	uunpSliders[39] = "UNPK High"
	uunpSliders[40] = "UNPK Bonus Low"
	uunpSliders[41] = "UNPK Bonus High"
	uunpSliders[42] = "UN7B Low"
	uunpSliders[43] = "UN7B High"
	uunpSliders[44] = "UNPBB Low"
	uunpSliders[45] = "UNPBB High"
	uunpSliders[46] = "Seraphim Low"
	uunpSliders[47] = "Seraphim High"
	uunpSliders[48] = "Demonfet Low"
	uunpSliders[49] = "Demonfet High"
	uunpSliders[50] = "Dream Girl Low"
	uunpSliders[51] = "Dream Girl High"
	uunpSliders[52] = "Top Model Low"
	uunpSliders[53] = "Top Model High"
	uunpSliders[54] = "Leito Low"
	uunpSliders[55] = "Leito High"
	uunpSliders[56] = "UNPF Low"
	uunpSliders[57] = "UNPF High"
	uunpSliders[58] = "UNPFx Low"
	uunpSliders[59] = "UNPFx High"
	uunpSliders[60] = "CNHF Low"
	uunpSliders[61] = "CNHF High"
	uunpSliders[62] = "CNHF Bonus Low"
	uunpSliders[63] = "CNHF Bonus High"
	uunpSliders[64] = "MCBM Low"
	uunpSliders[65] = "MCBM High"
	uunpSliders[66] = "Venus Low"
	uunpSliders[67] = "Venus High"
	uunpSliders[68] = "ZGGB-R2 Low"
	uunpSliders[69] = "ZGGB-R2 High"
	uunpSliders[70] = "Manga Low"
	uunpSliders[71] = "Manga High"
	uunpSliders[72] = "CHSBHC Low"
	uunpSliders[73] = "CHSBHC High"
	
	bhunpSliders[0] = "BreastsTogether"
	bhunpSliders[1] = "BreastCenter"
	bhunpSliders[2] = "BreastCenterBig"
	bhunpSliders[3] = "Top Slope"
	bhunpSliders[4] = "BreastConverge"
	bhunpSliders[5] = "BreastsGone"
	bhunpSliders[6] = "BreastsPressed"
	bhunpSliders[7] = "NipplePuffyAreola"
	bhunpSliders[8] = "NipBGone"
	bhunpSliders[9] = "NippleInverted"
	bhunpSliders[10] = "ChestDepth"
	bhunpSliders[11] = "ChestWidth"
	bhunpSliders[12] = "RibsProminance"
	bhunpSliders[13] = "SternumDepth"
	bhunpSliders[14] = "SternumHeight"
	bhunpSliders[15] = "WaistHeight"
	bhunpSliders[16] = "BackArch"
	bhunpSliders[17] = "CrotchBack"
	bhunpSliders[18] = "LegsThin"
	bhunpSliders[19] = "KneeShape"
	bhunpSliders[20] = "KneeSlim"
	bhunpSliders[21] = "MuscleAbs"
	bhunpSliders[22] = "MuscleArms"
	bhunpSliders[23] = "MuscleButt"
	bhunpSliders[24] = "MuscleLegs"
	bhunpSliders[25] = "MusclePecs"
	bhunpSliders[26] = "HipForward"
	bhunpSliders[27] = "HipUpperWidth"
	bhunpSliders[28] = "ForearmSize"
	bhunpSliders[29] = "ShoulderTweak"
	bhunpSliders[30] = "BotePregnancy"
	bhunpSliders[31] = "BellyFatLower"
	bhunpSliders[32] = "BellyFatUpper"
	bhunpSliders[33] = "BellyObesity"
	bhunpSliders[34] = "BellyPressed"
	bhunpSliders[35] = "BellyLowerSwell1"
	bhunpSliders[36] = "BellyLowerSwell2"
	bhunpSliders[37] = "BellyLowerSwell3"
	bhunpSliders[38] = "BellyCenterProtrude"
	bhunpSliders[39] = "BellyCenterUpperProtrude"
	bhunpSliders[40] = "BellyBalls"
	bhunpSliders[41] = "Aruru6Duck Low"
	bhunpSliders[42] = "Aruru6Duck High"
	
	cbbeSESliders[0] = "BreastsSmall2"
	cbbeSESliders[1] = "BreastsNewSH"
	cbbeSESliders[2] = "BreastsNewSHSymmetry"
	cbbeSESliders[3] = "BreastTopSlope"
	cbbeSESliders[4] = "BreastFlatness2"
	cbbeSESliders[5] = "BreastGravity2"
	cbbeSESliders[6] = "BreastSideShape"
	cbbeSESliders[7] = "BreastUnderDepth"
	cbbeSESliders[8] = "AreolaSize"
	cbbeSESliders[9] = "NippleManga"
	cbbeSESliders[10] = "NipplePerkManga"
	cbbeSESliders[11] = "NippleTipManga"
	cbbeSESliders[12] = "NippleDip"
	cbbeSESliders[13] = "NavelEven"
	cbbeSESliders[14] = "ButtClassic"
	cbbeSESliders[15] = "ButtDimples"
	cbbeSESliders[16] = "ButtUnderFold"
	cbbeSESliders[17] = "HipCarved"
	cbbeSESliders[18] = "LegShapeClassic"
	cbbeSESliders[19] = "FeetFeminine"
	cbbeSESliders[20] = "AnkleSize"
	cbbeSESliders[21] = "WristSize"
	cbbeSESliders[22] = "VanillaSSELo"
	cbbeSESliders[23] = "VanillaSSEHi"
	cbbeSESliders[24] = "OldBaseShape"
	cbbeSESliders[25] = "7B Lower"
	cbbeSESliders[26] = "7B Upper"
	
	cbbeValues[0] = MultBreasts
	cbbeValues[1] = MultBreastsSmall
	cbbeValues[2] = MultBreastsSH
	cbbeValues[3] = MultBreastsSSH
	cbbeValues[4] = MultBreastsFantasy
	cbbeValues[5] = MultDoubleMelon
	cbbeValues[6] = MultBreastCleavage
	cbbeValues[7] = MultBreastFlatness
	cbbeValues[8] = MultBreastGravity
	cbbeValues[9] = MultPushUp
	cbbeValues[10] = MultBreastHeight
	cbbeValues[11] = MultBreastPerkiness
	cbbeValues[12] = MultBreastWidth
	cbbeValues[13] = MultNippleDistance
	cbbeValues[14] = MultNipplePerkiness
	cbbeValues[15] = MultNippleLength
	cbbeValues[16] = MultNippleSize
	cbbeValues[17] = MultNippleAreola
	cbbeValues[18] = MultNippleUp
	cbbeValues[19] = MultNippleDown
	cbbeValues[20] = MultNippleTip
	cbbeValues[21] = MultArms
	cbbeValues[22] = MultChubbyArms
	cbbeValues[23] = MultShoulderSmooth
	cbbeValues[24] = MultShoulderWidth
	cbbeValues[25] = MultBelly
	cbbeValues[26] = MultBigBelly
	cbbeValues[27] = MultPregnancyBelly
	cbbeValues[28] = MultTummyTuck
	cbbeValues[29] = MultBigTorso
	cbbeValues[30] = MultWaist
	cbbeValues[31] = MultWideWaistLine
	cbbeValues[32] = MultChubbyWaist
	cbbeValues[33] = MultBack
	cbbeValues[34] = MultButtCrack
	cbbeValues[35] = MultButt
	cbbeValues[36] = MultButtSmall
	cbbeValues[37] = MultButtShape2
	cbbeValues[38] = MultBigButt
	cbbeValues[39] = MultChubbyButt
	cbbeValues[40] = MultAppleCheeks
	cbbeValues[41] = MultRoundAss
	cbbeValues[42] = MultGroin
	cbbeValues[43] = MultHipbone
	cbbeValues[44] = MultHips
	cbbeValues[45] = MultSlimThighs
	cbbeValues[46] = MultThighs
	cbbeValues[47] = MultChubbyLegs
	cbbeValues[48] = MultLegs
	cbbeValues[49] = MultKneeHeight
	cbbeValues[50] = MultCalfSize
	cbbeValues[51] = MultCalfSmooth

	;TLALOC - UUNP sliders (74)
	uunpValues[0] = Mult7BLow
	uunpValues[1] = Mult7BHigh
	uunpValues[2] = Mult7BBombshellLow
	uunpValues[3] = Mult7BBombshellHigh
	uunpValues[4] = Mult7BNaturalLow
	uunpValues[5] = Mult7BNaturalHigh
	uunpValues[6] = Mult7BCleavageLow
	uunpValues[7] = Mult7BCleavageHigh
	uunpValues[8] = Mult7BBCupLow
	uunpValues[9] = Mult7BBCupHigh
	uunpValues[10] = Mult7BUNPLow
	uunpValues[11] = Mult7BUNPHigh
	uunpValues[12] = Mult7BCHLow
	uunpValues[13] = Mult7BCHHigh
	uunpValues[14] = Mult7BOppaiLow
	uunpValues[15] = Mult7BOppaiHigh
	uunpValues[16] = MultUNPLow
	uunpValues[17] = MultUNPHigh
	uunpValues[18] = MultUNPPushupLow
	uunpValues[19] = MultUNPPushupHigh
	uunpValues[20] = MultUNPSkinnyLow
	uunpValues[21] = MultUNPSkinnyHigh
	uunpValues[22] = MultUNPPerkyLow
	uunpValues[23] = MultUNPPerkyHigh
	uunpValues[24] = MultUNPBLow
	uunpValues[25] = MultUNPBHigh
	uunpValues[26] = MultUNPBChapi
	uunpValues[27] = MultUNPBOppaiv1
	uunpValues[28] = MultUNPBOppaiv3Low
	uunpValues[29] = MultUNPBOppaiv3High
	uunpValues[30] = MultUNPetiteLow
	uunpValues[31] = MultUNPetiteHigh
	uunpValues[32] = MultUNPCLow
	uunpValues[33] = MultUNPCHigh
	uunpValues[34] = MultUNPCMLow
	uunpValues[35] = MultUNPCMHigh
	uunpValues[36] = MultUNPSHLow
	uunpValues[37] = MultUNPSHHigh
	uunpValues[38] = MultUNPKLow
	uunpValues[39] = MultUNPKHigh
	uunpValues[40] = MultUNPKBonusLow
	uunpValues[41] = MultUNPKBonusHigh
	uunpValues[42] = MultUN7BLow
	uunpValues[43] = MultUN7BHigh
	uunpValues[44] = MultUNPBBLow
	uunpValues[45] = MultUNPBBHigh
	uunpValues[46] = MultSeraphimLow
	uunpValues[47] = MultSeraphimHigh
	uunpValues[48] = MultDemonfetLow
	uunpValues[49] = MultDemonfetHigh
	uunpValues[50] = MultDreamGirlLow
	uunpValues[51] = MultDreamGirlHigh
	uunpValues[52] = MultTopModelLow
	uunpValues[53] = MultTopModelHigh
	uunpValues[54] = MultLeitoLow
	uunpValues[55] = MultLeitoHigh
	uunpValues[56] = MultUNPFLow
	uunpValues[57] = MultUNPFHigh
	uunpValues[58] = MultUNPFxLow
	uunpValues[59] = MultUNPFxHigh
	uunpValues[60] = MultCNHFLow
	uunpValues[61] = MultCNHFHigh
	uunpValues[62] = MultCNHFBonusLow
	uunpValues[63] = MultCNHFBonusHigh
	uunpValues[64] = MultMCBMLow
	uunpValues[65] = MultMCBMHigh
	uunpValues[66] = MultVenusLow
	uunpValues[67] = MultVenusHigh
	uunpValues[68] = MultZGGBR2Low
	uunpValues[69] = MultZGGBR2High
	uunpValues[70] = MultMangaLow
	uunpValues[71] = MultMangaHigh
	uunpValues[72] = MultCHSBHCLow
	uunpValues[73] = MultCHSBHCHigh

	;BHUNP Sliders (43)
	bhunpValues[0] = MultBreastsTogether
	bhunpValues[1] = MultBreastCenter
	bhunpValues[2] = MultBreastCenterBig
	bhunpValues[3] = MultTopSlope
	bhunpValues[4] = MultBreastConverge
	bhunpValues[5] = MultBreastsGone
	bhunpValues[6] = MultBreastsPressed
	bhunpValues[7] = MultNipplePuffyAreola
	bhunpValues[8] = MultNipBGone
	bhunpValues[9] = MultNippleInverted
	bhunpValues[10] = MultChestDepth
	bhunpValues[11] = MultChestWidth
	bhunpValues[12] = MultRibsProminance
	bhunpValues[13] = MultSternumDepth
	bhunpValues[14] = MultSternumHeight
	bhunpValues[15] = MultWaistHeight
	bhunpValues[16] = MultBackArch
	bhunpValues[17] = MultCrotchBack
	bhunpValues[18] = MultLegsThin
	bhunpValues[19] = MultKneeShape
	bhunpValues[20] = MultKneeSlim
	bhunpValues[21] = MultMuscleAbs
	bhunpValues[22] = MultMuscleArms
	bhunpValues[23] = MultMuscleButt
	bhunpValues[24] = MultMuscleLegs
	bhunpValues[25] = MultMusclePecs
	bhunpValues[26] = MultHipForward
	bhunpValues[27] = MultHipUpperWidth
	bhunpValues[28] = MultForearmSize
	bhunpValues[29] = MultShoulderTweak
	bhunpValues[30] = MultBotePregnancy
	bhunpValues[31] = MultBellyFatLower
	bhunpValues[32] = MultBellyFatUpper
	bhunpValues[33] = MultBellyObesity
	bhunpValues[34] = MultBellyPressed
	bhunpValues[35] = MultBellyLowerSwell1
	bhunpValues[36] = MultBellyLowerSwell2
	bhunpValues[37] = MultBellyLowerSwell3
	bhunpValues[38] = MultBellyCenterProtrude
	bhunpValues[39] = MultBellyCenterUpperProtrude
	bhunpValues[40] = MultBellyBalls
	bhunpValues[41] = MultAruru6DuckLow
	bhunpValues[42] = MultAruru6DuckHigh
	
	;CBBE SE Sliders(27)
	cbbeSEValues[0] = MultBreastsSmall2
	cbbeSEValues[1] = MultBreastsNewSH
	cbbeSEValues[2] = MultBreastsNewSHSymmetry
	cbbeSEValues[3] = MultBreastTopSlope
	cbbeSEValues[4] = MultBreastFlatness2
	cbbeSEValues[5] = MultBreastGravity2
	cbbeSEValues[6] = MultBreastSideShape
	cbbeSEValues[7] = MultBreastUnderDepth
	cbbeSEValues[8] = MultAreolaSize
	cbbeSEValues[9] = MultNippleManga
	cbbeSEValues[10] = MultNipplePerkManga
	cbbeSEValues[11] = MultNippleTipManga
	cbbeSEValues[12] = MultNippleDip
	cbbeSEValues[13] = MultNavelEven
	cbbeSEValues[14] = MultButtClassic
	cbbeSEValues[15] = MultButtDimples
	cbbeSEValues[16] = MultButtUnderFold
	cbbeSEValues[17] = MultHipCarved
	cbbeSEValues[18] = MultLegShapeClassic
	cbbeSEValues[19] = MultFeetFeminine
	cbbeSEValues[20] = MultAnkleSize
	cbbeSEValues[21] = MultWristSize
	cbbeSEValues[22] = MultVanillaSSELo
	cbbeSEValues[23] = MultVanillaSSEHi
	cbbeSEValues[24] = MultOldBaseShape
	cbbeSEValues[25] = Mult7BLower
	cbbeSEValues[26] = Mult7BUpper
EndFunction

Function clearSliderData(Int group, Int position)
	If group == 1
		NiOverride.ClearBodyMorph(PlayerRef, cbbeSliders[position], SNUSNU_KEY)
	ElseIf group == 2
		NiOverride.ClearBodyMorph(PlayerRef, uunpSliders[position], SNUSNU_KEY)
	ElseIf group == 3
		NiOverride.ClearBodyMorph(PlayerRef, bhunpSliders[position], SNUSNU_KEY)
	ElseIf group == 4
		NiOverride.ClearBodyMorph(PlayerRef, cbbeSESliders[position], SNUSNU_KEY)
	EndIf
EndFunction

String Function getSliderString(int newIndex)
	Int group = getGroupIndex(newIndex)
	
	If group == 1
		return cbbeSliders[newIndex]
	ElseIf group == 2
		return uunpSliders[newIndex - 52]
	ElseIf group == 3
		return bhunpSliders[newIndex - 52 - 74]
	ElseIf group == 4
		return cbbeSESliders[newIndex - 52 - 74 - 43]
	EndIf
	
	return ""
EndFunction

Float Function getSliderValue(int newIndex)
	Int group = getGroupIndex(newIndex)
	
	If group == 1
		return cbbeValues[newIndex]
	ElseIf group == 2
		return uunpValues[newIndex - 52]
	ElseIf group == 3
		return bhunpValues[newIndex - 52 - 74]
	ElseIf group == 4
		return cbbeSEValues[newIndex - 52 - 74 - 43]
	EndIf
	
	return 0.0
EndFunction

Function setSliderValue(Int position, Float value)
	Int group = getGroupIndex(position)
	
	If group == 1
		cbbeValues[position] = value
	ElseIf group == 2
		uunpValues[position - 52] = value
	ElseIf group == 3
		bhunpValues[position - 52 - 74] = value
	ElseIf group == 4
		cbbeSEValues[position - 52 - 74 - 43] = value
	EndIf
	
	If value == 0.0
		Debug.Trace("SNU - Removing morph: "+getSliderString(position))
		NiOverride.ClearBodyMorph(PlayerRef, getSliderString(position), SNUSNU_KEY)
	EndIf
EndFunction

Int Function getGroupIndex(int newIndex)
	Int group = 1
	If newIndex > 51
		group = 2
	ElseIf newIndex > 125
		group = 3
	EndIf
	
	return group
EndFunction

Function initDefaultSliders()
	;Debug.Trace("SNU - initDefaultSliders()")
	IntListClear(PlayerRef, SNUSNU_KEY)
	IntListAdd(PlayerRef, SNUSNU_KEY, 117, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 89, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 47, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 15, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 50, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 40, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 38, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 45, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 51, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 8, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 33, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 29, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 35, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 32, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 23, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 24, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 31, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 9, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 3, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 11, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 13, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 30, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 37, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 46, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 4, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 5, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 18, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 19, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 10, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 7, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 12, false)
	IntListAdd(PlayerRef, SNUSNU_KEY, 22, false)
EndFunction

Function initFNISanims()
	snuCRC = FNIS_aa.GetInstallationCRC()
	if ( snuCRC == 0 )
		Debug.Trace("SNU - ERROR while loading custom animations. Where they generated correctly?")
	else
		snuModID = FNIS_aa.GetAAModID("snu", "Snusnu", true)	; true during test phase only
		snuMtBase = FNIS_aa.GetGroupBaseValue(snuModID, FNIS_aa._mt(), "Snusnu", true)
		snuMtxBase = FNIS_aa.GetGroupBaseValue(snuModID, FNIS_aa._mtx(), "Snusnu", true)
		snuIdleBase = FNIS_aa.GetGroupBaseValue(snuModID, FNIS_aa._mtidle(), "Snusnu", true)
		snuSneakBase = FNIS_aa.GetGroupBaseValue(snuModID, FNIS_aa._sneakmt(), "Snusnu", true)
		snuSneakIdleBase = FNIS_aa.GetGroupBaseValue(snuModID, FNIS_aa._sneakidle(), "Snusnu", true)
		snuSprintBase = FNIS_aa.GetGroupBaseValue(snuModID, FNIS_aa._sprint(), "Snusnu", true)
	endif
EndFunction

Function setMuscleAnimations(Actor buffActor, Bool removeAnims = false)
	bool bOk
	if ( removeAnims )
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mt", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mtx", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mtidle", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sneakmt", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sneakidle", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sprint", 0, 0, "Snusnu", true)
	else
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mt", snuMtBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mtx", snuMtxBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mtidle", snuIdleBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sneakmt", snuSneakBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sneakidle", snuSneakIdleBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sprint", snuSprintBase, 0, "Snusnu", true)
	endif
	if !bOk
		Debug.Trace("SNU - ERROR cannot set player animvar for group _mt")
	endif
EndFunction

Function ReloadHotkeys()
	UnregisterForAllKeys()
	RegisterForKey(getInfoKey)
EndFunction
