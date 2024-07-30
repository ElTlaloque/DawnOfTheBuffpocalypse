Scriptname SnusnuConcoctionEffectScript extends ActiveMagicEffect  

;Concoction Types:
;1 = Improve muscle
;2 = Degrade muscle
;3 = Improve muscle super
;4 = Degrade muscle super

Int Property concoctionType Auto
Snusnu Property snusnuMain Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	If StorageUtil.GetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 0) > 0
		Debug.Notification("The concoction has no effect...")
	EndIf
	
	If concoctionType == 1
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 2
		
		If snusnuMain.concoctionModifier > 1.0 && StorageUtil.GetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 0) == 0
			Debug.Notification("I already feel stronger")
		EndIf
	ElseIf concoctionType == 2
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 0.5
		
		If snusnuMain.concoctionModifier < 1.0 && StorageUtil.GetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 0) == 0
			Debug.Notification("I feel my strength slowly fading away")
		EndIf
	ElseIf concoctionType == 3
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 4
		
		If snusnuMain.concoctionModifier > 1.0 && StorageUtil.GetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 0) == 0
			Debug.Notification("I feel full of energy!")
		EndIf	
	ElseIf concoctionType == 4
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 0.25
		
		If snusnuMain.concoctionModifier < 1.0 && StorageUtil.GetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 0) == 0
			Debug.Notification("I feel my strength quickly fading away")
		EndIf
	EndIf
	
	If snusnuMain.concoctionModifier == 1.0 && StorageUtil.GetIntValue(snusnuMain.PlayerRef, "SNU_UltraMuscle", 0) == 0
		Debug.Notification("The concoction effects have cancelled each other...")
	EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	If concoctionType == 1
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 0.5
		Debug.Notification("The strenght concoction effects are fading away")
	ElseIf concoctionType == 2
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 2.0
		Debug.Notification("The weakness concoction effects are fading away")
	ElseIf concoctionType == 3
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 0.25
		Debug.Notification("The strenght concoction effects are fading away")
	ElseIf concoctionType == 4
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 4.0
		Debug.Notification("The weakness concoction effects are fading away")
	EndIf
	
	Debug.Trace("SNU - Ending concoction effect "+concoctionType+": "+snusnuMain.concoctionModifier)
EndEvent
