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
Bool Property justWakeUp = false Auto

Float bowDrawTime = 0.0
Float Property malnourishmentValue = -0.9 Auto

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
Bool malnourishmentWarning = False
Bool Property usePecs = False Auto
Armor Property handsFix Auto

Bool effectsChanged = False

Int Property getInfoKey = 52 Auto ;Period
Int Property npcMuscleKey = 37 Auto ;K
Int Property selectedBody = 0 Auto ;0=UUNP, 1=CBBE SE, 2=Vanilla

;TLALOC- WeightMorphs related values
Bool Property isWeightMorphsLoaded Auto
Bool Property removeWeightMorphs = true Auto
;PlayerSuccubusMenu PSQM
;WeightMorphsMCM WMCM

Bool Property useDynamicPhysics = true Auto
Bool Property is3BAPhysicsLoaded Auto

;TLALOC- TF related stuff
Bool Property isTransforming = false Auto
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
HeadPart Property MuscleHeadTan  Auto
HeadPart Property MuscleHeadTan2  Auto
HeadPart Property originalHead Auto
Sound Property snusnuTFSound  Auto
Sound Property snusnuTFSoundShort  Auto
Bool Property applyMoreChangesOvertime = true Auto
Bool Property dynamicChangesCalculation = false Auto
Float Property moreChangesInterval = 1.0  Auto ;When the next change will occour, in in-game days
Float Property moreChangesIncrements = 0.35  Auto ;How much to change
Float Property muscleMightAffinity = 0.0  Auto
Float Property muscleMightProbability = 0.25  Auto

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
Float Property maxItemsEquipedWeight = 150.0 Auto
Float Property minItemsEquipedWeight = 15.0 Auto
;FIX: CarryWeight value doesn't get updated after switch equipping 2 heavy items
Bool Property needEquipWeightUpdate = false Auto
Bool isEquipWeightUpdating = false

Bool Property isWerewolf = false Auto
Float Property addWerewolfStrength = 0.05 Auto

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

String[] cbbeSliders
String[] uunpSliders
String[] bhunpSliders
String[] cbbeSESliders
String[] cbbe3BASliders

Float[] Property cbbeValues Auto
Float[] Property uunpValues Auto
Float[] Property bhunpValues Auto
Float[] Property cbbeSEValues Auto
Float[] Property cbbe3BAValues Auto

;Bone related sliders
;XPMSEE Has 129 different bones. Not sure if all of them can be interacted with
;48 usable sliders found in RaceMenu, from which 6 are female exclusive
Float Property MultSpineBone = 1.05 Auto
Float Property MultForearmBone = 1.05 Auto
Float[] Property bonesValues Auto
String[] boneSliders

; Male morphs
;HIMBO has 126 morphs
Float Property MultSamuel = 1.0 Auto
Float Property MultSamson = 0.0 Auto
Float[] Property maleValues Auto

;ToDo- Werewolf morphs
Float[] Property wufwufValues Auto

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
		
		isWeightMorphsLoaded = (Game.GetModByName("WeightMorphs.esp") != 255)
		
		If useDynamicPhysics
			is3BAPhysicsLoaded = (Game.GetModByName("3BBB.esp") != 255)
			Debug.Trace("SNU - Is 3BBB loaded? "+is3BAPhysicsLoaded)
			If is3BAPhysicsLoaded
				firstUpdateForBoobs = true
			EndIf
		EndIf
		
		initSliderArrays()
		RegisterEvents(True)
		UpdateEffects()
		
		finalNormalsPath = "EMPTY"
		checkBodyNormalsState()
		
		ReloadHotkeys()
		
		If allowedItemsEquipedWeight == -1.0 && hardcoreMode
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
				updateAllowedItemsEquipedWeight()
			EndIf
			getEquipedFullWeight()
			isEquipWeightUpdating = false
		EndIf
		
		If !snuCRC
			initFNISanims()
		EndIf
	EndIf
EndEvent

