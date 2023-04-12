# Drawn To Magic

`I am Ivan Goncharuk, a junior studying computer science at Towson University, and I have been working on this project for a few weeks. Most of the ideas mentioned are still in the beginning stages.`

# Description

**"Drawn to Magic"** is an open-world RPG that uses a **gesture-based spellcasting system**. Players can spend countless hours exploring the game's world, encountering a diverse set of characters, and influencing their behavior and attitude. 

The unique gesture-based spellcasting system uses symbols inspired by nordic runes. By drawing these, players can cast spells, creating an engaging experience that requires precise skill and timing. The system is designed with the Dynamic Time Warping (DTW) algorithm, which allows for flexibility in how symbols are drawn while still accurately recognizing the intended spell.

The spellcasting system consists of four layers of complexity, providing a skill ceiling for players to master as they progress through the game:

- Basic Elements: Four elemental forces, each represented by a different rune.
- Spell Types: Players can combine basic elements with spell types to create more powerful spells.
- Modifiers: Enhance the spell's effects or add additional properties by connecting a modifier rune to the previous two runes.
- Status Effects: Create additional strategic options during duels by adding status effects to spells.

To balance the game for player duels, each element has a strength and weakness against the others, encouraging players to strategize and adapt to their opponents' choices.

The system's simplicity ensures that players can learn the basics quickly, while the wide range of spell combinations provides depth and complexity for advanced players. Duels will be exciting and unpredictable, as players must anticipate and adapt to their opponents' strategies.

As I continue to develop this game, I plan to expand the spellcasting system with additional elements, status effects, and more strategic options. The complexity and depth of the system will continue to grow, allowing players to develop advanced strategies and tactics during duels.

------------------------------------------------------------------------

