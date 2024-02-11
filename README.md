<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   IMPORTANT  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Please keep in mind that every time Skyrim gets an update all the base mods our mods depend on also need to be updated, especially SKSE and PapyrusUtil, which this mod heavily relies on.

You can keep track of which mods are compatible with the latest version of Skyrim SE in this site:

https://modding.wiki/en/skyrim/users/skse-plugins

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


For the Skyrim LE version of this mod go here (Not up to date, not planning to update it for now):
https://www.nexusmods.com/skyrim/mods/108978



Please consider visiting my Patreon page if you like the kind of mods i make and want to help me continue making them:





WHY
A few years ago I started messing with papyrus to automate the process of switching to muscular normal maps for my character every time I wanted for her to look more buff because of a roleplay narrative I was into. Then I started using WeightMorphs to organically change my character's look based on her diet, and not soon after I realized I could upgrade WeightMorphs to do the muscular normal switching and also to apply more muscular body shapes, thus the idea for this mod was born. When I asked ousnius for permission to release my mod as an upgrade of his, he recommended me to instead make it stand-alone so to avoid having conflicts in the event his mod would get an update, so I got to build everything from the ground up, taking as a reference the workings of WeightMorphs and adding everything I had already done into it.


WHAT EXACTLY DOES THIS DO
This is mostly a muscle training mod similar to Pumping Iron and the like, but as i stated before, my mod is more focused on the visual and roleplaying aspect, which means that the changes on your character are not a one time event linked to your skills, but instead it fluctuates overtime depending on your activities and (if your have WeightMorphs installed) you diet. The speed in which the changes take place can be configured to your liking,

Currently the actions that will add muscle mass are: using bows, one and two handed weapons, fighting and sprinting while using heavy armor, using workbenches and forges, mining, chopping wood and swimming.

Finally, some of the muscle mass your character looses can be regained while sleeping, only if he/she sleeps on regular intervals and is getting preferably 8 hours of sleep.

It is important to note that because this is a mod focused on visuals, it is script heavy and can be very taxing to your system and therefore it is not recommended if have a low end computer.




This is how the different values work for the mod to change the look of your character:

muscle Score: is the main value to track how muscular you character is. 0 means you character has no muscle mass, 1000 means your character has reached the maximum muscle mass allowed in this mod (we need to set a limit, otherwise the body will start to look very weird, specially if you are using any of the UUNP full body morphs)

maximum Muscle Score: How much it takes for your character to reach peak muscle mass. Default is 1000 which will allow your character to grow fairy quickly, but for roleplay purposes i would recommend something around 4000 or even 5000. That way the changes will be more gradual and realistic.

normals Score: This is mainly to separate muscle mass and muscle definition. The body shape of your character is defined by muscleScore, but the muscle definition (normal map) is tracked by normalsScore so that your character will show very defined muscles only if certain conditions are met, like if they just exercised or depending on WeightMorphs's weight (muscle definition will be low if weight is high, and high if weight is low). This allows for your character to have an "off season" look if they have high muscle score but have not exercised lately or have a high WeightMorphs's weight, or a "bodybuilder" look if they have a high muscle score, did exercise lately and WeightMorphs's weight is low enough.

stored Muscle: is how much muscle mass your character lost since the last time they slept and it will be recovered when she sleeps again. You can modify the rate in which your character looses muscle mass by changing the "Muscle Loss Factor" value.




Also, the MCM menu allows you to configure almost everything in this mod:
Add a Combat Proficiency modifier depending on muscle mass. You will get several skill buffs if your muscle score is on the upper half, and will get a debuff if your score is below half of your maximum muscle score. The skills affected by this option are: One Handed, Two Handed, Archery and Block. The recommended value for this option is 20, or 50 if you want a more immersive experience.
Add a Movement Speed modifier. Recommended value is 10. Your character will move faster the more muscular she gets.
Add a Stamina modifier. Recommended value: 40. Stamina regeneration will be quicker the more muscular your character is.
Muscle loss Factor: Change the speed rate of muscular degradation. How fast your character looses muscle mass. This is a constant effect and the only way to avoid loosing too much muscle mass is to keep exercising ;)
Fighting Gain Factor: Change how much muscle is gained by using weapons.
Heavy Armor Gain Factor: Change how much muscle is gained by using heavy armor.
Other activities Gain Factor: Change how much muscle is gained by performing other activities (mining, chopping wood and swimming).
You can also configure your maximum muscle score, depending on how fast/slowly you want your character's body to change.
Define a key shortcut to show your current muscular score and other relevant values.

