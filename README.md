# Drawn To Magic

I am Ivan Goncharuk, a ~~junior~~ senior studying computer science at Towson University, and I have been working on this project for a few weeks. Most of the ideas mentioned are still in the beginning stages.

# Description

**"Drawn to Magic"** is an open-world RPG that uses a **gesture-based spellcasting system**. Players can spend countless hours exploring the game's world, encountering a diverse set of characters, and influencing their behavior and attitude. 

- The unique gesture-based spellcasting system uses symbols inspired by nordic runes. 
- By drawing these, players can cast spells, creating an engaging experience that requires precise skill and timing. 
- The system is designed with the Dynamic Time Warping (DTW) algorithm
	- allows for flexibility in how symbols are drawn while still accurately recognizing the intended spell.

The spellcasting system consists of four layers of complexity, providing a skill ceiling for players to master as they progress through the game:

- Basic Elements: Four elemental forces, each represented by a different rune.
- Spell Types: Players can combine basic elements with spell types to create more powerful spells.
- Modifiers: Enhance the spell's effects or add additional properties by connecting a modifier rune to the previous two runes.
- Status Effects: Create additional strategic options during duels by adding status effects to spells.

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
	-   [x] Brainstorm new effects by combining elements
	-   [ ] Brainstorm elemental enemies and environments
-   Brainstorm Skill Tree
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



---

[Back to top](#drawn-to-magic)

# Solutions for symbol complexity

I believe that the complexity of the symbols and the difficulty for the players to remember and execute these spells should be addressed. Here are a few possible solutions to make it easier for the player:

- Introduce the symbols gradually: Instead of presenting all the symbols at once, introduce them to the players in stages as they progress through the game. This will give them time to learn and practice each set of symbols before adding more.

- In-game reference: Provide players with an in-game reference or a quick-access menu that displays the symbols and their effects, allowing players to consult it when needed.

- Autocomplete feature: Implement a system that autocompletes the symbols when a player starts drawing them, reducing the need to draw the entire symbol perfectly.
	- As the player starts drawing a symbol, the system detects the pattern and identifies which symbol the player is attempting to draw.
	- Once the player has drawn a sufficient portion of the symbol, the system completes the drawing, filling in the remaining parts and triggering the corresponding spell or effect.
	- The system could also offer visual cues or suggestions for the next stroke or direction to help guide the player in completing the symbol.
	- This feature would make it easier for players to execute spells, reducing frustration and the need for precise drawing skills.


6. Icon-based system: Replace the symbols with more recognizable and easily distinguishable icons or images that represent each spell or effect.

7. Practice mode: Offer a practice mode where players can experiment with drawing and combining symbols without consequences, helping them to memorize and perfect their symbol execution.

8. Rune presets: Allow players to create and save a limited number of preset spell combinations, which can be quickly accessed during gameplay.

---