Event OnRaceSwitchComplete()
	isWerewolf = !isWerewolf
	If Enabled
		Debug.Trace("SNU - OnRaceSwitchComplete(isWerewolf="+isWerewolf+")")
		Debug.Trace("SNU - PC Race: "+PlayerRef.getRace().getName())
		If !isWerewolf
			RegisterEvents(True)
			UpdateEffects()
			checkBodyNormalsState()
			addWerewolfBuild()
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
			
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
				;TLALOC- Muscle score degradation
				Float DegradationTimer = GameDaysPassed.GetValue() - LastDegradationTime
				Float totalDegradation = degradationBase * MultLoss * DegradationTimer
				If justWakeUp
					Debug.Trace("SNU - justWakeUp, totalDegradation="+totalDegradation)
					Float sleepBonus = getSleepBonus()
					If sleepBonus > 0.0
						Debug.Notification("I got back "+sleepBonus+" muscle score points")
					EndIf
					totalDegradation = totalDegradation + sleepBonus
					Debug.Trace("SNU -             finalDegradation="+totalDegradation)
				EndIf
				updateMuscleScore(totalDegradation)
			EndIf
			
			If justWakeUp
				;ToDo- We might need to find a way to update the carry weight in a non intrusive way without having to 
				;      rely on specific events like sleep or eat. <--- That doesn't make sense. Specific events are exactly
				;      for that.
				updateCarryWeight()
				
				If hardcoreMode
					;Cleanup equipped item weights
					Debug.Notification("Refreshing hardcore weights")
					If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
						updateAllowedItemsEquipedWeight()
					EndIf
					getEquipedFullWeight()
				EndIf
			EndIf
			justWakeUp = false
			;Debug.Trace("SNU - DegradationTimer="+DegradationTimer)
			LastDegradationTime = GameDaysPassed.GetValue()
			
			If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
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
					;NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
					NiOverride.RemoveSkinOverride(PlayerRef, true, false, 0x04, 9, 1)
					NiOverride.RemoveSkinOverride(PlayerRef, true, true, 0x04, 9, 1)
				EndIf
				If StorageUtil.GetIntValue(PlayerRef, "PSQ_HasMuscle") != 0
					;TLALOC- PSQ still needs this to be called
					ClearMorphs()
				EndIf
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
				;Debug.Notification("Carry weight: "+actualCarryWeight)
			
				;PlayerRef.UnequipItem(type, true)
				PlayerRef.ModActorValue("CarryWeight", -modWeight)
				heavyItemsEquiped = 1
				IsOverwhelmed.setValue(1)
			ElseIf heavyItemsEquiped && itemsEquipedWeight <= allowedItemsEquipedWeight && PlayerRef.GetActorValue("CarryWeight") < -100
				Debug.Trace("SNU - All heavy items were removed. Restoring carryWeight")
				;Debug.Notification("Restoring carry weight: "+actualCarryWeight+"+500")
				Debug.Notification("I can move freely now")
				
				PlayerRef.ModActorValue("CarryWeight", actualCarryWeight + 500)
				heavyItemsEquiped = 0
				IsOverwhelmed.setValue(0)
				
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
	return !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask31) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask35) && \
		   !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask36) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask40) && \
		   !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask41) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask43) && \
		   !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask44) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask45) && \
		   !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask47) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask52) && \
		   !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask55) && !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask57) && \
		   !Math.LogicalAnd(itemArmor.getSlotMask(), itemArmor.kSlotMask58) && itemArmor != HandsFix
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
		EndIf
		
		Float itemWeight = theItem.GetWeight()
		;Debug.Trace("SNU - "+theItem.getName()+" weight is "+itemWeight)
		itemWeight = itemWeight * (1.0 - skillHelp)
		;Debug.Trace("SNU - "+theItem.getName()+" NEW weight is "+itemWeight)
	
		return itemWeight
	EndIf
	
	return 0.0
EndFunction

Function updateAllowedItemsEquipedWeight(Float fmgMusclePercent = 1.0)
	Float currentEquipRange = maxItemsEquipedWeight - minItemsEquipedWeight
	Float musclePercent = muscleScore / muscleScoreMax
	allowedItemsEquipedWeight = (currentEquipRange * musclePercent) + minItemsEquipedWeight
	
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") > 0
		If fmgMusclePercent == 1.0
			allowedItemsEquipedWeight = allowedItemsEquipedWeight + 200
		Else
			allowedItemsEquipedWeight = allowedItemsEquipedWeight + (100 * fmgMusclePercent)
		EndIf
	EndIf
EndFunction

Event OnObjectEquipped(Form type, ObjectReference ref)
	;Debug.Trace("SNU -----------------OnObjectEquipped()-----------------")
	Potion iaExercise = Game.GetFormFromFile(0x05084235, "ImmersiveInteractions.esp") As Potion
	If iaExercise && type == iaExercise
		updateMuscleScore(0.75 * MultGainMisc)
		Debug.Notification("I'm getting a little stronger")
		return
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
		Debug.Notification("Equipped weight is "+itemsEquipedWeight)
		
		If itemsEquipedWeight > allowedItemsEquipedWeight
			needEquipWeightUpdate = true
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
		Debug.Notification("Equipped weight is now "+itemsEquipedWeight)
	EndIf
		
	If heavyItemsEquiped && itemsEquipedWeight <= allowedItemsEquipedWeight && PlayerRef.GetActorValue("CarryWeight") < -100
		needEquipWeightUpdate = true
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
	If Enabled && akSource == PlayerRef && StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
		;Debug.Trace("SNU - OnAnimationEvent("+asEventName+")")
		Float scoreAddition = 0.0
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
				;Debug.Notification("Running up!")
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
			;Debug.Notification("bowDrawTime: "+bowDrawTime)
			
			scoreAddition = scoreAddition + (0.25 * MultGainFight)
			;Debug.Notification("Drawing my bow to full charge surely requieres a certain ammount of strenght")
			
			;bowDrawTime = 0.0
		Else
			;TLALOC- Experimental custom events debug
			Debug.Notification(asEventName)
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
	
	;TLALOC-ToDo- Check if sleep time was enough (7 hrs. could be configurable) and restore muscleScore with 
	;           previously stored value (Around 0.291748 GameDaysPassed for 7 hrs)
	
	;LOGIC: storedMuscle records all of muscle gain on a day, but gets degraded over time so that if PC doesn't sleep regurarly
	;       stored muscle will be lost. recoveredMuscle records how much muscle was lost and we use it so that we cannot recover
	;       more muscle than what we lost
	
	;NEW FEATURE: Randomly transform if muscle affinity is above the threshold
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") > 0
		muscleMightAffinity += 0.02
		If muscleMightAffinity > 1.0
			muscleMightAffinity = 1.0
		EndIf
	Else
		muscleMightAffinity -= 0.005
		If muscleMightAffinity < 0.0
			muscleMightAffinity = 0.0
		EndIf
	EndIf
		
	Float affinityScore = muscleMightAffinity * muscleMightProbability
	Float randomProbability = Utility.RandomFloat(0.0, 1.0)
	Debug.Trace("SNU - Checking mighty dream probability:")
	Debug.Trace("SNU -        affinityScore="+affinityScore)
	Debug.Trace("SNU -        randomProbability="+randomProbability)
	If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0 && affinityScore > randomProbability
		Debug.Notification("I had a dream i was mighty unstoppable")
		Utility.wait(1)
		If affinityScore <= muscleMightProbability * 0.9
			MusclePowerSpell.Cast(PlayerRef)
		Else
			UltraMusclePowerSpell.Cast(PlayerRef)
		EndIf
	Else
		totalSleepTime = GameDaysPassed.GetValue() - startSleepTime
		justWakeUp = true
	EndIf
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
		
		;/WetFunctionRedux info
		If Game.GetModByName("WetFunction.esp") != 255
			Debug.Notification("Wetness: "+StorageUtil.GetFloatValue(PlayerRef, "WetFunction_Actor_wetness", 0.0))
		EndIf
		/;
		
		;WeightMorphs info
		If isWeightMorphsLoaded
			WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
			Debug.Notification("WeightMorphs Weight="+WMCM.WMorphs.Weight)
		EndIf
		If carryWeightBoost != 0.0
			Debug.Notification("ExtraCarryWeight="+currentExtraCarryWeight)
			
		EndIf
		Debug.Notification("muscleMightAffinity="+muscleMightAffinity)
		Debug.Notification("itemsEquipedWeight="+itemsEquipedWeight+", allowedItemsEquipedWeight="+allowedItemsEquipedWeight)
		Debug.Notification("muscleScore="+getMuscleValuePercent(muscleScore)+"%, normalsScore="+getMuscleValuePercent(normalsScore)+"%")
		;Debug.Notification("lostMuscle="+getMuscleValuePercent(lostMuscle)+"%, storedMuscle="+getMuscleValuePercent(storedMuscle)+"%")
		
		If !disableNormals
			Debug.Notification("Normals="+getFinalNormalsPath())
		EndIf
	ElseIf KeyCode == npcMuscleKey && !UI.IsTextInputEnabled() && !Utility.IsInMenuMode()
		applyNPCMuscle()
	EndIf
