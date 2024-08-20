ScriptName Snusnu Extends ReferenceAlias

Import StorageUtil

;/ >>>>>---- NEW IDEAS ----<<<<<

- Calculate muscle gain only by the weight of the weapon and armor being
  used, instead of only checking the type (This modification could also be
  applied to weightMorphs!)

/;

; Version data
Int Property SKEE_VERSION = 1 AutoReadOnly
Int Property NIOVERRIDE_SCRIPT_VERSION = 6 AutoReadOnly
Int Property SNUSNU_VERSION = 2 AutoReadOnly
Int Property Version = 0 Auto
Bool Property showUpdateMessage = false Auto
Bool HAS_NIOVERRIDE = false
Bool Property showInfoMessages = true Auto

LeveledItem Property LItemSpellTomes00AllSpells Auto
Bool Property alreadyAddedSpellTomes = false Auto
Book Property SpellTomeBigMuscle Auto
Book Property SpellTomeUltraBigMuscle Auto
Book Property SpellTomeBigMuscleNPC Auto

String Property SNUSNU_KEY = "Snusnu.esp" AutoReadOnly
String Property SNU_EQUIP_WEIGHTS_KEY = "SNU_EQUIP_WEIGHTS" AutoReadOnly

Actor Property PlayerRef Auto

SPELL Property AbilityStamina  Auto  
SPELL Property AbilitySpeed  Auto  
SPELL Property AbilityCombat  Auto  
SPELL Property DecreaseCombat  Auto  

GlobalVariable Property GameDaysPassed  Auto  
GlobalVariable Property MuscleLevel  Auto  
GlobalVariable Property muscleAnimsLevel  Auto
GlobalVariable Property IsOverwhelmed  Auto

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
Float Property carryWeightBoost = 0.0 Auto
Float Property currentExtraCarryWeight = 0.0 Auto

Float Property LastDegradationTime = 0.0 Auto
Float Property startSleepTime = 0.0 Auto
Float Property totalSleepTime = 0.0 Auto
Float Property lastSleepTime = 0.0 Auto
Bool Property justWakeUp = false Auto

Float bowDrawTime = 0.0
Float Property malnourishmentValue = -0.9 Auto

Float Property lostMuscle = 0.0 Auto
Float Property storedMuscle = 0.0 Auto
Float Property muscleScore = 500.0 Auto
Float Property muscleScoreMax = 1000.0 Auto
Float Property normalsScore = 450.0 Auto ;This will change along with muscleScore, but with a faster pace.
Float prevMuscleScore = 0.0 ;Save the previous value so we can decide to apply changes based on difference
Float Property scoreAddition = 0.0 Auto

Float Property concoctionModifier = 1.0 Auto

;TLALOC - Normals related values
Int Property currentBuildStage = 1 Auto
Int Property currentPregStage = 0 Auto
Int Property currentSlimStage = 0 Auto
String finalNormalsPath = "EMPTY"
String Property normalsPath = "textures\\Snusnu\\Normals\\" Auto
String buildCivilianString = "civilian"
String buildAthleticString = "athletic"
String buildCrusherString = "boneCrusher"
String pregStageString = "_PREG"
String slimStageString = "_SLIM"
Bool musclePeakReached = False
Bool malnourishmentWarning = False
Bool Property usePecs = False Auto
Armor Property handsFix Auto

Bool effectsChanged = False

Int Property getInfoKey = 52 Auto ;Period
Int Property npcMuscleKey = 37 Auto ;K
Int Property selectedBody = 0 Auto ;0=UUNP, 1=CBBE SE, 2=Vanilla

;TLALOC- WeightMorphs related values
Bool Property isWeightMorphsLoaded = false Auto
Bool Property removeWeightMorphs = true Auto
;PlayerSuccubusMenu PSQM
;WeightMorphsMCM WMCM

Bool Property useDynamicPhysics = true Auto
Bool Property is3BAPhysicsLoaded = false Auto
Int property BreastsPhysicsLevel = 3 auto ;Moved from the 3BBB scripts
Int Property physicsLevelKey = 48 Auto ;B

;TLALOC- TF related stuff
Bool Property isTransforming = false Auto
SPELL Property MusclePowerSpell  Auto
SPELL Property UltraMusclePowerSpell  Auto  
Bool Property hadMusclePowerSpell = false Auto
Bool Property hadUltraMusclePowerSpell = false Auto
Armor Property FistsOfRage  Auto 
Bool Property tfAnimation = true Auto
Bool Property useAltAnims = true Auto
Bool Property tfAnimationNPC = true Auto
Bool Property useAltAnimsNPC = true Auto
Bool Property changeHeadPart = true Auto
Bool Property playTFSound = true Auto
HeadPart Property MuscleHead  Auto
HeadPart Property MuscleHeadTan  Auto
HeadPart Property MuscleHeadTan2  Auto
HeadPart Property MuscleHeadTanUNP  Auto
HeadPart Property MuscleHeadTan2UNP  Auto
HeadPart Property originalHead Auto
Sound Property snusnuTFSound  Auto
Sound Property snusnuTFSoundShort  Auto
Bool Property applyMoreChangesOvertime = true Auto
Bool Property dynamicChangesCalculation = false Auto
Float Property moreChangesInterval = 1.0  Auto ;When the next change will occour, in in-game days
Float Property moreChangesIncrements = 0.35  Auto ;How much to change
Float Property muscleMightAffinity = 0.0  Auto
Float Property muscleMightProbability = 0.25  Auto
Float Property totalMuscleToAdd = 0.01 Auto
Float Property currentMusclePercent = 1.0 Auto
Float Property forcedMusclePercent = -1.0 Auto
Bool Property changeToBarbarianVoice = true Auto
VoiceType Property originalPCVoice = none Auto

;Alt FMG body. No morphs, just a different body mesh
Bool Property useAltBody = false Auto
Armor Property AltFMGBody Auto
HeadPart Property AltFMGHead Auto
TextureSet Property AltFMGFace Auto
Armor Property originalBody Auto
TextureSet Property originalFace Auto

;Experimental custom NPC muscle.
Float Property npcMuscleScore = 0.5 Auto

;TLALOC- Body management stuff
Float prevPositionZ = 0.0
Bool firstUpdateForBoobs = true
FormList Property PushupExceptions Auto

Keyword property daggerKeyword auto
Float Property actualCarryWeight = 0.0 Auto
Bool Property hardcoreMode = false Auto
;int Property lightItemsEquiped = 0 Auto
int Property heavyItemsEquiped = 0 Auto
Float Property itemsEquipedWeight = -1.0 Auto
Float Property allowedItemsEquipedWeight = -1.0 Auto
Float Property maxItemsEquipedWeight = 100.0 Auto
Float Property minItemsEquipedWeight = 15.0 Auto
;FIX: CarryWeight value doesn't get updated after switch equipping 2 heavy items
Bool Property needEquipWeightUpdate = false Auto
Bool isEquipWeightUpdating = false

Bool Property isWerewolf = false Auto
Float Property addWerewolfStrength = 0.05 Auto
Bool Property useWerewolfMorphs = false Auto
Bool Property isWerewolvesLoaded = false Auto

Keyword Property isVampire Auto
Float Property addVampireStrength = 0.125 Auto
Bool Property isVampireLord = false Auto
SPELL Property VampireLordMuscleSpell Auto
Float Property vampireLordMusclePercent = 0.0 Auto
Bool Property isVampireLordReVampedLoaded = false Auto
FormList Property SnusnuPlayableRaces Auto
FormList Property SnusnuVampireRaces Auto
Bool Property applyVampireFix = false Auto

;TLALOC- Custom animations
int Property snuModID Auto
int Property snuMtBase Auto
int Property snuMtxBase Auto
int Property snuIdleBase Auto
int Property snuSneakBase Auto
int Property snuSneakIdleBase Auto
int Property snuSprintBase Auto
int Property snuCRC Auto

Bool Property useMuscleAnims = true Auto
Bool Property useDARAnims = true Auto
Bool Property isUsingFNIS = false Auto
Bool Property isFNISLoaded = false Auto

String[] cbbeSliders
String[] uunpSliders
String[] bhunpSliders
String[] cbbeSESliders
String[] cbbe3BASliders
String[] bhunp3Sliders

Float[] Property cbbeValues Auto
Float[] Property uunpValues Auto
Float[] Property bhunpValues Auto
Float[] Property cbbeSEValues Auto
Float[] Property cbbe3BAValues Auto
Float[] Property bhunp3Values Auto

;Bone related sliders
;XPMSEE Has 129 different bones. Not sure if all of them can be interacted with
;48 usable sliders found in RaceMenu, from which 6 are female exclusive
Float Property MultSpineBone = 1.05 Auto
Float Property MultForearmBone = 1.05 Auto
Float[] Property bonesValues Auto
Int Property totalCurrentBones Auto
String[] boneSliders

; Male morphs
;HIMBO has 126 morphs
Float Property MultSamuel = 1.0 Auto
Float Property MultSamson = 0.0 Auto
Float[] Property maleValues Auto

;ToDo- Werewolf morphs
Float[] Property wufwufValues Auto
Float[] Property wufwufBoneValues Auto
String[] Property wufwufBones Auto

Int Function GetVersion()
	Return Version
EndFunction

Bool Function CheckNiOverride()
	Return SKSE.GetPluginVersion("skee") >= SKEE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

Function addSpellsToMerchantLists()
	Debug.Trace("SNU - Adding spells to leveled lists...")
	LItemSpellTomes00AllSpells.addForm(SpellTomeBigMuscleNPC, 1, 1)
	LItemSpellTomes00AllSpells.addForm(SpellTomeBigMuscle, 1, 1)
	LItemSpellTomes00AllSpells.addForm(SpellTomeUltraBigMuscle, 1, 1)
EndFunction

Event OnInit()
	;Debug.Trace("SNU - OnInit()")
	Version = SNUSNU_VERSION
	
	If PlayerRef == none
		PlayerRef = Game.getPlayer()
	EndIf
	
	If PlayerRef.GetActorBase().GetSex() == 0
		selectedBody = 2
	EndIf
	
	;ResetWeight(True)
	;RegisterEvents(True)
	;UpdateEffects()
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
		
		isWeightMorphsLoaded = (Game.GetModByName("WeightMorphs.esp") != 255)
		isWerewolvesLoaded = (Game.GetModByName("Werewolves.esp") != 255)
		isVampireLordReVampedLoaded = (Game.GetModByName("VampLordBS.esp") != 255)
		
		If useDynamicPhysics
			is3BAPhysicsLoaded = (Game.GetModByName("3BBB.esp") != 255)
			Debug.Trace("SNU - Is 3BBB loaded? "+is3BAPhysicsLoaded)
			If is3BAPhysicsLoaded
				firstUpdateForBoobs = true
			EndIf
		EndIf
		
		If !alreadyAddedSpellTomes
			addSpellsToMerchantLists()
			alreadyAddedSpellTomes = true
		EndIf
		
		initSliderArrays()
		RegisterEvents(True)
		UpdateEffects()
		
		finalNormalsPath = "EMPTY"
		checkBodyNormalsState()
		
		ReloadHotkeys()
		
		If allowedItemsEquipedWeight == -1.0 && hardcoreMode
			updateAllowedItemsEquipedWeight()
			getEquipedFullWeight()
			isEquipWeightUpdating = false
		EndIf
		
		If !snuCRC
			initFNISanims()
		EndIf
		
		;Reset NPCs normals updated flags
		Int totalNPCs = FormListCount(none, "MUSCLE_NPCS")
		Int npcsLoop = 0
		while npcsLoop < totalNPCs
			StorageUtil.IntListSet(none, "MUSCLE_NPCS", npcsLoop, 0)
			npcsLoop += 1
		EndWhile
	EndIf
EndEvent

Event OnRaceSwitchComplete()
	If PlayerRef.getRace().getName() != "Werewolf" && PlayerRef.getRace().getName() != "Vampire Lord"
		;Race is neither vampire or werewolf, so we assume whatever they were transformed into they reverted back
		If isWerewolf
			isWerewolf = false
			addWerewolfBuild()
			updateWerewolfBones(PlayerRef, 1.0, true)
			;ToDo- Reapply changes if FMG spell is active (Just bones. Skin should be managed by the spell itself. Normals are reapplied later in this function)
		ElseIf isVampireLord
			isVampireLord = false
			Debug.Trace("SNU - Dispeling VampireLordMuscleSpell")
			
			;VampireLordMuscleSpell.cast(PlayerRef)
			PlayerRef.DispelSpell( VampireLordMuscleSpell )
			
			clearVampireLordMuscle()
			
			Utility.Wait(0.2)
		EndIf
		
		If Enabled
			RegisterEvents(True)
			UpdateEffects()
			checkBodyNormalsState()
		EndIf
		
	ElseIf PlayerRef.getRace().getName() == "Werewolf"
		isWerewolf = true
		If useWerewolfMorphs
			updateWerewolfMuscle(getfightingMuscle())
			If !wufwufBoneValues || wufwufBoneValues.length == 0
				initWerewolfMorphArrays()
			EndIf
		EndIf
	ElseIf PlayerRef.getRace().getName() == "Vampire Lord"
		If isVampireLordReVampedLoaded
			isVampireLord = true
			Debug.Trace("SNU - Casting VampireLordMuscleSpell")
			VampireLordMuscleSpell.cast(PlayerRef)
		EndIf
	EndIf
	
	Debug.Trace("SNU - OnRaceSwitchComplete(isWerewolf="+isWerewolf+")")
	Debug.Trace("SNU - PC Race: "+PlayerRef.getRace().getName())
	Debug.Trace("SNU - isVampire? "+PlayerRef.hasKeyword(isVampire))
EndEvent

; Event received when every object in this object's parent cell is loaded
Event OnCellLoad()
	;This will be used to refresh normal maps on NPCs
	;LOGIC: Have a new boolean array to store if an NPC has been refreshed. Reset the array to all false in OnPlayerLoadGame.
	;Loop on the NPCs list and check if they have their 3d loaded and the refreshed flag is false, then refresh their normal maps
	;showInfoNotification("Cell finished loading!")
	Utility.Wait(1)
	applyNPCMuscle()
	
	If Enabled
		Location playerLocation = PlayerRef.GetCurrentLocation()
		If playerLocation.HasKeywordString("LocTypePlayerHouse") || playerLocation.HasKeywordString("LocTypeInn") ;|| \
		;playerLocation.HasKeywordString("LocTypeTemple") || playerLocation.HasKeywordString("LocTypeStore") || playerLocation.HasKeywordString("LocTypeHouse")
			
			updateCarryWeight()
			
			If hardcoreMode
				;Fix for hardcore mode values not being updated often enough (specially happens for vampires. Or not going to bed in general...)
				showInfoNotification("Updating allowed equipped weight")
				updateAllowedItemsEquipedWeight()
				needEquipWeightUpdate = true
			EndIf
		EndIf
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
		
		If scoreAddition != 0.0
			updateMuscleScore(scoreAddition)
			scoreAddition = 0.0
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
			
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0 && !isVampireLord
				;TLALOC- Muscle score degradation
				Float DegradationTimer = GameDaysPassed.GetValue() - LastDegradationTime
				Float totalDegradation = degradationBase * MultLoss * DegradationTimer
				
				If checkVampirism()
					;ToDo- If PC is vampire and they are outside in the day, degradation should be twice as bad
					;For now, degradation is always ten times faster
					totalDegradation = totalDegradation * 15
				EndIf
				
				If isWeightMorphsLoaded && SnusnuUtil.getWeightmorphsWeight() < malnourishmentValue
					totalDegradation = totalDegradation * 2
				EndIf
				
				totalDegradation = totalDegradation / concoctionModifier
				
				If justWakeUp
					Debug.Trace("SNU - justWakeUp, totalDegradation="+totalDegradation)
					Float sleepBonus = getSleepBonus()
					If sleepBonus > 0.0
						showInfoNotification("I got back "+sleepBonus+" muscle score points")
					EndIf
					totalDegradation = totalDegradation + sleepBonus
					Debug.Trace("SNU -             finalDegradation="+totalDegradation)
				EndIf
				updateMuscleScore(totalDegradation)
				
				If justWakeUp
					;Moved to OnCellLoad
					;updateCarryWeight()
					
					If hardcoreMode
						;Cleanup equipped item weights
						showInfoNotification("Refreshing hardcore weights")
						updateAllowedItemsEquipedWeight()
						getEquipedFullWeight()
					EndIf
				EndIf
			EndIf
			
			justWakeUp = false
			;Debug.Trace("SNU - DegradationTimer="+DegradationTimer)
			LastDegradationTime = GameDaysPassed.GetValue()
			
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0 && !isVampireLord
				UpdateWeight(true)
				checkBodyNormalsState()
				
				If effectsChanged
					UpdateEffects()
					effectsChanged = False
				EndIf
			ElseIf finalNormalsPath != "EMPTY"
				If finalNormalsPath == "VAMP_EMPTY"
					;TLALOC- Experimental messed up hand textures fix
					Bool hasHandFix = false
					Armor handsArmor = PlayerRef.GetWornForm(0x00000008) as Armor
					if !handsArmor
						Debug.Trace("SNU - Attempting to apply hands fix!")
						PlayerRef.equipItem(handsFix, true, true)
						Utility.wait(0.2)
						hasHandFix = true
					endIf
				
					Int level = SnusnuMusclePowerNPCScript.forceSwitchMuscleNormals(PlayerRef, vampireLordMusclePercent * 100, getNormalsByBodyType(PlayerRef))
					chooseVampLordBoobsPhysics(level)
					
					;TLALOC- Experimental messed up hand textures fix
					if hasHandFix
						Debug.Trace("SNU - Finishing to apply hands fix!")
						Utility.wait(0.2)
						PlayerRef.unequipItemslot(33)
						PlayerRef.removeitem(handsFix, 1, true)
					endIf
				EndIf
				
				;Clean all morphs so that MuscleSpell can apply their own
				finalNormalsPath = "EMPTY"
				UpdateEffects()
				
				;This causes a bug where if your PC already has muscle normals, the FMG spell will not need to override them
				;but then they will be removed by this code here. I'm really trying to think why i did add this in the first
				;place
				;/If !disableNormals
					;NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
					NiOverride.RemoveSkinOverride(PlayerRef, true, false, 0x04, 9, 1)
					NiOverride.RemoveSkinOverride(PlayerRef, true, true, 0x04, 9, 1)
				EndIf
				/;
			ElseIf useWerewolfMorphs && isWerewolf
				updateWerewolfMuscle()
			EndIf
