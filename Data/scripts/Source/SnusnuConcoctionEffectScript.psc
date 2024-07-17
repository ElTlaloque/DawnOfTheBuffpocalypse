Scriptname SnusnuConcoctionEffectScript extends ActiveMagicEffect  

;Concoction Types:
;1 = Improve muscle
;2 = Degrade muscle

Int Property concoctionType Auto
Snusnu Property snusnuMain Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	If concoctionType == 1
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 2
		
		If snusnuMain.concoctionModifier > 1.0
			Debug.Notification("I already feel stronger")
		EndIf
	ElseIf concoctionType == 2
		snusnuMain.concoctionModifier = snusnuMain.concoctionModifier * 0.5
		
		If snusnuMain.concoctionModifier < 1.0
			Debug.Notification("I feel my strength fading away")
		EndIf
		
	EndIf
	
	If snusnuMain.concoctionModifier == 1.0
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
	EndIf
	
	Debug.Trace("SNU - Ending concoction effect "+concoctionType+": "+snusnuMain.concoctionModifier)
EndEvent
