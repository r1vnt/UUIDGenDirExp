#########################################################################################################Logging System#################################################################################################################
loggingSystem() {														#Logging System Used to generate Logs for commands executed
currentUser=$(whoami) 														#Fetchs current user executing command, to be used in the logging system
Date=$(date)															#Fetchs current date, to be used in the logging system														
PID="PID : $$"															#
commandLog="Current User : $currentUser\nDate :$Date\nCommand Executed : $commandExecuted\nCommand Output: $commandOutput\n$PID" #Combines elements of logging system, fetchs command Executed/Output from different functions
echo -e "$commandLog" >> LogFile.txt												#Outputs Log to the Log File, (LogFile.txt)
}																#End of Function
#########################################################################################################Logging System##################################################################################################################
																#
																#
######################################################################################################File Existence Check###############################################################################################################
checkfileExistence() {														#Checks if a file exists, used in UUID generation functions
																#
    if [[ -f "$fileLocation" ]]; then												#Checks if target is a File
        echo "File"														#Echos that it's a file, this is used in the UUIDGeneration.txt's
    elif [ -d "$fileLocation" ]; then												#Checks if target is a Directory
        echo "Directory"													#Echos that it's a file, also used in the UUIDGeneration.txt's
    else															#Checks if it's something else
        echo "Invalid"														#Marks it as invalid
    fi  															#
																#
}																#End of Function
######################################################################################################File Existence Check###############################################################################################################
																#
																#
####################################################################################################Current Date Generation##############################################################################################################
currentDate() {															#Function used to generate currentDate
																#
echo $(date)															#Echos Current Date
																#
}																#End of Function
####################################################################################################Current Date Generation##############################################################################################################
																#
																#
####################################################################################################UUID Generation Handling#############################################################################################################
																#
saveToFile() {															#Function that saves to file depending on the UUID type
																#
case $uuidVersion in														#Case to determine which UUID is being used so it can save to the correct file
																#
    1)																#Determines that UUID is Version 1
        echo "$writeToFileUUID1" >> UUID1Generation.txt										#Writes Write To File to UUID1Generation.txt
        echo "$writeToFileUUID1" >> UUIDGeneration.txt 										#Writes Write To FIle To UUIDGeneration (List for all UUID Generations)
        ;;															#
    2)																#Determines that UUID is Version 2
        echo "$writeToFileUUID2" >> UUID2Generation.txt										#Writes Write To File to UUID2Generation.txt
        echo "$writeToFileUUID2" >> UUIDGeneration.txt										#Writes Write To FIle To UUIDGeneration (List for all UUID Generations)
        ;;															#
    3)																#Determines that UUID is Version 3
        echo "$writeToFileUUID3" >> UUID3Generation.txt										#Writes Write To File to UUID3Generation.txt
        echo "$writeToFileUUID3" >> UUIDGeneration.txt										#Writes Write To FIle To UUIDGeneration (List for all UUID Generations)
        ;;															#
    4)																#Determines that UUID is Version 4
        echo "$writeToFileUUID4" >> UUID4Generation.txt										#Writes Write To File to UUID4Generation.txt
        echo "$writeToFileUUID4" >> UUIDGeneration.txt										#Writes Write To FIle To UUID4Generation (List for all UUID Generations)
        ;;															#
    5)																#Determines that UUID is Version 5
        echo "$writeToFileUUID5" >> UUID5Generation.txt										#Writes Write To File to UUID5Generation.txt
        echo "$writeToFileUUID5" >> UUIDGeneration.txt										#Writes Write To FIle To UUID5Generation (List for all UUID Generations)
        ;;															#
    *) 																#If anything else, return an Error
        echo "Error, UUID failed to be written to file."									#Generates and Echos Error Message
        ;;															#
esac																#End Case
																#
																#
}																#End of Function
####################################################################################################UUID Generation Handling#############################################################################################################
																#
																#
####################################################################################################UUID Collision Handling##############################################################################################################
checkUUIDCollision() {														#Function to Check UUID Collisions
																#
    if grep -q $generatedUUID UUID1Generation.txt UUID2Generation.txt UUID3Generation.txt UUID4Generation.txt UUID5Generation.txt UUIDGeneration.txt; then #Grep Searchs for the Generated UUID to identify if there's collisions
        echo true														#Echoes true if a collision is found
    else															#Normal case, where a collision isn't found
        echo false														#Echoes false if a collision isn't found
    fi																#
																#
																#
}																#End of Function
####################################################################################################UUID Collision Handling##############################################################################################################
																#
																#
################################################################################################Existing UUID for File Handling##########################################################################################################
checkExistingUUID() {														#Checks if a UUID of the same version is assigned to a file, if so returns an error    																				

    if [[ "$uuidVersion" == "1" ]] ; then											#Checks if the version of the UUID is Version 1

        if grep -q $fileLocation UUID1Generation.txt; then									#grep searchs to see if a matching file location is located within UUIDGeneration1.txt
            echo true														#echos true if matching file location is found
        else 															#else statement if file location isn't found
            echo false														#echos false if file location isn't found
        fi															#
    fi																#	
    if [[ "$uuidVersion" == "2" ]] ; then											#checks if the version of the UUID is Version 2
        if grep -q $fileLocation UUID2Generation.txt; then									#grep searchs to see if a matching file location is located within UUIDGeneration2.txt
            echo true														#echos true if matching file location is found
        else 															#else statement if file location isn't found
            echo false														#echos false if file location isn't found
        fi															#
    fi																#
    if [[ "$uuidVersion" == "3" ]] ; then											#Checks if the version of the UUID is Version 3
        if grep -q $fileLocation UUID3Generation.txt; then									#grep searchs to see if a matching file location is located within UUIDGeneration3.txt
            echo true														#echos true if matching file location is found
        else 															#else statement if file location isn't found
            echo false														#chos false if file location isn't found
        fi															#
    fi																#
    if [[ "$uuidVersion" == "4" ]] ; then											#Checks if the version of the UUID is Version 4
        if grep -q $fileLocation UUID4Generation.txt; then									#grep searchs to see if a matching file location is located within UUIDGeneration4.txt
            echo true														#echos true if matching file location is found
        else 															#else statement if file location isn't found
            echo false														#echos false if file location isn't found
        fi															#
    fi																#
    if [[ "$uuidVersion" == "5" ]] ; then											#Checks if the version of the UUID is Version 4
        if grep -q $fileLocation UUID5Generation.txt; then									#grep searchs to see if a matching file location is located within UUIDGeneration5.txt
            echo true														#echos true if matching file location is found
        else 															#else statement if file location isn't found
            echo false														#echos false if file location isn't found
        fi															#
    fi																#
																#
}																#End of Function
################################################################################################Existing UUID for File Handling##########################################################################################################
																#
																#