EndEvent

Float Function getfightingMuscle()
	Float fightingMuscle = muscleScore / muscleScoreMax
		
	; Female
	If isWeightMorphsLoaded
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		Int PlayerSex = PlayerRef.GetActorBase().GetSex()
		If PlayerSex == 1 && WMCM.WMorphs.Weight > 0.2 ;There will be always at least 20% muscularity
			;TLALOC- If getting chubbier, muscle mass gets smaller (This is to avoid overly big arms and thighs on bigger muscleScore)
			;Debug.Trace("SNU - fightingMuscle="+fightingMuscle)
			fightingMuscle = fightingMuscle * ( 1.2 - WMCM.WMorphs.Weight )
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

Float Function getBoneSize(Float baseModifier, Float boneModifier)
	return baseModifier * Math.abs( 1.0 - boneModifier )
EndFunction

Function UpdateWeight(Bool applyNow = True)
	If HAS_NIOVERRIDE && !isTransforming && StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
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
				PlayerRef.QueueNiNodeUpdate()
				PlayerRef.UpdateWeight(tNeckdelta)
				;Debug.Trace("SNU - New weight was set")
			EndIf
			
			;TLALOC- Apply bone changes
			changeBoneScale(PlayerRef, 0, getBoneSize(muscleScore / muscleScoreMax, bonesValues[0]))
			changeBoneScale(PlayerRef, 1, getBoneSize(muscleScore / muscleScoreMax, bonesValues[1]))
			
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
					changeBoneScale(PlayerRef, 0, getBoneSize(muscleScore / muscleScoreMax, bonesValues[0]))
					changeBoneScale(PlayerRef, 1, getBoneSize(muscleScore / muscleScoreMax, bonesValues[1]))
					
					;TLALOC- Werewolf body morph --------------------------------------------------------------------
					;ToDo- Add slider support for all Werewolf morphs
					
					;NiOverride.SetBodyMorph(PlayerRef, "BodyHigh", SNUSNU_KEY, fightingMuscle * 1.5) ;1.5
					;NiOverride.SetBodyMorph(PlayerRef, "BreastsLowHDT", SNUSNU_KEY, fightingMuscle * -1.0)
					
					;SMALL version
					NiOverride.SetBodyMorph(PlayerRef, "BodyHigh", SNUSNU_KEY, fightingMuscle * 2.0)
					NiOverride.SetBodyMorph(PlayerRef, "BreastsLowHDT", SNUSNU_KEY, fightingMuscle * -0.5)
					
					;WeightMorphs;
					If isWeightMorphsLoaded 
						WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
						If WMCM.WMorphs.Weight >= 0.0
							NiOverride.SetBodyMorph(PlayerRef, "BodyHighHDT", SNUSNU_KEY, WMCM.WMorphs.Weight * 0.5);0.8
							;NiOverride.SetBodyMorph(PlayerRef, "BodyVeryHighHDT", SNUSNU_KEY, fightingMuscle * 0.4)
						EndIf
					EndIf
					;TLALOC- Werewolf body morph --------------------------------------------------------------------
				EndIf
				
				;TLALOC- Custom Boobs physics
				updateBoobsPhysics()
			; Male
			ElseIf PlayerSex == 0
				If maleValues[0] != 0.0
					NiOverride.SetBodyMorph(PlayerRef, "Samuel", SNUSNU_KEY, fightingMuscle * maleValues[0])
				Else
					NiOverride.ClearBodyMorph(PlayerRef, "Samuel", SNUSNU_KEY)
				EndIf
				If maleValues[1] != 0.0
					NiOverride.SetBodyMorph(PlayerRef, "Samson", SNUSNU_KEY, fightingMuscle * maleValues[1])
				Else
					NiOverride.ClearBodyMorph(PlayerRef, "Samson", SNUSNU_KEY)
				EndIf
			EndIf
		EndIf
		
		If applyNow
			NiOverride.UpdateModelWeight(PlayerRef)
		EndIf
	
		effectsChanged = True
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
		;ToDo- We could add a toggle for this in the MCM, but it might not be necesary
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
			WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
			If WMCM.WMorphs.Weight < malnourishmentValue
				If !malnourishmentWarning
					Debug.Notification("I can barely develop any muscle mass with this diet!")
					malnourishmentWarning = true
				EndIf
				
				incValue = incValue * 0.25
			ElseIf malnourishmentWarning
				malnourishmentWarning = false
			EndIf
		EndIf
		
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