There are also more options added in the latest version (v3.0):
Hardcore Mode: This one is more focused in the roleplaying aspect. It will limit your movement speed if the sum of the weight of what your character has equipped exceeds your character's muscle score. For example if your character has low muscle score they probably will not be able to use two handed or even any kind of weapon at all, but if they have a high muscle score they could go around with a full set of heavy armor and a Dragon Bone War Hammer with no issues.
Current body installed: In order for the configuration menu to only show you the most relevant morphs, you need to specify which body replacer mod you are currently using. This mod currently has support for UUNP/BHUNP, CBBE and derivatives, and Vanilla (No body mod installed).
Load default morphs: This will set all body morphs depending on a profile of you choice. Keep in mind that you will loose all morph changes you have made. Current options are UUNP, CBBE SE and CBBE SE Pecs, which will put more emphasis on the pectoral area instead of the more feminine breasts shape.
Disable Normals Switching: You can disable the custom normals used by this mod if you have issues or if you don't like how they look.
Boost carry weight: Your character will be able to carry more stuff depending on their current muscle score. The value you choose in this option will be the maximum carry weight boost you can get if your character reaches maximum muscle score.
Zero all sliders: If you want to build your own muscular body shape you can set all morph sliders to zero so you can start from the ground up instead to having to modify everything by hand before you can start.
Default slider values: This will wipe out all changes you may have made to the slider morphs and will revert them to their initial default muscular body shape.
Malnourishment: With this option enabled your character will barely get any muscular grow if their weight is below this value. You need WeightMorphs installed for this to work. This mechanic was created to make emphasis on the importance of your character to be well fed in order to be able to grow muscle mass.
NPC Custom Muscle: Now you can make any female character permanently more muscular. First check how muscular you want them to be with this option, then press the key 'K' while looking at them to apply the changes. If you do this when they already have changes applied to them, then they will be reset back to their original body shape. If you press the 'K' key while not targeting anyone, all characters currently loaded with changes in them will get their changes reapplied; this is to fix a nioverride issue where the custom normal maps sometimes are not applied correctly on NPCs.



ADDITIONAL FMG (Female Muscle Grow) SPELL
This mode also includes several spells that will buff your character to extreme levels. It will not only make her look very muscular, but will also boost several things to make you feel your character have really turned into a muscular powerhouse. Her jumping height will be higher, speed, stamina and weapons damage will be greatly improved, and unarmed damage will be very destructive (currently fixed at 150 pts of damage).

You can actually get 3 different spells, two for your character and one for female NPCs. The ones for your character are almost the same, with the only difference being how much time they will last (3 real time minutes for one and 1 hour for the other). The spell for NPCs will instead be permanent and if you cast it on the same character a second time it will completely remove the transformation. You can get the spells from any general spell seller, or you can use AddItemMenu.

This feature also has it's own MCM configurable options. You can choose to play a transformation sound, play a special animation while transforming, apply alternate animations while transformed (idle, walk, run and sprint), and use an alternate muscular head mesh.

Also, this feature is exclusive for female characters, at least until I add support for male body morphs.

Another important thing to note is that Bodyslide tri morphs files are needed for this to look like in my video showcase. Right now it only works with UUNP/BHUNP/CBBE SE, so with any other body with no support for BodySlide the transformation will not have any visible changes on the bodies of your victims.


MORE STUFF THAT WILL PROBABLY BE ADDED IN THE FUTURE
I already have several ideas to improve the mod, but due to lack of time and the complexity of some of those I prefer to leave them for future versions.
Option to configure the shape of the FMG transformation (This one has been requested several times so it might be the next feature i add in the next version).
Make the FMG spell compatible with males (need support for male body morphs, should not be too difficult as the logic to do it is already there).
Implement an alternative for texture switching by using overlays (already did it but it is very buggy so I need to fix it first).
Support for Dynamic Animation Replacer (I don't use it so I don't know how to do it yet). Already implemented!
Add a MCM page to show the NPCs currently affected by the FMG spell (Should not be too difficult, maybe in the next version).
Add an option to set all sliders to 0 so you can apply your own morph settings (great if you only want your character to use the UNP-SH body or something like that).   Already implemented!
Include patches for other mods to add to the muscle score, like PoserHotkeys, GSPoses and Immersive Animated Poses III (I lost the original files on a disk crash i got a while ago, so i deed to reimplement it and then get the proper permissions). 
Add a body shape placeholder to use alternate body meshes for the FMG spells (You could add TBD or similar body meshes)(This one should not be too difficult to implement, maybe in the next version).
Add muscle training mechanics to NPCs (This one is a very complex change and might leave it on pause only after i finish the other pending changes).
Include an alternate textures pack using Halofarm's abs layers with support of CBBE (Already did some tests and it looks very doable. Still it is very time consuming so i will leave it of future versions). Support for CBBE has been fully added!
Add an option to boost carry weight depending on muscle score (Another requested feature. I actually wanted to add this in the first release but ended ditching it due to time limitations. Should not be too difficult to implement, just a little time consuming). Already implemented!
Add option to load/save morphs into a file (Most of the logic is there so the only thing left to do is choose which file management framework i should use: <FISS> or <JSON Manager>).
Add a complete list of bone morphs so you can add custom changes to vanilla bodies. This one would probably be very time consuming and problematic because it heavily depends on the skeleton you have installed. XPMSE skeletons need special code to manage them so i could only have support for them or for vanilla, but not for both.


