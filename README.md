# tall_grass: A Pokemon D&D Adventure Aid
## Purpose of the Repository
This is a side project intended to help build Ruby programming skills and have some fun along the way! The primary purpose of tall_grass is to generate pokemon and relevant information for encounters during adventures. The secondary purpose of tall_grass is to act as a way to hold campaign relevant information such as a parsable pokedex, smaller area localized dex, save states, and game play documents such as the play through narration and a printable pokedex.

Note: If the behavior of this program acts unexpectedly please contact me through GitHub and I will work to fix it. Provided with no warranty. Unsure of compatibility with Windows.

## Requirements
* Ruby 2.7.1 or newer must be installed

## Usage

### Game Play
Print all files in the game_play directory. Read and follow the pkmondd.odt narration, use pokedex.ods to track enounters, use status_moves.odt to determine (and record) the effect of status_moves, and use items_dex.ods to track items gained during the adventure.

### Accessing the Pokedex
As is fitting for this project there are many pokedex that can be accessed. Below we list these files and their intended purpose:

* dex.rb parses the \*\_dex files to be used in other scripts. Require dex.rb in a new script and mix Dex into a class. Then use Dex.pokedex to access the complete pokedex or Dex.compile_dex to access any other dex. Dex.pokedex is an Array of Structs ordered as follows:  
    `[#<struct Dex::Entry :num, :name, :evo, :prime_type, :second_type>]`  
and contains each of the base species released as of 03/03/2020. This is found in the backend directory.
* pokedex is the parsible complete pokedex used by dex.rb and should only be accessed through dex.rb when writing new scripts. This is found in the ./backend/dex_store directory.
* pokedex.ods is the table top version of the complete pokedex. It has the same information as pokedex in a physical ready format with additional columns for keeping track of pokemon seen, captured, and bonded with. This is intended to serve as a pokedex that players can fill out as their adventure unfolds. Additionally, this file has a key for reading the distinction symbols that appear at the end of the species name. This is found in the game_play directory.
* pokedexres* files are intended to be read_only pokedex for archival purposes. These are kept for the case where reversion is warranted for the project later down the line. If access is desired please copy the file to the dex_store directory, rename it, and then treat it like pokedex. These are found in the ./backend/resevered directory.
* \*\_dex files, such as incubator_facility_dex, are intended to keep track of the pokemon that can be encountered in a certain area during the exploration process. These are found in the ./backend/dex_store directory.
    - Additionally some of these dex files were designed for specific purposes during game play.
    - events_dex tracks completion of story events. Because this dex takes a special form it should only be accessed through Coordinator.
    - npc_dex makes a pokedex of a random size and contents. While this can be treated like any other \*\_dex file, it's intended purpose is to simulate non-playable-character's (NPC) pokemon found in public areas such as arenas, pokemarts, pokecenters, and other places seen as fit to the Dungeon Master (DM).
    - items_dex relates items found in the video games to their items category. Because this dex takes a special form it should only be accessed through ShopKeeper.
* The counterpart to the \*\_dex files are the seed files such as incubator_facility.rb. These are used by rediscover_area.rb to fill a \*\_dex file with new pokemon that fit the original requirements specified when the \*\_dex file was created with discovery.rb. These are found in the ./backend/dex_seeds directory.

### Starting tall_grass
* In the terminal change to the tall_grass directory and type: ruby run.rb
* You will be prompted with a warm welcome and an input options list. Type the option corresponding to what you want to do with tall_grass.

note: If you want to 'install' tall_grass on your Linux system these are the steps I recommend:
1. In the terminal change to the tall_grass directory and run the command pwd.
2. Copy the output. It will look something like this:  
    `/PATH/TO/TALL/GRASS/tall_grass`
3. Add the following alias to your .bashrc or equivalent profile:  
    `# 'installing' tall_grass`  
    `alias tall_grass='cd /PATH/TO/TALL/GRASS/tall_grass && ruby run.rb && cd - >> /dev/null'`  
Then close out of all terminal sessions that you have open. You can now Enter tall_grass in any directory and tall_grass will run perfectly! As the project progresses other installation options will be considered, but until tall_grass matures this is the most feasible 'install' solution.

### Encountering a Pokemon
* Enter 'e' or 'encounter' in the tall_grass main menu.
* You will be prompted to enter an area with "Where are you?". You can type the name of the area in many manners. If the name of the area dex you want to access is incubator_facility the following are acceptable methods of entry: incubator_facility, incubator facility, Incubator Facility, INCUBATOR facility, or any combination of these styles. You can also enter the number next to the area on the list.
* You will then be prompted with "Any specific type?" where you can either enter a type or leave empty for no preference. The accepted types are as follows: Normal, Fire, Water, Grass, Electric, Ice, Fighting, Poison, Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel, and Fairy.
* A pokemon from the dex you specified will be shown. It will look similar to "Swinub No. 220".
* Next you will be prompted with "Would you like to have another encounter?" where return escapes the program and y takes you through another encounter

Note: For a random encounter from the entire pokedex, type pokedex at the "Where are you?" prompt and leave the type prompt empty.

### Making a New Area Dex
* Enter 'n' or 'new' in the tall_grass main menu.
* Answer the questions when prompted. Be sure to follow input guides.
* Discovery creates a \*\_dex file with the name you provided for the area and a seed file with the same name.

