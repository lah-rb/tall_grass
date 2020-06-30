# tall_grass: A Pokemon D&D adventure aid
## Purpose of the repository
This is a side project to help build programming skills and have some fun along the way. The primary purpose of tall_grass is to generate pokemon and relevant information for encounters during play. The secondary purpose of tall_grass is to act as a way to hold campaign relevant information such as a parsable pokedex, smaller area localized dexes, save states, and game play documents such as the play through narration and printable pokedex.

Note: If the behavior of this program acts unexpectedly please contact me through github and I will work to fix it. Provided with no warrenty

## Requirements
* Ruby 2.7.1 or newer must be installed

## Usage

### Game Play
Print all files in the game_play directory. Read and follow the pkmondd.odt narration, use pokedex.ods to track enounters, and use items_dex.ods to track items gained during the adventure.

### Accessing the pokedex
As is fitting for this project there are many pokedexes that can be accessed. Below are a few of the files and their intended purpose.
* dex.rb parses the \*\_dex files to be used in other scripts. Require dex.rb in a new script and mix Dex into a class. Then use Dex.pokedex to access this dex. Dex.pokedex is an array of Structs order as follows: [<num,name,evo,prime_type,second_type>] and contains each of the base species relesed as of 03/03/2020.
* pokedex is the parsible complete pokedex used by dex.rb and should be accessed through dex.rb when writing new scripts. This is found in the ./backend/dex_store directory.
* pokedex.ods is the table top version of the pokedex file. It has the same information in a human usable format plus seen, captured, and bonded sections to act as a way to actively fill the dex. Additionally this file has a key for reading the classifying symbols that appear at the end of the species name. This is found in the game_play directory.
* pokedexres files are intended to be read_only versions of older dexes incase reversion is wanted or nessary for the project later down the line. If access is desired please copy and rename the file then treat it like pokedex. These are found in the ./backend/resevered directory.
* \*\_dex files such as incubator_facility_dex are intended to keep track of the pokemon in a certain area encountered during the exploration process. These are found in the ./backend/dex_store directory.
* The counterpart to the \*\_dex files are the seed files such as incubator_facility.rb. These are used by rediscover_area.rb to fill a \*\_dex file with new pokemon that fit the original requirements specified when the \*\_dex file was created.These are found in the .backend/dex_seeds directory.

### Making a new area_dex
* In the terminal change to the tall_grass directory and type: ruby discovery.rb
* Answer the question when prompted. Be sure to follow input guides.
* discover_area.rb creates a \*\_dex file with the name you decided to call the area and a seed file with the same name.

### Refreshing an old area_dex
* In the terminal change to the tall_grass directory and type: ruby rediscovery.rb
* When prompted type the name of an area that already exists. You can substitute underscores for spaces. tall_grass ships with the following areas which can be rediscovered along with any you create: cloudy_peak, incubator_facility, land_hoe, legends, pkmn_lottery, and to_stern.
* rediscover_area.rb overwrites the old \*\_dex file with a new one of the same name using the information stored in the seed file.
Note: If you want to keep the old dex file and play with a revitialized file I suggest creating a save state as specified below.

### Encountering a pokemon
* In the terminal change to the tall_grass UI directory and type: ruby pkmn_encounter.rb
* You will be prompted to enter an area with "Where are you?". You can type the name of the area in many manners. If the name of the area dex you want to access is incubator_facility the following are acceptable methods of entry: incubator_facility, incubator facility, Incubator Facility, INCUBATOR facility, or any combination of these styles.
* You will then be prompted with "Any specific type? (Hit return for no type)" where you can either enter a type or leave empty for no preference. The accepted types are as follows: Normal, Fire, Water, Grass, Electric, Ice, Fighting, Poison, Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel, and Fairy.

Note: For a random encounter from the entire pokedex type pokedex at the "Where are you?" prompt and leave the type prompt empty.

### Managing story events
In pkmndd.odt there are a series of events. The events_dex keeps track of these events, events_manager interacts with the events_dex and coordinator.rb shows the events dex in an interactive and human useful manner.
* In the terminal change to the tall_grass directory and type: ruby coordinator.rb
* When prompted with "Which mission has been completed? (hit return to exit)" enter the integer that corresponds to the event finished

Note: The next time you use coordinator.rb you will see that the events status will have changed from incomplete to complete.

### Gathering information on specific pokemon
There are many (890) pokemon that you may run into while using tall_grass. As such there is a good chance that you will find one that you are unfamilar with. For detailed information I recommend you look at bublapedia at this url https://bulbapedia.bulbagarden.net/wiki/Main_Page. For basic information you may find tall_grass's pkmn_lookup.rb program useful.
* In the terminal change to the tall_grass directory and type: ruby pkmn_lookup.rb
* You will be prompted with "Look up by name or number? (name/#)" where you can enter 'name', '#', 'num', or 'number'
* Next you will be prompted with "What are you searching for?" where you can enter either an integer if '#' was selected or the species name if 'name' was selected
* If your input was '#' and '703' you will see this output: "No. 703 is Carbink which is at evolution stage 1 and is typed as Rock-Fairy."

### Creating save states
* In the terminal change to the tall_grass directory and type: ruby save.rb
* You will be prompted to enter a saving or loading technique with "Would you like to start, overwrite, or load an advenure?"
* Follow the input guide and select an option then hit return
* If you choose to save new then you will be prompted with "Please give a name to this save:" then type the name wou wish to create your save under and hit return
* If you choose to load or overwrite, a list of avaliable saves will be displayed and you will be prompted with "Give the number of the save you wish to load||overwrite:" then type the number next to the save you need to use and hit return.

## In the works
* Implement tests for Dexshelf, TallGrass, and SaveManager.
* DexMaker should have its legend_select method abstracted so that the user can request fossil, baby, myth, legend, and ultra beast distinctions separately.
* EventManager should be able to add new events to the events dex. Coordinator should be updated to reflect the new functionality. (low priority)
