
# Author : BHANSALI MUKESH KUMAR
# This Utility Script provides many useful aliases and help to work with git

# Step You May Follow for Usage 
	#1 Save this file on your Computer ( $HOME/Git.sh, You may save at other location but that will lead to some other changes like, See custom and profile section for more )
	#2 You May Move Entire "Profile Section" to your profile file ( .bash_profile or so ), Need to remove '#' for run command for this file, See profile section for more
		# If You Don't Move "Profile Section" Then At Least You Need to Run This File to Use This Utitlity
	#3 Change Name and Workspace Direstories/Repositories, See Custom Section for more
	#4 Type "Help", It Will Show You Everything it Has
	#5 Type "Usage" for Help on Set up and Usage
	#6 You can also Add, Update aliases here, and If You Provides Proper Comments Above Your Commands, That Will Also Be Visible in Help
alias Usage='Help Usage';

# Another Name for Usage
alias Setup='Usage';   

###### %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PROFILE SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ######

# This Section should be added in start-up profile file ( .bash_profile etc )
# . ~/.Git.sh ( Remove '#' and add to profile, Run this file on login )

# Going back to the calling directory when things are done
alias Back='cd - > /dev/null; echo -e "\a" ';

# Helpful Short-cut not related to Git

# Clear Screen
alias c=clear

# Show Alias's Actual Command String
alias a=alias

###### ------------------------------------------ HELP SECTION ------------------------------------------ ######

# Just type "Help" on Terminal
# If Help is Followed By Some Special Command then it will Show Help for that Command
# Else Displaying Help with Pagination ( Press Enter or Space to Scroll, "q" to Quite )
# If you Add, Update and Command in this Utility with Proper Comment, it will Automatically Visible in Help as well. 
alias Help='function JASOL() { Document=`Help_Document`; if [ M"$1" = "M" ]; then echo "$Document"| less; return; fi;  echo ""; echo "$Document" | sed -n "/^"$1"/,/^$/p"; }; JASOL'

# Generating Help Document from the Source on Runtime
alias Help_Document='function MB() { Comment_Character="#"; Alias_Character="alias"; Help=""; Alias=""; while read line; do if [[ $line == $Comment_Character* ]]; then Help="$Help""\n""$line"; else Alias_Found=`echo "$line"| grep $Alias_Character`; if [[ M"$Alias_Found" != "M" ]]; then Alias=`echo "$line"| cut -d"=" -f1 | tr -s " "| cut -d" " -f2`; if [[ M"$Alias" != "M" ]]; then echo -e "\n$Alias" : "$Help"; Help=""; fi; else Help=""; fi; fi; done < "$FILENAME"; }; MB'

###### {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{ CUSTOM SECTION }{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{} ###### 

# Script File Name, I have Saved this file under this Path and Name, you may vary But then will needs to run the Same from Profile file
FILENAME="$HOME/Git.sh"

# PLEASE CHANGE BELOW GIT AUTHOR NAME AND WORKSPACE

#* Used for checking My Git Log, You Need to Put You Name in Git Log, Need to Change
export NAME="Bhansali";

#* Global Environment Variables, Change to your top level repository Path, Need to Change
export ROOT=$HOME"/BHANSALI_WORKSPACE/product-root";

# Some Repositories, you can define yours n number of repositories here
export BASE=$ROOT"/src/product-base";
export CORE=$ROOT"/src/product-core";
export GRAPH=$ROOT"/src/prodcut-graphics";

###### ***************************************** GIT ALIASES ***************************************** ###### 

# Set Alias "Git" to Open this File
alias Git="vi $FILENAME";

# Default Repository where I work most of the time.
export WORKSPACE="$BASE";

# Goes to Workspace Directory
alias Workspace='cd $WORKSPACE';

# Goes to product-root ( Some Specific Repository )
alias root="cd $ROOT";

# Goes to product-base ( Some Specific Repository )
alias base="cd $BASE";

# Goes to product-core ( Some Specific Repository )
alias core="cd $CORE";

# Goes to product-graphics ( Some Specific Repository )
alias g="cd $GRAPH";

