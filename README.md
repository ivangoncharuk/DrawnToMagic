# Drawn To Magic

- [Description 💬](#description)
- [Game screenshots 🎮](#game-screenshots)
- [Glyph Recognizer v1 📷](#glyph-recognizer-v1)
- [TODO Items 📝](#todo-items)
- [Spellcasting Glyph System ✨](#spellcasting-glyph-system)
    - [Layer 1: Basic Elements 🔴🔵❄️⚡️](#layer-1-basic-elements)
    - [Layer 2: Spell Types 🔪🌐🛡️💊](#layer-2-spell-types)
    - [Layer 3: Modifiers 💪📏🏃‍♂️⌛](#layer-3-modifiers)
    - [Layer 4: Status Effects 🐢🤐🌀💔](#layer-4-status-effects)
    - [Additional Basic Elements 🌿🔮](#additional-basic-elements)
- [Additional features and gameplay mechanics 🚀](#additional-features-and-gameplay-mechanics)
- [Environmental Interactions 💧](#environmental-interactions)
- [Time-limited Glyphs ⌛](#time-limited-glyphs)
- [Cooperative Spellcasting 👥](#cooperative-spellcasting)
- [Glyph Evolution 🌟](#glyph-evolution)
- [Spellcasting Challenges 🏆](#spellcasting-challenges)
- [Glyph Mastery 🔝](#glyph-mastery)
- [Elemental Affinities 🔥🌪️❄️⚡️](#elemental-affinities)
- [Hidden Glyphs 🔒](#hidden-glyphs)
- [Glyph Customization 💅](#glyph-customization)



# Description

Drawn to Magic is an open-world RPG that allows you to interact with the world through gestures. The game's primary focus is create a fun environment where you can play the game for hours exploring the world.

Interact with a diverse cast of characters ranging from friendly allies to hostile enemies and influence their behavior and attitude towards you. The unique gesture-based spellcasting system requires skill and timing [(#1)](/../../issues/1), adding an extra layer of excitement and challenge to the gameplay. Discover and collect a wide range of items, from weapons and armor to potions and scrolls, and use them to enhance your performance and appearance.

Embark on quests, sell items, or perform services for others to earn money and unlock new perks and upgrades as you level up your character. Additionally, you can build your own home or base where you can store your belongings, craft items, and rest.

------------------------------------------------------------------------

[Back to Top](#drawn-to-magic)
# Game screenshots:

## Glyph Recognizer v1
This is the first iteration of the glyph recognition system. I caught it working and managed to record it, but it is often times confused.

![](https://github.com/ivangoncharuk/DrawnToMagic/blob/main/drawing_glyph_screencapture.gif)

---

[Back to Top](#drawn-to-magic)
# TODO Items:

*Note: These are ideas from brainstorming. Items that are bolded or linked to an issue will be implemented.*

-   Create Elemental Magic System
    -   [ ] Define strengths and weaknesses of each element
    -   [ ] Create new effects by combining elements
    -   [ ] Add elemental enemies and environments
-   Implement Skill Tree
    -   [ ] Include branches like offensive, defensive, supportive, and utility, for example
        -   Each branch has unique perks and drawbacks
    -   [ ] Unlock new skills through quests or finding items
-   Integrate Crafting System
    -   [ ] Craft potions, scrolls, weapons, and armor
    -   [ ] Gather ingredients from shops, enemies, or environment
    -   [ ] Create different effects with different recipes
    -   [ ] Forge weapons and armor with varying attributes and bonuses
-   Develop Quest System
    -   [ ] Find quests from NPCs, bulletin boards, letters, or events
    -   [ ] Main story quests advance plot and unlock new areas
    -   [ ] Side quests offer extra content and benefits
    -   [ ] Repeatable quests provide money or items by doing simple tasks
    -   [ ] Hidden quests require exploration or talking to people
-   [Implement Glyph Drawing Mechanic](/../../issues/1)
    -   [x] [Allow players to draw glyphs on the screen](/../../issues/2)
    -   [ ] Add a feature to create your own
    -   [x] **Use the q dollar gesture recognition algorithm**
-   Create Game World
    -   [ ] Design a world for the game to take place in
    -   [ ] Create NPCs and enemies for the player to interact with
    -   [ ] Populate the world with quests and events
    -   [ ] Design environments for each area with unique elements and obstacles

------------------------------------------------------------------------

# Spellcasting Glyph System

The spellcasting system is based on a combination of symbols inspired by Japanese kanji, Nordic runes, and Chinese characters. The system consists of three layers of complexity, providing a skill ceiling for players to master as they progress through the game.

## Layer 1: Basic Elements

In the first layer, players will learn the basic elements of spellcasting. These basic elements are:

- `Luminance ✨ - 光` (inspired by the Chinese character for "light")
- `Umbrance 🌑 - 陰` (inspired by the Chinese character for "shadow")
- `Cryomancy ❄️ - 冰` (inspired by the Chinese character for "ice")
- `Electromancy ⚡ - 電` (inspired by the Chinese character for "electricity")

## Layer 2: Spell Types

The second layer introduces different spell types. Players can combine these with the basic elements to create more powerful spells:

- `Projectile 🏹 - ㄖ` (Inspired by the Chinese character 射)
- `Area of Effect (AoE) 🌐 - ᛟ` (Inspired by the Nordic rune for "Othala")
- `Shield 🛡️ - ㄱ` (Inspired by the Korean character 기)
- `Healing 💊 - 医` (Inspired by the Japanese kanji for "medicine")

To combine a basic element with a spell type, players need to draw the corresponding symbols connected or overlapping each other. 
For example, drawing the `luminance symbol 光` followed by the `projectile symbol ㄖ` will create a `luminance projectile ✨🏹` spell.

## Layer 3: Modifiers

The third layer introduces modifiers that can be added to the spells created using the basic elements and spell types. These modifiers will enhance the spell's effects or add additional properties:

- `Power 💪 - 力` (Inspired by the Chinese character for "strength")
- `Range 📏 - ᚱ` (Inspired by the Nordic rune for "Raido")
- `Speed 🏃‍♂️ - ㅅ` (Inspired by the Korean character 속)
- `Duration ⌛ - 時` (Inspired by the Japanese kanji for "time")

To add a modifier to a spell, players need to draw the corresponding symbol connected to the previous two symbols. 
For example, drawing the luminance symbol 光, the projectile symbol ㄖ, and the power symbol 力 will create a powerful luminance projectile 💪✨🏹 spell.

## Examples of Spell Combinations

- `Luminance AoE ✨🌐`
    - `光 + ᛟ = ✨🌐`
        - An area-of-effect luminance spell that blinds and disorients enemies.
- `Umbrance Shield 🌑🛡️`
    - `陰 + ㄱ = 🌑🛡️`
        - A shadow-based shield that absorbs damage and can potentially heal the caster.
- `Cryomancy Healing ❄️💊`
    - `冰 + 医 = ❄️💊`
        - An ice-based healing spell that restores health to the caster or allies while providing temporary damage resistance.
- `Electromancy Projectile with Increased Range ⚡🏹📏`
    - `電 + ㄖ + ᚱ = ⚡🏹📏`
        - An extended-range electromancy projectile that shocks and stuns enemies from a distance.

By using this system, players can create a wide variety of spells by combining and layering elements, spell types, and modifiers. This allows for creative experimentation and rewards skillful drawing of the symbols.

Balancing the game for player duels can be achieved by giving each element a strength and weakness against the others. This encourages players to strategize and adapt to their opponents' choices:

- `Luminance ✨` is strong against `Umbrance 🌑`
    but weak against `Electromancy ⚡`.
- `Umbrance 🌑` is strong against `Luminance ✨` 
    but weak against `Cryomancy ❄️`.
- `Cryomancy ❄️` is strong against `Umbrance 🌑` 
    but weak against `Electromancy ⚡`.
- `Electromancy ⚡` is strong against `Luminance ✨` and `Cryomancy ❄️` 
    but is less effective against `Umbrance 🌑`.

The system's simplicity ensures that players can learn the basics quickly, while the wide range of spell combinations provides depth and complexity for advanced players. Duels will be exciting and unpredictable, as players must anticipate and adapt to their opponents' strategies.

## Layer 4: Status Effects
The fourth layer introduces status effects that can be added to spells to create additional strategic options during duels. These status effects will change the target's condition or the battlefield:

- `Slow 🐢 - 鈍` (Inspired by the Chinese character for "slow")
- `Silence 🤐 - 無` (Inspired by the Japanese kanji for "nothingness")
- `Confuse 🌀 - 乱` (Inspired by the Chinese character for "chaos")
- `Weaken 💔 - 弱` (Inspired by the Japanese kanji for "weak")

To add a status effect to a spell, players need to draw the corresponding symbol connected to the previous symbols. 

For example, drawing the luminance symbol 光, the projectile symbol ㄖ, and the slow symbol 鈍
will create a luminance projectile that slows the target ✨🏹🐢.

## Additional Basic Elements

The following basic elements are added to increase the variety of elemental interactions and strategic possibilities (possibly later in the game, or paid version):

- `Biomancy 🌿 - 生` (Inspired by the Chinese character for "life")
- `Pyromancy 🔮 - 炎` (Inspired by the Chinese character for "flame")

These elements introduce new strengths and weaknesses:

- `Biomancy 🌿` is strong against `Cryomancy ❄️` but weak against `Pyromancy 🔮`.
- `Pyromancy 🔮` is strong against `Biomancy 🌿` but weak against `Cryomancy ❄️`.

## Examples of New Spell Combinations

Umbrance AoE with Confusion
- `陰 + ᛟ + 乱 = 🌑🌐🌀`
- An area-of-effect umbrance spell that engulfs enemies in darkness and confuses them, causing them to attack each other or wander aimlessly.
Electromancy Shield with Silence ⚡🛡️🤐

Electromancy Shield with Silence
- `電 + ㄱ + 無 = ⚡🛡️🤐`
- An electromancy-based shield that not only protects the caster but also silences nearby enemies, preventing them from casting spells for a short duration.

Biomancy Healing with Weaken
- `生 + 医 + 弱 = 🌿💊💔`
- A biomancy-based healing spell that restores health to the caster or allies and weakens enemies within its range, reducing their damage output.
By expanding the system with additional elements, status effects, and more strategic options, players will have even more opportunities to experiment and discover new, powerful spell combinations. The complexity and depth of the system will continue to grow, allowing players to develop advanced strategies and tactics during duels.

---

# Additional features and gameplay mechanics

## Environmental Interactions

the [Spellcasting Glyph System](#spellcasting-glyph system) can incorporate glyphs that interact with the environment in various ways, creating more strategic depth and interesting gameplay opportunities.

- `Water Manipulation 💧🌀 - 水` (Inspired by the Chinese character for "water")

This glyph can be used to control water, with the following possible effects:

- Extinguish fires
- Create temporary bridges
- Solve puzzles

Example: 
- `Water Manipulation AoE 💧🌐`
    - `水 + ᛟ = 💧🌐`

By drawing this combination, players can manipulate a large area of water for a short period, allowing them to solve environmental challenges and progress through the game world.



## Time-limited Glyphs

Introducing temporary, powerful glyphs can add excitement and variety to gameplay. These glyphs can be acquired through quests, events, or rare drops and grant exceptional abilities for a limited time.

- `Invincibility 💠 - 無敵` (Inspired by the Japanese kanji for "invincibility")

Example: 
- `Invincibility AoE 💠🌐` 
    - `無敵 + ᛟ = 💠🌐`

This combination creates an area-of-effect invincibility shield that protects the caster and nearby allies for a short period. To maintain balance, the duration and usage of such glyphs should be limited.



## Cooperative Spellcasting

In a multiplayer setting, players can collaborate to create more powerful spells. They can combine different elements and spell types to produce unique and potent spell effects.

Example: 
- `Cryomancy AoE with Electromancy Projectile ❄️🌐⚡🏹` 
    - `冰 + ᛟ + 電 + ㄖ = ❄️🌐⚡🏹`

In this example, one player casts a cryomancy area-of-effect spell while another player casts an electromancy projectile. When combined, the resulting ice-lightning combo deals massive damage to enemies within the AoE.



## Glyph Evolution

As players progress and level up, their glyphs can evolve, increasing their potency and adding new abilities. A separate progression system based on glyph usage, specific items, or player choices can guide the development of glyphs.

Example: 
- `Advanced Biomancy Healing 🌿💊⭐` 
    - `生 + 医 + 星 = 🌿💊⭐`

This combination represents an evolved version of the basic biomancy healing glyph, which provides increased healing and additional effects.



## Spellcasting Challenges

Incorporating challenges that test players' skill in drawing glyphs can add an engaging and rewarding aspect to gameplay. These challenges can include time-limited tests, precision trials, and puzzles requiring specific glyph combinations.

Successfully completing these challenges can reward players with new glyphs, resources, or unique items.



## Glyph Mastery

A mastery system can be implemented to allow players to improve their proficiency with specific glyphs. As players become more skilled, they can reduce casting time, increase power, or add new effects to their spells.

Mastery can be achieved through repeated glyph usage or by completing glyph-related challenges.



## Elemental Affinities

The current system includes elemental strengths and weaknesses, which encourage strategic glyph usage in encounters with enemies and other players.



## Hidden Glyphs
Secret glyphs can be hidden throughout the game world, rewarding exploration and curiosity. These glyphs can have unique effects or grant access to hidden areas and content.

- `Portal Glyph 🌀🚪 - 门` (Inspired by the Chinese character for "door")

This hidden glyph can create temporary portals, allowing players to access secret areas or traverse the game world more quickly.

Example: 
- `Portal Glyph 🌀🚪` 
    - `门 + 🌀 = 🌀🚪`

By drawing this combination, players can create a portal to a previously visited location or a hidden area, encouraging exploration and discovery.



## Glyph Customization

Players can personalize their glyphs with cosmetic enhancements, fostering a sense of ownership and pride in their spellcasting abilities. These enhancements can include unique visual effects, colors, and animations.

Example: 
- `Customized Fire AoE 🔥💥🎨` 
    - `ㄈ + ᛟ + 色 = 🔥💥🎨`

This combination represents a fire AoE spell with a custom color, making the spell visually unique to the player who cast it.


## Summary

1. `光 - Luminance ✨` - Basic element for light-based spells

[Wiki](https://en.wiktionary.org/wiki/%E5%85%89)

<img src=https://user-images.githubusercontent.com/85744041/231459922-76debe66-6763-45f7-ba43-7d2eb942e983.png style="border-radius: 50%;" />

2. `陰 - Umbrance 🌑` - Basic element for shadow-based spells


3. `冰 - Cryomancy ❄️` - Basic element for ice-based spells

[Wiki](https://en.wiktionary.org/wiki/%E5%86%B0)

<img src=https://user-images.githubusercontent.com/85744041/231461850-f0a1038d-ec89-41d5-832d-250ab8adc317.png xxx style="border-radius: 50%;" />

4. `電 - Electromancy ⚡` - Basic element for electricity-based spells
5. `ㄖ - Projectile 🏹` - Spell type that creates projectile spells
6. `ᛟ - Area of Effect (AoE) 🌐` - Spell type that creates area-of-effect spells
7. `ㄱ - Shield 🛡️` - Spell type that creates shield spells
8. `医 - Healing 💊` - Spell type that creates healing spells
9. `力 - Power 💪` - Modifier that enhances spell strength
10. `ᚱ - Range 📏` - Modifier that increases spell range
11. `ㅅ - Speed 🏃‍♂️` - Modifier that increases spell speed
12. `時 - Duration ⌛` - Modifier that increases spell duration
13. `鈍 - Slow 🐢` - Status effect that slows the target
14. `無 - Silence 🤐` - Status effect that prevents target from casting spells
15. `乱 - Confuse 🌀` - Status effect that confuses the target
16. `弱 - Weaken 💔` - Status effect that weakens the target
17. `生 - Biomancy 🌿` - Basic element for life-based spells
18. `炎 - Pyromancy 🔥` - Basic element for fire-based spells
19. `水 - Water Manipulation 💧🌀` - Glyph that interacts with water in the environment
20. `無敵 - Invincibility 💠` - Time-limited glyph that grants invincibility
21. `门 - Portal Glyph 🌀🚪` - Hidden glyph that creates temporary portals
22. `ㄈ - Customized Fire AoE 🔥💥🎨` - Example of a glyph with cosmetic enhancement



`光, 陰, 冰, 電, ㄖ, ᛟ, ㄱ, 医, 力, ᚱ, ㅅ, 時, 鈍, 無, 乱, 弱, 生, 炎, 水, 無敵, 门, ㄈ`


## Inspirations for Glyphs

In addition to the previously mentioned inspirations
- Korean Characters
- Chinese Characters
- Japanese Kanji
- Nordic Runes
- Alchemical symbols 

I could possibly draw inspiration from
- Egyptian Hieroglyphics
- Mayan Glyphs
- Celtic Knots
- Sacred Geometry

---