;TLALOC- BUG FIX: changes applied to main bones will cause a one frame glitch in the character animation, so we need to avoid it
;         as much as we can and only apply it when the change difference is big enough
Function changeSpineBoneScale(Actor theActor, Float scaleValue)
	;Debug.Trace("SNU - changeSpineBoneScale()")
	Float currentScale = NiOverride.GetNodeTransformScale(theActor, false, true, "NPC Spine2 [Spn2]", SNUSNU_KEY)
	
	scaleValue = 1.0 + scaleValue
	
	;Debug.Trace("SNU - Going to update spine scale to: "+scaleValue+" (Prev value = "+currentScale+")")
	If scaleValue - currentScale > 0.001 || scaleValue - currentScale < -0.001
		;Debug.Trace("SNU - Updating spine scale")
		Debug.Trace("SNU - Updating spine scale from: "+currentScale+" to: "+scaleValue)
		SetNodeScale(theActor, true, "NPC Spine2 [Spn2]", scaleValue, SNUSNU_KEY)
		SetNodeScale(theActor, true, "CME Spine2 [Spn2]", 1.0 / scaleValue, SNUSNU_KEY)
	EndIf
EndFunction

Function changeForearmBoneScale(Actor theActor, Float scaleValue)
	;Debug.Trace("SNU - changeForearmBoneScale()")
	Float currentScale = NiOverride.GetNodeTransformScale(theActor, false, true, "NPC R Forearm [RLar]", SNUSNU_KEY)
	
	scaleValue = 1.0 + scaleValue
	
	;Debug.Trace("SNU - Going to update forearm scale to: "+scaleValue+" (Prev value = "+currentScale+")")
	If scaleValue - currentScale > 0.001 || scaleValue - currentScale < -0.001
		;Debug.Trace("SNU - Updating forearm scale")
		;TLALOC- BodySlide doesn't have slides for forearms, so we change the bones instead
		SetNodeScale(theActor, true, "NPC L Forearm [LLar]", scaleValue, SNUSNU_KEY)
		SetNodeScale(theActor, true, "CME L Forearm [LLar]", 1.0 / scaleValue, SNUSNU_KEY)
		SetNodeScale(theActor, true, "NPC L Forearm [RLar]", scaleValue, SNUSNU_KEY)
		
		SetNodeScale(theActor, true, "NPC R Forearm [RLar]", scaleValue, SNUSNU_KEY)
		SetNodeScale(theActor, true, "CME R Forearm [RLar]", 1.0 / scaleValue, SNUSNU_KEY)
		
		SetNodeScale(theActor, true, "NPC L ForearmTwist2 [LLt2]", scaleValue, SNUSNU_KEY)
		SetNodeScale(theActor, true, "NPC R ForearmTwist2 [RLt2]", scaleValue, SNUSNU_KEY)
	EndIf
EndFunction