# npm sync in product-root ( Running some kind of sync, setup etc. after taking latest code )
alias SYNC='root; npm run sync; Back';

# Shows All Branches in Repository
alias Branch="git branch";

# Shows current git branch
alias Current='Branch| grep \* | cut -d" " -f2;'

# Checkout to a git branch
alias Checkout='From=`Current`; git checkout'

# Creates and checks out the same git branch
# You can switch to your branch any time by just typing it's Jira id
# Example 
#        Branch Name : NGCONT-1745_Infiniti-Create-new-homepage-outlines
#        Just Fire Command : Create NGCONT-1745_Infiniti-Create-new-homepage-outlines
# Now if I type "1745" on terminal Anytime, I am switched to this Branch        
alias Create='function MBMB(){ story=`echo $1| cut -d'-' -f2`; jira=`echo $story| cut -d'_' -f1`; alias $jira="From=`Current`; git checkout $1"; git checkout -b $1; echo -e "\t\tType " \"$jira\" " to Jump to this Branch, Anytime"; };MBMB'

# Goes to PREVIOUS git branch
alias Previous='Present=$From; Checkout $Present';

# Goes to Master Branch
alias Master='Checkout master';

# Pulls origin Master ( Merge Latest From Master Branch )
alias Origin='git pull origin master';

# Remove git branch
alias Remove="git branch -D";

# Deletes the branch you are currently on
alias Delete='Me=`Current`; echo press Y to delete branch \"$Me\"; read confirm; if [ $confirm == "Y" ]; then Master; Remove $Me; else echo Action Cancelled; fi;'

# Adds files to Commit
alias Add='git add';

#Commits Added File in Branch for Permanent Changes
alias Commit='git commit -m';

# Push Current Branch
alias Push='me=`Current`; git push --set-upstream origin $me'

# It Needs "Commit Message" in double quotes as Parameter.
# Add, Commit and Push in 1 Shot ( Makes Our Branch Available in Remote Server, Also Used in Recovery, Share and Review Changes )
alias Stage='function MKBJ(){ modified=`?|grep "modified"| wc -l`; echo $modified; if [ "$modified" -eq 0 ]; then echo -e "\nNo Changes to Stage\n"; return; fi; echo -e "Following Files are Modified.\n"; ?| grep "modified"; echo -e "Press Y to Stage All\n"; read confirm; if [ $confirm == "Y" ]; then Add .; Commit "$1"; Push; else echo -e "Action Cancelled \n"; fi;}; MKBJ'

# Briefs for all current local git branches
alias Last='git branch -vv';

# Fetches Remote Branch into your Local But DO NOT Merge Changes into Your Local Branch.
alias Ffetch='git fetch';

# Before fetching, remove any remote-tracking references that no longer exist on the remote ( Recommended )
alias Fetch='git fetch --prune';

# Merges Changes into Branch
alias Merge='git Merge';

# Fetches Remote Branch into your Local and Merges Changes into Your Local Branch ( Fetch + Merge ) .
alias Pull='git pull';

# Gives List of All Modified Files
alias ?='git status';

# Delete All Local git branches except Master
alias Delete_But='Master; git branch | tr -s " "| cut -d" " -f2 | grep -v master | xargs git branch -d;'

# Saves Change Point to Rollback in Future, If Needed
alias Sstash='git stash';

# Adds Modified Files and Saves in Stash List
alias Shelve='Add .; shelved=`Sstash | grep "Saved working directory"`'

# Takes Branch to The Latest Saved Stage
alias UnShelve='if [ M"$shelved" != "M" ]; then Pop; fi'

# Goes to Latest Saved Change Point
alias Pop='Sstash pop';

# Switch to Master Branch if not on Master
alias Switch='this=`Current`; if [ $this != 'master' ]; then Shelve; Master; fi'

# Switch Back to the Origin Branch and Goes to the Saved Changes Point
alias Switch_Back='if [ $this != 'master' ]; then Previous; UnShelve; fi';

# Clean UnTracked Files and Directories
alias Clean='git clean -fdx';

# Resets given File ( As Argument )
alias Rreset='git reset'