;		Else
;			LastDegradationTime = GameDaysPassed.GetValue()
;		EndIf
		
		If needEquipWeightUpdate
			If !heavyItemsEquiped && itemsEquipedWeight > allowedItemsEquipedWeight
				Debug.Notification("I'm too weak to equip all of this!")
			
				;ToDo- We need to check how this works with the dynamic weight changes during FMG
				actualCarryWeight = PlayerRef.GetActorValue("CarryWeight")
				Float modWeight = actualCarryWeight + 500.0
				Debug.Trace("SNU - actualCarryWeight="+actualCarryWeight)
				;showInfoNotification("Carry weight: "+actualCarryWeight)
			
				;PlayerRef.UnequipItem(type, true)
				PlayerRef.ModActorValue("CarryWeight", -modWeight)
				heavyItemsEquiped = 1
				IsOverwhelmed.setValue(1)
				
				If SnusnuUtil.canPlayAnimation(PlayerRef)
					Utility.Wait(1)
					Debug.SendAnimationEvent(PlayerRef,"IdleForceDefaultState")
				EndIf
			ElseIf heavyItemsEquiped && itemsEquipedWeight <= allowedItemsEquipedWeight && PlayerRef.GetActorValue("CarryWeight") < -100
				Debug.Trace("SNU - All heavy items were removed. Restoring carryWeight")
				;showInfoNotification("Restoring carry weight: "+actualCarryWeight+"+500")
				Debug.Notification("I can move freely now")
				
				PlayerRef.ModActorValue("CarryWeight", actualCarryWeight + 500)
				heavyItemsEquiped = 0
				IsOverwhelmed.setValue(0)
				
				If SnusnuUtil.canPlayAnimation(PlayerRef)
					Utility.Wait(1)
					Debug.SendAnimationEvent(PlayerRef,"IdleForceDefaultState")
				EndIf
				
				;DEBUG
				Debug.Trace("SNU - CarryWeight after items unequipped = "+PlayerRef.GetActorValue("CarryWeight"))
			EndIf
			
			needEquipWeightUpdate = false
		EndIf
		
		RegisterForSingleUpdate(15) ;Was 6
		RegisterForSleep()
	EndIf
EndEvent

Bool Function IsValidSlotForEquipWeight(Armor itemArmor)
	;31=Hair, 35=Amulet, 36=Ring, 40=Tail, 41=LongHair, 43=Earrings, 44=FaceCover, 45=Chokers, 
	;47=Backpacks, 52=Underwear, 55=Wig, 57=Bras, 58=Armlets
	
	;Helmets use slots 30, 31, 42 & 43
	If itemArmor.HasKeywordString("ArmorHelmet") ;|| itemArmor.HasKeywordString("ArmorBoots") || itemArmor.HasKeywordString("ArmorGauntlets")
		return true
	Else
		return !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask35) && \
	           !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask36) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask40) && \
		       !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask41) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask43) && \
		       !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask44) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask45) && \
		       !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask47) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask52) && \
		       !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask55) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask57) && \
		       !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask58) && itemArmor != HandsFix
	           ;!Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask31) && 
	EndIf
EndFunction

;ITEM TYPES:
;-1=Clothing, 0=LightArmor, 1=HeavyArmor, 2=LightWeapon, 3=HeavyWeapon, 4=Bow, 5=Shield, 6=Staff
Int Function getEquipedItemType(Form theItem)
	If theItem as Armor
		Armor itemArmor = theItem as Armor
		
		If Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask32)
			If itemArmor.GetWeightClass() == 0
				return 0
			ElseIf itemArmor.GetWeightClass() == 1
				return 1
			Else
				return -1
			EndIf
		Else
			;Adding exceptions for small items:
			If IsValidSlotForEquipWeight(itemArmor)
				return 11
			EndIf
		EndIf
	ElseIf theItem as Weapon
		Weapon itemWeapon = theItem as Weapon
		If itemWeapon.hasKeyword(daggerKeyword)
			return -2
		ElseIf itemWeapon.isBow()
			return 4
		ElseIf itemWeapon.getEquipType().getNumParents() == 2
			return 3
		ElseIf itemWeapon.isStaff()
			;Staffs will need to have special handling because we don't want them to be too heavy
			return 6
		Else
			return 2
		EndIf
	EndIf
	
	return -2
EndFunction

;Skill modifier: 
;           get skill for that particular item then divide it by 15 then multipy that for the current muscle score
;           skill / 15 ->  This means that if the skill level is at the minimum (15), there will not be any skill bonus,
;           but if for example, skill is 30, the skill bonus will double the muscle score for this calculation
Float Function getEquipmentSkillBonus(Int itemType)
	Float bonus = 0.0
	
	If itemType == 2
		bonus = PlayerRef.getBaseActorValue("OneHanded")
	ElseIf itemType == 3
		bonus = PlayerRef.getBaseActorValue("TwoHanded")
	ElseIf itemType == 4
		bonus = PlayerRef.getBaseActorValue("Marksman")
	ElseIf itemType == 1
		bonus = PlayerRef.getBaseActorValue("HeavyArmor")
	ElseIf itemType == 0
		bonus = PlayerRef.getBaseActorValue("LightArmor")
	ElseIf itemType == 6
		;Staffs will need special handling
		bonus = 65.0
	EndIf
	
	;Debug.Trace("SNU - Skill value is: "+bonus)
	return bonus
EndFunction

;Nueva logica:
;         Sumar el peso de todos los items equipados en los slots principales (+Slot 49) mas las armas y escudos
;         y hacer el calculo con el rango de 10 como minimo y 150 como maximo
Float Function getEquipedFullWeight()
	;ToDo- Dont forget to add Papyrus Extender as a new requeriment for this mod
	Form[] equipedItems = PO3_SKSEFunctions.AddAllEquippedItemsToArray(PlayerRef)
	
	FormListClear(PlayerRef, SNU_EQUIP_WEIGHTS_KEY)
	FloatListClear(PlayerRef, SNU_EQUIP_WEIGHTS_KEY)
	
	int counter = 0
	itemsEquipedWeight = 0
	while counter < equipedItems.length
		Armor tmpItem = equipedItems[counter] as Armor
		If tmpItem
			Float tmpItemWeight = getItemWeight(tmpItem)
			If tmpItemWeight > 0.0
				itemsEquipedWeight = itemsEquipedWeight + tmpItemWeight
				
				FormListAdd(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, tmpItem, true)
				FloatListAdd(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, tmpItemWeight, true)
			EndIf
		EndIf
		counter += 1
	endWhile
	
	; 0 - left hand, 1 - right hand, 2 - shout
	Form theWeapon = PlayerRef.GetEquippedObject(0)
	If theWeapon
		Float tmpItemWeight = getItemWeight(theWeapon)
		If tmpItemWeight > 0.0
			itemsEquipedWeight = itemsEquipedWeight + tmpItemWeight
			
			FormListAdd(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, theWeapon, true)
			FloatListAdd(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, tmpItemWeight, true)
		EndIf
	EndIf
	
	theWeapon = PlayerRef.GetEquippedObject(1)
	If theWeapon && FormListFind(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, theWeapon) == -1
		Float tmpItemWeight = getItemWeight(theWeapon)
		If tmpItemWeight > 0.0
			itemsEquipedWeight = itemsEquipedWeight + tmpItemWeight
			
			FormListAdd(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, theWeapon, true)
			FloatListAdd(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, tmpItemWeight, true)
		EndIf
	EndIf

	;We also need to check if weight is above character limits!
	If itemsEquipedWeight > allowedItemsEquipedWeight
		actualCarryWeight = PlayerRef.GetActorValue("CarryWeight")
		Float modWeight = actualCarryWeight + 500.0
		;Debug.Trace("SNU - actualCarryWeight="+actualCarryWeight)
		
		PlayerRef.ModActorValue("CarryWeight", -modWeight)
		heavyItemsEquiped = 1
		IsOverwhelmed.setValue(1)
	EndIf
	
	return itemsEquipedWeight
EndFunction

Float Function getItemWeight(Form theItem)
	Int itemType = getEquipedItemType(theItem)
	If itemType != -2
		Float skillHelp = getEquipmentSkillBonus(itemType)
		skillHelp = (skillHelp/100) - 0.15
		If skillHelp < 0.0
			skillHelp = 0.0
		ElseIf skillHelp > 0.5
			;Maximum weight reduction by skill should be 50%. More than that would seem too unrealistic
			skillHelp = 0.5
		EndIf
		
		Float itemWeight = theItem.GetWeight()
		;Debug.Trace("SNU - "+theItem.getName()+" weight is "+itemWeight)
		itemWeight = itemWeight * (1.0 - skillHelp)
		;Debug.Trace("SNU - "+theItem.getName()+" NEW weight is "+itemWeight)
	
		return itemWeight
	EndIf
	
	return 0.0
EndFunction

Function updateAllowedItemsEquipedWeight()
	Float currentEquipRange = maxItemsEquipedWeight - minItemsEquipedWeight
	Float musclePercent = muscleScore / muscleScoreMax
	allowedItemsEquipedWeight = (currentEquipRange * musclePercent) + minItemsEquipedWeight
	
	Debug.Trace("SNU - Updating Allowed Equipped Weight. maxItemsEquipedWeight="+maxItemsEquipedWeight+", allowedItemsEquipedWeight="+allowedItemsEquipedWeight)
	
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) > 0
		If currentMusclePercent == 1.0
			allowedItemsEquipedWeight = allowedItemsEquipedWeight + 200
		Else
			allowedItemsEquipedWeight = allowedItemsEquipedWeight + (100 * currentMusclePercent)
		EndIf
	EndIf
EndFunction

Event OnObjectEquipped(Form type, ObjectReference ref)
	;Debug.Trace("SNU -----------------OnObjectEquipped()-----------------")
	If Game.IsPluginInstalled("ImmersiveInteractions.esp")
		;Debug.Trace("SNU - ImmersiveInteractions found in load order")
		Potion iaExercise = Game.GetFormFromFile(0x05084235, "ImmersiveInteractions.esp") As Potion
		If !checkVampirism() && StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0 && iaExercise && type == iaExercise
			updateMuscleScore(0.75 * MultGainMisc)
			Debug.Notification("I'm getting a little stronger")
			return
		EndIf
	EndIf
	
	If !hardcoreMode
		return
	EndIf
	
	While isEquipWeightUpdating
		Utility.wait(0.1)
	endWhile
	
	isEquipWeightUpdating = true
	;Debug.Trace("SNU - Adding weight of "+type.getName())
	Float newItemWeight = getItemWeight(type)
	If newItemWeight > 0.0
		itemsEquipedWeight = itemsEquipedWeight + newItemWeight
		FormListAdd(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, type, true)
		FloatListAdd(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, newItemWeight, true)
		;Debug.Trace("SNU - Full equiped weight is "+itemsEquipedWeight)
		showInfoNotification("Equipped weight is "+itemsEquipedWeight)
		
		If itemsEquipedWeight > allowedItemsEquipedWeight
			needEquipWeightUpdate = true
			UnregisterForUpdate()
			RegisterForSingleUpdate(1)
		EndIf
	EndIf
	isEquipWeightUpdating = false
EndEvent

Event OnObjectUnequipped(Form type, ObjectReference ref)
	Int itemType = getEquipedItemType(type)
	;Debug.Trace("SNU -----------------OnObjectUnequipped()-----------------")
	
	If !hardcoreMode || itemType == -2
		return
	EndIf
	
	While isEquipWeightUpdating
		Utility.wait(0.1)
	endWhile
	
	isEquipWeightUpdating = true
	;Debug.Trace("SNU - Removing weight of "+type.getName())
	Int itemIndex = FormListFind(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, type)
	if itemIndex > -1
		FormListPluck(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, itemIndex, none)
		Float oldItemWeight = FloatListPluck(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, itemIndex, 0.0)
		;Debug.Trace("SNU - Item weight "+oldItemWeight)
		itemsEquipedWeight = itemsEquipedWeight - oldItemWeight
		;Debug.Trace("SNU - New full equiped weight is "+itemsEquipedWeight)
		showInfoNotification("Equipped weight is now "+itemsEquipedWeight)
	EndIf
		
	If heavyItemsEquiped && itemsEquipedWeight <= allowedItemsEquipedWeight && PlayerRef.GetActorValue("CarryWeight") < -100
		needEquipWeightUpdate = true
		UnregisterForUpdate()
		RegisterForSingleUpdate(1)
	EndIf
	isEquipWeightUpdating = false
EndEvent

Function cleanupHardcoreMode()
	itemsEquipedWeight = -1.0
	allowedItemsEquipedWeight = -1.0
	
	FormListClear(PlayerRef, SNU_EQUIP_WEIGHTS_KEY)
	FloatListClear(PlayerRef, SNU_EQUIP_WEIGHTS_KEY)
	
	heavyItemsEquiped = 0
	IsOverwhelmed.setValue(0)
	
	If PlayerRef.GetActorValue("CarryWeight") < -100
		PlayerRef.ModActorValue("CarryWeight", actualCarryWeight + 500)
	EndIf
	
	Debug.Trace("SNU - CarryWeight = "+PlayerRef.GetActorValue("CarryWeight"))
EndFunction

Bool Function hasHeavyEquipment()
	If !hardcoreMode
		Armor mainArmor = PlayerRef.GetWornForm(0x00000004) as Armor
		If mainArmor && ( mainArmor.IsHeavyArmor() || mainArmor.GetWeightClass() == 1 )
			Return true
		EndIf
	ElseIf itemsEquipedWeight > allowedItemsEquipedWeight * 0.9
		Return true
	EndIf
	
	Return false
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	If Enabled && akSource == PlayerRef && StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0 && !checkVampirism()
		;Debug.Trace("SNU - OnAnimationEvent("+asEventName+")")
		
		Bool isRunningUp = false
		If asEventName == "FootSprintLeft" || asEventName == "weaponSwing" || asEventName == "weaponLeftSwing"
			If asEventName == "weaponSwing" || asEventName == "weaponLeftSwing"				
				Weapon eqWeapon = PlayerRef.GetEquippedWeapon()
				if eqWeapon != None && eqWeapon.getEquipType().getNumParents() == 2
					scoreAddition = scoreAddition + (0.5 * MultGainFight)
				Else
					scoreAddition = scoreAddition + (0.25 * MultGainFight)
				EndIf
			ElseIf PlayerRef.GetPositionZ() > prevPositionZ + 40.0 ;Was 30.0
				;showInfoNotification("Running up!")
				isRunningUp = true
				prevPositionZ = PlayerRef.GetPositionZ()
				return
			Else
				prevPositionZ = PlayerRef.GetPositionZ()
			EndIf
			
			If hasHeavyEquipment()
				If isRunningUp
					scoreAddition = scoreAddition + (0.3 * MultGainArmor)
				Else
					scoreAddition = scoreAddition + (0.05 * MultGainArmor) ;Sprinting while wearing heavy armor sure would lead to some muscle development
				EndIf
				;Debug.Trace("SNU - Sprinting extra muscle development for wearing heavy armor")
			EndIf
		ElseIf asEventName == "SoundPlay.NPCHumanWoodChopDistant" || asEventName == "SoundPlay.NPCHumanPickAxe" || \
		asEventName == "SoundPlay.OBJBlacksmithForge" || asEventName == "SoundPlay.NPCHumanBlacksmithForgeTake" || \
		asEventName == "SoundPlay.NPCHumanBlacksmithHammer" || asEventName == "SoundPlay.NPCHumanBlacksmithRepairHammer"
		
			scoreAddition = scoreAddition + (0.25 * MultGainMisc)
			If asEventName == "SoundPlay.NPCHumanWoodChopDistant"
				Debug.Notification("Chopping wood makes me feel a little stronger")
			ElseIf asEventName == "SoundPlay.NPCHumanPickAxe"
				Debug.Notification("Minning makes me feel a little stronger")
			ElseIf asEventName == "SoundPlay.NPCHumanBlacksmithForgeTake"
				Debug.Notification("A blacksmith requieres a strong build")
			EndIf
		ElseIf asEventName == "JumpUp" || asEventName == "PowerAttack_Start_end" || asEventName == "PowerAttackStop"
			;Debug.Trace("SNU - "+asEventName+" reduces the most of calories!")
			prevPositionZ = PlayerRef.GetPositionZ()
			
			If asEventName == "JumpUp"
				If hasHeavyEquipment()
					scoreAddition = scoreAddition + (0.3 * MultGainArmor) ;Jumping while wearing heavy armor sure would lead to some muscle development
					;Debug.Trace("SNU - Jumping extra muscle development for wearing heavy armor")
				EndIf
			Else
				Weapon eqWeapon = PlayerRef.GetEquippedWeapon()
				if eqWeapon != None && eqWeapon.getEquipType().getNumParents() == 2
					scoreAddition = scoreAddition + (0.8 * MultGainFight) ;16
				Else
					scoreAddition = scoreAddition + (0.5 * MultGainFight) ;16
				EndIf
			EndIf
		ElseIf asEventName == "SoundPlay.FSTSwimSwim"
			scoreAddition = scoreAddition + (0.2 * MultGainMisc)
			
			;ToDo- Due to SinkOrSwim changes, this event might never happen, so we need to change the way we detect being underwater
			If hasHeavyEquipment()
				scoreAddition = scoreAddition + (0.3 * MultGainArmor) ;Swimming while wearing heavy armor sure would lead to some muscle development
				;Debug.Trace("SNU - Swimming extra muscle development for wearing heavy armor")
			EndIf
		ElseIf asEventName == "bowDrawStart"
			;bowDrawTime = GameDaysPassed.GetValue()
			
		ElseIf asEventName == "bowDrawn" || asEventName == "arrowRelease" ;&& bowDrawTime != 0.0
			;TLALOC- This event will trigger when the bow is in "full charge", so there is no need to get the "charge time" 
			;        as it will be always the same
			
			;bowDrawTime = GameDaysPassed.GetValue() - bowDrawTime
			;showInfoNotification("bowDrawTime: "+bowDrawTime)
			
			scoreAddition = scoreAddition + (0.25 * MultGainFight)
			;Debug.Notification("Drawing my bow to full charge surely requieres a certain ammount of strength")
			
			;bowDrawTime = 0.0
		ElseIf asEventName == "FootRight" && (PlayerRef.IsOverEncumbered() || PO3_SKSEFunctions.IsActorUnderwater(PlayerRef))
			scoreAddition = scoreAddition + (0.05 * MultGainArmor)
			;Debug.Notification("Moving heavy stuff is good excercise")
		Else
			;TLALOC- Experimental custom events debug
			;showInfoNotification(asEventName)
			;Debug.Trace("SNU - "+asEventName)
		EndIf
	EndIf
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	;Debug.Trace("SNU - OnSleepStart()")
	startSleepTime = GameDaysPassed.GetValue()