#######################################################################################################UUID1 Generation##################################################################################################################																
generateUUID1() {														#Function for UUID1 Generation
#UUID Version 1:														#Format for UUID1
#T = Timestamp															#Timestamp has to be in 1592 format for UUID1 generation
#V = Version															#Version identifying the Version of UUID, in this case 1
#N = Node 															#Node being the Mac Address for the system
#v = Variant															#Variant, being the Variant of UUID, this could be anything
#C = Clock Sequence (Random)													#Clock Sequence is uncalculable on computers, so left random
#TTTTTTTT-TTTT-VTTT-vCCC-NNNNNNNNNNNNN												#Format for UUID1
#Low      Mid   High														#Low-High portruding to the location of the Timestamp
																#
local currentTimestampLow=$(($(date +%s) * 10000000 + 122192928000000000))							#Generation of Time stamp in the 1592 format
currentTimestampLow=${currentTimestampLow:0:10} 										#Takes the Low part of the timestamp (the beginning, this is the first part of the stamp)
local currentTimestampLow=$(printf "%x" "$currentTimestampLow") 								#Converts it in Hexadecimal
local currentTimestampMid=$(date +%s%N | sha1sum | head -c 4) 									#Randomised Mid of timestamp since uncalculable
local version="1" 														#Version number being UUID1
local currentTimestampHigh=$(date +%s%N | sha1sum | head -c 3) 									#Randomised High of timestamp since uncalculable
local variant="8" 														#Variant of the UUID being 8
local clockSeq=$(date +%s%N | sha1sum | head -c 3) 										#Clock sequence is randomised
local macAddress=$(ifconfig eth0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'| tr -d ':') 				#Generation of Mac Address,truncation of ":" comprised within it, giving a plain hexadecimal string
UUID1="$currentTimestampLow-$currentTimestampMid-$version$currentTimestampHigh-$variant$clockSeq-$macAddress"			#Combination of elements creating the UUID Version 1
echo $UUID1															#Returning UUID1 using echo
																#
																#
}																#End of Function
#######################################################################################################UUID1 Generation##################################################################################################################															
																#
																#
#######################################################################################################UUID2 Generation##################################################################################################################		
generateUUID2() {														#Function for UUID2 Generation
																#
#UUID Version 2:														#Format for UUID2
#L = Local Domain Number													#Local Domain Number being the current user
#M = Mid Time															#Mid time being essentially random, since incalculable
#V = Version															#Version identifying the Version of UUID, in this case 2
#H = High Time															#High time being essentially random since incalculable
#v = Variant															#Variant being the Variant of UUID, this could be anything
#C = Clock															#Clock sequence is uncalculable on computers, so left random
#l = Local Domain														#Local domain is also random
#M = Mac Address														#Mac address, without the ":" 
#LLLLLLLL-MMMM-VHHH-vCll-MMMMMMMMMMMM												#Format for UUID2
																#
																#
    local localDomainNumber="$(whoami | sha1sum | head -c 8)"									#Generates a Local Domain Number based on the current user operating the CLI
    local currentTimestampMid=$(date +%s%N | sha1sum | head -c 4)								#Generates Mid Time Stamp, which is essentially completely random since it's incalculable
    local version="2"														#Defines Version, in this case it is Version 2
    local currentTimestampHigh=$(date +%s%N | sha1sum | head -c 3)								#Generates High Time Stamp, which is essentially completely random since it's incalculable
    local variant="8"														#Generates Variant, This case it is 8
    local clock=$(date +%s%N | sha1sum | head -c 1)										#Generates Clock, which is essentially completely random since it's incalculable
    local localDomain=$(date +%s%N | sha1sum | head -c 2)									#Generates Local Domain, which is also completely random
    local macAddress=$(ifconfig eth0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'| tr -d ':')			#Generates Mac Address, using ifconfig
    																#
    UUID2="$localDomainNumber-$currentTimestampMid-$version$currentTimestampHigh-$variant$clock$localDomain-$macAddress"	#Combination of elements creating the UUID Version 2
    																#
    echo "$UUID2"														#Returning UUID2 using echo
    																#
																#
}																#
#######################################################################################################UUID2 Generation##################################################################################################################		
																#
																#
#######################################################################################################UUID3 Generation##################################################################################################################								
generateUUID3() {														#Function for UUID3 Generation
																#
#UUID Version 3:														#Format for UUID3
#M = MD5 High															#First 12 Hexadecimal Characters of an MD5 Encryption sum
#m = MD5 Mid															#Next 3 Hexademical Characters of an MD5 Encryption sum
#n = MD5 low															#Next 15 Hexademical Characters of an MD5 Encryption sum
#V = Version															#Version identifying the Version of UUID, in this case 3
#v = Variant															#Variant identifying the Variant of UUID, in this case 8
#MMMMMMMM-MMMM-Vmmm-vnnn-nnnnnnnnnnnn												#Format For UUID3
																#
																#
local generateMd5sum=$(date +%s%N | md5sum)											#Generates a md5sum based on the date, which can essentially be assumed as completely random
local md5sumHigh=${generateMd5sum:0:8}												#Snips First 8 Characters of the previously Generated MD5Sum and makes it a new variable for Md5Sum High
local md5sumHigh2=${generateMd5sum:8:4}												#Snips Next 4 Characters of the previously Generated MD5Sum and makes it a new variable for Md5Sum High 2 
local version="3"														#Variable for Version, this case it's 3
local md5sumMid=${generateMd5sum:12:3}												#Snips Next 3 Characters of the previously Generated MD5Sum and makes it a new variable for Md5SumMid
local variant="8"														#Variable for Variant, this case it's 8
local md5sumLow1=${generateMd5sum:15:3}												#Snips Next 3 Characters of the previously Generated MD5Sum and makes it a new variable for Md5SumLow 1
local md5sumLow2=${generateMd5sum:18:12}											#Snips Next 12 Characters of the previously Generated MD5Sum and makes it a new variable for Md5SumLow 2
UUID3="$md5sumHigh-$md5sumHigh2-$version$md5sumMid-$variant$md5sumLow1-$md5sumLow2"						#Combination of elements creating the UUID Version 3
																#
echo $UUID3															#Returning UUID3 using echo
																#
}																#
#######################################################################################################UUID3 Generation##################################################################################################################
																#
																#
#######################################################################################################UUID4 Generation##################################################################################################################
generateUUID4() {														#
																#
#UUID Version 4:														#Format for UUID4
#r = Random															#UUID4 is completely Random, apart from the Version and Variant
#V = Version															#Version being Version 4
#v = Variant															#Variant being Variant 9
#rrrrrrrr-rrrr-Vrrr-vrrr-rrrrrrrrrrrr												#Format for UUID4
																#
																#
local generateSha256sum=$(date +%s%N | sha256sum)										#Creating completely random string, using the current time stamp and sha256 (making it essentially random)																#
local sha256sumHigh=${generateSha256sum:0:8}											#Generating the first 8 characters of UUID4
local sha256sumHigh2=${generateSha256sum:8:4}											#Generating the next 4 characters of UUID4
local version="4"														#Version being Version 4
local sha256sumMid=${generateSha256sum:12:3}											#Generating the first 3 characters of UUID4
local variant="9"														#Variant being Variant 9
local sha256sumLow1=${generateSha256sum:15:3}											#Generating the first 3 characters of UUID4
local sha256sumLow2=${generateSha256sum:18:12}											#Generating the first 12 characters of UUID4
UUID4="$sha256sumHigh-$sha256sumHigh2-$version$sha256sumMid-$variant$sha256sumLow1-$sha256sumLow2"				#Combination of elements creating the UUID Version 4
																#
echo $UUID4															#Returning UUID4 using echo
																#
}																#
#######################################################################################################UUID4 Generation##################################################################################################################
																#
																#
#######################################################################################################UUID5 Generation##################################################################################################################
generateUUID5() {														#
																#
#UUID Version 5:														#Format for UUID5
#S = SHA - 1 High														#First 12 Hexadecimal Characters of an SHA-1 Encryption sum														
#s = SHA - 1 Mid														#Next 3 Hexademical Characters of an SHA-1 Encryption sum
#z = SHA - 1 Low														#Next 15 Hexademical Characters of an SHA-1 Encryption sum
#V = Version															#Version identifying the Version of UUID, in this case 5
#v = Variant															#Variant identifying the Variant of UUID, in this case a
#SSSSSSSS-SSSS-Vsss-vzzzzzzzzzzzzzzz												#Format For UUID3
																#
local generateSha1sum=$(date +%s%N | sha1sum)											#Generates a SHA-1 based on the date, which can essentially be assumed as completely random
local sha1sumHigh=${generateSha1sum:0:8}											#Snips First 8 Characters of the previously Generated SHA-1 and makes it a new variable for SHA-1 High
local sha1sumHigh2=${generateSha1sum:8:4}											#Snips Next 4 Characters of the previously Generated SHA-1 and makes it a new variable for SHA-1 High 2
local version="5"														#Variable for Version, this case it's 5
local sha1sumMid=${generateSha1sum:12:3}											#Snips Next 3 Characters of the previously Generated SHA-1 and makes it a new variable for SHA-1 Mid
local variant="a"														#Variable for Variant, this case it's a
local sha1sumLow1=${generateSha1sum:15:3}											#Snips Next 3 Characters of the previously Generated SHA-1 and makes it a new variable for SHA-1 Low 1
local sha1sumLow2=${generateSha1sum:18:12}											#Snips Next 12 Characters of the previously Generated SHA-1 and makes it a new variable for SHA-1 Low 2
UUID5="$sha1sumHigh-$sha1sumHigh2-$version$sha1sumMid-$variant$sha1sumLow1-$sha1sumLow2"					#Combination of elements creating the UUID Version 5
echo $UUID5															#Returning UUID5 using echo
																#
}																#
#######################################################################################################UUID5 Generation##################################################################################################################
																#
																#
############################################################################################################ MAIN #######################################################################################################################
main() {															#This consists of, the main code, including the programming for CLI and it's functions
																#
																#
UUID1=""															#Declaration of Variable UUID1, to be used later
UUID2=""															#Declaration of Variable UUID2, to be used later
UUID3=""															#Declaration of Variable UUID3, to be used later
UUID4=""															#Declaration of Variable UUID4, to be used later
UUID5=""															#Declaration of Variable UUID5, to be used later
																#
																#
writeToFileUUID1=""														#Declaration of Variable writeToFileUUID1, to be used later
writeToFileUUID2=""														#Declaration of Variable writeToFileUUID2, to be used later
writeToFileUUID3=""														#Declaration of Variable writeToFileUUID3, to be used later
writeToFileUUID4=""														#Declaration of Variable writeToFileUUID4, to be used later
writeToFileUUID5=""														#Declaration of Variable writeToFileUUID5, to be used later
																#
																#
touch "UUID1Generation.txt"													#Creates UUID1Generation.txt (empty), if not created previously
touch "UUID2Generation.txt"													#Creates UUID2Generation.txt (empty), if not created previously
touch "UUID3Generation.txt"													#Creates UUID3Generation.txt (empty), if not created previously
touch "UUID4Generation.txt"													#Creates UUID4Generation.txt (empty), if not created previously
touch "UUID5Generation.txt"													#Creates UUID5Generation.txt (empty), if not created previously
touch "LogFile.txt"														#Creates LogFile.txt (empty), if not created previously
																#
																#
################################################################################################# MAIN (Flags and Arguments) ############################################################################################################
while getopts ":1:2:3:4:5:P:F:L:M:S:L:TW:G:H" opt; 										#(1) Parses Command Line Options and Arguments, While loop processes each option one by one
#Options															#(2) ":1:2:3:4:5:P:F:L:M:S:L:TW:" List of Arguments the Script supports
# 1 - Generate UUID Version 1													#
# 2 - Generate UUID Version 2													#
# 3 - Generate UUID Version 3													#
# 4 - Generate UUID Version 4													#
# 5 - Generate UUID Version 5													#
																#
# G - Fetch A previously UUID for specific file											#
# P - Previously Generated UUID													#
# F - Number of Files in Directory												#
# S - Size of Directory, incl. Sub Directories											#
# L - Sort Files by Filename Length												#
																#
# W - Write To Specified File													#
# T - Print to Terminal														#
do																#
  case $opt in															#
    H) man ./UUIDGenDirExpManPage												#Displays Man Page for this Bash Script
    ;;																#
																#This command allows user to output commands to Terminal using "-T"
    T) terminalOutput=true													#Sets terminalOutput variable to true used to echo later commands to terminal
    commandExecuted="Outputted command to the terminal."									#Logs, that the user outputted commands to terminal
    commandOutput="Output to terminal"												#Log to tell use that there was a command outputted to terminal
    loggingSystem														#Sends these variables to be saved using Logging System function
    ;;																#
    																#
    W) specifiedFile="$OPTARG"													#This command allows user to write command outputs to a specified file
    writeFileOutput=true													#Sets writeFileOutput variable to true used to echo later commands to specified file
    commandExecuted="Outputted command to a file ($specifiedFile)."								#Logs, that the user outputted commands to a file ($specifiedFile)
    commandOutput="Output to $specifiedFile"											#Repeat saying that the user outputted commands to a file.
    loggingSystem														#Sends these variables to be saved using Logging System function
    ;;																#								
    G) targetFileG="$OPTARG"													#Get previously Generated UUID, by filename
    ;;																#		
    1)																#Command allowing user to generate a UUID1 for a specified File or Directory
    UUID1="$OPTARG"														#Saves the Optarg to be used later
    generatedUUID=$(generateUUID1)												#Generates UUID1 using UUID1Generation Function
    uuidVersion="1"														#Determines UUID Version for Logging
    creationDate=$(currentDate)													#Sets creation Date to the current date
    fileLocation=$(readlink -f $OPTARG)												#Set's the File Location
    																#
    if [ ! -e "$fileLocation" ]; then												#Checks if file doesn't exist
        echo "Error, specified file does not exist, therefore cannot have a UUID assigned"					#Echos error if specified file does not exist
        commandExecuted="UUIDv1 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Sends to logging system that UUIDv1 generation was attempted
    	commandOutput="$writeToFileUUID1, File/Directory does not exist, therefore cannot have a UUID assigned."		#Sends the output, in this caes the file/directory didn't exist so error
    	loggingSystem														#
    	exit 1															#Exits and returns log explainign error
    fi																#
    if [[ "$(checkUUIDCollision)" == true ]]; then										#Checks if a UUID Collision is detected, using the previous checkUUIDCollision Command
        echo "UUID Collision Detected, ending process to maintain UUID integrity (UUID)."					#Echos that a UUID Collision has been detected
        commandExecuted="UUIDv1 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Sends to the logging system that this command was attempted
	commandOutput="UUID Collision Detected, 2 identical UUIDs generated, Command Aborted"					#Sends to the logging system that this command failed since a UUID Collision was Detected
																#
	loggingSystem														#Sends these Variables to the logging system
	exit 1															#Executes exit clause
    fi																#
    																#
    if [[ "$(checkExistingUUID)" == true ]]; then										#Checks if a a file already has a UUID(n) assigned, using the previous checkExistingUUID Command
        echo "UUID Collision Detected, ending process to maintain UUID integrity (Duplicate File Locations)."			#Echos that the file already has a UUID(n) assigned, tells the user that the process is being aborted.
        commandExecuted="UUIDv1 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Sends to the logging system that this command was attempted
	commandOutput="UUID Collision Detected, creating 2 of the same UUID type for one file, Command Aborted"			#Sends to the logging system that this command failed, since a UUID Collision was Detected
																#
	loggingSystem														#Sends these Variables to the logging system
	exit 1															#Executes exit clause
    fi																#
    																#
    if [[ $(checkfileExistence) == "File" || $(checkfileExistence) == "Directory" ]]; then					#Checks File Type, and further verifies existence
        writeToFileUUID1="UUID : $generatedUUID , Version : $uuidVersion , Creation Date : $creationDate , Location : $fileLocation , Type : $(checkfileExistence)" #Creates variable combining all the file data
        saveToFile														#executes save to File function
	commandExecuted="UUIDv1 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Sends to the logging system that this command was attempted
	commandOutput="$writeToFileUUID1, Written to UUIDGeneration.txt and UUID1Generation.txt"				#Sends to logging system that command was successful, UUID  written to UUID1Generation/UUIDGeneration.txt
																#
	loggingSystem														#Sends these Variables to the logging system
    else															#
    																#
    echo "This File/Directory does not exist, therefore cannot have a UUID assigned."						#Else clause in case file does not exist, therefore a UUID cannot be assigned, incase item slips through all checks
    	commandExecuted="UUIDv1 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Sends to the logging system that this command was attempted
    	commandOutput="$writeToFileUUID1, File/Directory does not exist, therefore cannot have a UUID assigned."		#ends to logging system that command was in successful
																#
    	loggingSystem														#Sends these Variables to the logging system
    	exit 1															#Executes exit clause
    fi																#
																#
																#
																#
																#
    ;;																#
    2)																#Command allowing user to generate a UUID2 for a specified File or Directory
    UUID2="$OPTARG"														#Saves the Optarg to be used later
    generatedUUID=$(generateUUID2)												#Generates UUID1 using UUID1Generation Function
    creationDate=$(currentDate)													#Sets CreationDate
    uuidVersion="2"														#Determines UUID Version for Logging
    fileLocation=$(readlink -f $OPTARG)												#Gets full file location
    																#
     if [ ! -e "$fileLocation" ]; then												#Checks if file location doesn't exist
        echo "Error, specified file does not exist, therefore cannot have a UUID assigned"					#echo's error, if this statement is true since you cannot assign a UUID to a non existent file
        commandExecuted="UUIDv2 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
    	commandOutput="$writeToFileUUID2, File/Directory does not exist, therefore cannot have a UUID assigned."		#Message for log
    	loggingSystem														#sends these variables to logging system
    	exit 1															#executes exit clause
    fi																#
    if [[ "$(checkUUIDCollision)" == true ]]; then										#checks if there is a UUID collision (2 identical UUIDs)
        echo "UUID Collision Detected, ending process to maintain UUID integrity (UUID)."					#echos that a UUID collision is detected, and notifies that the process is being immediately ended
        commandExecuted="UUIDv2 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
	commandOutput="UUID Collision Detected, 2 identical UUIDs generated, Command Aborted"					#Messsage for log
	loggingSystem														#sends these variables to logging system
        exit 1															#executes exit clause
    fi																#
    if [[ "$(checkExistingUUID)" == true ]]; then										#Checks if file already has UUID2 assigned to it
        echo "UUID Collision Detected, ending process to maintain UUID integrity (Duplicate File Locations)."			#echos that a UUID collision is detected, and notifies that the process is being immediately ended
        commandExecuted="UUIDv2 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
	commandOutput="UUID Collision Detected, creating 2 of the same UUID type for one file, Command Aborted"			#Message for log
	loggingSystem														#sends these variables to logging system
	exit 1															#executes exit clause
    fi																#
    if [[ $(checkfileExistence) == "File" || $(checkfileExistence) == "Directory" ]]; then					#Further checks that the file is a directory/file
        writeToFileUUID2="UUID : $generatedUUID , Version : $uuidVersion , Creation Date : $creationDate , Location : $fileLocation , Type : $(checkfileExistence)" #Creates write to file variable if confirmed
        saveToFile														#saves to default files using saveToFile command
	commandExecuted="UUIDv2 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
	commandOutput="$writeToFileUUID2, Written to UUIDGeneration.txt and UUID1Generation.txt"				#Message for log
	loggingSystem														#sends these variables to logging system
    else															#
    echo "This File/Directory does not exist, therefore cannot have a UUID assigned."						#Else clause if not caught by other if statements, mentioning file doesn't exist to user
        commandExecuted="UUIDv1 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
    	commandOutput="File/Directory does not exist, therefore cannot have a UUID assigned."					#Message for log
    	loggingSystem														#sends these variables to logging system
    	exit 1															#executes exit clause
    fi																#
    ;;																#
    3) UUID3="$OPTARG"														#Command allowing user to generate a UUID3 for a specified File or Directory
    generatedUUID=$(generateUUID3)												#Generates UUID3 using, UUID3 generation function
    creationDate=$(currentDate)													#creates date for generation
    uuidVersion="3"														#creates Version stamp for UUID generation
    fileLocation=$(readlink -f $OPTARG)												#Gets full file location
    																#
     if [ ! -e "$fileLocation" ]; then												#checks if filelocation doesn't exist
        echo "Error, specified file does not exist, therefore cannot have a UUID assigned."					#echos an error if the specified file does not exist, therefore a UUID cannot be assigned
        commandExecuted="UUIDv3 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
    	commandOutput="$writeToFileUUID3, File/Directory does not exist, therefore cannot have a UUID assigned."		#Message for log
    	loggingSystem														#sends variables to logging system
    	exit 1															#executes exit clause
    fi																#
    if [[ "$(checkUUIDCollision)" == true ]]; then										#checks if there is UUID collision
        echo "UUID Collision Detected, ending process to maintain UUID integrity (UUID)."					#Notifies user that there is a UUID collision
        commandExecuted="UUIDv3 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
	commandOutput="UUID Collision Detected, 2 identical UUIDs generated, Command Aborted."					#Message for log
	loggingSystem														#sends variables to logging system
        exit 1															#executes exit clause
    fi																#
    if [[ "$(checkExistingUUID)" == true ]]; then										#Checks if there is UUID3 already assigned to the filelocation
        echo "UUID Collision Detected, ending process to maintain UUID integrity (Duplicate File Locations)."			#notifies user that there is a UUID collision
        commandExecuted="UUIDv3 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
	commandOutput="UUID Collision Detected, creating 2 of the same UUID type for one file, Command Aborted."		#Message for log
	loggingSystem														#sends variables to logging system
        exit 1															#executes exit clause
    fi																#
    if [[ $(checkfileExistence) == "File" || $(checkfileExistence) == "Directory" ]]; then					#Further checks if file exists, and file type
        writeToFileUUID3="UUID : $generatedUUID , Version : $uuidVersion , Creation Date : $creationDate , Location : $fileLocation , Type : $(checkfileExistence)" #Creates message to be saved to file
        saveToFile														#executes saveToFile function
	commandExecuted="UUIDv3 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
	commandOutput="$writeToFileUUID3, Written to UUIDGeneration.txt and UUID1Generation.txt"				#Message for log
	loggingSystem														#sends variables to logging system
																#
    else															#
    	echo "This File/Directory does not exist, therefore cannot have a UUID assigned."					#Catch, incase not caught by other if statements
    	commandExecuted="UUIDv3 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#Message for log
    	commandOutput="$writeToFileUUID3, File/Directory does not exist, therefore cannot have a UUID assigned."		#Message for log
    	loggingSystem														#sends variables to logging system
	exit 1															#executes exit clause
    fi																#
																#
																#
    ;;																#
    4) UUID4="$OPTARG"														#UUID4 is somewhat similar to UUID1/2/3
    generatedUUID=$(generateUUID4)												#
    creationDate=$(currentDate)													#
    uuidVersion="4"														#
    fileLocation=$(readlink -f $OPTARG)												#
    																#
     if [ ! -e "$fileLocation" ]; then												#
        echo "Error, specified file does not exist, therefore cannot have a UUID assigned"					#
        commandExecuted="UUIDv4 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
    	commandOutput="$writeToFileUUID4, File/Directory does not exist, therefore cannot have a UUID assigned."		#
    	loggingSystem														#
    	exit 1															#
    fi																#
    if [[ "$(checkUUIDCollision)" == true ]]; then										#
        echo "UUID Collision Detected, ending process to maintain UUID integrity (UUID)."					#
        commandExecuted="UUIDv4 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
	commandOutput="UUID Collision Detected, 2 identical UUIDs generated, Command Aborted"					#
	loggingSystem														#
        exit 1															#
    fi																#
    if [[ "$(checkExistingUUID)" == true ]]; then										#
        echo "UUID Collision Detected, ending process to maintain UUID integrity (Duplicate File Locations)."			#
        commandExecuted="UUIDv4 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
	commandOutput="UUID Collision Detected, creating 2 of the same UUID type for one file, Command Aborted"			#
	loggingSystem														#
        exit 1															#
    fi																#
    if [[ $(checkfileExistence) == "File" || $(checkfileExistence) == "Directory" ]]; then					#
        writeToFileUUID4="UUID : $generatedUUID , Version : $uuidVersion , Creation Date : $creationDate , Location : $fileLocation , Type : $(checkfileExistence)" #
        saveToFile														#
        commandExecuted="UUIDv4 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
	commandOutput="$writeToFileUUID4, Written to UUIDGeneration.txt and UUID1Generation.txt"				#
	loggingSystem														#
																#
    else															#
    	echo "This File/Directory does not exist, therefore cannot have a UUID assigned."					#
        commandExecuted="UUIDv4 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
    	commandOutput="$writeToFileUUID4, File/Directory does not exist, therefore cannot have a UUID assigned."		#
    	loggingSystem														#
	exit 1															#
    fi																#
    ;;																#
																#
    5) UUID5="$OPTARG"														#5 is also similar to 1/2/3/4
    generatedUUID=$(generateUUID5)												#
    creationDate=$(currentDate)													#
    uuidVersion="5"														#
    fileLocation=$(readlink -f $OPTARG)												#
    if [ ! -e "$fileLocation" ]; then												#
        echo "Error, specified file does not exist, therefore cannot have a UUID assigned"					#
        commandExecuted="UUIDv5 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
    	commandOutput="$writeToFileUUID5, File/Directory does not exist, therefore cannot have a UUID assigned."		#
    	loggingSystem														#
    	exit 1															#
    fi																#
    writeToFileUUID5="UUID : $generatedUUID , Version : $uuidVersion , Creation Date : $creationDate , File Location : $fileLocation " #
    if [[ "$(checkUUIDCollision)" == true ]]; then										#
        echo "UUID Collision Detected, ending process to maintain UUID integrity (UUID)."					#
        commandExecuted="UUIDv5 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
	commandOutput="UUID Collision Detected, 2 identical UUIDs generated, Command Aborted"					#
	loggingSystem														#
        exit 1															#
    fi																#
    if [[ "$(checkExistingUUID)" == true ]]; then										#
        echo "UUID Collision Detected, ending process to maintain UUID integrity (Duplicate File Locations)."			#
        commandExecuted="UUIDv5 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
	commandOutput="UUID Collision Detected, creating 2 of the same UUID type for one file, Command Aborted"			#
	loggingSystem														#
        exit 1															#
    fi																#
    if [[ $(checkfileExistence) == "File" || $(checkfileExistence) == "Directory" ]]; then					#
        writeToFileUUID5="UUID : $generatedUUID , Version : $uuidVersion , Creation Date : $creationDate , Location : $fileLocation , Type : $(checkfileExistence)" #
        saveToFile														#
	commandExecuted="UUIDv5 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
	commandOutput="$writeToFileUUID5, Written to UUIDGeneration.txt and UUID1Generation.txt"				#
	loggingSystem														#
        															#
    else															#
    echo "This File/Directory does not exist, therefore cannot have a UUID assigned."						#
    	commandExecuted="UUIDv5 Generation For, $fileLocation, UUID : $generatedUUID, Type : $(checkfileExistence)"		#
    	commandOutput="$writeToFileUUID5, File/Directory does not exist, therefore cannot have a UUID assigned."		#
    	loggingSystem														#
	exit 1															#
    fi																#
    ;;																#
    P)  previousGenNum="$OPTARG"												#Collects number to be used in previousGenNum script
    ;;																#
    F) targetDirectory="$OPTARG"												#Collects Directory to be used in F script
    ;;																#
    S) directorySize="$OPTARG"													#Collects Directory to be used in S script
    ;;																#
    L) sortbyLength="$OPTARG"													#Collects Directory to be used in L script
																#
    ;;																#
    \?) echo "Invalid option: -$OPTARG" >&2											#Sends invalid option message, if use inputs option that doesn't exist
    ;;																#
    esac															#