# Resets All Files ( dot denotes All )
alias Reset='git reset .;'

# Stash Changes including untracked file ( -u )
# Untracked files are the Files which are not in remote repositories ( Newly Added Files ) etc.
# Undo local changes
alias Save_Clean='git stash -u';

# Revert Code to Origin Master
alias Revert='Fetch; git reset --hard origin/master; Clean'

# Fetches Remote Branch and Merge it into Local Brach ( Pull ) and Downloads Dependencies ( SYNC ) 
alias update='Pull; SYNC'

# Takes Pull in all Repositories.
alias UPDATE='At=`pwd`; root; cd src/node_modules; for repository in `ls`; do if [ -d "$repository" ]; then cd $repository; Switch; Pull; Switch_Back; Back; fi; done; cd $At'

# Takes Pull in all Repositories and Downloads Dependencies.
# It Help Sometime Resolving Server Start-up issue
alias Update_Sync='UPDATE; SYNC'

# Checkout Master and Take Latest from Remote
alias sync_master='Switch; Save_Clean; Revert; Switch_Back'

# Get Latest of master Branch in all Repositories
alias Sync_MASTERS='At=`pwd`; root; cd src/node_modules; for repository in `ls`; do if [ -d "$repository" ]; then echo -e "\n\t\tUpdating master branch in Repository : \t $repository\n"; cd $repository; sync_master; Back; fi; done; cd $At'

# Checkout Master and Take Latest for all Repositories under $ROOT
alias Latest='Sync_MASTERS;  SYNC;'

# Checkout Master in every Repository under $ROOT
alias MASTERS='At=`pwd`; root; cd src/node_modules; for repository in `ls`; do if [ -d "$repository" ]; then echo -e "\n\t\tCheckout Branch master in Repository : \t $repository\n"; cd $repository; Master; Back; fi; done; cd $At;'

# Shows All Branches ( Selected Branch is With * ) For Every Repository Under $DEV
alias ShowAllBranches='At=`pwd`; dev; cd src/node_modules; for repository in `ls`; do if [ -d "$repository" ]; then cd $repository; echo -e "\t\t\t\t ***************** $repository ***************** \n"; Branch; Back; fi; done; cd $At'

# Checkout Specified Branch ( Supplied Parameter, $1 ) in Every Repository Under $DEV, If Branch is Present
alias CheckoutAll='function BHANSALI() { At=`pwd`; dev; cd src/node_modules; echo -e "\n\n"; for repository in `ls`; do if [ -d "$repository" ]; then cd $repository; echo -e "\t\t\t\t ***************** $repository ***************** \n"; checkIfBranch; Back; fi; done; cd $At; }; BHANSALI'

# Being Used With 'CheckoutAll', Needs Improvement For Re-use Purpose
alias checkIfBranch='for branch in `git branch | tr -s " " | cut -d" " -f2`; do if [ "$1" = "$branch" ]; then echo -e "\n\t\tChecking out Branch \"${1}\" in Repository : \t $repository\n"; Checkout $1; fi; done'

# Rebase to Origin Master Branch
alias Rebase='git rebase origin master;'

# Git Log
alias Log='git log';

# Shows git logs related to YOU only ( Filtered Logs )
alias My='Workspace; git log --author $NAME; Back;'

# git Logs for specific Author
alias Author='git log --author';

# git logs since $date
alias Since='git log --since';

# git Logs for TODAY's changes
alias Today='date +%F| xargs git log --since';

# git Logs for Changes Since YESTERDAY
alias Yesterday='date -v-1d +%F| xargs git log --since';

# Set up product-root environment
alias SETUP_ROOT='git clone http://'"$USER"'@stash.cdk.com/scm/bhansali/product-root.git; npm run setup';

# Set up Specific Repository ( Needs ${repository_name} as Argument)
alias CLONE='root; npm run clone -- '

# Needs a Parameter ( Commit Id ) to Revert 
alias Git_Revert='git revert';

# In case if you change your password and git doesn't know it
# Erase git cached Password ( Press Enter Twice )
alias Git_Erase_Password='git credential-osxkeychain erase';