Function changeBoneScale(Actor theActor, Int boneIndex, Float scaleValue)
	Bool actorIsFemale = theActor.GetActorBase().GetSex()
	Float currentScale = NiOverride.GetNodeTransformScale(theActor, false, actorIsFemale, boneSliders[boneIndex], SNUSNU_KEY)
	scaleValue = 1.0 + scaleValue
	
	If scaleValue - currentScale > 0.001 || scaleValue - currentScale < -0.001
		If boneIndex == 0
			Debug.Trace("SNU - Updating spine scale from: "+currentScale+" to: "+scaleValue)
			SetNodeScale(theActor, actorIsFemale, "NPC Spine2 [Spn2]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME Spine2 [Spn2]", 1.0 / scaleValue, SNUSNU_KEY)
		ElseIf boneIndex == 1
			SetNodeScale(theActor, actorIsFemale, "NPC L Forearm [LLar]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME L Forearm [LLar]", 1.0 / scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC L Forearm [RLar]", scaleValue, SNUSNU_KEY)
			
			SetNodeScale(theActor, actorIsFemale, "NPC R Forearm [RLar]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "CME R Forearm [RLar]", 1.0 / scaleValue, SNUSNU_KEY)
			
			SetNodeScale(theActor, actorIsFemale, "NPC L ForearmTwist2 [LLt2]", scaleValue, SNUSNU_KEY)
			SetNodeScale(theActor, actorIsFemale, "NPC R ForearmTwist2 [RLt2]", scaleValue, SNUSNU_KEY)
		EndIf
	EndIf
EndFunction

Function clearBoneScales(Actor theActor)
	;Debug.Trace("SNU - clearBoneScales()")
	SetNodeScale(theActor, true, "NPC Spine2 [Spn2]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, true, "CME Spine2 [Spn2]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, true, "NPC L Clavicle [LClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, true, "CME L Clavicle [LClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, true, "NPC L Clavicle [RClv]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, true, "NPC R Clavicle [RClv]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, true, "CME R Clavicle [RClv]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, true, "NPC L Forearm [LLar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, true, "CME L Forearm [LLar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, true, "NPC L Forearm [RLar]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, true, "NPC R Forearm [RLar]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, true, "CME R Forearm [RLar]", 1.0, SNUSNU_KEY)
	
	SetNodeScale(theActor, true, "NPC L ForearmTwist2 [LLt2]", 1.0, SNUSNU_KEY)
	SetNodeScale(theActor, true, "NPC R ForearmTwist2 [RLt2]", 1.0, SNUSNU_KEY)
EndFunction

Function chooseBoobsPhysics(Int buildStage)
	If !useDynamicPhysics
		return
	EndIf
	
	Int boobsLevel = 4
	
	If buildStage >= 3
		;Bone Crusher
		boobsLevel = 1
	ElseIf buildStage == 2
		boobsLevel = 2
	EndIf
	
	;weightMorphs calculations
	If isWeightMorphsLoaded
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If boobsLevel > 1
			If WMCM.WMorphs.Weight < -0.75 ;-0.7
				;Boobs too small to have noticeable physics
				boobsLevel = 1
			ElseIf WMCM.WMorphs.Weight < -0.25 && boobsLevel > 2
				;Was: WMCM.WMorphs.Weight < 0.0
				;Boobs still too small to have full physics
				boobsLevel = 2
			ElseIf WMCM.WMorphs.Weight < 0.5
				boobsLevel = 3
			ElseIf WMCM.WMorphs.Weight >= 0.5
				;Was WMCM.WMorphs.Weight > 0.4
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
	
	If checkSMPPhysics()
		;Player is using SMP for body physics so we stop here
		return
	EndIf
	
	;TLALOC- Boobs physics only get updated once, unless a significant muscle change is made
	If is3BAPhysicsLoaded && (firstUpdateForBoobs || forceUpdate)
		Mus3BPhysicsManager PhysicsManager = Game.GetFormFromFile(0x0500084A, "3BBB.esp") As Mus3BPhysicsManager
		;Debug.Trace("SNU- Checking for boobs physics")
		If PhysicsManager != none
			Int physicsLevel = PhysicsManager.getPhysicsLevel()
			
			If newLevel != -1
				If forceUpdate && physicsLevel == newLevel
					return
				Else
					physicsLevel = newLevel
					PhysicsManager.setPhysicsLevel(physicsLevel)
				EndIf
			EndIf
			
			Debug.Trace("SNU- Physics level is "+physicsLevel)
			If physicsLevel == 1
				Debug.Notification("Switching to breasts physics level 1")
				Debug.Trace("Switching to breasts physics level 1")
				PhysicsManager.CBPCBreasts(PlayerRef, true)
				PhysicsManager.CBPCBreastsSmall(PlayerRef)
			ElseIf physicsLevel == 2
				Debug.Notification("Switching to breasts physics level 2")
				Debug.Trace("Switching to breasts physics level 2")
				PhysicsManager.CBPCBreasts(PlayerRef, true)
				PhysicsManager.CBPCBreastsMid(PlayerRef)
			ElseIf physicsLevel == 3
				Debug.Notification("Switching to breasts physics level 3")
				Debug.Trace("Switching to breasts physics level 3")
				PhysicsManager.CBPCBreasts(PlayerRef, true)
				PhysicsManager.CBPCBreastsBig(PlayerRef)
			ElseIf physicsLevel == 4
				;ToDo- Change physics to SMP if body weight (from WeightMorphs) is big enough
				;NOTE: As of right now, CBPC physics are more than enough to simulate big breasts Physics,
				;      so there is no need for complicated SMP switching
				Debug.Notification("Switching to breasts physics level 4")
				Debug.Trace("Switching to breasts physics level 4")
				PhysicsManager.CBPCBreasts(PlayerRef, true)
				PhysicsManager.CBPCBreasts(PlayerRef)
			EndIf
		Endif
		
		firstUpdateForBoobs = false
	EndIf
EndFunction

Bool Function checkSMPPhysics()
	;/	
	armor property SMPONObjectP48 auto
	armor property SMPONObjectP50 auto
	armor property SMPONObjectP51 auto
	armor property SMPONObjectP60 auto
	/;
	
	Armor smpArmor = PlayerRef.GetWornForm(Armor.GetMaskForSlot(48)) as Armor
	If smpArmor && StringUtil.Find(smpArmor.getName(), "3BBB Body SMP", 0) != -1
		return true
	Else
		smpArmor = PlayerRef.GetWornForm(Armor.GetMaskForSlot(50)) as Armor
		If smpArmor && StringUtil.Find(smpArmor.getName(), "3BBB Body SMP", 0) != -1
			return true
		Else
			smpArmor = PlayerRef.GetWornForm(Armor.GetMaskForSlot(51)) as Armor
			If smpArmor && StringUtil.Find(smpArmor.getName(), "3BBB Body SMP", 0) != -1
				return true
			Else
				smpArmor = PlayerRef.GetWornForm(Armor.GetMaskForSlot(60)) as Armor
				If smpArmor && StringUtil.Find(smpArmor.getName(), "3BBB Body SMP", 0) != -1
					return true
				EndIf
			EndIf
		EndIf
	EndIf
	
	return false
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

;     Muscle build stages = 1=Civilian, 2=Athletic, 3=Bone Crusher, 4=Extra Bone Crusher
;     Slim boobs stages = 0=Not slim, 1=Slim
;     Pregnancy stages = 0=Not preg, 1=Preg
Function checkBodyNormalsState()
	;Debug.Trace("SNU - checkBodyNormalsState()")
	If disableNormals || StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") != 0
		return
	EndIf
	
	String tempNormalsPath = normalsPath
	Float stage4Score = muscleScoreMax - (muscleScoreMax * 0.1)
	Float stage3Score = muscleScoreMax - (muscleScoreMax * 0.3)
	Float stage2Score = muscleScoreMax - (muscleScoreMax * 0.5)
	
	
	;Debug.Trace("SNU - muscleScore value from Snusnu is: "+muscleScore)
	;Debug.Trace("SNU - normalsScore value from Snusnu is: "+normalsScore)
	
	;TLALOC- Expand the range of the changes if muscleScore is below 0.25 (This logic will allow to have a extreme muscular definition 
	;      even at that muscleScore, but only if score is high enough
	If isWeightMorphsLoaded 
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If WMCM.WMorphs.Weight < 0.3
			Float changeDelta = (muscleScoreMax * 0.3)
			Float changeFactor = (WMCM.WMorphs.Weight * changeDelta)
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
		WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
		If currentBuildStage >= 2 && WMCM.WMorphs.Weight >= 0.25
			currentBuildStage = 1
		ElseIf currentBuildStage >= 3 && WMCM.WMorphs.Weight >= 0.175 && WMCM.WMorphs.Weight < 0.25
			currentBuildStage = 2
		ElseIf currentBuildStage >= 4 && WMCM.WMorphs.Weight >= 0.10 && WMCM.WMorphs.Weight < 0.175
			currentBuildStage = 3
		EndIf
		
		If WMCM.WMorphs.Weight < -0.5
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
			WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
			If currentBuildStage == 1 && WMCM.WMorphs.Weight > 0.5
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
		
		;ToDo- We need to actually check for character's gender instead of always assuming female. 
		;      This goes for every single call to NiOverride
		NiOverride.AddSkinOverrideString(PlayerRef, true, false, 0x04, 9, 1, finalNormalsPath, true)
		NiOverride.AddSkinOverrideString(PlayerRef, true, true, 0x04, 9, 1, finalNormalsPath, true)
		
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
		
		If StorageUtil.GetIntValue(PlayerRef, "SNU_UltraMuscle") == 0
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
		
		;TLALOC- Bow charge and release
		RegisterForAnimationEvent(PlayerRef, "bowDrawStart")
		UnregisterForAnimationEvent(PlayerRef, "Bow_Release")
		UnregisterForAnimationEvent(PlayerRef, "BowLowered")
		RegisterForAnimationEvent(PlayerRef, "arrowRelease")
		UnregisterForAnimationEvent(PlayerRef, "bowEnd")
		RegisterForAnimationEvent(PlayerRef, "bowDrawn");Happens after doing a full charge
		
		;TLALOC- Blacksmith work
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.OBJBlacksmithForge")
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithForgeTake")
		;RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithForgeQuench")
		;RegisterForAnimationEvent(PlayerRef, "soundPlay.NPCHumanBlacksmithForgeQuenchDrop")
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithHammer")
		RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithRepairHammer")
		
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithHammerDistant")
		UnregisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanBlacksmithRepairHammerDistant")
		
		;TLALOC- Experimental anim events!
		;RegisterForAnimationEvent(PlayerRef, "IdleGreybeardWordTeach");Immersive interactions Dummy training
		;RegisterForAnimationEvent(PlayerRef, "XXX")
		;RegisterForAnimationEvent(PlayerRef, "XXX")
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
			disableNormals = true
		EndIf
		UpdateEffects()
		checkBodyNormalsState()
		initDefaultSliders()
		LastDegradationTime = GameDaysPassed.GetValue()
		
		If PlayerRef.getRace().getName() == "Werewolf"
			isWerewolf = true
		EndIf
	Else
		UpdateEffects(False)
		;NiOverride.RemoveAllReferenceSkinOverrides(PlayerRef)
		NiOverride.RemoveSkinOverride(PlayerRef, true, false, 0x04, 9, 1)
		NiOverride.RemoveSkinOverride(PlayerRef, true, true, 0x04, 9, 1)
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
		
		;CBBE 3BA Sliders
		Int cbbe3BALoop = 0
		while cbbe3BALoop < 40
			clearSliderData(5, cbbe3BALoop)
			cbbe3BALoop += 1
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
	cbbe3BASliders = new String[40]
	
	boneSliders = new String[68]
	
	
	;Check if new arrays havent been initialized
	If !bonesValues
		bonesValues = new Float[68]
		
		bonesValues[0] = MultSpineBone ;1.05
		bonesValues[1] = MultForearmBone ;1.0
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
	
	boneSliders[0] = "NPC Spine2 [Spn2]"
	boneSliders[1] = "NPC R Forearm [RLar]"
	boneSliders[2] = "XXX"
	boneSliders[3] = "XXX"
	boneSliders[4] = "XXX"
	boneSliders[5] = "XXX"
	boneSliders[6] = "XXX"
	boneSliders[7] = "XXX"
	boneSliders[8] = "XXX"
	boneSliders[9] = "XXX"
	boneSliders[10] = "XXX"
	boneSliders[11] = "XXX"
	boneSliders[12] = "XXX"
	boneSliders[13] = "XXX"
	boneSliders[14] = "XXX"
	boneSliders[15] = "XXX"
	boneSliders[16] = "XXX"
	boneSliders[17] = "XXX"
	boneSliders[18] = "XXX"
	boneSliders[19] = "XXX"
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
	EndIf
	
	If value == 0.0
		IntListRemove(PlayerRef, SNUSNU_KEY, position)
		
		Debug.Trace("SNU - Removing morph: "+getSliderString(position))
		NiOverride.ClearBodyMorph(PlayerRef, getSliderString(position), SNUSNU_KEY)
	Else
		IntListAdd(PlayerRef, SNUSNU_KEY, position, false)
	EndIf
	
	If updateWeightNow
		UpdateWeight()
	EndIf
EndFunction

Int Function getGroupIndex(int newIndex)
	Int group = 1
	;ToDo- Check if those calculations are correct
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
	
	;Male and Unisex Bone sliders
	bonesValues[0] = 1.05 ;MultSpineBone
	bonesValues[0] = 1.0 ;MultForearmBone
	
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
	Else
		Debug.Trace("SNU - ERROR Default profile index not recognized!")
	EndIf
	
	;/ OLD CODE
	ClearMorphs(true)
	IntListClear(PlayerRef, SNUSNU_KEY)
	;setSliderValue(Int position, Float value, Bool updateWeightNow = true)
	If profileID == 1 ;UUNP
		setSliderValue(117, 0.5, false) ;MultMCBMHigh
		setSliderValue(89, 0.5, false) ;MultUNPSHHigh
		setSliderValue(47, 0.2, false) ;MultChubbyLegs
		setSliderValue(15, -0.4, false) ;MultNippleLength
		setSliderValue(50, -0.25, false) ;MultCalfSize
		setSliderValue(40, -0.6, false) ;MultAppleCheeks
		setSliderValue(38, 0.8, false) ;MultBigButt
		setSliderValue(45, 0.7, false) ;MultSlimThighs
		setSliderValue(51, -0.25, false) ;MultCalfSmooth
		setSliderValue(8, 1.1, false) ;MultBreastGravity
		setSliderValue(33, 0.4, false) ;MultBack
		setSliderValue(29, 0.5, false) ;MultBigTorso
		setSliderValue(35, -0.1, false) ;MultButt
		setSliderValue(32, -0.6, false) ;MultChubbyWaist
		setSliderValue(23, 0.1, false) ;MultShoulderSmooth
		setSliderValue(24, 0.5, false) ;MultShoulderWidth
		setSliderValue(31, 0.05, false) ;MultWideWaistLine
		setSliderValue(9, -0.4, false) ;MultPushUp
		setSliderValue(3, -0.8, false) ;MultBreastsSSH
		setSliderValue(11, -1.2, false) ;MultBreastPerkiness
		setSliderValue(13, -0.6, false) ;MultNippleDistance
		setSliderValue(30, -0.45, false) ;MultWaist
		setSliderValue(37, 0.4, false) ;MultButtShape2
		setSliderValue(46, -0.5, false) ;MultThighs
		setSliderValue(4, -1.0, false) ;MultBreastsFantasy
		setSliderValue(5, 0.7, false) ;MultDoubleMelon
		setSliderValue(18, -1.0, false) ;MultNippleUp
		setSliderValue(19, 0.2, false) ;MultNippleDown
		setSliderValue(10, 1.6, false) ;MultBreastHeight
		setSliderValue(7, -0.1, false) ;MultBreastFlatness
		setSliderValue(12, 1.2, false) ;MultBreastWidth
		setSliderValue(22, 1.1, false) ;MultChubbyArms
		
		bonesValues[0] = 1.05 ;MultSpineBone
		bonesValues[1] = 1.05 ;MultForearmBone
	ElseIf profileID == 2 ;CBBE 3BA
		setSliderValue(33, 0.5, false) ;Back
		setSliderValue(211, 1.0, false) ;BackValley_v2
		setSliderValue(212, 0.4, false) ;BackWing_v2
		setSliderValue(127, 1.0, false) ;BreastCenter
		setSliderValue(10, 1.1, false) ;BreastHeight
		setSliderValue(175, -1.0, false) ;BreastSideShape
		setSliderValue(172, 0.6, false) ;BreastTopSlope
		setSliderValue(12, 0.6, false) ;BreastWidth
		setSliderValue(1, 0.2, false) ;BreastsSmall
		setSliderValue(35, 0.5, false) ;Butt
		setSliderValue(34, -0.3, false) ;ButtCrack
		setSliderValue(184, 1.0, false) ;ButtDimples
		setSliderValue(215, 0.8, false) ;ButtNarrow_v2
		setSliderValue(51, -0.5, false) ;CalfSmooth
		setSliderValue(137, 0.1, false) ;ChestWidth
		setSliderValue(22, 0.6, false) ;ChubbyArms
		setSliderValue(47, 0.1, false) ;ChubbyLegs
		setSliderValue(154, 0.6, false) ;ForearmSize
		setSliderValue(227, -0.1, false) ;HipNarrow_v2
		setSliderValue(220, 0.1, false) ;LegSpread_v2
		setSliderValue(148, 1.5, false) ;MuscleArms
		setSliderValue(226, 0.6, false) ;MuscleBack_v2
		setSliderValue(150, 1.0, false) ;MuscleLegs
		setSliderValue(223, 1.0, false) ;MuscleMoreAbs_v2
		setSliderValue(224, 0.5, false) ;MuscleMoreArms_v2
		setSliderValue(225, 1.0, false) ;MuscleMoreLegs_v2
		setSliderValue(19, 1.0, false) ;NippleDown
		setSliderValue(18, -0.5, false) ;NippleUp
		setSliderValue(9, -0.1, false) ;PushUp
		setSliderValue(219, 0.3, false) ;ThighFBThicc_v2
		setSliderValue(217, 0.3, false) ;ThighOutsideThicc_v2
		setSliderValue(190, -1.0, false) ;WristSize
		setSliderValue(189, -1.0, false) ;AnkleSize
		setSliderValue(187, -0.6, false) ;LegShapeClassic
		
		bonesValues[0] = 1.05 ;MultSpineBone
		bonesValues[1] = 1.0 ;MultForearmBone
	Else ;CBBE 3BA Pecs
		setSliderValue(33, 0.5, false) ;Back
		setSliderValue(211, 1.0, false) ;BackValley_v2
		setSliderValue(212, 0.4, false) ;BackWing_v2
		setSliderValue(10, 1.1, false) ;BreastHeight
		setSliderValue(175, -1.0, false) ;BreastSideShape
		setSliderValue(172, -0.4, false) ;BreastTopSlope
		setSliderValue(12, 0.6, false) ;BreastWidth
		setSliderValue(1, 0.2, false) ;BreastsSmall
		setSliderValue(35, 0.5, false) ;Butt
		setSliderValue(34, -0.3, false) ;ButtCrack
		setSliderValue(184, 1.0, false) ;ButtDimples
		setSliderValue(215, 0.8, false) ;ButtNarrow_v2
		setSliderValue(51, -0.5, false) ;CalfSmooth
		setSliderValue(137, 0.1, false) ;ChestWidth
		setSliderValue(22, 0.6, false) ;ChubbyArms
		setSliderValue(47, 0.1, false) ;ChubbyLegs
		setSliderValue(154, 0.6, false) ;ForearmSize
		setSliderValue(227, -0.1, false) ;HipNarrow_v2
		setSliderValue(220, 0.1, false) ;LegSpread_v2
		setSliderValue(148, 1.5, false) ;MuscleArms
		setSliderValue(226, 0.6, false) ;MuscleBack_v2
		setSliderValue(150, 1.0, false) ;MuscleLegs
		setSliderValue(223, 1.0, false) ;MuscleMoreAbs_v2
		setSliderValue(224, 0.5, false) ;MuscleMoreArms_v2
		setSliderValue(225, 1.0, false) ;MuscleMoreLegs_v2
		setSliderValue(19, 1.0, false) ;NippleDown
		setSliderValue(18, -0.5, false) ;NippleUp
		setSliderValue(9, -0.1, false) ;PushUp
		setSliderValue(219, 0.3, false) ;ThighFBThicc_v2
		setSliderValue(217, 0.3, false) ;ThighOutsideThicc_v2
		setSliderValue(190, -1.0, false) ;WristSize
		setSliderValue(189, -1.0, false) ;AnkleSize
		setSliderValue(187, -0.6, false) ;LegShapeClassic
		
		;Pecs Shape
		setSliderValue(20, -0.2, false) ;NippleTip
		setSliderValue(131, 0.4, false) ;BreastsGone
		setSliderValue(126, 0.1, false) ;BreastsTogether
		
		
		bonesValues[0] = 1.05 ;MultSpineBone
		bonesValues[1] = 1.0 ;MultForearmBone
	EndIf
	
	UpdateWeight()
	/;
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
		EndIf
	EndIf
EndFunction

Function ReloadHotkeys()
	UnregisterForAllKeys()
	
	RegisterForKey(getInfoKey)
	
	;Experimental NPC muscle gain
	RegisterForKey(npcMuscleKey);K
EndFunction

Function SetNodeScale(Actor akActor, bool isFemale, string nodeName, float value, string modkey) global
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

Function addWerewolfBuild()
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
			
			WeightMorphsMCM WMCM = Game.GetFormFromFile(0x05000888, "WeightMorphs.esp") As WeightMorphsMCM
			If WMCM.WMorphs.Weight < 0.075
				If WMCM.WMorphs.Weight + modFactor > 0.075
					modFactor = 0.075 - WMCM.WMorphs.Weight
				EndIf
				WMCM.WMorphs.ChangeWeight(modFactor, true)
			ElseIf WMCM.WMorphs.Weight > 0.075
				modFactor = -modFactor
				If WMCM.WMorphs.Weight + modFactor < 0.075
					modFactor = -(WMCM.WMorphs.Weight - 0.075)
				EndIf
				
				WMCM.WMorphs.ChangeWeight(modFactor, true)
			EndIf
		EndIf
	EndIf
EndFunction

;TLALOC- NPC Related functions
Function applyNPCMuscle()
	Debug.Trace("SNU - Refreshing NPC muscle")
	
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
		Debug.Trace("SNU - Checking muscle on actor: "+currentActor.GetBaseObject().getName()+", Score: "+muscleScoreNPC)
		
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
			If currentActor && currentActor.is3dloaded() && muscleScoreNPC != 0
				String skinOverride = NiOverride.GetSkinOverrideString(currentActor, true, false, 0x04, 9, 1)
				Debug.Notification("Restoring normals to "+currentActor.GetBaseObject().getName())
				Debug.Trace("SNU - Restoring normals to "+currentActor.GetBaseObject().getName()+": "+skinOverride)
				If skinOverride == ""
					SnusnuMusclePowerNPCScript.forceSwitchMuscleNormals(currentActor, muscleScoreNPC * 100)
				Else
					NiOverride.AddSkinOverrideString(currentActor, true, false, 0x04, 9, 1, skinOverride, true)
				EndIf
				NiOverride.ApplySkinOverrides(currentActor)
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
	int[] tempMorphsArray = IntListToArray(PlayerRef, SNUSNU_KEY)
	If !JsonUtil.IntListCopy(fileName, "MainMorphs", tempMorphsArray)
		Debug.Trace("SNU - ERROR: Morphs array could not be saved!!")
		Return false
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
		If !IntListCopy(PlayerRef, SNUSNU_KEY, tempMorphsArray)
			Debug.Trace("SNU - ERROR: Morphs array could not be loaded!!")
			Return false
		EndIf
		
		NiOverride.ClearBodyMorphKeys(PlayerRef, SNUSNU_KEY)
		
		cbbeValues = JsonUtil.FloatListToArray(fileName, "CBBEMorphs")
		uunpValues = JsonUtil.FloatListToArray(fileName, "UUNPMorphs")
		bhunpValues = JsonUtil.FloatListToArray(fileName, "BHUNPMorphs")
		cbbeSEValues = JsonUtil.FloatListToArray(fileName, "CBBESEMorphs")
		cbbe3BAValues = JsonUtil.FloatListToArray(fileName, "3BAMorphs")
		
		bonesValues = JsonUtil.FloatListToArray(fileName, "BoneMorphs")
		maleValues = JsonUtil.FloatListToArray(fileName, "MaleMorphs")
		
		cleanupCurrentMorphsList(false) ;ToDo- Will this be always needed?
		
		UpdateWeight(true)
	Else
		Debug.Trace("SNU - ERROR: Morphs array could not be loaded!!")
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
EndFunction