[Back to top](#drawn-to-magic)
# Game screenshots:

## Glyph Recognizer v1
This is the first iteration of the glyph recognition system. I caught it working and managed to record it, but it is often times confused.

![](https://github.com/ivangoncharuk/DrawnToMagic/blob/main/drawing_glyph_screencapture.gif)

Added new buttons to save glyphs

![](https://github.com/ivangoncharuk/DrawnToMagic/blob/main/Screen%20Shot%202023-04-12%20at%202.22.30%20PM.png)

---

[Back to top](#drawn-to-magic)
# TODO Items:

*Note: These are ideas from brainstorming. Items that are bolded or linked to an issue will be implemented.*

-   Create Elemental Magic System
    -   [ ] Define strengths and weaknesses of each element
    -   [x] Create new effects by combining elements
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
    -   [ ] ~~Add a feature to create your own~~
    -   [x] **Use the q dollar gesture recognition algorithm**
-   Create Game World
    -   [ ] Design a world for the game to take place in
    -   [ ] Create NPCs and enemies for the player to interact with
    -   [ ] Populate the world with quests and events
    -   [ ] Design environments for each area with unique elements and obstacles

------------------------------------------------------------------------

[Back to top](#drawn-to-magic)

# The Rune-Based Spellcasting System

The spellcasting system is based on a combination of symbols inspired by Japanese kanji, Nordic runes, and Chinese characters. The system consists of three layers of complexity, providing a skill ceiling for players to master as they progress through the game.

## Layer 1: Basic Elements

The first layer consists of four basic elements:

- Fehu ᚠ (wealth/cattle)
- Uruz ᚢ (auroch/wild ox)
- Thurisaz ᚦ (giant/thorn)
- Ansuz ᚫ (god/mouth)

Each rune represents a different elemental force.

## Layer 2: Spell Types

The second layer introduces different spell types. Players can combine these with the basic elements to create more powerful spells:

- Projectile ᛇ (bow/yew)
- Area of Effect (AoE) ᛟ (homeland/estate)
- Shield ᛞ (day/dawn)
- Healing ᚻ (hail/health)

To combine a basic element with a spell type, players need to draw the corresponding runes connected or overlapping each other. For example, drawing the Fehu rune ᚠ followed by the Projectile rune ᛇ will create a Fehu Projectile ᚠᛇ spell.

## Layer 3: Modifiers

The third layer introduces modifiers that can be added to the spells created using the basic elements and spell types. These modifiers will enhance the spell's effects or add additional properties:

- Power ᛝ (wealth/treasure)
- Range ᚱ (journey/ride)
- Speed ᛋ (sun/journey)
- Duration ᛏ (day/time)

To add a modifier to a spell, players need to draw the corresponding rune connected to the previous two runes. For example, drawing the Fehu rune ᚠ, the Projectile rune ᛇ, and the Power rune ᛝ will create a powerful Fehu Projectile ᛝᚠᛇ spell.

## Examples of Spell Combinations

- Uruz AoE ᚢᛟ: An area-of-effect spell that damages and knocks back enemies.
- Thurisaz Shield ᚦᛞ: A thorn-based shield that reflects damage and can potentially stun attackers.
- Ansuz Healing ᚫᚻ: A divine-based healing spell that restores health to the caster or allies while providing temporary damage resistance.
- Fehu Projectile with Increased Range ᛝᚠᛇᚱ: An extended-range projectile that deals additional damage to enemies from a distance.

By using this system, players can create a wide variety of spells by combining and layering elements, spell types, and modifiers. This allows for creative experimentation and rewards skillful drawing of the runes.

Balancing the game for player duels can be achieved by giving each element a strength and weakness against the others. This encourages players to strategize and adapt to their opponents' choices:

- **`Fehu ᚠ`** is strong against **`Thurisaz ᚦ`** but weak against **`Uruz ᚢ`**.
- **`Uruz ᚢ`** is strong against **`Ansuz ᚫ`** but weak against **`Fehu ᚠ`**.
- **`Thurisaz ᚦ`** is strong against **`Uruz ᚢ`** but weak against **`Ansuz ᚫ`**.
- **`Ansuz ᚫ`** is strong against **`Fehu ᚠ`** and **`Thurisaz ᚦ`** but is less effective against **`Uruz ᚢ`**.





Balancing the game for player duels can be achieved by giving each element a strength and weakness against the others, as represented by the traditional elemental chart.

|     | Fehu ᚠ | Uruz ᚢ | Thurisaz ᚦ | Ansuz ᚫ |
| --- | ------ | ------ | ----------- | ------- |
| Fehu ᚠ |  -     | weak   | strong      | strong  |
| Uruz ᚢ | strong | -      | weak        | strong  |
| Thurisaz ᚦ | weak | strong | -           | weak    |
| Ansuz ᚫ | weak   | weak   | strong      | -       |

This encourages players to strategize and adapt to their opponents' choices. For example, Fehu is strong against Thurisaz but weak against Uruz, while Ansuz is strong against both Fehu and Thurisaz but is less effective against Uruz.

The system's simplicity ensures that players can learn the basics quickly, while the wide range of spell combinations provides depth and complexity for advanced players. Duels will be exciting and unpredictable, as players must anticipate and adapt to their opponents' strategies.

## Layer 4: Status Effects

The fourth layer introduces status effects that can be added to spells to create additional strategic options during duels. These status effects will change the target's condition or the battlefield:

- **Slow ᛣ** (Inspired by the rune for "ice" or "hail")
- **Silence ᛊ** (Inspired by the rune for "sun" or "victory")
- **Confuse ᚲ** (Inspired by the rune for "fire" or "torch")
- **Weaken ᚹ** (Inspired by the rune for "willow" or "woe")

To add a status effect to a spell, players need to draw the corresponding rune connected to the previous symbols.

For example, drawing the Fehu rune ᚠ, the Projectile rune ᛇ, and the Slow rune ᛣ will create a Fehu Projectile that slows the target ᛣᚠᛇ.

## **Additional Basic Elements**

The following basic elements are added to increase the variety of elemental interactions and strategic possibilities:

- **`Jera ᛃ`** (Inspired by the rune for "year" or "harvest")
- **`Ingwaz ᛜ`** (Inspired by the rune for "god" or "fertility")

These elements introduce new strengths and weaknesses:

- **`Jera ᛃ`** is strong against **`Thurisaz ᚦ`** but weak against **`Ansuz ᚫ`**.
- **`Ingwaz ᛜ`** is strong against **`Ansuz ᚫ`** but weak against **`Thurisaz ᚦ`**.

## **Examples of New Spell Combinations**

Uruz AoE with Confusion

- **`ᚢ + ᛟ + ᚲ = ᚢᛟᚲ`**
- An area-of-effect spell that confuses and disorients enemies, causing them to attack each other or wander aimlessly.

Thurisaz Shield with Silence

- **`ᚦ + ᛞ + ᛊ = ᚦᛞᛊ`**
- A thorn-based shield that not only protects the caster but also silences nearby enemies, preventing them from casting spells for a short duration.

Jera Healing with Weaken

- **`ᛃ + ᚻ + ᚹ = ᛃᚻᚹ`**
- A harvest-based healing spell that restores health to the caster or allies and weakens enemies within its range, reducing their damage output.

Ingwaz Projectile with Increased Range

- **`ᛜ + ᛇ + ᚱ = ᛜᛇᚱ`**
- A fertility-based projectile that travels a longer distance and pierces through multiple enemies.

By expanding the system with additional elements, status effects, and more strategic options, players will have even more opportunities to experiment and discover new, powerful spell combinations. The complexity and depth of the system will continue to grow, allowing players to develop advanced strategies and tactics during duels.


---

[Back to top](#drawn-to-magic)

# Solutions for symbol complexity

I believe that the complexity of the symbols and the difficulty for the players to remember and execute these spells should be addressed. Here are a few possible solutions to make it easier for the player:

1. Simplify the symbols: Redesign the symbols to be more simplistic and visually distinct, making them easier to draw and remember.

2. Introduce the symbols gradually: Instead of presenting all the symbols at once, introduce them to the players in stages as they progress through the game. This will give them time to learn and practice each set of symbols before adding more.

3. Symbol combination: Reduce the number of symbols by allowing players to combine simpler symbols to create more complex spells. For example, using a combination of "Projectile" (ㄖ) and "Luminance" (光) could create a light-based projectile spell.

4. In-game reference: Provide players with an in-game reference or a quick-access menu that displays the symbols and their effects, allowing players to consult it when needed.

5. Autocomplete feature: Implement a system that autocompletes the symbols when a player starts drawing them, reducing the need to draw the entire symbol perfectly.
    - As the player starts drawing a symbol, the system detects the pattern and identifies which symbol the player is attempting to draw.
    Once the player has drawn a sufficient portion of the symbol, the system completes the drawing, filling in the remaining parts and triggering the corresponding spell or effect.
    - The system could also offer visual cues or suggestions for the next stroke or direction to help guide the player in completing the symbol.
    - This feature would make it easier for players to execute spells, reducing frustration and the need for precise drawing skills.


6. Icon-based system: Replace the symbols with more recognizable and easily distinguishable icons or images that represent each spell or effect.

7. Practice mode: Offer a practice mode where players can experiment with drawing and combining symbols without consequences, helping them to memorize and perfect their symbol execution.

8. Rune presets: Allow players to create and save a limited number of preset spell combinations, which can be quickly accessed during gameplay.

---



