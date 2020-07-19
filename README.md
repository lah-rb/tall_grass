# tall_grass: A Pokemon D&D Adventure Aid
## Purpose of the Repository
This is a side project to help build programming skills and have some fun along the way. The primary purpose of tall_grass is to generate pokemon and relevant information for encounters during play. The secondary purpose of tall_grass is to act as a way to hold campaign relevant information such as a parsable pokedex, smaller area localized dexes, save states, and game play documents such as the play through narration and printable pokedex.

Note: If the behavior of this program acts unexpectedly please contact me through github and I will work to fix it. Provided with no warrenty. Unsure of compatability with Windows.

## Requirements
* Ruby 2.7.1 or newer must be installed

## Usage

### Game Play
Print all files in the game_play directory. Read and follow the pkmondd.odt narration, use pokedex.ods to track enounters, use status_moves.odt to determine (and record) the effect of status_moves, and use items_dex.ods to track items gained during the adventure.

### Accessing the Pokedex
As is fitting for this project there are many pokedex that can be accessed. Below we list these files and their intended purpose:

* dex.rb parses the \*\_dex files to be used in other scripts. Require dex.rb in a new script and mix Dex into a class. Then use Dex.pokedex to access the complete pokedex or Dex.compile_dex to access any other dex. Dex.pokedex is an Array of Structs ordered as follows:  
    `[#<struct Dex::Entry :num, :name, :evo, :prime_type, :second_type>]`  
and contains each of the base species relesed as of 03/03/2020. This is found in the backend directory.
* pokedex is the parsible complete pokedex used by dex.rb and should only be accessed through dex.rb when writing new scripts. This is found in the ./backend/dex_store directory.
* pokedex.ods is the table top version of the complete pokedex. It has the same information as pokedex in a physical ready format with additional columns for keeping track of pokemon seen, captured, and bonded with. This is ment to serve as a pokedex that players can fill out as their adventure unfolds. Additionally this file has a key for reading the distinction symbols that appear at the end of the species name. This is found in the game_play directory.
* pokedexres* files are intended to be read_only pokedex for archival purposes. These are kept for the case where reversion is warrented for the project later down the line. If access is desired please copy the file to the dex_store directory, rename it, and then treat it like pokedex. These are found in the ./backend/resevered directory.
* \*\_dex files, such as incubator_facility_dex, are intended to keep track of the pokemon that can be encountered in a certain area during the exploration process. These are found in the ./backend/dex_store directory.
    - Additionally some of these dex files were designed for specific purposes during game play.
    - events_dex tracks completion of story events. Because this dex takes a special form it should only be accessed through coordinator.rb.
    - npc_dex makes a pokedex of a random size and contents. While this can be treated like any other \*\_dex file, it's intended purpose is to simulate non-playable-character's (NPC) pokemon found in public areas such as areanas, pokemarts, pokecenters, and other places seen as fit to the Dungeon Master (DM).
* The counterpart to the \*\_dex files are the seed files such as incubator_facility.rb. These are used by rediscover_area.rb to fill a \*\_dex file with new pokemon that fit the original requirements specified when the \*\_dex file was created with discovery.rb. These are found in the ./backend/dex_seeds directory.

### Starting tall_grass
* In the terminal change to the tall_grass directory and type: ruby run.rb
* You will be prompted with a warm welcome and an input options list. Type the option coresponding to what you want to do with tall_grass.


### Encountering a Pokemon
* Enter 'e' or 'encounter' in run.rb
* You will be prompted to enter an area with "Where are you?". You can type the name of the area in many manners. If the name of the area dex you want to access is incubator_facility the following are acceptable methods of entry: incubator_facility, incubator facility, Incubator Facility, INCUBATOR facility, or any combination of these styles. You can also enter the number next to the area on the list.
* You will then be prompted with "Any specific type? (Hit return for no type)" where you can either enter a type or leave empty for no preference. The accepted types are as follows: Normal, Fire, Water, Grass, Electric, Ice, Fighting, Poison, Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel, and Fairy.
* Next you will be prompted with "Would you like to have another encounter? (y/return)" where return escapes the program and y takes you through another encounter.
* When you decide to have another encounter you will be prompted with "Would you like a new location? (y/return)" where return keep you in the area that you last specified and y takes you back to the original prompt.

Note: For a random encounter from the entire pokedex, type pokedex at the "Where are you?" prompt and leave the type prompt empty.

### Making a New Area Dex
* Enter 'n' or 'new' in run.rb
* Answer the questions when prompted. Be sure to follow input guides.
* discover_area.rb creates a \*\_dex file with the name you provided for the area and a seed file with the same name.

