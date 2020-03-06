# tall_grass: A Pokemon D&D adventure aid
## Purpose of the repository
This is a side project to help build programming skills and have some fun along the way. The primary purpose of tall_grass is to specifically or at random generate pokemon and relevant information for encounters. The secondary purpose of tall_grass is to act as a way to hold campaign relevant information such as a parsable pokedex, smaller area localized dexes, and game play documents such as the play through narration and physical dex copy.

## Requirements
* Ruby 2.6.3 or newer must be installed (2.5.5 should still work though)

## Usage

### Game Play
Print all files in the game_play directory. Read and follow the pkmondd.odt narration and use pokedex.gnumeric to track enounters.

### Accessing the pokedex
As is fitting for this project there are many pokedexes that can be accessed. Below are a few of the files and their intended purpose.
* dex.rb is the store for the cummulative pokedex for script's access. require the file in a new script (or area_maker as it stores the location of dex.rb and includes its methods) then use Dex::pokedex to access this dex. Dex::pokedex is an array or arrays order as follows: [[dex#,species,evolution_stage,primary_type,secondary_type]] and contains each the base (I am sure arguably in some cases) species relesed as of 03/03/2020.
* pokedex.txt is the parsible complete pokedex used by dex.rb and should be accessed through dex.rb when writing new scripts.
* pokedex.gnumeric is the table top version of dex.rb with the same information plus seen, captured, and bonded sections to act as a way to actively fill the dex. Additionally this file has a key for the symbols that appear at the end of the species name to help with parsing the text files.
* pokedexres files are intended to be read_only versions of older dexes incase reversion is wanted or nessary for the project later down the line. If access is desired please copy and rename the file then treat it like pokedex.txt
* area dex files such as incubator_facility.txt are intended to keep track of pokemon in a certain area encountered during the exploration process.

### Making a new_area dex
* Copy an existing area dex binder such as incubator_facility.rb and paste into a blank document
* On line 6 replace the current file name with the location where you would like to save the new file
* Change line 9 to grab the boadest set of pokemon acceptable
* On line 13 fill the array with the types you wish the pokemon to contain
* Name file and save
* In the terminal change to the pkmndd directory or wherever the file set is saved and type: ruby file_name.rb where file_name is the name of the ruby file you just worked on. This runs the code and generates a text file in the dex_store directory with the name that you gave it on line 6.

### Encountering a pokemon
* In the terminal change to the pkmndd directory or wherever the file set is saved and type: ruby pkmon_encounter.rb
* You will be prompted to enter an area this the message "Where are you?". You can type the name of the area in many manners. If the name of the area dex you want to access is incubator_facility.txt the following are acceptable methods of entry: incubator_facility, incubator facility, Incubator Facility, INCUBATOR facility, or any combination of these styles.
* You will then be prompted with "Any specific type? (Hit return for no type)" where you can either enter a type to look for or leave empty for no preference.

Note: For a random encounter from the entire pokedex type pokedex at the "Where are you?" prompt and leave the type prompt empty.