EndEvent

Event OnSleepStop(bool abInterrupted)
	;Debug.Trace("SNU - OnSleepStop()")
	
	;NEW FEATURE: Randomly transform if muscle affinity is above the threshold
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) > 0
		muscleMightAffinity += 0.02
		If muscleMightAffinity > 1.0
			muscleMightAffinity = 1.0
		EndIf
		
		totalMuscleToAdd += 0.01
	Else
		muscleMightAffinity -= 0.01 ;Was 0.005
		If muscleMightAffinity < 0.0
			muscleMightAffinity = 0.0
		EndIf
	EndIf
		
	Float affinityScore = muscleMightAffinity * muscleMightProbability
	Float randomProbability = Utility.RandomFloat(0.0, 1.0)
	Debug.Trace("SNU - Checking mighty dream probability:")
	Debug.Trace("SNU -        affinityScore="+affinityScore)
	Debug.Trace("SNU -        randomProbability="+randomProbability)
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0 && !isVampireLord && affinityScore > randomProbability
		Utility.wait(3)
		Debug.Notification("I had a dream i was mighty unstoppable")
		If applyMoreChangesOvertime && affinityScore <= muscleMightProbability * 0.95
			If muscleMightAffinity < 0.5
				forcedMusclePercent = 1.0 - (moreChangesIncrements * 2)
			Else
				forcedMusclePercent = 1.0 - moreChangesIncrements
			EndIf
			MusclePowerSpell.Cast(PlayerRef)
		Else
			forcedMusclePercent = 1.0
			;UltraMusclePowerSpell.Cast(PlayerRef)
			MusclePowerSpell.Cast(PlayerRef)
		EndIf
	Else
		totalSleepTime = GameDaysPassed.GetValue() - startSleepTime
		justWakeUp = true
	EndIf
EndEvent

;TLALOC- Check if sleep time was enough (7 hrs. could be configurable) and restore muscleScore with 
;        previously stored value (Around 0.291748 GameDaysPassed for 7 hrs)

;LOGIC: storedMuscle records all of muscle gain on a day, but gets degraded over time so that if PC doesn't sleep regurarly
;       stored muscle will be lost. recoveredMuscle records how much muscle was lost and we use it so that we cannot recover
;       more muscle than what we lost
Float Function getSleepBonus()
	Float sleepBonus = 0.0
	If storedMuscle > 0.0
		Float recoveredMuscle = storedMuscle * totalSleepTime * 2.5
		If recoveredMuscle > lostMuscle
			recoveredMuscle = lostMuscle
		EndIf
		
		;Apply muscle degradation if last sleep time is higher than 16 hours
		Float timeWithoutSleep = GameDaysPassed.GetValue() - lastSleepTime
		If timeWithoutSleep > 0.7
			timeWithoutSleep = (timeWithoutSleep - 0.7) * 0.5
			If timeWithoutSleep > 1.0
				timeWithoutSleep = 1.0
			EndIf
			recoveredMuscle = recoveredMuscle * (1 - timeWithoutSleep)
		EndIf
		
		Debug.Trace("SNU - totalSleepTime="+totalSleepTime+", storedMuscle="+storedMuscle+", lostMuscle="+lostMuscle+", recoveredMuscle="+recoveredMuscle)
		sleepBonus = recoveredMuscle
	EndIf
	storedMuscle = 0.0
	lostMuscle = 0.0
	lastSleepTime = GameDaysPassed.GetValue()
	
	return sleepBonus
EndFunction

Bool Function checkVampirism()
	return addVampireStrength > 0.0 && PlayerRef.hasKeyword(isVampire)
EndFunction

Function chooseVampLordBoobsPhysics(Int level)
	If level == 1
		updateBoobsPhysics(true, 3)
	ElseIf level == 2
		updateBoobsPhysics(true, 2)
	ElseIf level == 3
		updateBoobsPhysics(true, 1)
	ElseIf level >= 4
		updateBoobsPhysics(true, 1)
	EndIf
EndFunction

Function clearVampireLordMuscle()
	NiOverride.ClearBodyMorphKeys(PlayerRef, "Snusnu_BUFF")
	clearBoneScales(PlayerRef)

	Bool isFemale = PlayerRef.GetActorBase().GetSex() != 0
	NiOverride.RemoveSkinOverride(PlayerRef, isFemale, false, 0x04, 9, 1)
	NiOverride.RemoveSkinOverride(PlayerRef, isFemale, true, 0x04, 9, 1)
	If !PlayerRef.IsOnMount()
		PlayerRef.QueueNiNodeUpdate()
	EndIf
endFunction

Event OnVampireFeed(Actor akTarget)
	If addVampireStrength > 0.0 && StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0
		updateMuscleScore(muscleScoreMax * addVampireStrength) ;Was 0.075
		
		If hardcoreMode
			updateAllowedItemsEquipedWeight()
			getEquipedFullWeight()
		EndIf
		
		Debug.Notification("I feel stronger now")
		UpdateWeight(true)
	EndIf
EndEvent

Event OnKeyDown(Int KeyCode)
	If KeyCode == getInfoKey
		
		;/WetFunctionRedux info
		If Game.GetModByName("WetFunction.esp") != 255
			Debug.Notification("Wetness: "+StorageUtil.GetFloatValue(PlayerRef, "WetFunction_Actor_wetness", 0.0))
		EndIf
		/;
		
		;WeightMorphs info
		If isWeightMorphsLoaded
			Debug.Notification("WeightMorphs Weight="+SnusnuUtil.getWeightmorphsWeight())
		EndIf
		If carryWeightBoost != 0.0
			Debug.Notification("ExtraCarryWeight="+currentExtraCarryWeight)
			
		EndIf
		Debug.Notification("concoctionModifier="+concoctionModifier+", muscleMightAffinity="+muscleMightAffinity)
		Debug.Notification("itemsEquipedWeight="+itemsEquipedWeight+", allowedItemsEquipedWeight="+allowedItemsEquipedWeight)
		Debug.Notification("muscleScore="+getMuscleValuePercent(muscleScore)+"%, normalsScore="+getMuscleValuePercent(normalsScore)+"%")
		;Debug.Notification("lostMuscle="+getMuscleValuePercent(lostMuscle)+"%, storedMuscle="+getMuscleValuePercent(storedMuscle)+"%")
		If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) > 0
			Debug.Notification("totalMuscleToAdd="+totalMuscleToAdd+", currentBuildStage="+currentBuildStage)
		EndIf
		If !disableNormals
			Debug.Notification("Normals="+getFinalNormalsPath())
		EndIf
	ElseIf KeyCode == npcMuscleKey && !UI.IsTextInputEnabled() && !Utility.IsInMenuMode()
		applyNPCMuscle()
	ElseIf KeyCode == physicsLevelKey && !UI.IsTextInputEnabled() && !Utility.IsInMenuMode()
		If !useDynamicPhysics || SnusnuUtil.checkSMPPhysics(PlayerRef)
			;Player is using SMP for body physics so we stop here
			return
		EndIf
	
		BreastsPhysicsLevel = BreastsPhysicsLevel + 1
		If BreastsPhysicsLevel > 4
			BreastsPhysicsLevel = 1
		EndIf
		
		If BreastsPhysicsLevel == 1
			Debug.Notification("Switching to breasts physics level 1")
			SnusnuUtil.setCBPCBreastsPhysics(PlayerRef, true)
			SnusnuUtil.CBPCBreastsSmall(PlayerRef)
		ElseIf BreastsPhysicsLevel == 2
			Debug.Notification("Switching to breasts physics level 2")
			SnusnuUtil.CBPCBreastsSmall(PlayerRef, true)
			SnusnuUtil.CBPCBreastsMid(PlayerRef)
		ElseIf BreastsPhysicsLevel == 3
			Debug.Notification("Switching to breasts physics level 3")
			SnusnuUtil.CBPCBreastsMid(PlayerRef, true)
			SnusnuUtil.CBPCBreastsBig(PlayerRef)
		ElseIf BreastsPhysicsLevel == 4
			Debug.Notification("Switching to breasts physics level 4")
			SnusnuUtil.CBPCBreastsBig(PlayerRef, true)
			SnusnuUtil.setCBPCBreastsPhysics(PlayerRef)
		EndIf
	EndIf
EndEvent

Float Function getfightingMuscle()
	Float fightingMuscle = muscleScore / muscleScoreMax
		
	; Female
	If isWeightMorphsLoaded
		Int PlayerSex = PlayerRef.GetActorBase().GetSex()
		If PlayerSex == 1 && SnusnuUtil.getWeightmorphsWeight() > 0.2 ;There will be always at least 20% muscularity
			;TLALOC- If getting chubbier, muscle mass gets smaller (This is to avoid overly big arms and thighs on bigger muscleScore)
			;Debug.Trace("SNU - fightingMuscle="+fightingMuscle)
			fightingMuscle = fightingMuscle * ( 1.2 - SnusnuUtil.getWeightmorphsWeight() )
			;Debug.Trace("SNU - chubbyMuscle="+fightingMuscle)
		EndIf
	EndIf
;/	
	;TLALOC- Disguise form should not be too muscular
	If fightingMuscle > 0.5 && PlayerRef.hasSpell(PSQM.PSQ.PSQDisguiseCastSpell)
		fightingMuscle = 0.5
	EndIf
/;	
	return fightingMuscle
EndFunction

Float Function getMuscleValuePercent(Float theValue)
	return (theValue / muscleScoreMax) * 100
EndFunction

Float Function getBoneSize(Float modifierMagnitude, Float baseModifier)
	Float modifiedVal
	If baseModifier > 1.0
		modifiedVal = modifierMagnitude * Math.abs( 1.0 - baseModifier )
	Else
		;Debug.Trace("SNU - Found bone smaller than 1.0, modifierMagnitude="+modifierMagnitude+", baseModifier="+baseModifier)
		modifiedVal = modifierMagnitude * (baseModifier - 1.0)
		;Debug.Trace("SNU -            boneSize result: "+modifiedVal)
	EndIf
	
	return 1.0 + modifiedVal
EndFunction

Int Function findFirstActiveBoneMorph(Actor theActor)
	Int counter = 0
	Bool actorIsFemale = theActor.GetActorBase().GetSex()
	While counter < totalCurrentBones
		If NiOverride.GetNodeTransformScale(theActor, false, actorIsFemale, boneSliders[counter], SNUSNU_KEY) != 1.0
			return counter
		EndIf
		counter += 1
	endWhile
	
	return -1
EndFunction

String Function getBoneMorphName(Int boneIndex)
	Return boneSliders[boneIndex]
EndFunction

Function UpdateWeight(Bool applyNow = True)
	If HAS_NIOVERRIDE && !isTransforming && StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0 && !isVampireLord
		;Debug.Trace("SNU - UpdateWeight()")
		Float fightingMuscle = getfightingMuscle()
		
		If useWeightSlider
			FLoat newWeight = fightingMuscle * 100
			Float tWeight = PlayerRef.GetLeveledActorBase().GetWeight()
			Float tNeckdelta = (tWeight/100) - (newWeight/100)
			
			;Debug.Trace("SNU - currentWeight="+tWeight+", newWeight="+newWeight)
			If newWeight - tWeight > 5.0 || newWeight - tWeight < -5.0
				;TLALOC- The following code can produce small lags
				PlayerRef.GetActorBase().SetWeight(newWeight)
				PlayerRef.UpdateWeight(tNeckdelta)
				If !PlayerRef.IsOnMount()
					PlayerRef.QueueNiNodeUpdate()
				EndIf
				;Debug.Trace("SNU - New weight was set")
			EndIf
			
			;TLALOC- Apply bone changes
			;applyBoneMorphs(PlayerRef)
			
			;TLALOC- Custom Boobs physics
			updateBoobsPhysics()
		Else
			Int PlayerSex = PlayerRef.GetActorBase().GetSex()
			
			; Female
			If PlayerSex == 1
				If fightingMuscle > 0.0
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
					;applyBoneMorphs(PlayerRef)
					
					;TLALOC- Werewolf body morph --------------------------------------------------------------------
					;ToDo- Add slider support for all Werewolf morphs
					If useWerewolfMorphs && isWerewolf
						updateWerewolfMuscle(fightingMuscle)
					EndIf
					;TLALOC- Werewolf body morph --------------------------------------------------------------------
				EndIf
				
				;TLALOC- Custom Boobs physics
				updateBoobsPhysics()
			; Male
			ElseIf PlayerSex == 0
				;ToDo-...? This is a placeholder for future implementation of HIMBO or something like that... Some day
				;applyMaleMorphs(PlayerRef)
				
				;TLALOC- Apply bone changes
				;applyBoneMorphs(PlayerRef)
			EndIf
		EndIf
		
		;TLALOC- Apply bone changes
		applyBoneMorphs(PlayerRef)
		
		If applyNow
			NiOverride.UpdateModelWeight(PlayerRef)
		EndIf
	
		;Check if changes are big enough
		If fightingMuscle - prevMuscleScore > 0.01 || fightingMuscle - prevMuscleScore < -0.01
			Debug.Trace("SNU - Changes are big enough, going to update effects. fightingMuscle="+fightingMuscle+", prevMuscleScore="+prevMuscleScore)
			prevMuscleScore = fightingMuscle
			effectsChanged = True
		EndIf
	EndIf
	
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
		;NEW IDEA: Change incValue depending on muscle score. Low score increases value, high score decreases value
		;          This way it would feel like the traditional leveling system where the stronger you get, the longer
		;          it takes to get even stronger.
		Float medScoreMax = muscleScoreMax / 2
		If muscleScore < medScoreMax
			;Growth goes from 1:1 to 2:1
			;Float scoreIncFactor = 2 - (muscleScore / medScoreMax)
			;incValue = incValue * scoreIncFactor
			
			;Growth goes from 1:1 to 1.5:1
			Float scoreIncFactor = 2 - (muscleScore / muscleScoreMax)
			scoreIncFactor = scoreIncFactor - 0.5
			incValue = incValue * scoreIncFactor
		Else
			Float medScore = muscleScore - medScoreMax
			Float scoreDecFactor = 1 + (medScore / medScoreMax)
			incValue = incValue / scoreDecFactor
		EndIf
		
		;TLALOC- If Weight is too low muscle can't grow much due to lack of carbs
		If isWeightMorphsLoaded
			If SnusnuUtil.getWeightmorphsWeight() < malnourishmentValue
				If !malnourishmentWarning
					Debug.Notification("I can barely develop any muscle mass with this diet!")
					malnourishmentWarning = true
				EndIf
				
				incValue = incValue * 0.25
			ElseIf malnourishmentWarning
				malnourishmentWarning = false
			EndIf
		EndIf
		
		incValue = incValue * concoctionModifier
		
		storedMuscle = storedMuscle + incValue
	EndIf
	
	If normalsScore < muscleScore || incValue < 0
		normalsScore = normalsScore + (incValue * 2)
		
		If normalsScore < 0
			normalsScore = 0
		EndIf
	Else
		normalsScore = normalsScore + incValue
	EndIf
	
	muscleScore = muscleScore + incValue
	
	If muscleScore > muscleScoreMax
		muscleScore = muscleScoreMax
	ElseIf muscleScore < 0.0
		muscleScore = 0.0
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

Function recalculateAllMuscleVars(Float factor)	
	muscleScore = muscleScore * factor
	normalsScore = normalsScore * factor

	lostMuscle = lostMuscle * factor
	storedMuscle = storedMuscle * factor
EndFunction

Function applyBoneMorphs(Actor theActor)
	Int boneCounter = 0
	While boneCounter < totalCurrentBones
		changeBoneScale(theActor, boneCounter, getBoneSize(muscleScore / muscleScoreMax, bonesValues[boneCounter]))
		boneCounter += 1
	EndWhile
EndFunction

Function SetNodePosition(Actor akActor, bool isFemale, string nodeName, float[] values)
	If values[0] != 0.0 || values[1] != 0.0 || values[2] != 0.0
        NiOverride.AddNodeTransformPosition(akActor, false, isFemale, nodeName, SNUSNU_KEY, values)
        NiOverride.AddNodeTransformPosition(akActor, true, isFemale, nodeName, SNUSNU_KEY, values)
    Else
        NiOverride.RemoveNodeTransformPosition(akActor, false, isFemale, nodeName, SNUSNU_KEY)
        NiOverride.RemoveNodeTransformPosition(akActor, true, isFemale, nodeName, SNUSNU_KEY)
    Endif
    NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
    NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
EndFunction