done																#end of optargs
################################################################################################ MAIN (Flags and Arguments) #############################################################################################################
																#
																#
##################################################################################################### TERMINAL OUTPUTS ##################################################################################################################
																#
if [[ $terminalOutput = true ]]; then												#Outputs for if Terminal (-T) option is in command
																#
#################################################################################################### Get Generated UUID #################################################################################################################
    if [ -n "$targetFileG" ]; then												#
																#checks if variable is not empty
    	if [ -e "$targetFileG" ]; then 												#checks if targetFileG exists
		if grep -q "$targetFileG" "UUIDGeneration.txt"; then								#checks if targetFileG is found within UUID Generation
			echo "------------------------------------- UUIDs for $targetFileG -------------------------------------" #Spacers
			grep -w "$targetFileG" UUIDGeneration.txt								#Get's line for where targetFileG is found
			echo "--------------------------------------------------------------------------------------------------" #Spacers
			commandExecuted="$targetFile UUID grabbed using -G option and outputted to Terminal"			#message for log file
    			commandOutput="$(grep -w "$targetFileG" UUIDGeneration.txt)"						#message for log file
    			loggingSystem												#sends variables to logging system
		else														#
			echo "UUID not Generated for $targetFileG"								#Error message if erronous date is inputted
			commandExecuted="$targetFile UUID attempted to grabbed using -G option and outputted to Terminal"	#Returns error if empty
			commandOutput="Command failed (UUID not Generated)"							#message for log
			loggingSystem												#sends variables to logging system						
		fi														#
	else															#
		echo "Target File does not exist" 										#Returns error if target file doesn't exist
		commandExecuted="$targetFile UUID attempted to grabbed using -G option and outputted to Terminal"		#Returns error if empty
		commandOutput="Command failed (UUID does not exist)"								#message for log file
		loggingSystem													#sends variables to logging system
    	fi															#
    fi																#
    																#
    if [ -n "$writeToFileUUID1" ]; then												#if UUID1 arg is used in line with terminal output request output to terminal
       	echo "---------------------------------------- Generated UUID1 -----------------------------------------"		#outputs for UUID1
        echo $writeToFileUUID1													#outputs for UUID1
       echo "---------------------------------------------------------------------------------------------------"		#outputs for UUID1
    fi																#
    if [ -n "$writeToFileUUID2" ]; then												#if UUID2 arg is used in line with terminal output request output to terminal
       	echo "---------------------------------------- Generated UUID2 -----------------------------------------"		#outputs for UUID2
        echo $writeToFileUUID2													#outputs for UUID2
       	echo "--------------------------------------------------------------------------------------------------"		#outputs for UUID2
    fi																#
    if [ -n "$writeToFileUUID3" ]; then												#if UUID3 arg is used in line with terminal output request output to terminal
       	echo "---------------------------------------- Generated UUID3 -----------------------------------------"		#outputs for UUID3
        echo $writeToFileUUID3													#outputs for UUID3
       	echo "--------------------------------------------------------------------------------------------------"		#outputs for UUID3
    fi																#
    if [ -n "$writeToFileUUID4" ]; then												#if UUID4 arg is used in line with terminal output request output to terminal
       	echo "---------------------------------------- Generated UUID4 -----------------------------------------"		#outputs for UUID4
        echo $writeToFileUUID4													#outputs for UUID4
       	echo "--------------------------------------------------------------------------------------------------"		#outputs for UUID4
    fi																#
    if [ -n "$writeToFileUUID5" ]; then												#if UUID5 arg is used in line with terminal output request output to terminal
        echo "---------------------------------------- Generated UUID5 -----------------------------------------"		#outputs for UUID5
        echo $writeToFileUUID5													#outputs for UUID5
       	echo "--------------------------------------------------------------------------------------------------"		#outputs for UUID5
    fi																#
    if [[ -n "$previousGenNum" ]]; then												#checks if previousGenerationNumber option is used
        if [[ $previousGenNum =~ ^[0-9]+$ ]]; then										#checks if they are asking for a number
            commandExecuted="Previous Generation command executed, $previousGenNum generations displayed."			#logging system
            commandOutput=$(tail -n "$previousGenNum" UUIDGeneration.txt)							#logging system
            echo "------------------------------------Previous $previousGenNum generated UUIDs displayed------------------------------------" #outputs for previous gen num
            tail -n "$previousGenNum" UUIDGeneration.txt									#outputs for previous gen num
            echo "--------------------------------------------------------------------------------------------------------------------------" #outputs for previous gen num
            loggingSystem													#writes to logfile
        elif [[ $previousGenNum == "A" ]]; then											#checks if asking to print all previous generations
            commandExecuted="Previous Generation command executed, all generations displayed."					#logging system
            commandOutput="$(cat UUIDGeneration.txt)"										#logging system
            echo "-------------------------------------------All Previous generated UUIDs displayed-------------------------------------------" #outputs for previous gen num
            cat UUIDGeneration.txt												#outputs for previous gen num
            echo "----------------------------------------------------------------------------------------------------------------------------" #outputs for previous gen num
            loggingSystem													#logging system
        else															#
            echo "Invalid argument: $previousGenNum should be a number or A"							#echos that user inputted invalid argument, should be number or "A"
            commandExecuted="Previous Generation command executed, Invalid Arguments Errors, displayed."			#logging system
            commandOutput="Invalid Argument message displayed : Invalid argument: $previousGenNum should be a number or A "	#logging system
            loggingSystem													#logging system
        fi															#
    fi																#
    if [[ -n "$targetDirectory" ]]; then											#Code for -F
    		echo "------------------------------------------- Number of Files in $targetDirectory -------------------------------------------" #
                if [[ "$targetDirectory" == "pwd" ]]; then									#if the case is the main directory (-F pwd)
               	echo "Main Directory: $(pwd)"											#echo Directory Name
                echo "Num. Files in Directory: $(ls -1 | wc -l)"								#echo the Num of Files in the Directory
                echo "Num. Files in Directory + Hidden: $(ls -A | wc -l)"							#echo the Num of FIles in the Directory (incl hidden)
                echo "Num. Files, per File Type"										#
                echo "Type    Num."												#
                find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn | awk '{print $2 "      " $1}'  # modified from https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy This calculates the number of file per file type by extension.
                echo "Total Size of Files, Per File Type:"									#
                echo "Type	Total Size (KiB)"										#
                find . -type f | egrep -o "\.[a-zA-Z0-9]+$" | sort -u | LC_ALL=C xargs -I '%' find . -type f -name "*%" -exec du -ch {} + -exec echo % \; | egrep "^\.[a-zA-Z0-9]+$|total$" | sed 's/total//g' | uniq | paste - - #modified from answer from https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension This calculates the total size of file per file type by bytes
                for dir in */; do												#Runs same code through each sub-directory
    		cd "$dir" || continue												#changes directory and runs same code
                	echo "Sub Directory: $(pwd)"										#
                	echo "Num. Files in Directory: $(ls -1 | wc -l)"							#
                	echo "Num. Files in Directory + Hidden: $(ls -A | wc -l)"						#
                	echo "Num. Files, per File Type"									#
                	echo "Type    Num."											#
                	find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn | awk '{print $2 "      " $1}' # modified from https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy                
                	echo "Total Size of Files, Per File Type:"								#
                	echo "Type		Total Size (KiB)"								#
                	find $dir -type f | egrep -o "\.[a-zA-Z0-9]+$" | sort -u | LC_ALL=C xargs -I '%' find . -type f -name "*%" -exec du -ch {} + -exec echo % \; | egrep "^\.[a-zA-Z0-9]+$|total$" | sed 's/total//g' | uniq | paste - - #modified from answer from https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension
    			cd - >/dev/null || exit											#
                done 														#
                commandExecuted="Present Working Directory (PWD , $(pwd)) scanned for Number of Files/Sub-Directories in Directory" #
                commandOutput="Command successfully outputted"									#
                loggingSystem													#
            elif [[ -d "$targetDirectory" ]]; then										#Same code but in this case, the targetDirectory has been specified, and not as "PWD"
                echo "Directory: $targetDirectory"										#
                echo "Num. Files in Directory: $(find "$targetDirectory" -type f | wc -l)"					#
                echo "Num. Files in Directory + Hidden: $(find "$targetDirectory" -type f -o -type d | wc -l)"			#
                echo "Num. Files, Per File Type:"										#
                echo "File Type    Num."											#
                find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn | awk '{print $2 "         " $1}' # modified from https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy       
                echo "Total Size of Files, Per File Type:"									#
                echo "Type	Total Size (KiB)"										#
                find . -type f | egrep -o "\.[a-zA-Z0-9]+$" | sort -u | LC_ALL=C xargs -I '%' find . -type f -name "*%" -exec du -ch {} + -exec echo % \; | egrep "^\.[a-zA-Z0-9]+$|total$" | sed 's/total//g' | uniq | paste - - #modified from answer from https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension
  																#
             for dir in $targetDirectory/*/; do											#
    		cd "$dir" || continue												#
                	echo "Sub Directory: $(pwd)"										#
                	echo "Num. Files in Directory: $(ls -1 | wc -l)"							#
                	echo "Num. Files in Directory + Hidden: $(ls -A | wc -l)"						#
                	echo "Num. Files, per File Type"									#
                	echo "File Type    Num."										#
                	find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn | awk '{print $2 "      " $1}' # modified from https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy                
                	echo "Total Size of Files, Per File Type:"								#
                	echo "Type	Total Size (KiB)"									#
                	find . -type f | egrep -o "\.[a-zA-Z0-9]+$" | sort -u | LC_ALL=C xargs -I '%' find . -type f -name "*%" -exec du -ch {} + -exec echo % \; | egrep "^\.[a-zA-Z0-9]+$|total$" | sed 's/total//g' | uniq | paste - - #modified from answer from https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension
    			cd - >/dev/null || exit											#
                done														#
                echo "----------------------------------------------------------------------------------------------------------------------------"
                commandExecuted="$targetDirectory scanned for Number of Files/Sub-Directories in Directory."			#
                commandOutput="Command Successfully Outputted" 												#
                loggingSystem													#
            else														#
                echo "Error: Target directory does not exist."									#
                commandExecuted="Errorneous, Directory scan for Number of Files/Sub-Directories in Directory attempted."	#
                commandOutput="Error: Target directory does not exist. Command Execution Aborted." 				#
                loggingSystem													#
            fi															#
    fi																#
																#
    if [[ -n "$directorySize" ]]; then												#
    	    echo "------------------------------------------ Size of $directorySize ------------------------------------------"	#
	    if [[ "$directorySize" == "pwd" ]]; then										#
																#
	    echo "Directory: $PWD"												#
	    echo "Size of Directory (Not Incl. Subdirectories) :  $(du -shS $PWD | awk '{print $1}')b"				#
	    echo "Size of Directory (Incl. Subdirectories) : $(du -sh $PWD | awk '{print $1}')b"				#
	    echo "Size of Directory (Incl. Hidden Files) :  $(find $PWD -type f -exec du -ch {} + | grep total | awk '{print $1}')b" #
	    	for dir in */; do												#Checks Size of subdirectories by iterating same command over directories
	    	    	if [ -d "$dir" ]; then											#
			cd "$dir" || continue											#
			echo "Size of Subdirectory (~/$dir) : $(du -sh $PWD | awk '{print $1}')b"				#
			cd - >/dev/null || exit											#
			fi													#
	    	done														#
	    	commandExecuted="Directory/Sub-Directory ($(pwd)) size scan attempted on Present Working Directory (PWD)"	#
		commandOutput="Command Successfully Outputted" 									#
		loggingSystem													#
	    															#
	    elif [[ -d "$directorySize" ]]; then										#
	    echo "Directory: $(readlink -f $directorySize)"									#
	    echo "Size of Directory (Not Incl. Subdirectories) : $(du -shS $directorySize | awk '{print $1}')b"			#
	    echo "Size of Directory (Incl. Subdirectories) : $(du -sh $directorySize | awk '{print $1}')b"			#
	    echo "Size of Directory (Incl. Hidden Files) :  $(find $directorySize -type f -exec du -ch {} + | grep total | awk '{print $1}')b" #
	    	for dir in "$directorySize"/*; do										#
	    		if [ -d "$dir" ]; then											#
			cd "$dir" || continue											#
			echo "Size of Subdirectory ($dir) : $(du -sh | awk '{print $1}')b"					#
			cd - >/dev/null || exit											#
			fi													#
	    	done														#
	    	echo "------------------------------------------------------------------------------------------------------------" #								
	    	commandExecuted="Directory/Sub-Directory size scan attempted on $directorySize"					#
		commandOutput="Command Successfully Outputted" 												#
		loggingSystem													#
	    															#
	    elif [[ ! -d "$directorySize" ]]; then										#
	    	echo "Error, Invalid directory." 										#
	    	commandExecuted="Directory/Sub-Directory size scan attempted"							#
		commandOutput="Error Occured, Invalid Directory inputtted, process aborted." 					#
		loggingSystem													#
	    	exit 1														#
	    else 														#
	    	echo "Fatal Error Occurred, exiting process."									#
	    	commandExecuted="Directory/Sub-Directory size scan attempted"							#
		commandOutput="Fatal Error Occured, Process aborted." 								#
		loggingSystem													#
	    	exit 1														#
	    fi															#
    fi																#
																#
    if [[ -n "$sortbyLength" ]]; then												#
    	    echo "------------------------------------------ Sort Files in $sortbyLength by Length ------------------------------------------" #
	    echo "Directory: $(readlink -f $sortbyLength)"    									#
	    echo "Files in Longest to Shortest Format:"										#
	    echo "Name 	 Length"												#
	    if [[ "$sortbyLength" == "pwd" ]]; then										#
		filenames=()													#
	    	lengths=()													#
	    	for file in *    												#
	    	do														#
			if [[ -n "$file" ]]; then  										#
		    	filename=$(basename "$file")  										#
		    	length=${#filename}           										#
		    	filenames+=("$filename") 										#Inspired by Answer from https://www.unix.com/shell-programming-and-scripting/67581-find-length-file-names-directory.html
		    	lengths+=("$length")											#
			fi													#
	    	done														#
		paste <(printf "%s\n" "${filenames[@]}") <(printf "%s\n" "${lengths[@]}") | sort -k2,2nr | while IFS=$'\t' read -r filename length; do #
																#
	    echo "$filename : $length"												#
																#
	    done														#
	    echo "Shortest File Length : ${filenames[-1]}"									#
	    echo "Longest File Length : ${filenames[0]}"									#
	    															#
	    commandExecuted="File Name Length scan attempted on PWD $(pwd)"							#
	    commandOutput="Command successfully outputted"									#
	    loggingSystem													#
																#
	    elif [[ -d "$sortbyLength" ]]; then											#
		cd "$sortbyLength" || continue 											#
			filenames=()												#
	    		lengths=()												#
	    	for file in *    												#
	  		do													#
				if [[ -n "$file" ]]; then  									#
		    			filename=$(basename "$file")  								#
		    			length=${#filename}           								#
		    			filenames+=("$filename") 								#Inspired by Answer from https://www.unix.com/shell-programming-and-scripting/67581-find-length-file-names-directory.html
		    			lengths+=("$length")									#
				fi												#
	    		done													#
		paste <(printf "%s\n" "${filenames[@]}") <(printf "%s\n" "${lengths[@]}") | sort -k2,2nr | while IFS=$'\t' read -r filename length; do #
																#
	    	echo "$filename : $length"											#
																#
	    done														#
	    echo "Shortest File Length : ${filenames[-1]}"									#
	    echo "Longest File Length : ${filenames[0]}"									#
	    cd - >/dev/null || exit												#
	    echo "------------------------------------------------------------------------------------------------------------" #
	    commandExecuted="File Name Length scan attempted on PWD $sortByLength"						#
	    commandOutput="Command Successfully Outputted"									#
	    loggingSystem													#
	    															#
	    elif [[ ! -d "$sortbyLength" ]]; then										#
		echo "Error, Invalid directory." 										#
	    	commandExecuted="File Name Length scan attempted"								#
	    	commandOutput="Error Occured, File Name Length Scan aborted, Invalid Directory"					#
	    	loggingSystem													#
	    exit 1														#
	    else														#
		echo "Fatal Error Occurred, exiting process."									#
		commandExecuted="File Name Length scan attempted"								#
	    	commandOutput="Fatal Error Occured, File Name Length Scan aborted"						#
	    	loggingSystem													#
	    	exit 1														#
	 fi															#
    fi																#
fi																#
###################################################################################################### TERMINAL OUTPUTS #################################################################################################################
																#
																#
#################################################################################################### WRITE TO FILE OUTPUTS ##############################################################################################################
																# Same commands but writes to specified file instead
if [[ $writeFileOutput = true ]]; then												#
    if [ -n "$targetFileG" ]; then												#
																#
    	if [ -e "$targetFileG" ]; then 												#
		if grep -q "$targetFileG" "UUIDGeneration.txt"; then								#
			echo "------------------------------------- UUIDs for $targetFileG -------------------------------------" >> "$specifiedFile"
			grep -w "$targetFileG" UUIDGeneration.txt >> "$specifiedFile"
			echo "--------------------------------------------------------------------------------------------------" >> "$specifiedFile"
		else														#
			echo "UUID not Generated for $targetFileG"								#
		fi														#
	else															#
		echo "Target File does not exist" 										#
    	fi															#
    fi																#
    if [ -n "$writeToFileUUID1" ]; then												#
    	echo "---------------------------------------- Generated UUID1 -----------------------------------------" >> "$specifiedFile" #
    	echo "$writeToFile" >> "$specifiedFile"											#
    	echo "--------------------------------------------------------------------------------------------------" >> "$specifiedFile" #
    fi																#
    if [ -n "$writeToFileUUID2" ]; then												#
        echo "---------------------------------------- Generated UUID2 -----------------------------------------">> "$specifiedFile" #
    	echo "$writeToFile" >> "$specifiedFile"											#
    	echo "--------------------------------------------------------------------------------------------------">> "$specifiedFile" #
    fi																#
    if [ -n "$writeToFileUUID3" ]; then												#
        echo "---------------------------------------- Generated UUID3 -----------------------------------------">> "$specifiedFile" #
    	echo "$writeToFile" >> "$specifiedFile"											#
        echo "--------------------------------------------------------------------------------------------------">> "$specifiedFile" #
    fi																#
    if [ -n "$writeToFileUUID4" ]; then												#
        echo "---------------------------------------- Generated UUID4 -----------------------------------------">> "$specifiedFile" #
    	echo "$writeToFile" >> "$specifiedFile"
 	echo "--------------------------------------------------------------------------------------------------">> "$specifiedFile" #
    fi																#
    if [ -n "$writeToFileUUID5" ]; then												#
        echo "---------------------------------------- Generated UUID5 -----------------------------------------">> "$specifiedFile" #
    	echo "$writeToFile" >> "$specifiedFile"											#
 	echo "--------------------------------------------------------------------------------------------------">> "$specifiedFile" #
    if [[ -n "$previousGenNum" ]]; then												#
        if [[ $previousGenNum =~ ^[0-9]+$ ]]; then										#
            commandExecuted="Previous Generation command executed, $previousGenNum generations written to $specifiedFile"	#
            commandOutput=$(tail -n "$previousGenNum" UUIDGeneration.txt)							#
	    echo "------------------------------------Previous $previousGenNum generated UUIDs displayed------------------------------------">> "$specifiedFile" #
            tail -n "$previousGenNum" UUIDGeneration.txt >> "$specifiedFile"							#
            echo "------------------------------------------------------------------------------------------------------------">> "$specifiedFile" #
            loggingSystem													#
        elif [[ $previousGenNum == "A" ]]; then											#
            commandExecuted="Previous Generation command executed, all generations written to $specifiedFile."			#
            commandOutput="$(cat UUIDGeneration.txt)"										#
            echo "-------------------------------------------All Previous generated UUIDs displayed-------------------------------------------"	>> "$specifiedFile" #
            cat UUIDGeneration.txt >> "$specifiedFile"										#
            echo "----------------------------------------------------------------------------------------------------------------------------"	>> "$specifiedFile" #										
            loggingSystem													#
        else															#
            echo "Invalid argument: $previousGenNum should be a number or A"							#
            commandExecuted="Previous Generation command executed, Invalid Arguments Errors, displayed."			#
            commandOutput="Invalid Argument message displayed : Invalid argument: $previousGenNum should be a number or A "	#
            loggingSystem													#
        fi															#
    fi																#
    if [[ -n "$targetDirectory" ]]; then											#
        echo "------------------------------------------- Number of Files in $targetDirectory -------------------------------------------" >> "$specifiedFile" #
    	if [[ "$targetDirectory" == "pwd" ]]; then										#
               	echo "Main Directory: $(pwd)" >> "$specifiedFile"								#
                echo "Num. Files in Directory: $(ls -1 | wc -l)" >> "$specifiedFile"						#
                echo "Num. Files in Directory + Hidden: $(ls -A | wc -l)" >> "$specifiedFile"					#
                echo "Num. Files, per File Type" >> "$specifiedFile"								#
                echo "Type    Num." >> "$specifiedFile"										#
                find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn | awk '{print $2 "      " $1}' >> "$specifiedFile" # modified from https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy 
                echo "Total Size of Files, Per File Type:" >> "$specifiedFile"							#
                echo "Type	Total Size (KiB)" >> "$specifiedFile"								#
                find . -type f | egrep -o "\.[a-zA-Z0-9]+$" | sort -u | LC_ALL=C xargs -I '%' find . -type f -name "*%" -exec du -ch {} + -exec echo % \; | egrep "^\.[a-zA-Z0-9]+$|total$" | sed 's/total//g' | uniq | paste - - >> "$specifiedFile" #modified from answer from https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension
                for dir in */; do												#
    		cd "$dir" || continue												#
                	echo "Sub Directory: $(pwd)" >> "$specifiedFile"							#
                	echo "Num. Files in Directory: $(ls -1 | wc -l)" >> "$specifiedFile"					#
                	echo "Num. Files in Directory + Hidden: $(ls -A | wc -l)" >> "$specifiedFile"				#
                	echo "Num. Files, per File Type" >> "$specifiedFile"							#
                	echo "Type    Num."  >> "$specifiedFile"								#
                	find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn | awk '{print $2 "      " $1}'  >> "$specifiedFile" # modified from https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy                
                	echo "Total Size of Files, Per File Type:"  >> "$specifiedFile"						#
                	echo "Type		Total Size (KiB)"  >> "$specifiedFile"						#
                	find $dir -type f | egrep -o "\.[a-zA-Z0-9]+$" | sort -u | LC_ALL=C xargs -I '%' find . -type f -name "*%" -exec du -ch {} + -exec echo % \; | egrep "^\.[a-zA-Z0-9]+$|total$" | sed 's/total//g' | uniq | paste - -  >> "$specifiedFile" #modified from answer from https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension
    			cd - >/dev/null || exit											#
                done 														#
                commandExecuted="Present Working Directory (PWD , $(pwd)) scanned for Number of Files/Sub-Directories in Directory" #
                commandOutput=""												#
                loggingSystem													#
            elif [[ -d "$targetDirectory" ]]; then										#
                echo "Directory: $targetDirectory"  >> "$specifiedFile"								#
                echo "Num. Files in Directory: $(find "$targetDirectory" -type f | wc -l)"  >> "$specifiedFile"			#
                echo "Num. Files in Directory + Hidden: $(find "$targetDirectory" -type f -o -type d | wc -l)"  >> "$specifiedFile" #
                echo "Num. Files, Per File Type:"  >> "$specifiedFile"								#
                echo "File Type    Num."  >> "$specifiedFile"									#
                find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn | awk '{print $2 "         " $1}'   >> "$specifiedFile" # modified from https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy       
                echo "Total Size of Files, Per File Type:"  >> "$specifiedFile"							#
                echo "Type	Total Size (KiB)"  >> "$specifiedFile"								#
                find . -type f | egrep -o "\.[a-zA-Z0-9]+$" | sort -u | LC_ALL=C xargs -I '%' find . -type f -name "*%" -exec du -ch {} + -exec echo % \; | egrep "^\.[a-zA-Z0-9]+$|total$" | sed 's/total//g' | uniq | paste - -  >> "$specifiedFile" #modified from answer from https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension
                
             for dir in $targetDirectory/*/; do											#
    		cd "$dir" || continue												#
                	echo "Sub Directory: $(pwd)"  >> "$specifiedFile"							#
                	echo "Num. Files in Directory: $(ls -1 | wc -l)"  >> "$specifiedFile"					#
                	echo "Num. Files in Directory + Hidden: $(ls -A | wc -l)"  >> "$specifiedFile"				#
                	echo "Num. Files, per File Type"  >> "$specifiedFile"							#
                	echo "File Type    Num."  >> "$specifiedFile"								#
                	find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn | awk '{print $2 "      " $1}'  >> "$specifiedFile" # modified from https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy                
                	echo "Total Size of Files, Per File Type:"  >> "$specifiedFile"						#
                	echo "Type	Total Size (KiB)"  >> "$specifiedFile"							#
                	find . -type f | egrep -o "\.[a-zA-Z0-9]+$" | sort -u | LC_ALL=C xargs -I '%' find . -type f -name "*%" -exec du -ch {} + -exec echo % \; | egrep "^\.[a-zA-Z0-9]+$|total$" | sed 's/total//g' | uniq | paste - -  >> "$specifiedFile" #modified from answer from https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension
    			cd - >/dev/null || exit											#
                done														#
                echo "----------------------------------------------------------------------------------------------------------------------------" >> "$specifiedFile"
                commandExecuted="$targetDirectory scanned for Number of Files/Sub-Directories in Directory."			#
                commandOutput="Command Sucessfully Outputted" 												#
                loggingSystem													#
            else														#
                echo "Error: Target directory does not exist."									#
                commandExecuted="Errorneous, Directory scan for Number of Files/Sub-Directories in Directory attempted."	#
                commandOutput="Error: Target directory does not exist. Command Execution Aborted." 				#
                loggingSystem													#
            fi															#
    fi																#
																#
    if [[ -n "$directorySize" ]]; then												#
            echo "------------------------------------------ Size of $directorySize ------------------------------------------"	>> "$specifiedFile" #
    	    if [[ "$directorySize" == "pwd" ]]; then										#
	    echo "Directory: $PWD" >> "$specifiedFile"										#
	    echo "Size of Directory (Not Incl. Subdirectories) :  $(du -shS $PWD | awk '{print $1}')b"	>> "$specifiedFile"     #
	    echo "Size of Directory (Incl. Subdirectories) : $(du -sh $PWD | awk '{print $1}')b" >> "$specifiedFile"		#
	    echo "Size of Directory (Incl. Hidden Files) :  $(find $PWD -type f -exec du -ch {} + | grep total | awk '{print $1}')b" >> "$specifiedFile" #
	    	for dir in */; do												#
	    	    	if [ -d "$dir" ]; then											#
			cd "$dir" || continue											#
			echo "Size of Subdirectory (~/$dir) : $(du -sh $PWD | awk '{print $1}')b" >> "$specifiedFile"		#
			cd - >/dev/null || exit											#
			fi													#
	    	done														#
	    	commandExecuted="Directory/Sub-Directory size scan attempted on Present Working Directory (PWD)"		#
		commandOutput="Command Sucessfully Outputted" 												#
		loggingSystem													#
	    															#
	    elif [[ -d "$directorySize" ]]; then										#
	    echo "Directory: $(readlink -f $directorySize)" >> "$specifiedFile"							#
	    echo "Size of Directory (Not Incl. Subdirectories) : $(du -shS $directorySize | awk '{print $1}')b"	>> "$specifiedFile" #
	    echo "Size of Directory (Incl. Subdirectories) : $(du -sh $directorySize | awk '{print $1}')b" >> "$specifiedFile"  #
	    echo "Size of Directory (Incl. Hidden Files) :  $(find $directorySize -type f -exec du -ch {} + | grep total | awk '{print $1}')b"  >> "$specifiedFile" #
	    	for dir in "$directorySize"/*; do										#
	    		if [ -d "$dir" ]; then											#
			cd "$dir" || continue											#
			echo "Size of Subdirectory ($dir) : $(du -sh | awk '{print $1}')b" >> "$specifiedFile"			#
			cd - >/dev/null || exit											#
			fi													#
	    	done														#
	    	echo "------------------------------------------------------------------------------------------------------------"	>> "$specifiedFile" #
	    	commandExecuted="Directory/Sub-Directory size scan attempted on $directorySize"					#
		commandOutput="Command Sucessfully Outputted" 												#
		loggingSystem													#
	    															#
	    elif [[ ! -d "$directorySize" ]]; then										#
	    	echo "Error, Invalid directory." 										#
	    	commandExecuted="Directory/Sub-Directory size scan attempted"							#
		commandOutput="Error Occured, Invalid Directory inputtted, process aborted." 					#
		loggingSystem													#
	    	exit 1														#
	    else 														#
	    	echo "Fatal Error Occurred, exiting process."									#
	    	commandExecuted="Directory/Sub-Directory size scan attempted"							#
		commandOutput="Fatal Error Occured, Process aborted." 								#
		loggingSystem													#
	    	exit 1														#
	    fi															#
	fi															#
																#
																#
    if [[ -n "$sortbyLength" ]]; then												#
            echo "------------------------------------------ Sort Files in $sortbyLength by Length ------------------------------------------" >> "$specifiedFile" #
	    echo "Directory: $(readlink -f $sortbyLength)" >> "$specifiedFile"	   						#
	    echo "Files in Longest to Shortest Format:" >> "$specifiedFile"							#
	    echo "Name 	 Length" >> "$specifiedFile"										#
	    if [[ "$sortbyLength" == "pwd" ]]; then										#
		filenames=()													#
	    	lengths=()													#
	    	for file in *    												#
	    	do														#
			if [[ -n "$file" ]]; then  										#
		    	filename=$(basename "$file")  										#
		    	length=${#filename}           										#
		    	filenames+=("$filename") 										#Inspired by Answer from https://www.unix.com/shell-programming-and-scripting/67581-find-length-file-names-directory.html
		    	lengths+=("$length")											#
			fi													#
	    	done														#
		paste <(printf "%s\n" "${filenames[@]}") <(printf "%s\n" "${lengths[@]}") | sort -k2,2nr | while IFS=$'\t' read -r filename length; do #
																#
	    echo "$filename : $length" >> "$specifiedFile"									#
	    done														#
	    echo "Shortest File Length : ${filenames[-1]}" >> "$specifiedFile"							#
	    echo "Longest File Length : ${filenames[0]}" >> "$specifiedFile"							#
	    															#
	    commandExecuted="File Name Length scan attempted on PWD $(pwd)"							#
	    commandOutput="Command Sucessfully Outputted"													#
	    loggingSystem													#
																#
	    elif [[ -d "$sortbyLength" ]]; then											#
		cd "$sortbyLength" || continue 											#
			filenames=()												#
	    		lengths=()												#
	    	for file in *    												#
	  		do													#
				if [[ -n "$file" ]]; then  									#
		    			filename=$(basename "$file")  								#
		    			length=${#filename}       								#
		    			filenames+=("$filename") 								#Inspired by Answer from https://www.unix.com/shell-programming-and-scripting/67581-find-length-file-name
		    			lengths+=("$length")									#
				fi												#
	    		done													#
		paste <(printf "%s\n" "${filenames[@]}") <(printf "%s\n" "${lengths[@]}") | sort -k2,2nr | while IFS=$'\t' read -r filename length; do #
																#
	    	echo "$filename : $length" >> "$specifiedFile"									#
																#
	    done														#
	    echo "Shortest File Length : ${filenames[-1]}" >> "$specifiedFile"							#
	    echo "Longest File Length : ${filenames[0]}" >> "$specifiedFile"							#
	    cd - >/dev/null || exit												#
	    echo "---------------------------------------------------------------------------------------------------------------------------" >> "$specifiedFile" #						
	    commandExecuted="File Name Length scan attempted on PWD $sortByLength"						#
	    commandOutput=""													#
	    loggingSystem													#
	    															#
	    elif [[ ! -d "$sortbyLength" ]]; then										#
		echo "Error, Invalid directory." 										#
	    	commandExecuted="File Name Length scan attempted"								#
	    	commandOutput="Error Occured, File Name Length Scan aborted, Invalid Directory"					#
	    	loggingSystem													#
	    exit 1														#
	    else														#
		echo "Fatal Error Occurred, exiting process."									#
		commandExecuted="File Name Length scan attempted"								#
	    	commandOutput="Fatal Error Occured, File Name Length Scan aborted"						#
	    	loggingSystem													#
	    	exit 1														#
	 	fi														#
    	    fi															#
	fi															#
fi																#
																#
																#
}																#
########################################################################################################### MAIN ########################################################################################################################
																#
main "$@"															#
																#
																#																
																#