REQUIEREMENTS
SKSE
SkyUI
RaceMenu Or NiOverride
PapyrusUtil
XPMSE


OPTIONAL REQUIEREMENTS
BodySlide: You'll need to generate the tri files for all your BodySlide bodies and outfits ONLY if you are using a BodySlide supported body shape. This mod has support for both BodySlide morphs and vanilla weight slider, making it fully compatible with both male and female characters and any type of body replacers. Using BodySlide has the benefit of changing the body of your character inside the game without having to install different body replacers everytime you want your character to look different, and also to make her look buffed without making all other females in the game also buffed. And as i mentioned before, this is a hard requierment for the FMG transformation feature.
WeightMorphs: This mod was originally made around WeightMorphs, so some of it's features will work better with WeightMorps installed. This mod will chande the textures of your character depending on WeightMorphs's weight. If WeightMorphs's weight is above 0.3, softer looking textures will be used. If weight is below -0.3, more ripped looking textures will be used. Since version 1.2 came out you will need to download the WeightMorphs patch included in the optional files section to add back support for WeightMorphs.


INSTALLATION
Use the mod manager of your preference or just extract everything in your Skyrim folder. Load order should not matter.

UNINSTALATION
Just uncheck the Enabled option in the main MCM page and the mod will remove/reset any changes made to your character. If you have NPCs currently transformed you need to cast the FMG spell on them again to remove the transformation. After that you can remove the mod.


COMPATIBILITY
This mod should be compatible with almost everything, but you might need to deactivate some features depending on your load order. For example, if you have any mod that changes the textures depending on character's weight (eg. CBBE Muscle Solution), you will need to deactivate the texture switching option for this mod in the MCM. 

This mod is compatible with all body shapes, but only includes normal textures for UNP based bodies. There is an optional patch for CBBE bodies in the files page, but it is only intended for the muscle training part of the mod. The FMG transformation spell is only compatible with UUNP based bodies at the moment. Normal texture switching is also not compatible with male characters (i don't even know if there are resources for male characters with different levels of buffedness)




FAQ
Q: Does this mod supports male characters?
A: Yes, but only for the muscle training feature. the FMG spells only work for female characters at the moment.

Q: Will this work on custom body types?
A: Yes. I'm also planning to add more Bone Morphs for maximum customization. This mod has full support for UNP based BodySlide supported bodies (CBBE, UUNP and BHUNP). The FMG feature will only work with UUNP based bodies though (UUNP and BHUNP).

Q: Why would I want this?
A: I created this to have a visual reward on all the time my character spends on fighting and doing general physical activities, so it is for immersion I guess. It is weird when a very skinny looking character can overpower a half a ton bear. This mod makes it so that a character that looks skinny and with no muscle development is proportionally weak, and vice-versa.



DISCLAIMER: As you may have noticed I was inspired by Pumping Iron's description page to do mine. In no way I claim my mod to be better than others who do the same kind of thing. I am just trying a different approach and I encourage everyone to try other similar mods and see which one better fits their needs. That being said, I feel like my mod is a bit heavier on the resources side, so if you have a powerful machine you are more than welcome to try my mod, but if your PC is not that powerful then I recommend for you to try other alternatives. Also my English is very shitty due to not being my native language, sorry for that.


CREDITS
ousnius: For giving me permission to use his WeightMorphs mod as base to make mine.
MoonBeast-AR: For letting me use one of her amazing TF audio clips.
Tigersan: For his amazing Diesel normal map which at this point is the base for most of the other muscular normal maps you will find on the nexus.
The Internet: I downloaded the splash image for the MCM from a random stock image site. If this image is yours and you don't want me to use please contact me and i will immediatly remove it.
Caliente: This mod includes a HDT presset bassed on Caliente's CBBE mod.
Halofarm: The alternate textures package uses an ABS normal map originally from HalosOverlays package.
Pancakes22: I got the idea to boost the unarmed damage value from his Unarmed Damage Enhancements mod.
ojanen: Thanks for his PSQ mod because from it I got the inspiration and the knowledge to create the FMG feature on this mod. The knowledge to implement all the buffs and debuffs on my mod also come from PSQ.