Function changeBoneScale(Actor theActor, Int boneIndex, Float scaleValue)
	Bool actorIsFemale = theActor.GetActorBase().GetSex()
	Float currentScale = NiOverride.GetNodeTransformScale(theActor, false, actorIsFemale, boneSliders[boneIndex], SNUSNU_KEY)
	
	;TLALOC- BUG FIX: changes applied to main bones will cause a one frame glitch in the character animation, so we need to avoid it
	;         as much as we can and only apply it when the change difference is big enough
	If scaleValue - currentScale > 0.001 || scaleValue - currentScale < -0.001
		If boneIndex == 0 ;Upper spine
			Debug.Trace("SNU - Updating spine scale from: "+currentScale+" to: "+scaleValue)
			SetNodeScale(theActor, actorIsFemale, "NPC Spine2 [Spn2]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME Spine2 [Spn2]", 1.0 / scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 1 ;Advanced forearms
			SetNodeScale(theActor, actorIsFemale, "NPC L Forearm [LLar]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME L Forearm [LLar]", 1.0 / scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC L Forearm [RLar]", scaleValue, SNUSNU_KEY)
			
			SetNodeScale(theActor, actorIsFemale, "NPC R Forearm [RLar]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME R Forearm [RLar]", 1.0 / scaleValue, SNUSNU_KEY)
			
			SetNodeScale(theActor, actorIsFemale, "NPC L ForearmTwist2 [LLt2]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R ForearmTwist2 [RLt2]", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 2 ;Upperarms
			SetNodeScale(theActor, actorIsFemale, "NPC L UpperArm [LUar]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME L UpperArm [LUar]", 1/scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC L UpperArm [RUar]", scaleValue, SNUSNU_KEY)
			
			SetNodeScale(theActor, actorIsFemale, "NPC R UpperArm [RUar]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME R UpperArm [RUar]", 1/scaleValue, SNUSNU_KEY)
			
			;/ It seems like this only lenghtents the bone itself but doesnt fix the overlap issue
			;Test lenght fix
			float[] _upperArm_Length
			_upperArm_Length = NiOverride.GetNodeTransformPosition(theActor, false, actorIsFemale, "CME L UpperArm [LUar]", SNUSNU_KEY)
			_upperArm_Length[2] = 1.0 - scaleValue
			SetNodePosition(theActor, actorIsFemale, "CME L UpperArm [LUar]", _upperArm_Length)
			SetNodePosition(theActor, actorIsFemale, "CME R UpperArm [RUar]", _upperArm_Length)
			/;
		ElseIf boneIndex == 3 ;Hand
			SetNodeScale(theActor, actorIsFemale, "NPC L Hand [LHnd]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R Hand [RHnd]", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 4 ;Clavicle
			SetNodeScale(theActor, actorIsFemale, "NPC L Clavicle [LClv]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME L Clavicle [LClv]", 1/scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC L Clavicle [RClv]", scaleValue, SNUSNU_KEY)
			
			SetNodeScale(theActor, actorIsFemale, "NPC R Clavicle [RClv]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME R Clavicle [RClv]", 1/scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 5 ;Pelvis
			SetNodeScale(theActor, actorIsFemale, "NPC Pelvis [Pelv]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME Pelvis [Pelv]", 1/scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 6 ;Waist
			SetNodeScale(theActor, actorIsFemale, "CME Spine [Spn0]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME Spine1 [Spn1]", 1/scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 7 ;Lower Spine
			SetNodeScale(theActor, actorIsFemale, "NPC Spine [Spn0]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME Spine [Spn0]", 1/scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 8 ;Middle Spine
			SetNodeScale(theActor, actorIsFemale, "NPC Spine1 [Spn1]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME Spine1 [Spn1]", 1/scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 9 ;Thighs
			SetNodeScale(theActor, actorIsFemale, "NPC L Thigh [LThg]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME L Thigh [LThg]", 1/scaleValue, SNUSNU_KEY)		
			
			SetNodeScale(theActor, actorIsFemale, "NPC R Thigh [RThg]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME R Thigh [RThg]", 1/scaleValue, SNUSNU_KEY)	
			SetNodeScale(theActor, actorIsFemale, "NPC R Thigh [LThg]", scaleValue, SNUSNU_KEY)
			
			;/Test lenght fix
			float[] _thigh_Length = NiOverride.GetNodeTransformPosition(theActor, false, actorIsFemale, "NPC L Thigh [LThg]", SNUSNU_KEY)
			Debug.Trace("SNU - Thigh length is: "+_thigh_Length[2])
			_thigh_Length[2] = Math.abs(1.0 - scaleValue)
			Debug.Trace("SNU - Setting thigh length to: "+_thigh_Length[2])
			SetNodePosition(theActor, actorIsFemale, "NPC L Thigh [LThg]", _thigh_Length)
			SetNodePosition(theActor, actorIsFemale, "NPC R Thigh [RThg]", _thigh_Length)
			/;
		ElseIf boneIndex == 10 ;Calfs
			SetNodeScale(theActor, actorIsFemale, "NPC L Calf [LClf]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME L Calf [LClf]", 1/scaleValue, SNUSNU_KEY)		
		
			SetNodeScale(theActor, actorIsFemale, "NPC R Calf [RClf]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME R Calf [RClf]", 1/scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R Calf [LClf]", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 11 ;Feet
			SetNodeScale(theActor, actorIsFemale, "NPC L Foot [Lft ]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME L Foot [Lft ]", 1/scaleValue, SNUSNU_KEY)		
			
			SetNodeScale(theActor, actorIsFemale, "NPC R Foot [Rft ]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME R Foot [Rft ]", 1/scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R Foot [Lft ]", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 12 ;Breasts
			SetNodeScale(theActor, actorIsFemale, "NPC L Breast", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R Breast", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC L Breast01", 1/scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R Breast01", 1/scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 13 ;Breast Fullness
			SetNodeScale(theActor, actorIsFemale, "NPC L PreBreast", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R PreBreast", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 14 ;Belly
			SetNodeScale(theActor, actorIsFemale, "NPC Belly", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 15 ;Butt
			SetNodeScale(theActor, actorIsFemale, "NPC L Butt", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R Butt", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 16 ;Height
			SetNodeScale(theActor, actorIsFemale, "NPC", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 17 ;Head
			SetNodeScale(theActor, actorIsFemale, "NPC Head [Head]", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 18 ;Biceps
			SetNodeScale(theActor, actorIsFemale, "NPC L UpperarmTwist1 [LUt1]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R UpperarmTwist1 [RUt1]", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 19 ;Biceps2
			SetNodeScale(theActor, actorIsFemale, "NPC L UpperarmTwist2 [LUt2]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R UpperarmTwist2 [RUt2]", scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 20
			;Placeholder for future additions
		EndIf
	EndIf
EndFunction

Function clearBoneScales(Actor theActor)
	;Debug.Trace("SNU - clearBoneScales()")
	Bool actorIsFemale = theActor.GetActorBase().GetSex()
	
	SetNodeScale(theActor, actorIsFemale, "NPC Spine2 [Spn2]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME Spine2 [Spn2]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, actorIsFemale, "NPC L Clavicle [LClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME L Clavicle [LClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC L Clavicle [RClv]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, actorIsFemale, "NPC R Clavicle [RClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME R Clavicle [RClv]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, actorIsFemale, "NPC L Forearm [LLar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME L Forearm [LLar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC L Forearm [RLar]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, actorIsFemale, "NPC R Forearm [RLar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME R Forearm [RLar]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, actorIsFemale, "NPC L ForearmTwist2 [LLt2]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R ForearmTwist2 [RLt2]", 1.0, SNUSNU_KEY)
	
	;Overhaul additions
	SetNodeScale(theActor, actorIsFemale, "NPC L UpperArm [LUar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME L UpperArm [LUar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC L UpperArm [RUar]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, actorIsFemale, "NPC R UpperArm [RUar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME R UpperArm [RUar]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, actorIsFemale, "NPC L Hand [LHnd]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R Hand [RHnd]", 1.0, SNUSNU_KEY)
		
	SetNodeScale(theActor, actorIsFemale, "NPC L Clavicle [LClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME L Clavicle [LClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC L Clavicle [RClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R Clavicle [RClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME R Clavicle [RClv]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC Pelvis [Pelv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME Pelvis [Pelv]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "CME Spine [Spn0]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME Spine1 [Spn1]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC Spine [Spn0]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME Spine [Spn0]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC Spine1 [Spn1]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME Spine1 [Spn1]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC L Thigh [LThg]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME L Thigh [LThg]", 1.0, SNUSNU_KEY)		
	SetNodeScale(theActor, actorIsFemale, "NPC R Thigh [RThg]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME R Thigh [RThg]", 1.0, SNUSNU_KEY)	
	SetNodeScale(theActor, actorIsFemale, "NPC R Thigh [LThg]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC L Calf [LClf]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME L Calf [LClf]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R Calf [RClf]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME R Calf [RClf]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R Calf [LClf]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC L Foot [Lft ]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME L Foot [Lft ]", 1.0, SNUSNU_KEY)		
	SetNodeScale(theActor, actorIsFemale, "NPC R Foot [Rft ]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "CME R Foot [Rft ]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R Foot [Lft ]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC L Breast", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R Breast", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC L Breast01", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R Breast01", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC L PreBreast", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R PreBreast", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC Belly", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC L Butt", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R Butt", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC Head [Head]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC L UpperarmTwist1 [LUt1]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R UpperarmTwist1 [RUt1]", 1.0, SNUSNU_KEY)

	SetNodeScale(theActor, actorIsFemale, "NPC L UpperarmTwist2 [LUt2]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, actorIsFemale, "NPC R UpperarmTwist2 [RUt2]", 1.0, SNUSNU_KEY)
	
	;Length changes
	float[] _thigh_Length = NiOverride.GetNodeTransformPosition(theActor, false, actorIsFemale, "NPC L Thigh [LThg]", SNUSNU_KEY)
	_thigh_Length[2] = 0.0
	SetNodePosition(theActor, actorIsFemale, "NPC L Thigh [LThg]", _thigh_Length)
	SetNodePosition(theActor, actorIsFemale, "NPC R Thigh [RThg]", _thigh_Length)
EndFunction

Function SetNodeScale(Actor akActor, bool isFemale, string nodeName, float value, string modkey)
	If value != 1.0
		NiOverride.AddNodeTransformScale(akActor, false, isFemale, nodeName, modkey, value)
		NiOverride.AddNodeTransformScale(akActor, true, isFemale, nodeName, modkey, value)
	Else
		NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, modkey)
		NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, modkey)
	Endif
	NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
	NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
EndFunction

Function chooseBoobsPhysics(Int buildStage)
	If !useDynamicPhysics
		return
	EndIf
	
	Int boobsLevel = 4
	;Debug.Trace("SNU - Choosing physics: buildStage="+buildStage+", usePecs="+usePecs)
	If (buildStage >= 3 && usePecs) || (buildStage == 4 && !usePecs)
		;BoneCrusherExtra
		boobsLevel = 1
	ElseIf buildStage == 3 && !usePecs
		;BoneCrusher
		boobsLevel = 2
	ElseIf buildStage == 2
		;Athletic
		boobsLevel = 3
	EndIf
	
	;weightMorphs calculations
	If isWeightMorphsLoaded
		If boobsLevel > 1
			If SnusnuUtil.getWeightmorphsWeight() < -0.75 ;-0.7
				;Boobs too small to have noticeable physics
				boobsLevel = 1
			ElseIf SnusnuUtil.getWeightmorphsWeight() < -0.25 && boobsLevel > 2
				;Was: SnusnuUtil.getWeightmorphsWeight() < 0.0
				;Boobs still too small to have full physics
				boobsLevel = 2
			ElseIf SnusnuUtil.getWeightmorphsWeight() < 0.5 && boobsLevel > 3
				boobsLevel = 3
			ElseIf SnusnuUtil.getWeightmorphsWeight() >= 0.5
				;Was SnusnuUtil.getWeightmorphsWeight() > 0.4
				boobsLevel = 4
			EndIf
		EndIf
	EndIf
	
	updateBoobsPhysics(true, boobsLevel)
EndFunction

Function updateBoobsPhysics(Bool forceUpdate = false, Int newLevel = -1)
	If !useDynamicPhysics
		return
	EndIf
	
	If SnusnuUtil.checkSMPPhysics(PlayerRef)
		;Player is using SMP for body physics so we stop here
		return
	EndIf
	
	;TLALOC- Boobs physics only get updated once, unless a significant muscle change is made
	If is3BAPhysicsLoaded && (firstUpdateForBoobs || forceUpdate)
		;Debug.Trace("SNU- Checking for boobs physics")
		If newLevel != -1
			If forceUpdate && BreastsPhysicsLevel == newLevel
				return
			Else
				BreastsPhysicsLevel = newLevel
			EndIf
		EndIf
		
		Debug.Trace("SNU - Physics level is "+BreastsPhysicsLevel)
		If BreastsPhysicsLevel == 1
			showInfoNotification("Switching to breasts physics level 1")
			Debug.Trace("SNU - Switching to breasts physics level 1")
			SnusnuUtil.setCBPCBreastsPhysics(PlayerRef, true)
			SnusnuUtil.CBPCBreastsSmall(PlayerRef)
		ElseIf BreastsPhysicsLevel == 2
			showInfoNotification("Switching to breasts physics level 2")
			Debug.Trace("SNU - Switching to breasts physics level 2")
			SnusnuUtil.setCBPCBreastsPhysics(PlayerRef, true)
			SnusnuUtil.CBPCBreastsMid(PlayerRef)
		ElseIf BreastsPhysicsLevel == 3
			showInfoNotification("Switching to breasts physics level 3")
			Debug.Trace("SNU - Switching to breasts physics level 3")
			SnusnuUtil.setCBPCBreastsPhysics(PlayerRef, true)
			SnusnuUtil.CBPCBreastsBig(PlayerRef)
		ElseIf BreastsPhysicsLevel == 4
			;ToDo- Change physics to SMP if body weight (from WeightMorphs) is big enough
			;NOTE: As of right now, CBPC physics are more than enough to simulate big breasts Physics,
			;      so there is no need for complicated SMP switching
			showInfoNotification("Switching to breasts physics level 4")
			Debug.Trace("SNU - Switching to breasts physics level 4")
			SnusnuUtil.setCBPCBreastsPhysics(PlayerRef, true)
			SnusnuUtil.setCBPCBreastsPhysics(PlayerRef)
		EndIf
		
		firstUpdateForBoobs = false
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
	Debug.Trace("SNU - SpineBoneScale = "+bonesValues[0])
	Debug.Trace("SNU - ForearmBoneScale = "+bonesValues[1])
	
	Debug.Trace("SNU - Hardcore values:")
	slidersLoop = 0
	while slidersLoop < FormListCount(PlayerRef, SNU_EQUIP_WEIGHTS_KEY)
		Form currentItem = FormListGet(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, slidersLoop)
		Float currentWeight = FloatListGet(PlayerRef, SNU_EQUIP_WEIGHTS_KEY, slidersLoop)
		Debug.Trace("SNU -     currentItem="+currentItem.getName()+", Item weight="+currentWeight)
		slidersLoop += 1
	endWhile
EndFunction

String Function getNormalsByBodyType(Actor normalVictim, Bool pathFormat = true)
	String addition = "\\"
	If !pathFormat
		addition = ""
	EndIf
	If normalVictim.GetActorBase().GetSex() == 0
		return "MALE" + addition
	ElseIf selectedBody == 0 || selectedBody == 2
		return "UNP" + addition
	ElseIf selectedBody == 1
		return "CBBE" + addition
	EndIf
EndFunction

;     Muscle build stages = 1=Civilian, 2=Athletic, 3=Bone Crusher, 4=Extra Bone Crusher
;     Slim boobs stages = 0=Not slim, 1=Slim
;     Pregnancy stages = 0=Not preg, 1=Preg
Function checkBodyNormalsState()
	;Debug.Trace("SNU - checkBodyNormalsState()")
	If disableNormals || StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) != 0 || isVampireLord || isWerewolf
		If isVampireLord
			finalNormalsPath = "VAMP_EMPTY"
		EndIf
		
		return
	EndIf
	
	String tempNormalsPath = normalsPath + getNormalsByBodyType(PlayerRef)
	Float stage4Score = muscleScoreMax - (muscleScoreMax * 0.1)
	Float stage3Score = muscleScoreMax - (muscleScoreMax * 0.3)
	Float stage2Score = muscleScoreMax - (muscleScoreMax * 0.5)
		
	;Debug.Trace("SNU - muscleScore value from Snusnu is: "+muscleScore)
	;Debug.Trace("SNU - normalsScore value from Snusnu is: "+normalsScore)
	
	;TLALOC- Expand the range of the changes if muscleScore is below 0.25 (This logic will allow to have a extreme muscular definition 
	;      even at that muscleScore, but only if score is high enough
	If isWeightMorphsLoaded
		If SnusnuUtil.getWeightmorphsWeight() < 0.3
			Float changeDelta = (muscleScoreMax * 0.3)
			Float changeFactor = (SnusnuUtil.getWeightmorphsWeight() * changeDelta)
			stage2Score = stage2Score + changeFactor
			stage3Score = (muscleScoreMax * 0.2) + (Math.abs(changeFactor) / 4)
			stage4Score = stage3Score * 2
			
			stage3Score = stage3Score + stage2Score
			stage4Score = stage4Score + stage2Score
			
			;Debug.Trace("SNU - New change ranges are: stage2="+stage2Score+", stage3="+stage3Score+", stage4="+stage4Score)
		EndIf
	EndIf
	
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
	
	;Rangos originales: 0.12-0.225, 0.225-0.30
	If isWeightMorphsLoaded
		If currentBuildStage >= 2 && SnusnuUtil.getWeightmorphsWeight() >= 0.25
			currentBuildStage = 1
		ElseIf currentBuildStage >= 3 && SnusnuUtil.getWeightmorphsWeight() >= 0.175 && SnusnuUtil.getWeightmorphsWeight() < 0.25
			currentBuildStage = 2
		ElseIf currentBuildStage >= 4 && SnusnuUtil.getWeightmorphsWeight() >= 0.10 && SnusnuUtil.getWeightmorphsWeight() < 0.175
			currentBuildStage = 3
		EndIf
		
		If SnusnuUtil.getWeightmorphsWeight() < -0.5
			currentSlimStage = 1
		Else
			currentSlimStage = 0
		EndIf
	EndIf
	
	If StorageUtil.GetFloatValue(PlayerRef, "PRG_SeedsTotal") > 3000 && currentBuildStage != 1 ;Civilian normals are already the same as preg
		currentPregStage = 1
	Else
		currentPregStage = 0
	EndIf
	
	If useMuscleAnims
		updateAnimations(currentBuildStage)
	EndIf
	
	;TLALOC- Custom Boobs physics
	chooseBoobsPhysics(currentBuildStage)
	
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
	If currentSlimStage == 1 || (currentBuildStage >= 3 && usePecs)
		tempNormalsPath = tempNormalsPath + slimStageString
	EndIf
	If currentPregStage == 1
		tempNormalsPath = tempNormalsPath + pregStageString
	Else
		;TLALOC- Special condition for weightMorphs
		If isWeightMorphsLoaded
			If currentBuildStage == 1 && SnusnuUtil.getWeightmorphsWeight() > 0.5
				tempNormalsPath = tempNormalsPath + "_FAT"
			EndIf
		EndIf
	EndIf
	
	If isTransforming
		finalNormalsPath = "EMPTY"
		return
	EndIf
	
	tempNormalsPath = tempNormalsPath + ".dds"
	;Debug.Trace("SNU - Normals path is now "+tempNormalsPath)
	
	;Debug.Trace("SNU - Temp normals path: "+tempNormalsPath)
	;Debug.Trace("SNU - Final normals path: "+finalNormalsPath)
	;TLALOC - Apply new normals
	If finalNormalsPath == "EMPTY" || StringUtil.Find(tempNormalsPath, finalNormalsPath) == -1
		finalNormalsPath = tempNormalsPath
		
		Debug.Trace("SNU - Updating normals path to "+finalNormalsPath)
		
		;TLALOC- Experimental messed up hand textures fix
		Bool hasHandFix = false
		Armor handsArmor = PlayerRef.GetWornForm(0x00000008) as Armor
		if !handsArmor
			Debug.Trace("SNU - Attempting to apply hands fix!")
			PlayerRef.equipItem(handsFix, true, true)
			Utility.wait(0.2)
			hasHandFix = true
		endIf
		
		Bool isFemale = PlayerRef.GetActorBase().GetSex() != 0
		NiOverride.AddSkinOverrideString(PlayerRef, isFemale, false, 0x04, 9, 1, finalNormalsPath, true)
		NiOverride.AddSkinOverrideString(PlayerRef, isFemale, true, 0x04, 9, 1, finalNormalsPath, true)
		
		;TLALOC- Experimental messed up hand textures fix
		if hasHandFix
			Debug.Trace("SNU - Finishing to apply hands fix!")
			Utility.wait(0.2)
			PlayerRef.unequipItemslot(33)
			PlayerRef.removeitem(handsFix, 1, true)
		endIf
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
		
		If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0 && !isVampireLord
			magStamina = (muscleScore / muscleScoreMax) * Stamina
			magSpeed = (muscleScore / muscleScoreMax) * Speed
		Else
			magStamina = 500;Was Stamina * 4
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
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0 && !isVampireLord
				Float halfMaxScore = muscleScoreMax / 2
				If muscleScore > halfMaxScore
					Float magCombat = ((muscleScore - halfMaxScore) / halfMaxScore) * combatProficiency
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
		
		;TLALOC- Bow charge and release
		RegisterForAnimationEvent(PlayerRef, "bowDrawStart")
		;RegisterForAnimationEvent(PlayerRef, "Bow_Release")
		;RegisterForAnimationEvent(PlayerRef, "BowLowered")
		RegisterForAnimationEvent(PlayerRef, "arrowRelease")
		;RegisterForAnimationEvent(PlayerRef, "bowEnd")
		RegisterForAnimationEvent(PlayerRef, "bowDrawn");Happens after doing a full charge
		
		;TLALOC- Blacksmith work
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.OBJBlacksmithForge")
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithForgeTake")
		;RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithForgeQuench")
		;RegisterForAnimationEvent(PlayerRef, "soundPlay.NPCHumanBlacksmithForgeQuenchDrop")
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithHammer")
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithRepairHammer")
		
		;Need to check if player is overencumbered while walking as it means it is carrying heavy stuff
		;RegisterForAnimationEvent(PlayerRef, "FootLeft")
		RegisterForAnimationEvent(PlayerRef, "FootRight")
		
		;ToDo- Temporal Go to Bed fix. Will move to MCBM
		;RegisterForAnimationEvent(PlayerRef, "IdleBedEnterToSleep")
		
		;TLALOC- Experimental anim events!
		;RegisterForAnimationEvent(PlayerRef, "IdleGreybeardWordTeach");Immersive interactions Dummy training
		;RegisterForAnimationEvent(PlayerRef, "XXX")
		;RegisterForAnimationEvent(PlayerRef, "XXX")
		;RegisterForAnimationEvent(PlayerRef, "XXX")
		
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
		
		UnregisterForAnimationEvent(PlayerRef, "bowDrawStart")
		UnregisterForAnimationEvent(PlayerRef, "arrowRelease")
		UnregisterForAnimationEvent(PlayerRef, "bowDrawn")
		
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.OBJBlacksmithForge")
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithForgeTake")
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithHammer")
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithRepairHammer")
		
		UnregisterForAnimationEvent(PlayerRef, "FootLeft")
		UnregisterForAnimationEvent(PlayerRef, "FootRight")
		
		;UnRegisterForAnimationEvent(PlayerRef, "IdleBedEnterToSleep")
		
		UnRegisterForSleep()
		UnregisterForUpdate()
	EndIf
EndFunction

;Get custom initial muscleScore depending on Player's race
;      Orc=max/2, Nord=max/3, WoodElf/Redguard/Khajiit/Imperial=max/4, HighElf/DarkElf/Breton/Argonian=0
Function chooseScoreByRace()
	String pcRace = PlayerRef.getRace().getName()
	If pcRace == "Orc"
		muscleScore = muscleScoreMax * 0.5
		normalsScore = muscleScoreMax * 0.45
	ElseIf pcRace == "Nord"
		muscleScore = muscleScoreMax * 0.35
		normalsScore = muscleScoreMax * 0.3
	ElseIf pcRace == "Wood Elf" || pcRace == "Redguard"  || pcRace == "Khajiit"  || pcRace == "Imperial" 
		muscleScore = muscleScoreMax * 0.25
		normalsScore = muscleScoreMax * 0.2
	ElseIf pcRace == "High Elf" || pcRace == "Dark Elf"  || pcRace == "Breton"  || pcRace == "Argonian" 
		muscleScore = muscleScoreMax * 0.0
		normalsScore = muscleScoreMax * 0.0
	Else
		muscleScore = muscleScoreMax * 0.35
		normalsScore = muscleScoreMax * 0.3
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
	muscleScoreMax = 2000.0
	If hardcoreMode
		chooseScoreByRace()
	Else
		muscleScore = muscleScoreMax * 0.5
		normalsScore = muscleScoreMax * 0.45
	EndIf
	
	MuscleLevel.setValue(0)
	
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
			useWeightSlider = true
			;disableNormals = true
			
			playTFSound = false
			useDynamicPhysics = false
			useMuscleAnims = false
			useAltAnims = false
			changeHeadPart = false
		EndIf
		UpdateEffects()
		checkBodyNormalsState()
		initDefaultSliders()
		LastDegradationTime = GameDaysPassed.GetValue()
		
		If PlayerRef.getRace().getName() == "Werewolf"
			isWerewolf = true
		ElseIf PlayerRef.getRace().getName() == "Vampire Lord" && isVampireLordReVampedLoaded
			isVampireLord = true
			;ToDo- We really NEED a toggle for this!
			VampireLordMuscleSpell.cast(PlayerRef)
		EndIf
	Else
		If isVampireLord
			isVampireLord = false
			Debug.Trace("SNU - Dispeling VampireLordMuscleSpell")
			VampireLordMuscleSpell.cast(PlayerRef)
			Utility.Wait(2)
		EndIf
		
		UpdateEffects(False)
		;NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
		Bool isFemale = PlayerRef.GetActorBase().GetSex() != 0
		NiOverride.RemoveSkinOverride(PlayerRef, isFemale, false, 0x04, 9, 1)
		NiOverride.RemoveSkinOverride(PlayerRef, isFemale, true, 0x04, 9, 1)
		ClearMorphs()
	EndIf
EndFunction

Function ClearMorphs(Bool clearBones = true)
	If HAS_NIOVERRIDE
		;Debug.Trace("SNU - ClearMorphs()")
		; CBBE
		Int cbbeLoop = 0
		while cbbeLoop < 52
			;clearSliderData(1, cbbeLoop)
			setSliderValue(cbbeLoop, 0.0, false)
			cbbeLoop += 1
		endWhile
		
		;UUNP
		Int uunpLoop = 0
		while uunpLoop < 74
			;clearSliderData(2, uunpLoop)
			setSliderValue(uunpLoop + 52, 0.0, false)
			uunpLoop += 1
		endWhile

		;BHUNP Sliders
		Int bhunpLoop = 0
		while bhunpLoop < 43
			;clearSliderData(3, bhunpLoop)
			setSliderValue(bhunpLoop + 52 + 74, 0.0, false)
			bhunpLoop += 1
		endWhile
		
		;CBBE SE Sliders
		Int cbbeSELoop = 0
		while cbbeSELoop < 27
			;clearSliderData(4, cbbeSELoop)
			setSliderValue(cbbeSELoop + 52 + 74 + 43, 0.0, false)
			cbbeSELoop += 1
		endWhile
		
		;CBBE 3BA Sliders
		Int cbbe3BALoop = 0
		while cbbe3BALoop < 40
			;clearSliderData(5, cbbe3BALoop)
			setSliderValue(cbbe3BALoop + 52 + 74 + 43 + 27, 0.0, false)
			cbbe3BALoop += 1
		endWhile
		
		;Bone changes
		If clearBones
			clearBoneScales(PlayerRef)
			
			Int boneCounter = 0
			While boneCounter < 68
				bonesValues[boneCounter] = 1.0
				boneCounter += 1
			EndWhile
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
	cbbe3BASliders = new String[40]
	bhunp3Sliders = new String[43]
	
	boneSliders = new String[68]
	totalCurrentBones = 20 ;This is meant to be updated as we add support for more bones
	
	
	
	;Check if new arrays havent been initialized
	
	If !bhunp3Values || bhunp3Values.length == 0
		bhunp3Values = new Float[43]
		Debug.Trace("SNU - Initializing bhunp3Values array!!")
		Int bhunp3Counter = 0
		While bhunp3Counter < 43
			bhunp3Values[bhunp3Counter] = 0.0
			bhunp3Counter += 1
		EndWhile
	EndIf
	
	If !bonesValues || bonesValues.length < totalCurrentBones
		bonesValues = new Float[68]
		
		bonesValues[0] = MultSpineBone ;1.05
		bonesValues[1] = MultForearmBone ;1.0
		
		Int boneCounter = 2
		While boneCounter < 68
			bonesValues[boneCounter] = 1.0
			boneCounter += 1
		EndWhile
	EndIf
	
	If !maleValues
		maleValues = new Float[2]
		
		maleValues[0] = MultSamuel ;1.0
		maleValues[1] = MultSamson ;0.0
	EndIf
	
	
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
	
	;/
	cbbeSliders[0]  = "Breasts"
	cbbeSliders[1]  = "BreastsSmall"
	cbbeSESliders[0]  = "BreastsSmall2"
	cbbeSESliders[1] = "BreastsNewSH"
	cbbeSESliders[2] = "BreastsNewSHSymmetry"
	cbbeSliders[4] = "BreastsFantasy"
	cbbeSliders[5]  = "DoubleMelon"
	bhunpSliders[0] = "BreastsTogether"/;
	cbbe3BASliders[0] = "BreastsConverage_v2"
	;/bhunpSliders[1] = "BreastCenter"
	bhunpSliders[2] = "BreastCenterBig"
	cbbeSESliders[3] = "BreastTopSlope"
	cbbeSliders[6]  = "BreastCleavage"
	cbbeSliders[7] = "BreastFlatness"
	cbbeSESliders[4] = "BreastFlatness2"
	bhunpSliders[5] = "BreastsGone"
	cbbeSESliders[5] = "BreastGravity2"
	cbbeSliders[9] = "PushUp"
	cbbeSliders[10] = "BreastHeight"
	cbbeSliders[11] = "BreastPerkiness"
	cbbeSliders[12] = "BreastWidth"
	cbbeSESliders[6] = "BreastSideShape"
	cbbeSESliders[7] = "BreastUnderDepth"/;
	cbbe3BASliders[1] = "BreastsPressed_v2"
	
	;cbbeSESliders[8] = "AreolaSize"
	cbbe3BASliders[2] = "AreolaPull_v2"
	;/cbbeSliders[18] = "NippleUp"
	cbbeSliders[19] = "NippleDown"
	cbbeSliders[16] = "NippleSize"
	cbbeSliders[15] = "NippleLength"/;
	cbbe3BASliders[3] = "NippleSquash1_v2"
	cbbe3BASliders[4] = "NippleSquash2_v2"
	;/cbbeSESliders[9] = "NippleManga"
	cbbeSliders[14] = "NipplePerkiness"
	cbbeSESliders[10] = "NipplePerkManga"/;
	cbbe3BASliders[5] = "NipplePuffy_v2"
	cbbe3BASliders[6] = "NippleShy_v2"
	cbbe3BASliders[7] = "NippleThicc_v2"
	cbbe3BASliders[8] = "NippleTube_v2"
	cbbe3BASliders[9] = "NippleCrease_v2"
	cbbe3BASliders[10] = "NippleCrumpled_v2"
	cbbe3BASliders[11] = "NippleBump_v2"
	cbbe3BASliders[12] = "NippleInvert_v2"
	;/cbbeSliders[20] = "NippleTip"
	cbbeSESliders[11] = "NippleTipManga"
	cbbeSliders[13] = "NippleDistance"
	cbbeSESliders[12] = "NippleDip"
	bhunpSliders[8] = "NipBGone"/;
	
	;/bhunpSliders[10] = "ChestDepth"
	bhunpSliders[11] = "ChestWidth"/;
	cbbe3BASliders[13] = "Clavicle_v2"
	;bhunpSliders[12] = "RibsProminance"
	cbbe3BASliders[14] = "RibsMore_v2"
	;/bhunpSliders[13] = "SternumDepth"
	bhunpSliders[14] = "SternumHeight"
	cbbeSliders[29] = "BigTorso"
	cbbeSliders[33] = "Back"
	bhunpSliders[16] = "BackArch"/;
	cbbe3BASliders[15] = "BackValley_v2"
	cbbe3BASliders[16] = "BackWing_v2"
	;/cbbeSESliders[13] = "NavelEven"
	
	cbbeSliders[30] = "Waist"
	bhunpSliders[15] = "WaistHeight"
	cbbeSliders[31] = "WideWaistLine"
	cbbeSliders[32] = "ChubbyWaist"
	
	cbbeSESliders[14] = "ButtClassic"
	cbbeSliders[37] = "ButtShape2"
	cbbeSliders[34] = "ButtCrack"
	cbbeSliders[35] = "Butt"
	cbbeSliders[38] = "BigButt"
	cbbeSliders[36] = "ButtSmall"
	cbbeSliders[39] = "ChubbyButt"
	cbbeSliders[40] = "AppleCheeks"/;
	cbbe3BASliders[17] = "ButtSaggy_v2"
	cbbe3BASliders[18] = "ButtPressed_v2"
	cbbe3BASliders[19] = "ButtNarrow_v2"
	;/cbbeSESliders[15] = "ButtDimples"
	cbbeSESliders[16] = "ButtUnderFold"
	cbbeSliders[41] = "RoundAss"
	bhunpSliders[17] = "CrotchBack"
	cbbeSliders[42] = "Groin"
	
	cbbeSESliders[18] = "LegShapeClassic/;
	cbbe3BASliders[20] = "7BLeg_v2"
	;/bhunpSliders[18] = "LegsThin"
	cbbeSliders[45] = "SlimThighs"
	cbbeSliders[46] = "Thighs"/;
	cbbe3BASliders[21] = "ThighOutsideThicc_v2"
	cbbe3BASliders[22] = "ThighInsideThicc_v2"
	cbbe3BASliders[23] = "ThighFBThicc_v2"
	;/cbbeSliders[47] = "ChubbyLegs"
	cbbeSliders[48] = "Legs"/;
	cbbe3BASliders[24] = "LegSpread_v2"
	;/cbbeSliders[49] = "KneeHeight"
	bhunpSliders[19] = "KneeShape"/;
	cbbe3BASliders[25] = "KneeTogether_v2"
	;/cbbeSliders[50] = "CalfSize"
	cbbeSliders[51] = "CalfSmooth"/;
	cbbe3BASliders[26] = "CalfFBThicc_v2"
	;cbbeSESliders[19] = "FeetFeminine"
	
	cbbe3BASliders[39] = "HipBone"
	;/cbbeSliders[44] = "Hips"
	bhunpSliders[26] = "HipForward"
	bhunpSliders[27] = "HipUpperWidth"
	cbbeSESliders[17] = "HipCarved"/;
	cbbe3BASliders[31] = "HipNarrow_v2"
	cbbe3BASliders[32] = "UNPHip_v2"
	
	;/cbbeSliders[21] = "Arms"
	bhunpSliders[28] = "ForearmSize"
	cbbeSliders[22] = "ChubbyArms"
	cbbeSliders[23] = "ShoulderSmooth"
	cbbeSliders[24] = "ShoulderWidth"
	bhunpSliders[29] = "ShoulderTweak"/;
	cbbe3BASliders[33] = "ArmpitShape_v2"
	
	;/cbbeSliders[25] = "Belly"
	cbbeSliders[26] = "BigBelly"
	cbbeSliders[27] = "PregnancyBelly"/;
	cbbe3BASliders[34] = "BellyFrontUpFat_v2"
	cbbe3BASliders[35] = "BellyFrontDownFat_v2"
	cbbe3BASliders[36] = "BellySideUpFat_v2"
	cbbe3BASliders[37] = "BellySideDownFat_v2"
	cbbe3BASliders[38] = "BellyUnder_v2"
	;/cbbeSliders[28] = "TummyTuck"
	
	
	bhunpSliders[21] = "MuscleAbs"
	bhunpSliders[22] = "MuscleArms"
	bhunpSliders[23] = "MuscleButt"
	bhunpSliders[24] = "MuscleLegs"
	bhunpSliders[25] = "MusclePecs"/;
	cbbe3BASliders[30] = "MuscleBack_v2"
	cbbe3BASliders[27] = "MuscleMoreAbs_v2"
	cbbe3BASliders[28] = "MuscleMoreArms_v2"
	cbbe3BASliders[29] = "MuscleMoreLegs_v2"
	
	;/cbbe3BASliders[22]  = "7B Lower"
	cbbe3BASliders[23]  = "7B Upper"
	cbbe3BASliders[25]  = "VanillaSSELo"
	cbbe3BASliders[24]  = "VanillaSSEHi"
	cbbe3BASliders[26]  = "OldBaseShape"
	
	cbbe3BASliders[125] = "AnkleSize"
	cbbe3BASliders[18] = "WristSize"
	/;
	
	bhunp3Sliders[0] = "BreastSaggy"
	bhunp3Sliders[1] = "BreastsSpread"
	bhunp3Sliders[2] = "BreastDiameter"
	bhunp3Sliders[3] = "AreolaPull"
	bhunp3Sliders[4] = "NippleErection"
	bhunp3Sliders[5] = "NeckSmooth"
	bhunp3Sliders[6] = "RibsMore"
	bhunp3Sliders[7] = "BackWing"
	bhunp3Sliders[8] = "BackValley"
	bhunp3Sliders[9] = "ButtSaggy"
	bhunp3Sliders[10] = "ButtConverge"
	bhunp3Sliders[11] = "ThighApart"
	bhunp3Sliders[12] = "ThighOuter"
	bhunp3Sliders[13] = "ThighThicker"
	bhunp3Sliders[14] = "ThighInnerThicker"
	bhunp3Sliders[15] = "ThighFBThicker"
	bhunp3Sliders[16] = "LegSpread"
	bhunp3Sliders[17] = "CrotchGap"
	bhunp3Sliders[18] = "Soleus"
	bhunp3Sliders[19] = "HipNarrow"
	bhunp3Sliders[20] = "ArmpitShape"
	bhunp3Sliders[21] = "Clavicle"
	bhunp3Sliders[22] = "ClaviclesSize"
	bhunp3Sliders[23] = "ClaviclesFront"
	bhunp3Sliders[24] = "ClaviclesAngle"
	bhunp3Sliders[25] = "BellyUnder"
	
	;Muscle related
	bhunp3Sliders[26] = "BellyDefine"
	bhunp3Sliders[27] = "RectusOuterDetail"
	bhunp3Sliders[28] = "RectusAbdominis"
	bhunp3Sliders[29] = "Biceps"
	bhunp3Sliders[30] = "Triceps"
	bhunp3Sliders[31] = "Deltoid"
	bhunp3Sliders[32] = "Brachioradialis"
	bhunp3Sliders[33] = "Flexor"
	bhunp3Sliders[34] = "ExtensorDigitorum"
	bhunp3Sliders[35] = "TricepsLateral"
	bhunp3Sliders[36] = "Sartorius"
	bhunp3Sliders[37] = "RectusFemoris"
	bhunp3Sliders[38] = "VastusLateralis"
	bhunp3Sliders[39] = "VastusMedialis"
	bhunp3Sliders[40] = "Hamstrings"
	bhunp3Sliders[41] = "BicepsFemoris"
	bhunp3Sliders[42] = "BackTrapezius"
	
	
	
	boneSliders[0] = "NPC Spine2 [Spn2]" ;Original upper back FMG enhancement
	boneSliders[1] = "NPC L Forearm [LLar]" ;UUNP forearm FMG enhancement
	boneSliders[2] = "NPC L UpperArm [LUar]" ;Upper arm
	boneSliders[3] = "NPC L Hand [LHnd]" ;Hand
	boneSliders[4] = "NPC L Clavicle [LClv]" ;Clavicle
	boneSliders[5] = "NPC Pelvis [Pelv]" ;Pelvis
	boneSliders[6] = "CME Spine [Spn0]" ;Waist
	boneSliders[7] = "NPC Spine [Spn0]" ;Lower Spine
	boneSliders[8] = "NPC Spine1 [Spn1]" ;Middle Spine
	boneSliders[9] = "NPC L Thigh [LThg]" ;Thighs
	boneSliders[10] = "NPC L Calf [LClf]" ;Calfs
	boneSliders[11] = "NPC L Foot [Lft ]" ;Feet
	boneSliders[12] = "NPC L Breast" ;Breasts
	boneSliders[13] = "NPC L PreBreast" ;Breast Fullness
	boneSliders[14] = "NPC Belly" ;Belly
	boneSliders[15] = "NPC L Butt" ;Butt
	boneSliders[16] = "NPC" ;Height
	boneSliders[17] = "NPC Head [Head]" ;Head
	boneSliders[18] = "NPC L UpperarmTwist1 [LUt1]" ;Biceps
	boneSliders[19] = "NPC L UpperarmTwist2 [LUt2]" ;Biceps2
	boneSliders[20] = "XXX"
	boneSliders[21] = "XXX"
	boneSliders[22] = "XXX"
	boneSliders[23] = "XXX"
	boneSliders[24] = "XXX"
	boneSliders[25] = "XXX"
	boneSliders[26] = "XXX"
	boneSliders[27] = "XXX"
	boneSliders[28] = "XXX"
	boneSliders[29] = "XXX"
	boneSliders[30] = "XXX"
	boneSliders[31] = "XXX"
	boneSliders[32] = "XXX"
	boneSliders[33] = "XXX"
	boneSliders[34] = "XXX"
	boneSliders[35] = "XXX"
	boneSliders[36] = "XXX"
	boneSliders[37] = "XXX"
	boneSliders[38] = "XXX"
	boneSliders[39] = "XXX"
	boneSliders[40] = "XXX"
	boneSliders[41] = "XXX"
	boneSliders[42] = "XXX"
	boneSliders[43] = "XXX"
	boneSliders[44] = "XXX"
	boneSliders[45] = "XXX"
	boneSliders[46] = "XXX"
	boneSliders[47] = "XXX"
	boneSliders[48] = "XXX"
	boneSliders[49] = "XXX"
	boneSliders[50] = "XXX"
	boneSliders[51] = "XXX"
	boneSliders[52] = "XXX"
	boneSliders[53] = "XXX"
	boneSliders[54] = "XXX"
	boneSliders[55] = "XXX"
	boneSliders[56] = "XXX"
	boneSliders[57] = "XXX"
	boneSliders[58] = "XXX"
	boneSliders[59] = "XXX"
	boneSliders[60] = "XXX"
	boneSliders[61] = "XXX"
	boneSliders[62] = "XXX"
	boneSliders[63] = "XXX"
	boneSliders[64] = "XXX"
	boneSliders[65] = "XXX"
	boneSliders[66] = "XXX"
	boneSliders[67] = "XXX"
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
	ElseIf group == 5
		NiOverride.ClearBodyMorph(PlayerRef, cbbe3BASliders[position], SNUSNU_KEY)
	ElseIf group == 6
		NiOverride.ClearBodyMorph(PlayerRef, bhunp3Sliders[position], SNUSNU_KEY)
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
	ElseIf group == 5
		return cbbe3BASliders[newIndex - 52 - 74 - 43 - 27]
	ElseIf group == 6
		return bhunp3Sliders[newIndex - 52 - 74 - 43 - 27 - 40]
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
	ElseIf group == 5
		return cbbe3BAValues[newIndex - 52 - 74 - 43 - 27]
	ElseIf group == 6
		return bhunp3Values[newIndex - 52 - 74 - 43 - 27 - 40]
	EndIf
	
	return 0.0
EndFunction

Function setSliderValue(Int position, Float value, Bool updateWeightNow = true)
	Int group = getGroupIndex(position)
	
	If group == 1
		cbbeValues[position] = value
	ElseIf group == 2
		uunpValues[position - 52] = value
	ElseIf group == 3
		bhunpValues[position - 52 - 74] = value
	ElseIf group == 4
		cbbeSEValues[position - 52 - 74 - 43] = value
	ElseIf group == 5
		cbbe3BAValues[position - 52 - 74 - 43 - 27] = value
	ElseIf group == 6
		bhunp3Values[position - 52 - 74 - 43 - 27 - 40] = value
	EndIf
	
	If value == 0.0
		IntListRemove(PlayerRef, SNUSNU_KEY, position)
		
		Debug.Trace("SNU - Removing morph: "+getSliderString(position))
		NiOverride.ClearBodyMorph(PlayerRef, getSliderString(position), SNUSNU_KEY)
	Else
		IntListAdd(PlayerRef, SNUSNU_KEY, position, false)
	EndIf
	
	;We should NEVER call UpdateWeight() for individual morph changes!!!
	;/If updateWeightNow
		UpdateWeight()
	EndIf/;
EndFunction

Int Function getGroupIndex(int newIndex)
	Int group = 1
	;ToDo- Always look for inconsistencies on this
	If newIndex > 195
		group = 5
	ElseIf newIndex > 168
		group = 4
	ElseIf newIndex > 125
		group = 3
	ElseIf newIndex > 51
		group = 2
	EndIf
	
	return group
EndFunction

Function initDefaultSliders()
	;Debug.Trace("SNU - initDefaultSliders()")
	
	cbbeValues = new Float[52]
	uunpValues = new Float[74]
	bhunpValues = new Float[43]
	cbbeSEValues = new Float[27]
	cbbe3BAValues = new Float[40]
	bhunp3Values = new Float[43]
	
	;48 usable bones plus 20 overhead for future additions
	bonesValues = new Float[68]
	maleValues = new Float[2]
	
	
	;TLALOC- Arrays were turned into properties so we no longer need the individual value refs
	cbbeValues[0] = 0.0 ;Breasts
	cbbeValues[1] = 0.2 ;BreastsSmall
	cbbeValues[2] = 0.0 ;BreastsSH
	cbbeValues[3] = 0.0 ;BreastsSSH
	cbbeValues[4] = 0.0 ;BreastsFantasy
	cbbeValues[5] = 0.0 ;DoubleMelon
	cbbeValues[6] = 0.0 ;BreastCleavage
	cbbeValues[7] = 0.0 ;BreastFlatness
	cbbeValues[8] = 0.0 ;BreastGravity
	cbbeValues[9] = -0.1 ;PushUp
	cbbeValues[10] = 1.1 ;BreastHeight
	cbbeValues[11] = 0.0 ;BreastPerkiness
	cbbeValues[12] = 0.6 ;BreastWidth
	
	cbbeValues[13] = 0.0 ;NippleDistance
	cbbeValues[14] = 0.0 ;NipplePerkiness
	cbbeValues[15] = 0.0 ;NippleLength
	cbbeValues[16] = 0.0 ;NippleSize
	cbbeValues[17] = 0.0 ;NippleAreola
	cbbeValues[18] = -0.5 ;NippleUp
	cbbeValues[19] = 1.0 ;NippleDown
	cbbeValues[20] = 0.0 ;NippleTip
	
	cbbeValues[21] = 0.0 ;Arms
	cbbeValues[22] = 0.6 ;ChubbyArms
	cbbeValues[23] = 0.0 ;ShoulderSmooth
	cbbeValues[24] = 0.0 ;ShoulderWidth
	
	cbbeValues[25] = 0.0 ;Belly
	cbbeValues[26] = -0.3 ;BigBelly
	cbbeValues[27] = 0.0 ;PregnancyBelly
	cbbeValues[28] = 0.0 ;TummyTuck
	
	cbbeValues[29] = 0.0 ;BigTorso
	cbbeValues[30] = 0.0 ;Waist
	cbbeValues[31] = 0.0 ;WideWaistLine
	cbbeValues[32] = 0.0 ;ChubbyWaist
	cbbeValues[33] = 0.5 ;Back
	
	cbbeValues[34] = -0.3 ;ButtCrack
	cbbeValues[35] = 0.5 ;Butt
	cbbeValues[36] = 0.0 ;ButtSmall
	cbbeValues[37] = 0.0 ;ButtShape2
	cbbeValues[38] = 0.0 ;BigButt
	cbbeValues[39] = 0.0 ;ChubbyButt
	cbbeValues[40] = 0.0 ;AppleCheeks
	cbbeValues[41] = 0.0 ;RoundAss
	cbbeValues[42] = 0.0 ;Groin
	
	cbbeValues[43] = 0.0 ;Hipbone
	cbbeValues[44] = 0.0 ;Hips
	
	cbbeValues[45] = 0.0 ;SlimThighs
	cbbeValues[46] = 0.0 ;Thighs
	cbbeValues[47] = 0.1 ;ChubbyLegs
	cbbeValues[48] = 0.0 ;Legs
	cbbeValues[49] = 0.0 ;KneeHeight
	cbbeValues[50] = 0.0 ;CalfSize
	cbbeValues[51] = -0.5 ;CalfSmooth

	;UUNP sliders (74)
	uunpValues[0] = 0.0 ;7BLow
	uunpValues[1] = 0.0 ;7BHigh
	uunpValues[2] = 0.0 ;7BBombshellLow
	uunpValues[3] = 0.0 ;7BBombshellHigh
	uunpValues[4] = 0.0 ;7BNaturalLow
	uunpValues[5] = 0.0 ;7BNaturalHigh
	uunpValues[6] = 0.0 ;7BCleavageLow
	uunpValues[7] = 0.0 ;7BCleavageHigh
	uunpValues[8] = 0.0 ;7BBCupLow
	uunpValues[9] = 0.0 ;7BBCupHigh
	uunpValues[10] = 0.0 ;7BUNPLow
	uunpValues[11] = 0.0 ;7BUNPHigh
	uunpValues[12] = 0.0 ;7BCHLow
	uunpValues[13] = 0.0 ;7BCHHigh
	uunpValues[14] = 0.0 ;7BOppaiLow
	uunpValues[15] = 0.0 ;7BOppaiHigh
	uunpValues[16] = 0.0 ;UNPLow
	uunpValues[17] = 0.0 ;UNPHigh
	uunpValues[18] = 0.0 ;UNPPushupLow
	uunpValues[19] = 0.0 ;UNPPushupHigh
	uunpValues[20] = 0.0 ;UNPSkinnyLow
	uunpValues[21] = 0.0 ;UNPSkinnyHigh
	uunpValues[22] = 0.0 ;UNPPerkyLow
	uunpValues[23] = 0.0 ;UNPPerkyHigh
	uunpValues[24] = 0.0 ;UNPBLow
	uunpValues[25] = 0.0 ;UNPBHigh
	uunpValues[26] = 0.0 ;UNPBChapi
	uunpValues[27] = 0.0 ;UNPBOppaiv1
	uunpValues[28] = 0.0 ;UNPBOppaiv3Low
	uunpValues[29] = 0.0 ;UNPBOppaiv3High
	uunpValues[30] = 0.0 ;UNPetiteLow
	uunpValues[31] = 0.0 ;UNPetiteHigh
	uunpValues[32] = 0.0 ;UNPCLow
	uunpValues[33] = 0.0 ;UNPCHigh
	uunpValues[34] = 0.0 ;UNPCMLow
	uunpValues[35] = 0.0 ;UNPCMHigh
	uunpValues[36] = 0.0 ;UNPSHLow
	uunpValues[37] = 0.0 ;UNPSHHigh
	uunpValues[38] = 0.0 ;UNPKLow
	uunpValues[39] = 0.0 ;UNPKHigh
	uunpValues[40] = 0.0 ;UNPKBonusLow
	uunpValues[41] = 0.0 ;UNPKBonusHigh
	uunpValues[42] = 0.0 ;UN7BLow
	uunpValues[43] = 0.0 ;UN7BHigh
	uunpValues[44] = 0.0 ;UNPBBLow
	uunpValues[45] = 0.0 ;UNPBBHigh
	uunpValues[46] = 0.0 ;SeraphimLow
	uunpValues[47] = 0.0 ;SeraphimHigh
	uunpValues[48] = 0.0 ;DemonfetLow
	uunpValues[49] = 0.0 ;DemonfetHigh
	uunpValues[50] = 0.0 ;DreamGirlLow
	uunpValues[51] = 0.0 ;DreamGirlHigh
	uunpValues[52] = 0.0 ;TopModelLow
	uunpValues[53] = 0.0 ;TopModelHigh
	uunpValues[54] = 0.0 ;LeitoLow
	uunpValues[55] = 0.0 ;LeitoHigh
	uunpValues[56] = 0.0 ;UNPFLow
	uunpValues[57] = 0.0 ;UNPFHigh
	uunpValues[58] = 0.0 ;UNPFxLow
	uunpValues[59] = 0.0 ;UNPFxHigh
	uunpValues[60] = 0.0 ;CNHFLow
	uunpValues[61] = 0.0 ;CNHFHigh
	uunpValues[62] = 0.0 ;CNHFBonusLow
	uunpValues[63] = 0.0 ;CNHFBonusHigh
	uunpValues[64] = 0.0 ;MCBMLow
	uunpValues[65] = 0.0 ;MCBMHigh
	uunpValues[66] = 0.0 ;VenusLow
	uunpValues[67] = 0.0 ;VenusHigh
	uunpValues[68] = 0.0 ;ZGGBR2Low
	uunpValues[69] = 0.0 ;ZGGBR2High
	uunpValues[70] = 0.0 ;MangaLow
	uunpValues[71] = 0.0 ;MangaHigh
	uunpValues[72] = 0.0 ;CHSBHCLow
	uunpValues[73] = 0.0 ;CHSBHCHigh

	;BHUNP Sliders (43)
	bhunpValues[0] = 0.0 ;BreastsTogether
	bhunpValues[1] = 1.0 ;BreastCenter
	bhunpValues[2] = 0.0 ;BreastCenterBig
	bhunpValues[3] = 0.0 ;TopSlope
	bhunpValues[4] = 0.0 ;BreastConverge
	bhunpValues[5] = 0.0 ;BreastsGone
	bhunpValues[6] = 0.0 ;BreastsPressed
	bhunpValues[7] = 0.0 ;NipplePuffyAreola
	bhunpValues[8] = 0.0 ;NipBGone
	bhunpValues[9] = 0.0 ;NippleInverted
	bhunpValues[10] = 0.0 ;ChestDepth
	bhunpValues[11] = 0.1 ;ChestWidth
	bhunpValues[12] = 0.0 ;RibsProminance
	bhunpValues[13] = 0.0 ;SternumDepth
	bhunpValues[14] = 0.0 ;SternumHeight
	bhunpValues[15] = 0.0 ;WaistHeight
	bhunpValues[16] = 0.0 ;BackArch
	bhunpValues[17] = 0.0 ;CrotchBack
	bhunpValues[18] = 0.0 ;LegsThin
	bhunpValues[19] = 0.0 ;KneeShape
	bhunpValues[20] = 0.0 ;KneeSlim
	bhunpValues[21] = 0.0 ;MuscleAbs
	bhunpValues[22] = 1.0 ;MuscleArms
	bhunpValues[23] = 0.0 ;MuscleButt
	bhunpValues[24] = 1.0 ;MuscleLegs
	bhunpValues[25] = 0.0 ;MusclePecs
	bhunpValues[26] = 0.0 ;HipForward
	bhunpValues[27] = 0.0 ;HipUpperWidth
	bhunpValues[28] = 0.6 ;ForearmSize
	bhunpValues[29] = 0.0 ;ShoulderTweak
	bhunpValues[30] = 0.0 ;BotePregnancy
	bhunpValues[31] = 0.0 ;BellyFatLower
	bhunpValues[32] = 0.0 ;BellyFatUpper
	bhunpValues[33] = 0.0 ;BellyObesity
	bhunpValues[34] = 0.0 ;BellyPressed
	bhunpValues[35] = 0.0 ;BellyLowerSwell1
	bhunpValues[36] = 0.0 ;BellyLowerSwell2
	bhunpValues[37] = 0.0 ;BellyLowerSwell3
	bhunpValues[38] = 0.0 ;BellyCenterProtrude
	bhunpValues[39] = 0.0 ;BellyCenterUpperProtrude
	bhunpValues[40] = 0.0 ;BellyBalls
	bhunpValues[41] = 0.0 ;Aruru6DuckLow
	bhunpValues[42] = 0.0 ;Aruru6DuckHigh
	
	;CBBE SE Sliders(27)
	cbbeSEValues[0] = 0.0 ;BreastsSmall2
	cbbeSEValues[1] = 0.0 ;BreastsNewSH
	cbbeSEValues[2] = 0.0 ;BreastsNewSHSymmetry
	cbbeSEValues[3] = 0.6 ;BreastTopSlope
	cbbeSEValues[4] = 0.0 ;BreastFlatness2
	cbbeSEValues[5] = 0.0 ;BreastGravity2
	cbbeSEValues[6] = -1.0 ;BreastSideShape
	cbbeSEValues[7] = 0.0 ;BreastUnderDepth
	cbbeSEValues[8] = 0.0 ;AreolaSize
	cbbeSEValues[9] = 0.0 ;NippleManga
	cbbeSEValues[10] = 0.0 ;NipplePerkManga
	cbbeSEValues[11] = 0.0 ;NippleTipManga
	cbbeSEValues[12] = 0.0 ;NippleDip
	cbbeSEValues[13] = 0.0 ;NavelEven
	cbbeSEValues[14] = 0.0 ;ButtClassic
	cbbeSEValues[15] = 1.0 ;ButtDimples
	cbbeSEValues[16] = 0.0 ;ButtUnderFold
	cbbeSEValues[17] = 0.0 ;HipCarved
	cbbeSEValues[18] = 0.0 ;LegShapeClassic
	cbbeSEValues[19] = 0.0 ;FeetFeminine
	cbbeSEValues[20] = 0.0 ;AnkleSize
	cbbeSEValues[21] = 0.0 ;WristSize
	cbbeSEValues[22] = 0.0 ;VanillaSSELo
	cbbeSEValues[23] = 0.0 ;VanillaSSEHi
	cbbeSEValues[24] = 0.0 ;OldBaseShape
	cbbeSEValues[25] = 0.0 ;7BLower
	cbbeSEValues[26] = 0.0 ;7BUpper
	
	;CBBE 3BA Sliders(40)
	cbbe3BAValues[0] = 0.0 ;BreastsConverage_v2
	cbbe3BAValues[1] = 0.0 ;BreastsPressed_v2
	cbbe3BAValues[2] = 0.0 ;AreolaPull_v2
	cbbe3BAValues[3] = 0.0 ;NippleSquash1_v2
	cbbe3BAValues[4] = 0.0 ;NippleSquash2_v2
	cbbe3BAValues[5] = 0.0 ;NipplePuffy_v2
	cbbe3BAValues[6] = 0.0 ;NippleShy_v2
	cbbe3BAValues[7] = 0.0 ;NippleThicc_v2
	cbbe3BAValues[8] = 0.0 ;NippleTube_v2
	cbbe3BAValues[9] = 0.0 ;NippleCrease_v2
	cbbe3BAValues[10] = 0.0 ;NippleCrumpled_v2
	cbbe3BAValues[11] = 0.0 ;NippleBump_v2
	cbbe3BAValues[12] = 0.0 ;NippleInvert_v2
	cbbe3BAValues[13] = 0.0 ;Clavicle_v2
	cbbe3BAValues[14] = 0.0 ;RibsMore_v2
	cbbe3BAValues[15] = 1.0 ;BackValley_v2
	cbbe3BAValues[16] = 0.4 ;BackWing_v2
	cbbe3BAValues[17] = 0.0 ;ButtSaggy_v2
	cbbe3BAValues[18] = 0.0 ;ButtPressed_v2
	cbbe3BAValues[19] = 0.8 ;ButtNarrow_v2
	cbbe3BAValues[20] = 0.0 ;7BLeg_v2
	cbbe3BAValues[21] = 0.3 ;0.1 ;ThighOutsideThicc_v2
	cbbe3BAValues[22] = 0.0 ;ThighInsideThicc_v2
	cbbe3BAValues[23] = 0.3 ;ThighFBThicc_v2
	cbbe3BAValues[24] = 0.1 ;LegSpread_v2
	cbbe3BAValues[25] = 0.0 ;KneeTogether_v2
	cbbe3BAValues[26] = 0.0 ;CalfFBThicc_v2
	cbbe3BAValues[27] = 0.8 ;MuscleMoreAbs_v2
	cbbe3BAValues[28] = 0.5 ;MuscleMoreArms_v2
	cbbe3BAValues[29] = 1.0 ;MuscleMoreLegs_v2
	cbbe3BAValues[30] = 0.6 ;MuscleBack_v2
	cbbe3BAValues[31] = -0.1 ;HipNarrow_v2
	cbbe3BAValues[32] = 0.0 ;UNPHip_v2
	cbbe3BAValues[33] = 0.0 ;ArmpitShape_v2
	cbbe3BAValues[34] = 0.0 ;BellyFrontUpFat_v2
	cbbe3BAValues[35] = 0.0 ;BellyFrontDownFat_v2
	cbbe3BAValues[36] = 0.0 ;BellySideUpFat_v2
	cbbe3BAValues[37] = 0.0 ;BellySideDownFat_v2
	cbbe3BAValues[38] = 0.0 ;BellyUnder_v2
	cbbe3BAValues[39] = 0.0 ;HipBone
	
	Int bhunp3Counter = 0
	While bhunp3Counter < 43
		bhunp3Values[bhunp3Counter] = 0.0
		bhunp3Counter += 1
	EndWhile
	
	;Male and Unisex Bone sliders
	bonesValues[0] = 1.05 ;MultSpineBone
	bonesValues[0] = 1.0 ;MultForearmBone
	Int boneCounter = 2
	While boneCounter < 68
		bonesValues[boneCounter] = 1.0
		boneCounter += 1
	EndWhile
	
	maleValues[0] = 1.0 ;MultSamuel
	maleValues[0] = 0.0 ;MultSamson
	
	
	IntListClear(PlayerRef, SNUSNU_KEY)
	
	IntListAdd(PlayerRef, SNUSNU_KEY, 33, false) ;Back
	IntListAdd(PlayerRef, SNUSNU_KEY, 211, false) ;BackValley_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 212, false) ;BackWing_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 26, false) ;BigBelly
	IntListAdd(PlayerRef, SNUSNU_KEY, 127, false) ;BreastCenter
	IntListAdd(PlayerRef, SNUSNU_KEY, 10, false) ;BreastHeight
	IntListAdd(PlayerRef, SNUSNU_KEY, 175, false) ;BreastSideShape
	IntListAdd(PlayerRef, SNUSNU_KEY, 172, false) ;BreastTopSlope
	IntListAdd(PlayerRef, SNUSNU_KEY, 12, false) ;BreastWidth
	IntListAdd(PlayerRef, SNUSNU_KEY, 1, false) ;BreastsSmall
	IntListAdd(PlayerRef, SNUSNU_KEY, 35, false) ;Butt
	IntListAdd(PlayerRef, SNUSNU_KEY, 34, false) ;ButtCrack
	IntListAdd(PlayerRef, SNUSNU_KEY, 184, false) ;ButtDimples
	IntListAdd(PlayerRef, SNUSNU_KEY, 215, false) ;ButtNarrow_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 51, false) ;CalfSmooth
	IntListAdd(PlayerRef, SNUSNU_KEY, 137, false) ;ChestWidth
	IntListAdd(PlayerRef, SNUSNU_KEY, 22, false) ;ChubbyArms
	IntListAdd(PlayerRef, SNUSNU_KEY, 47, false) ;ChubbyLegs
	IntListAdd(PlayerRef, SNUSNU_KEY, 154, false) ;ForearmSize
	IntListAdd(PlayerRef, SNUSNU_KEY, 227, false) ;HipNarrow_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 220, false) ;LegSpread_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 148, false) ;MuscleArms
	IntListAdd(PlayerRef, SNUSNU_KEY, 226, false) ;MuscleBack_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 150, false) ;MuscleLegs
	IntListAdd(PlayerRef, SNUSNU_KEY, 223, false) ;MuscleMoreAbs_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 224, false) ;MuscleMoreArms_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 225, false) ;MuscleMoreLegs_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 19, false) ;NippleDown
	IntListAdd(PlayerRef, SNUSNU_KEY, 18, false) ;NippleUp
	IntListAdd(PlayerRef, SNUSNU_KEY, 9, false) ;PushUp
	IntListAdd(PlayerRef, SNUSNU_KEY, 219, false) ;ThighFBThicc_v2
	IntListAdd(PlayerRef, SNUSNU_KEY, 217, false) ;ThighOutsideThicc_v2
EndFunction

;profileID: 1=UUNP, 2=CBBE 3BA, 3=CBBE 3BA Pecs
Function LoadDefaultProfile(Int profileID)
	If profileID == 1 ;UUNP
		loadAllMorphs("SnuSnuProfiles/SnuDefaultUUNP")
	ElseIf profileID == 2 ;CBBE 3BA
		loadAllMorphs("SnuSnuProfiles/SnuDefault3BA")
	ElseIf profileID == 3 ;CBBE 3BA Pecs
		loadAllMorphs("SnuSnuProfiles/SnuDefault3BAPecs")
	ElseIf profileID == 4 ;FMG UUNP
		loadAllMorphs("SnuSnuProfiles/SnuDefaultFMG_UNP")
	ElseIf profileID == 5 ;FMG CBBE 3BA
		loadAllMorphs("SnuSnuProfiles/SnuDefaultFMG_CBBE")
	ElseIf profileID == 6 ;FMG Vanilla (Bone morphs)
		loadAllMorphs("SnuSnuProfiles/SnuDefaultFMG_MALE")
	Else
		Debug.Trace("SNU - ERROR Default profile index not recognized!")
	EndIf
EndFunction

Function ForceNewWeight(Float newScore = 500.0)
	storedMuscle = 0.0
	lostMuscle = 0.0
	muscleScore = newScore
	normalsScore = newScore * 0.9
	Debug.Trace("SNU - Muscle score has been set to: "+muscleScore)
	LastDegradationTime = 0.0
	startSleepTime = 0.0
	totalSleepTime = 0.0
	justWakeUp = false

	currentBuildStage = 1
	currentPregStage = 0
	currentSlimStage = 0
	finalNormalsPath = "EMPTY"
	
	updateCarryWeight()
	UpdateEffects()
	checkBodyNormalsState()
	LastDegradationTime = GameDaysPassed.GetValue()
EndFunction

Function initFNISanims()
	isFNISLoaded = (Game.GetModByName("FNIS.esp") != 255)
	If !isFNISLoaded
		isFNISLoaded = MiscUtil.FileExists("data/Scripts/FNIS_aa.pex")
		If !isFNISLoaded
			isUsingFNIS = false
			return
		Else
			Debug.Trace("SNU - FNIS_aa found but not FNIS.esp. Probably using Nemesis...")
		EndIf
	EndIf
	
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
	If !isFNISLoaded
		return
	EndIf
	
	bool bOk
	If isUsingFNIS && removeAnims
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mt", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mtx", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mtidle", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sneakmt", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sneakidle", 0, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sprint", 0, 0, "Snusnu", true)
		isUsingFNIS = false
	ElseIf !isUsingFNIS
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mt", snuMtBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mtx", snuMtxBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_mtidle", snuIdleBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sneakmt", snuSneakBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sneakidle", snuSneakIdleBase, 0, "Snusnu", true)
		bOk = FNIS_aa.SetAnimGroup(buffActor, "_sprint", snuSprintBase, 0, "Snusnu", true)
		isUsingFNIS = true
	EndIf
	If !bOk
		Debug.Trace("SNU - ERROR cannot set player animvar for group _mt")
	EndIf
EndFunction

Function updateAnimations(Int newBuildStage)
	If (MuscleLevel.getValue() as Int) != newBuildStage - 1
		;TLALOC- For use with DAR
		MuscleLevel.setValue(newBuildStage - 1)
		
		If !useDARAnims
			If isUsingFNIS && (MuscleLevel.getValue() as Int) < (muscleAnimsLevel.getValue() as Int)
				setMuscleAnimations(PlayerRef, true)
			ElseIf !isUsingFNIS && (MuscleLevel.getValue() as Int) >= (muscleAnimsLevel.getValue() as Int)
				setMuscleAnimations(PlayerRef)
			EndIf
		Else
			;Force an idle reset so that DAR can use the new animations
			If SnusnuUtil.canPlayAnimation(PlayerRef)
				Debug.SendAnimationEvent(PlayerRef,"IdleForceDefaultState")
			EndIf
		EndIf
	EndIf
EndFunction

Function ReloadHotkeys()
	UnregisterForAllKeys()
	
	RegisterForKey(getInfoKey)
	
	;Experimental NPC muscle gain
	RegisterForKey(npcMuscleKey);K
	
	;Switch breast physics. Migrated from changes made to 3BBB scripts
	RegisterForKey(physicsLevelKey);B
EndFunction

Function updateCarryWeight()
	If carryWeightBoost > 0.0
		Float tempCarryWeight = getCarryWeightPercent()
		If tempCarryWeight != currentExtraCarryWeight
			If tempCarryWeight == 0.0
				If currentExtraCarryWeight > 0.0
					PlayerRef.ModActorValue("CarryWeight", -currentExtraCarryWeight)
					currentExtraCarryWeight = 0.0
				EndIf
			Else
				;IMPORTANT! We need to always remove the previous CarryWeight modification before applying the new changes, 
				;           because otherwise the new changes will be applied on top of the previous value
				PlayerRef.ModActorValue("CarryWeight", -currentExtraCarryWeight)
				currentExtraCarryWeight = tempCarryWeight
				PlayerRef.ModActorValue("CarryWeight", currentExtraCarryWeight)
			EndIf
		EndIf
	ElseIf currentExtraCarryWeight > 0.0
		PlayerRef.ModActorValue("CarryWeight", -currentExtraCarryWeight)
		currentExtraCarryWeight = 0.0
	EndIf
EndFunction

;/
------- REFERENCES
------- actualCarryWeight = PlayerRef.GetActorValue("CarryWeight")
------- PlayerRef.ModActorValue("CarryWeight", -modWeight)

Int currentStage = carryWeightBoost / currentExtraCarryWeight
/;

;/ ----------- LOGIC ----------- 
carryWeightBoost is the maximum carry weight we can get, and what we actually get depends on the
muscle score. 

To avoid constantly changing the carry weight, we divide the muscleScore in stages.
From 0 to 20% of maximumMuscleScore, carryWeight should be 0
From 20 to 40%, carryWeight should be 25% of carryWeightBoost
From 40 to 60%, carryWeight should be 50% of carryWeightBoost
From 60 to 80%, carryWeight should be 75% of carryWeightBoost
From 80% and up, carryWeight should be 100% of carryWeightBoost

If the user changes the value of carryWeightBoost, we shoud recalculate the ranges and reapply the
correct boost to carry weight if necessary

There is a couple of values we need to calculate always
- Muscle score percent: should be muscleScore divided by muscleScoreMax. Result should be between 0 and 1
  musclePercent = muscleScore/muscleScoreMax
- Carry weight percent: Same calculation: currentExtraCarryWeight divided by carryWeightBoost. Result should be between 0 and 1
  carryWeightPercent = currentExtraCarryWeight/carryWeightBoost
  
But first we need to know what value currentExtraCarryWeight should actually be. For that we just
- carryWeightBoost*0.75 = 75%
- carryWeightBoost*0.5 = 50%
- carryWeightBoost*0.25 = 25%


EVERY TIME WE WANT TO UPDATE THE CARRY WEIGHT, we get the musclePercent value, then the carryWeightPercent,
and check if we are out of range. If we are, we update the carryWeight accordingly
/;
Float Function getCarryWeightPercent()
	Float newCarryWeight
	Float musclePercent = muscleScore/muscleScoreMax
	
	If musclePercent < 0.2
		newCarryWeight = 0.0
	ElseIf musclePercent < 0.4
		newCarryWeight = carryWeightBoost*0.25
	ElseIf musclePercent < 0.6
		newCarryWeight = carryWeightBoost*0.5
	ElseIf musclePercent < 0.8
		newCarryWeight = carryWeightBoost*0.75
	Else
		newCarryWeight = carryWeightBoost
	EndIf
	
	Debug.Trace("SNU - musclePercent="+musclePercent+", newCarryWeight="+newCarryWeight)
	return newCarryWeight
EndFunction

Function removeNormalMuscle(Actor buffTarget, Float changePercent)
	If useWeightSlider
		FLoat newWeight = changePercent * 100
		Float tWeight = buffTarget.GetLeveledActorBase().GetWeight()
		Float tNeckdelta = (tWeight/100) - (newWeight/100)
		
		If tWeight == 0
			Return
		EndIf
		
		;Debug.Trace("SNU - currentWeight="+tWeight+", newWeight="+newWeight)
		If newWeight - tWeight > 5.0 || newWeight - tWeight < -5.0
			;TLALOC- The following code can produce small lags
			buffTarget.GetActorBase().SetWeight(newWeight)
			buffTarget.UpdateWeight(tNeckdelta)
			If !PlayerRef.IsOnMount()
				buffTarget.QueueNiNodeUpdate()
			EndIf
		EndIf
	Else
		If getfightingMuscle() == 0
			Return
		EndIf
		
		Float fightingMuscle = getfightingMuscle() * (1 - changePercent)
		Debug.Trace("SNU - Removing normal muscle: "+fightingMuscle)
		
		Int totalSliders = StorageUtil.IntListCount(buffTarget, SNUSNU_KEY)
		Int slidersLoop = 0
		while slidersLoop < totalSliders
			Int currentSliderIndex = StorageUtil.IntListGet(buffTarget, SNUSNU_KEY, slidersLoop)
			NiOverride.SetBodyMorph(buffTarget, getSliderString(currentSliderIndex), SNUSNU_KEY, fightingMuscle * getSliderValue(currentSliderIndex))
			slidersLoop += 1
		endWhile
	EndIf
EndFunction

Function initWerewolfMorphArrays()
	;wufwufValues = new Float[]
	wufwufBones = new String[24]
	wufwufBoneValues = new Float[24]
	
	wufwufBones[0] = "NPC"
	wufwufBones[1] = "NPC Spine2 [Spn2]"
	wufwufBones[2] = "NPC L UpperarmTwist1 [LUt1]"
	wufwufBones[3] = "NPC R UpperarmTwist1 [RUt1]"
	wufwufBones[4] = "NPC L UpperarmTwist2 [LUt2]"
	wufwufBones[5] = "NPC R UpperarmTwist2 [RUt2]"
	wufwufBones[6] = "NPC L Forearm [RLar]"
	wufwufBones[7] = "NPC R Forearm [RLar]"
	wufwufBones[8] = "NPC R RearCalf [RrClf]"
	wufwufBones[9] = "NPC L RearCalf [LrClf]"
	wufwufBones[10] = "NPC R RearThigh"
	wufwufBones[11] = "NPC L RearThigh"
	wufwufBones[12] = "NPC R FrontThigh"
	wufwufBones[13] = "NPC L FrontThigh"
	wufwufBones[14] = "XXX"
	wufwufBones[15] = "XXX"
	wufwufBones[16] = "XXX"
	wufwufBones[17] = "XXX"
	wufwufBones[18] = "XXX"
	wufwufBones[19] = "XXX"
	wufwufBones[20] = "XXX"
	wufwufBones[21] = "XXX"
	wufwufBones[22] = "XXX"
	wufwufBones[23] = "XXX"
	
	wufwufBoneValues[0] = 1.075 ;Height
	wufwufBoneValues[1] = 1.11 ;Spine2
	wufwufBoneValues[2] = 1.25 ;UpperarmTwist1 L
	wufwufBoneValues[3] = 1.25 ;UpperarmTwist1 R
	wufwufBoneValues[4] = 1.25 ;UpperarmTwist2 L
	wufwufBoneValues[5] = 1.25 ;UpperarmTwist2 R
	wufwufBoneValues[6] = 1.25 ;Forearm R
	wufwufBoneValues[7] = 1.25 ;Forearm L
	wufwufBoneValues[8] = 1.5 ;RearCalf R
	wufwufBoneValues[9] = 1.5 ;RearCalf L
	wufwufBoneValues[10] = 1.5 ;RearThigh R
	wufwufBoneValues[11] = 1.5 ;RearThigh L
	wufwufBoneValues[12] = 1.5 ;FrontThigh R
	wufwufBoneValues[13] = 1.5 ;FrontThigh L
	wufwufBoneValues[14] = 1.0 ;XXX
	wufwufBoneValues[15] = 1.0 ;XXX
	wufwufBoneValues[16] = 1.0 ;XXX
	wufwufBoneValues[17] = 1.0 ;XXX
	wufwufBoneValues[18] = 1.0 ;XXX
	wufwufBoneValues[19] = 1.0 ;XXX
	wufwufBoneValues[20] = 1.0 ;XXX
	wufwufBoneValues[21] = 1.0 ;XXX
	wufwufBoneValues[22] = 1.0 ;XXX
	wufwufBoneValues[23] = 1.0 ;XXX
EndFunction

Function updateWerewolfBones(Actor theWufwuf, Float sizeFactor = 1.0, Bool removeMorphs = false)
	Bool actorIsFemale = theWufwuf.GetActorBase().GetSex()
	Int wufBonesLoop = 0
	while wufBonesLoop < wufwufBones.length && wufwufBones[wufBonesLoop] != "XXX"
		Float wufBoneScale
		If removeMorphs
			wufBoneScale = 1.0
		Else
			wufBoneScale = getBoneSize(sizeFactor, wufwufBoneValues[wufBonesLoop])
		EndIf
		
		SetNodeScale(theWufwuf, actorIsFemale, wufwufBones[wufBonesLoop], wufBoneScale, SNUSNU_KEY)
		wufBonesLoop += 1
	EndWhile
EndFunction

Function updateWerewolfMuscle(Float sizeFactor = 1.0)
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle", 0) == 0
		;NiOverride.SetBodyMorph(PlayerRef, "BodyHigh", SNUSNU_KEY, sizeFactor * 1.5) ;1.5
		;NiOverride.SetBodyMorph(PlayerRef, "BreastsLowHDT", SNUSNU_KEY, sizeFactor * -1.0)
		Debug.Trace("SNU - Updating werewolf shape, sizeFactor="+sizeFactor)
		;SMALL version
		NiOverride.SetBodyMorph(PlayerRef, "BodyHigh", SNUSNU_KEY, sizeFactor * 2.0)
		NiOverride.SetBodyMorph(PlayerRef, "BreastsLowHDT", SNUSNU_KEY, sizeFactor * -0.5)
		
		;WeightMorphs;
		If isWeightMorphsLoaded 
			If SnusnuUtil.getWeightmorphsWeight() >= 0.0
				NiOverride.SetBodyMorph(PlayerRef, "BodyHighHDT", SNUSNU_KEY, SnusnuUtil.getWeightmorphsWeight() * 0.5);0.8
				;NiOverride.SetBodyMorph(PlayerRef, "BodyVeryHighHDT", SNUSNU_KEY, sizeFactor * 0.4)
			EndIf
		EndIf
	Else
		Debug.Trace("SNU - Updating werewolf shape, currentMusclePercent="+currentMusclePercent)
		NiOverride.SetBodyMorph(PlayerRef, "BodyHigh", SNUSNU_KEY, currentMusclePercent * 2.5)
		NiOverride.SetBodyMorph(PlayerRef, "BreastsLowHDT", SNUSNU_KEY, currentMusclePercent * -1.0)
		
		;Add some thickness -- NOT NEEDED since we are using bone morphs now
		;NiOverride.SetBodyMorph(PlayerRef, "BodyHighHDT", SNUSNU_KEY, 0.1)
		
		;Big bones
		;ToDo- We might need to remove the human bone morphs during werewolf TF
		updateWerewolfBones(PlayerRef, currentMusclePercent)
	EndIf
	
	NiOverride.UpdateModelWeight(PlayerRef)
EndFunction

Function addWerewolfBuild()
	If !Enabled
		return
	EndIf
	
	Debug.Trace("SNU - addWerewolfBuild()")
	If addWerewolfStrength > 0.0
		;Werewolf characters should have a lean, muscular build, so that means:
		;   added muscle mass (take from stored) and updated body weight
		;	(should be around 20% chubbiness) after transformation.
		
		totalSleepTime = GameDaysPassed.GetValue() - startSleepTime
		justWakeUp = true
		updateMuscleScore(muscleScoreMax * addWerewolfStrength) ;Add 5% extra muscle
		
		If isWeightMorphsLoaded
			Float modFactor = 0.05
			
			Float wMorphsWeight = SnusnuUtil.getWeightmorphsWeight()
			If wMorphsWeight < 0.075
				If wMorphsWeight + modFactor > 0.075
					modFactor = 0.075 - wMorphsWeight
				EndIf
				SnusnuUtil.changeWeightmorphsWeight(modFactor, true)
			ElseIf wMorphsWeight > 0.075
				modFactor = -modFactor
				If wMorphsWeight + modFactor < 0.075
					modFactor = -(wMorphsWeight - 0.075)
				EndIf
				
				SnusnuUtil.changeWeightmorphsWeight(modFactor, true)
			EndIf
		EndIf
	EndIf
EndFunction

Race Function getVampireRace(Actor theVampire)
	Race vampireRace = theVampire.GetRace()
	int index = SnusnuVampireRaces.Find(vampireRace)
	If index > -1
		return SnusnuVampireRaces.GetAt(index) as Race
	EndIf
	
	return none
endFunction

Race Function getNonVampireRace(Race vampireRace)
	int vampireIndex = SnusnuVampireRaces.Find(vampireRace)
	return SnusnuPlayableRaces.GetAt(vampireIndex) as Race
endFunction

;TLALOC- NPC Related functions
Function applyNPCMuscle()
	Debug.Trace("SNU - Refreshing NPC muscle")
	;ToDo- We need to add logic to customize and store morphs for male bodies even if PC is female
	Int totalNPCs = FormListCount(none, "MUSCLE_NPCS")
	Debug.Trace("SNU - Total muscle NPCs: "+totalNPCs)
	Int npcsLoop = 0
	while npcsLoop < totalNPCs
		Actor currentActor = FormListGet(none, "MUSCLE_NPCS", npcsLoop) as Actor
		Float muscleScoreNPC = StorageUtil.GetFloatValue(currentActor, "hasMuscle", 0)
		;/
		If muscleScoreNPC == 0.0
			muscleScoreNPC = floatListGet(none, "MUSCLE_NPCS_SCORE", npcsLoop)
		EndIf /;
		;Debug.Trace("SNU - Checking muscle on actor: "+currentActor.GetBaseObject().getName()+", Score: "+muscleScoreNPC)
		
		If currentActor.GetBaseObject().getName() == ""
			Debug.Trace("SNU - Found invalid actor. Removing from list")
			
			StorageUtil.SetFloatValue(currentActor, "hasMuscle", 0)
			If !StorageUtil.FormListRemoveAt(none, "MUSCLE_NPCS", npcsLoop)
				Debug.Trace("SNU - ERROR! Actor could not be removed!!")
				npcsLoop += 1
			Else
				StorageUtil.floatListRemoveAt(none, "MUSCLE_NPCS_SCORE", npcsLoop)
			EndIf
		Else
			If muscleScoreNPC == 0.0
				muscleScoreNPC = 0.3
				;StorageUtil.FloatListAdd(none, "MUSCLE_NPCS_SCORE", muscleScoreNPC, true)
				StorageUtil.SetFloatValue(currentActor, "hasMuscle", muscleScoreNPC)
			EndIf
			If currentActor && currentActor.is3dloaded() && muscleScoreNPC != 0 && StorageUtil.IntListGet(none, "MUSCLE_NPCS", npcsLoop) == 0
				Bool isFemale = currentActor.GetActorBase().GetSex() != 0
				String skinOverride = NiOverride.GetSkinOverrideString(currentActor, isFemale, false, 0x04, 9, 1)
				showInfoNotification("Restoring normals to "+currentActor.GetBaseObject().getName())
				Debug.Trace("SNU - Restoring normals to "+currentActor.GetBaseObject().getName()+": "+skinOverride)
				If skinOverride == ""
					SnusnuMusclePowerNPCScript.forceSwitchMuscleNormals(currentActor, muscleScoreNPC * 100, getNormalsByBodyType(currentActor))
				Else
					NiOverride.AddSkinOverrideString(currentActor, isFemale, false, 0x04, 9, 1, skinOverride, true)
				EndIf
				NiOverride.ApplySkinOverrides(currentActor)
				
				;Set a flag to know this NPC has already been refreshed
				StorageUtil.IntListSet(none, "MUSCLE_NPCS", npcsLoop, 1)
			EndIf
			npcsLoop += 1
		EndIf
	endWhile
EndFunction

Bool Function saveAllMorphs(String profileName = "")
	String fileName = "SnusnuMorphs"
	If profileName != ""
		fileName = profileName
	EndIf
	
	cleanupCurrentMorphsList(true) ;ToDo- Will this be always needed?
	If IntListCount(PlayerRef, SNUSNU_KEY) > 0
		int[] tempMorphsArray = IntListToArray(PlayerRef, SNUSNU_KEY)
		If !JsonUtil.IntListCopy(fileName, "MainMorphs", tempMorphsArray)
			Debug.Trace("SNU - ERROR: Morphs array could not be saved!!")
			Return false
		EndIf
	EndIf
	
	If !JsonUtil.FloatListCopy(fileName, "CBBEMorphs", cbbeValues)
		Debug.Trace("SNU - ERROR: CBBE array could not be saved!!")
		Return false
	EndIf
	If !JsonUtil.FloatListCopy(fileName, "UUNPMorphs", uunpValues)
		Debug.Trace("SNU - ERROR: UUNP array could not be saved!!")
		Return false
	EndIf
	If !JsonUtil.FloatListCopy(fileName, "BHUNPMorphs", bhunpValues)
		Debug.Trace("SNU - ERROR: BHUNP array could not be saved!!")
		Return false
	EndIf
	If !JsonUtil.FloatListCopy(fileName, "CBBESEMorphs", cbbeSEValues)
		Debug.Trace("SNU - ERROR: CBBESE array could not be saved!!")
		Return false
	EndIf
	If !JsonUtil.FloatListCopy(fileName, "3BAMorphs", cbbe3BAValues)
		Debug.Trace("SNU - ERROR: 3BA array could not be saved!!")
		Return false
	EndIf
	If !JsonUtil.FloatListCopy(fileName, "BHUNP3Morphs", bhunp3Values)
		Debug.Trace("SNU - ERROR: BHUNPv3 array could not be saved!!")
		Return false
	EndIf
	
	If !JsonUtil.FloatListCopy(fileName, "BoneMorphs", bonesValues)
		Debug.Trace("SNU - ERROR: Bone array could not be saved!!")
		Return false
	EndIf
	If !JsonUtil.FloatListCopy(fileName, "MaleMorphs", maleValues)
		Debug.Trace("SNU - ERROR: Male array could not be saved!!")
		Return false
	EndIf
	
	JsonUtil.Save(fileName, False)
	Return true
EndFunction

Bool Function loadAllMorphs(String profileName = "")
	String fileName = "SnusnuMorphs"
	If profileName != ""
		fileName = profileName
	EndIf
	
	If JsonUtil.Load(fileName) && JsonUtil.IsGood(fileName)
		int[] tempMorphsArray = JsonUtil.IntListToArray(fileName, "MainMorphs")
		If tempMorphsArray && tempMorphsArray.length > 0
			If !IntListCopy(PlayerRef, SNUSNU_KEY, tempMorphsArray)
				Debug.Trace("SNU - ERROR: Main morphs array could not be loaded!!")
				Return false
			EndIf
		Else
			IntListClear(PlayerRef, SNUSNU_KEY)
		EndIf
		
		NiOverride.ClearBodyMorphKeys(PlayerRef, SNUSNU_KEY)
		
		cbbeValues = JsonUtil.FloatListToArray(fileName, "CBBEMorphs")
		uunpValues = JsonUtil.FloatListToArray(fileName, "UUNPMorphs")
		bhunpValues = JsonUtil.FloatListToArray(fileName, "BHUNPMorphs")
		cbbeSEValues = JsonUtil.FloatListToArray(fileName, "CBBESEMorphs")
		cbbe3BAValues = JsonUtil.FloatListToArray(fileName, "3BAMorphs")
		bhunp3Values = JsonUtil.FloatListToArray(fileName, "BHUNP3Morphs")
		
		bonesValues = JsonUtil.FloatListToArray(fileName, "BoneMorphs")
		maleValues = JsonUtil.FloatListToArray(fileName, "MaleMorphs")
		
		cleanupCurrentMorphsList(false) ;ToDo- Will this be always needed?
		
		;We really should NOT update the body shape everytime a profile is loaded, specially if we are editing
		;the FMG morphs and switching around the profiles several times in the MCM
		;UpdateWeight(true)
	Else
		Debug.Trace("SNU - ERROR: Morphs could not be loaded!!")
		Return false
	EndIf
	
	Return true
EndFunction

Function cleanupCurrentMorphsList(Bool cleanValues)
	If !cleanValues
		IntListClear(PlayerRef, SNUSNU_KEY)
	EndIf
	
	Int cbbeLoop = 0
	while cbbeLoop < 52
		If cbbeValues[cbbeLoop] != 0.0
			If cleanValues
				If !IntListHas(PlayerRef, SNUSNU_KEY, cbbeLoop)
					cbbeValues[cbbeLoop] = 0.0
				EndIf
			Else
				IntListAdd(PlayerRef, SNUSNU_KEY, cbbeLoop, false)
			EndIf
		EndIf
		cbbeLoop += 1
	endWhile
	
	;UUNP
	Int uunpLoop = 0
	while uunpLoop < 74
		If uunpValues[uunpLoop] != 0.0
			If cleanValues
				If !IntListHas(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop)
					uunpValues[uunpLoop] = 0.0
				EndIf
			Else
				IntListAdd(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop, false)
			EndIf
		EndIf
		uunpLoop += 1
	endWhile

	;BHUNP Sliders
	Int bhunpLoop = 0
	while bhunpLoop < 43
		If bhunpValues[bhunpLoop] != 0.0
			If cleanValues
				If !IntListHas(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop+bhunpLoop)
					bhunpValues[bhunpLoop] = 0.0
				EndIf
			Else
				IntListAdd(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop+bhunpLoop, false)
			EndIf
		EndIf
		bhunpLoop += 1
	endWhile
	
	;CBBE SE Sliders
	Int cbbeSELoop = 0
	while cbbeSELoop < 27
		If cbbeSEValues[cbbeSELoop] != 0.0
			If cleanValues
				If !IntListHas(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop+bhunpLoop+cbbeSELoop)
					cbbeSEValues[cbbeSELoop] = 0.0
				EndIf
			Else
				IntListAdd(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop+bhunpLoop+cbbeSELoop, false)
			EndIf
		EndIf
		cbbeSELoop += 1
	endWhile
	
	;CBBE 3BA Sliders
	Int cbbe3BALoop = 0
	while cbbe3BALoop < 40
		If cbbe3BAValues[cbbe3BALoop] != 0.0
			If cleanValues
				If !IntListHas(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop+bhunpLoop+cbbeSELoop+cbbe3BALoop)
					cbbe3BAValues[cbbe3BALoop] = 0.0
				EndIf
			Else
				IntListAdd(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop+bhunpLoop+cbbeSELoop+cbbe3BALoop, false)
			EndIf
		EndIf
		cbbe3BALoop += 1
	endWhile
	
	;BHUNPv3 Sliders
	Int bhunp3Loop = 0
	while bhunp3Loop < 43
		If bhunp3Values[bhunp3Loop] != 0.0
			If cleanValues
				If !IntListHas(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop+bhunpLoop+cbbeSELoop+cbbe3BALoop+bhunp3Loop)
					bhunp3Values[bhunp3Loop] = 0.0
				EndIf
			Else
				IntListAdd(PlayerRef, SNUSNU_KEY, cbbeLoop+uunpLoop+bhunpLoop+cbbeSELoop+cbbe3BALoop+bhunp3Loop, false)
			EndIf
		EndIf
		bhunp3Loop += 1
	endWhile
EndFunction

Function showInfoNotification(String infoMessage)
	If showInfoMessages
		Debug.Notification(infoMessage)
	EndIf
EndFunction