### Creating Save States
* Enter 's' or 'save' in run.rb
* You will be prompted to enter a saving or loading technique with "Would you like to start, overwrite, load, or delete an advenure?"
* Follow the input guide and select an option then hit return
* If you choose to save new then you will be prompted with "Please give a name to this save:" then type the name you wish to create your save under and hit return
* If you choose to overwrite, load, or delete a list of avaliable saves will be displayed and you will be prompted with "Give the number of the save you wish to overwrite||load||delete:" then type the number next to the save you need to use and hit return.
* Choosing to delete a save called "adventure" will then prompt you with confirmation "Are you sure that you want to DELETE adventure? This action cannot be undone. (Y/n)" where you must type 'Y' in order to complete the deletion.

Note: If you choose to overwrite or load a save you may lose other unsaved game data. It is always a good idea to create a new save if in doubt.   
Note: If you delete a save you will lose data. That is the whole point...

### Refreshing an Area Dex
* Enter 'r' or 'refresh' in run.rb
* When prompted type the name of an area that already exists. You can substitute underscores for spaces and vice versa. tall_grass ships with the following areas which can be rediscovered along with any you create: cloudy_peak, incubator_facility, land_hoe, legends, pkmn_lottery, and to_stern. You can also enter the number next to the area on the list.
* rediscover_area.rb overwrites the old \*\_dex file with a new one of the same name using the information stored in the seed file.

Note: If you want to keep the old dex file and play with a revitialized file I suggest creating a save state as specified above.

### Managing Story Events
In the pkmndd.odt narration there are a series of events. The events_dex keeps track of the completion of these events, events_manager interacts with the events_dex, and coordinator.rb shows the events dex in an interactive manner.

* Enter 'm' or 'manage' in run.rb
* When prompted with "Which mission has been completed? (hit return to exit)" enter the integer that corresponds to the event finished.

Note: The next time you use coordinator.rb you will see that the events status will have changed from incomplete to complete.

### Gathering Pokemon Info
There are many (890) pokemon that you may run into while using tall_grass. As such, there is a good chance that you will find one that you are unfamilar with. For detailed information I recommend you use bublapedia at this url https://bulbapedia.bulbagarden.net/wiki/Main_Page. For basic information (number, name, evolution stage, primary type, and secondary type) you may find tall_grass's pkmn_lookup.rb program useful.

* Enter 'i' or 'info' in run.rb
* You will be prompted with "Lookup by species name or number? (name/#)" where you can enter 's', 'name', 'species', '#', 'num', or 'number'
* Next you will be prompted with "What are you searching for?" where you can enter either an integer if '#' was selected or the species name if 'name' was selected
* If your input was '#' and '703' you will see this output: "No. 703 is Carbink which is at evolution stage 1 and is typed as Rock-Fairy."

## In the works
\# - Relevance to tall_grass   
| - Skill required for improvement   
~ - Approximate time frame to move to higher priority

* Switch testing suite to Rspec #Testing |Devs
* Implement tests for Dexshelf, TallGrass, Evo, Distinctions, and SaveManager. #Testing |Devs
* Restructure DexMakerToolbox tests so that each of the standard dexes are tested against for greater robustness. #Testing |Devs
* Implement tests for dex_seeds and \*\_dex files considered to be standard #Testing |Devs
* ItemShop needs testing. #Testing |Devs
* Examine current dependantcies between objects in tall_grass and look to minimize with restructuring. (Use sequence diagrams) #Design |Devs
* Implement tall_grass as an executable terminal app #Implementation |Devs
* Package tall_grass as an snap! #Distro |Devs
* Runner hires too big of a crew. Employ memoization and clean up frontend initialize method dependantcies. #Design |Devs
* Prompt's get_location method is overly complicated. It should be simplified. #Design |Devs
* Create tall_grass specific character sheet based of Professor Redwood's interview in pkmndd.odt. #Tabletop |Art,Game
* Create more missions to recieve from Professor Redwood. (long term) #Tabletop |Story,Game
* Improve error handling in the frontend. (long term) #Design |Devs
* Add more status move mechanics to status_moves. (long term) #Design |Game
* Figure out and fill in relative strengths as a guide for dungeon master decisions. (low priority ~ project interest first) #Design |Game
* Add user input for how many yes distinction pokemon are included in the area. (low priority ~ GUI first) #Feature |Devs
* EventManager should be able to add new events to the events dex. Coordinator should be updated to reflect the new functionality. (low priority ~ story interest first) #Feature |Devs
