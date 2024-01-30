An immersive muscle training alternative (with a FMG feature as a bonus)

WHY
A few years ago I started messing with papyrus to automate the process of switching to muscular normal maps for my character every time I wanted for her to look more buff because of a roleplay narrative I was into. Then I started using WeightMorphs to organically change my character's look based on her diet, and not soon after I realized I could upgrade WeightMorphs to do the muscular normal switching and also to apply more muscular body shapes, thus the idea for this mod was born. When I asked ousnius for permission to release my mod as an upgrade of his, he recommended me to instead make it stand-alone so to avoid having conflicts in the event his mod would get an update, so I got to build everything from the ground up, taking as a reference the workings of WeightMorphs and adding everything I had already done into it.



WHAT EXACTLY DOES THIS DO
This is mostly a muscle training mod similar to Pumping Iron and the like, the main difference being that your character will gain muscle mass by doing stuff that would require physical strength to accomplish, regardless of the skill level he/she has. This hopefully makes growing muscle an organic experience: Keep using short ranged weapons and after a few in-game days you'll se your character starting to buff out. Stop doing any kind of physical actions and your character will begin to loose muscle mass.

Currently the actions that will add muscle mass are: using one and two handed weapons, fighting and sprinting while using heavy armor, mining, chopping wood and swimming.

Finally, some of the muscle mass your character looses can be regained while sleeping, only if he/she sleeps on regular intervals and is getting preferably 8 hours of sleep.

Also, the MCM menu allows you to configure almost everything in this mod:
- Add a Combat Proficiency modifier modifier depending on muscle mass. You will get several skill buffs if your muscle score is on the upper half, and will get a debuff if your score is below half of your maximum muscle score. The skills affected by this option are: One Handed, Two Handed, Archery and Block. The recommended value for this option is 20.
- Add a Speed modifier. Recommended value is 10
- Add a Stamina modifier. Recommended value: 40
- Change the speed rate of muscular degradation.
- Change how much muscle is gained by using weapons.
- Change how much muscle is gained by using heavy armor.
- Change how much muscle is gained by performing other activities (mining, chopping wood and swimming).
- You can also configure your maximum muscle score, depending on how fast/slowly you want your character's body to change.
- Define a key shortcut to show your current muscular score and other relevant values.



ADDITIONAL FMG (Female Muscle Grow) SPELL
This mode also includes several spells that will buff your character to extreme levels. It will not only make her look very muscular, but will also boost several things to make you feel your character have really turned into a muscular powerhouse. Her jumping height will be higher, speed, stamina and weapons damage will be greatly improved, and unarmed damage will be very destructive (currently fixed at 150 pts of damage).

You can actually get 3 different spells, two for your character and one for female NPCs. The ones for your character are almost the same, with the only difference being how much time they will last (3 real time minutes for one and 1 hour for the other). The spell for NPCs will instead be permanent and if you cast it on the same character a second time it will completely remove the transformation.

This feature also has it's own MCM configurable options. You can choose to play a transformation sound, play a special animation while transforming, apply alternate animations while transformed (idle, walk, run and sprint), and use an alternate muscular head mesh.

Also, this feature is exclusive for female characters, at least until I add support for male body morphs.




MORE STUFF THAT WILL PROBABLY BE ADDED IN THE FUTURE
I already have several ideas to improve the mod, but due to lack of time and the complexity of some of those I prefer to leave them for future versions.
- Option to configure the shape of the FMG transformation.
- Make the FMG spell compatible with males (need support for male body morphs).
- Implement an alternative for texture switching by using overlays (already did it but it is very buggy so I need to fix it first)
- Support for Dynamic Animation Replacer (I don't use it so I don't know how to do it yet).


REQUIEREMENTS
SKSE
SkyUI
RaceMenu Or NiOverride
PapyrusUtil
XPMSE


OPTIONAL REQUIEREMENTS
- BodySlide: You'll need to generate the tri files for all your BodySlide bodies and outfits. This mod has support for both BodySlide morphs and vanilla weight slider, making it fully compatible with both male and female characters and any type of body replacers. Using BodySlide has the benefit of changing the body of your character inside the game without having to install different body replacers everytime you want your character to look different, and also to make her look buffed without making all other females in the game also buffed.
- WeightMorphs: This mod was originally made around WeightMorphs, so some of it's features will work better with WeightMorps installed. This mod will chande the textures of your character depending on WeightMorphs's weight. If WeightMorphs's weight is above 0.3, softer looking textures will be used. If weight is below -0.3, more ripped looking textures will be used.
- Transformation animations: If you want your character to move like on the video showcase, you'll need to get the animation files from Realistic Animation Project?. Extract the file "FT-Idle3(male).hkx" and rename it as "snu0_mt_idle.hkx". Unfortunately I don't remember where I got the other one. I will update this as soon as I find out where I got it.