### Creating Save States
* Enter 's' or 'save' in the tall_grass main menu.
* You will be prompted to enter a saving or loading technique with "Would you like to start, overwrite, load, or delete an adventure?"
* Follow the input guide and select an option then hit return
* If you choose to save new then you will be prompted with "Please give a name to this save:" then type the name you wish to create your save under and hit return
* If you choose to overwrite, load, or delete a list of available saves will be displayed and you will be prompted with "Give the number of the save you wish to overwrite||load||delete:" then type the number next to the save you need to use and hit return.
* Choosing to delete a save called "adventure" will then prompt you with confirmation "Are you sure that you want to DELETE adventure? This action cannot be undone." where you must type 'Y' in order to complete the deletion.

Note: Gyms are not currently saved!
Note: If you choose to overwrite or load a save you may lose other unsaved game data. It is always a good idea to create a new save if in doubt.   
Note: If you delete a save you will lose data. That is the whole point...

### Refreshing an Area Dex
* Enter 'r' or 'refresh' in the tall_grass main menu.
* When prompted type the name of an area that already exists or enter 'all' to refresh all of the currently known area dex. tall_grass ships with the following areas which can be rediscovered along with any you create: cloudy_peak, incubator_facility, land_hoe, legends, npc, and to_stern. You can also enter the number next to the area on the list.
* Expedition overwrites the old \*\_dex file with a new one of the same name using the information stored in the seed file.

Note: If you want to keep the old dex file and play with a revitalized file I suggest creating a save state as specified above.

### Managing Story Events
In the pkmndd.odt narration there are a series of events. The events_dex keeps track of the completion of these events, events_manager interacts with the events_dex, and Coordinator shows the events_dex in an interactive manner.

* Enter 'm' or 'manage' in the tall_grass main menu.
* When prompted with "Which mission has been completed?" enter the integer that corresponds to the event finished.

Note: The next time you use coordinator.rb you will see that the events status will have changed from incomplete to complete.

### Gathering Pokemon Info
There are many (890) pokemon that you may run into while using tall_grass. As such, there is a good chance that you will find one that you are unfamiliar with. For detailed information I recommend you use bublapedia at this URL https://bulbapedia.bulbagarden.net/wiki/Main_Page. For basic information (number, name, evolution stage, primary type, and secondary type) you may find tall_grass's Librarian to be useful.

* Enter 'i' or 'info' in the tall_grass main menu.
* You will be prompted with "What are you searching for?" where you can enter either an integer if '#' was selected or the species name if 'name' was selected
* If your input was '#' and '703' you will see this output: "No. 703 is Carbink which is at evolution stage 1 and is typed as Rock-Fairy."

### Get Trainer Goods
On adventures you my find that a situation warrants a reward or your players may wish to purchase a good from an in-game store. tall_grass's ShopKeeper is perfect for retrieving items from the items_dex. If you want to offer an award like a chest at the end of the proverbial dungeon see 'Get a Cart of Goods'.

* Enter 'g' or 'goods' in the tall_grass main menu.
* A list of item categories will be displayed. You will be prompted with "What type of item do you need?" Here you can type the category you want, enter the number of the category you want, or simply hit return to get an item from any category.
* If you choose the category 'mail' the output you will see could be: "Here is your Space Mail. The catalog description says Mail if you trust that kind of marketing."

### Get a Cart of Goods
* Enter 'c' or 'cart' in the tall_grass main menu.
* You will be prompted with "How many items would you like in this cart?" where you should enter the number of items that you want the cart(chest) to contain.
* A random list of goods will then be displayed.

### Encounter a Trainer
Trainers are an integral part of the pokemon world. In order to meet trainers which are not developed characters within the story line, tall_grass's GymGreeter can take the drudgery out of choosing trainer names and parties.

* Enter 't' or 'trainer' in the tall_grass main menu.
* A message will be displayed providing you with a random trainer class, name, and party based on their class.

## In the works
\# - Relevance to tall_grass   
| - Skill required for improvement   
~ - Approximate time frame to move to higher priority

* Switch testing suite to Rspec. #Testing |Devs
* Implement tests for Dexshelf, TallGrass, Evo, Distinctions, and SaveManager. #Testing |Devs
* Restructure DexMakerToolbox tests so that each of the standard dexes are tested against for greater robustness. #Testing |Devs
* Implement tests for dex_seeds and \*\_dex files considered to be standard. #Testing |Devs
* Encouter's local_file method should be in tall_grass and should have a test written for it #testing |Devs
* ItemShop needs testing. #Testing |Devs
* Examine current dependencies between objects in tall_grass and look to minimize with restructuring. (Use sequence diagrams) #Design |Devs
* Package tall_grass as an snap! #Distro |Devs
* Saver should confirm that you want to overwrite/load a save #Feature |Devs
* Refactor Discovery's \@types variable to hold an array of yes_types and an array of no_types #Design |Devs
* ShopKeeper's checkout_cart method should be able to create carts from only certain items categories. #Feature |Devs
* Create an shoes GUI to turn tall_grass into an SDK app. #Implementation |Devs
* Add more items to items_dex. (long term) #Quality |Game
* Create more missions to receive from Professor Redwood. (long term) #Tabletop |Story,Game
* Improve error handling in the frontend. (long term) #Design |Devs
* Add more status move mechanics to status_moves. (long term) #Design |Game
* Add functionality to automatically restore from backup. (low priority ~ project interest first)
* Area dex should be able to include items and trainers as well as pokemon (low priority ~ solid item and trainer implementation first maybe GUI first too) #Feature |Devs
* Figure out and fill in relative strengths as a guide for dungeon master decisions. (low priority ~ project interest first) #Design |Game
* Add user input for how many yes distinction pokemon are included in the area. (low priority ~ GUI first) #Feature |Devs
* Add user input for any pokemon specifically not in an area. (low priority ~ GUI first) #Feature |Devs
* Venue should be able to add new events to events_dex. Coordinator should be updated to reflect the new functionality. (low priority ~ story interest first) #Feature |Devs