INSTALLATION
Use the mod manager of your preference or just extract everything in your Skyrim folder. Load order should not matter.


COMPATIBILITY
This mod should be compatible with everything, but you might need to deactivate some features depending on your load order. For example, if you have any mod that changes the textures depending on character's weight (eg. CBBE Muscle Solution), you will need to deactivate the texture switching option in the MCM. 

This mod is compatible with all body shapes, but only includes normal textures for UNP based bodies. If you are using CBBE or similar you can use a mod like Fitness Body to create your own normal maps. Normal texture switching is also not compatible with male characters (i don't even know if there are resources for male characters with different levels of buffedness)




FAQ
Q: Does this mod supports male characters?
A: Yes, but only for the muscle training feature. the FMG spells only work for female characters at the moment.

Q: Will this work on custom body types?
A: Yes. I'm also planning on adding more Bone Morphs for maximum customization. This mod has full support for UNP based BodySlide supported bodies (CBBE, UUNP and BHUNP).

Q: Why would I want this?
A: I created this to have a visual reward on all the time my character spends on fighting and doing general physical activities, so it is for immersion I guess. It is weird when a very skinny looking character can overpower a half a ton bear. This mod makes it so that a character that looks skinny and with no muscle development is proportionally weak, and vice-versa.

Q: Does this effect the character in any way other than size? Can he hit harder?
A: Yes, stamina, speed, and damage with one handed, two handed, bows and shields will be affected by your character's muscle score, depending on the values you set in the MCM menu (Stamina Modifier, Movement Speed Modifier and Combat Proficiency Modifier).

Q: Can you make female characters who gain muscle actually lose body fat (and breast size)?
A: No, but if you have WeightMorphs installed it will work like that.



DISCLAIMER: As you may have noticed I was inspired by Pumping Iron's description page to do mine. In no way I claim my mod to be better than others who do the same kind of thing. I am just trying a different approach and I encourage everyone to try other similar mods and see which one better fits their needs. That being said, I feel like my mod is a bit heavier on the resources side, so if you have a powerful machine you are more than welcome to try my mod, but if your PC is not that powerful then I recommend for you to try other alternatives. Also my English is very shitty due to not being my native language, sorry for that.

CREDITS
ousnius: For giving me permission to use his WeightMorphs mod as base to make mine.
MoonBeast-AR: For letting me use one of her amazing TF audio clips.
Tigersan: For his amazing Diesel normal map which at this point is the base for most of the other muscular normal maps you will find on the nexus.
The Internet: I downloaded the splash image for the MCM from a random stock image site. If this image is yours and you don't want me to use please contact me and i will immediatly remove it.
Caliente: This mod includes a HDT presset bassed on Caliente's CBBE mod.
Halofarm: The alternate textures package uses an ABS normal map originally from HalosOverlays package.
Pancakes22: I got the idea to boost the unarmed damage value from his Unarmed Damage Enhancements mod.
ojanen: Thanks for his PSQ mod because from it i got the inspiration and the knowledge to create the FMG feature on this mod. The knowledge to implement all the buffs and debuffs on my mod come from PSQ.


VERSION HISTORY

1.0 - Initial Release

1.2 - Removed all WeightMorphs references and moved them to a patch.
    - Fixed Enabled option not being updated correctly in the MCM menu when using male characters.
    
2.0 - Renamed MCM moprh page names to be more clear on what they include.
    - Added support for new CBBE SE (only had support of Oldrim CBBE which was carried from that version of this mod)
    - Added option to select the body shape being used and added logic to show only the sliders relevant only to the body shape currently selected.
    - Fixed muscular head mesh texture paths.
    - Reworked sleep bonus calculations.
    - (WeightMorphs patch only) Added situation where muscle will grow very slowly if character is too skinny (WeightMorphs's Weight = -1.0)
    - Fixed incorrect default settings for male characters.
    - Added more info to the description of several MCM options.
    - Added option to set all sliders values to 0 (useful if you want to create your own muscular body shape from the ground up. Keep in mind this will also reset the bone morphs)
    - Added text message to inform the user of the need to set the Vanilla Weight slider option on if needed.
    
