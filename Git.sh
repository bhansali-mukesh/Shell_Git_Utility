
# Author : BHANSALI MUKESH KUMAR
# This Utility Script provides many useful aliases and help to work with git

# Step You May Follow for Usage 
	#1 Save this file on your Computer ( $HOME/Git.sh, You may save at other location but that will lead to some other changes like, See custom and profile section for more )
	#2 You May Move Entire "Profile Section" to your profile file ( .bash_profile or so ), Need to remove '#' to run command for this file, See profile section for more
		# If You Don't Move "Profile Section" Then At Least You Need to Run This File to Use This Utitlity
	#3 Change Name and Workspace Direstories/Repositories, See Custom Section for more
	#4 Type "Help", It Will Show You Everything it Has
	#5 Type "Usage" for Help on Set up and Usage
	#6 You can also Add, Update aliases here, and If You Provides Proper Comments Above Your Commands, That Will Also Be Visible in Help
alias Usage='Help Usage';

# Another Name for Usage
alias Setup='Usage';

###### {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{ CUSTOM SECTION }{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{} ######

# Defines Workspace Directory 
export WORKSPACE="/opt/wnc"

# Script File Name, I have Saved this file under this Path and Name
# You May Vary But Then You May Need to Change It's Run Command in Profile file
export FILENAME="$HOME/Git.sh"

# PLEASE CHANGE BELOW AS PER YOUR NEED

# Used for checking My Git Log, You Need to Put You Name in Git Log
# Need to Change
export NAME="Bhansali";

# Remote Name for Git Repository
export origin="origin"

# Git Master Branch NAME
export master="main"


###### %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PROFILE SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ######

# This Section should be added in start-up profile file ( .bash_profile etc )
# . ~/Git.sh ( Remove '#' and add to profile, Run this file on login )

# Going back to the calling directory when things are done
alias Back='cd - > /dev/null; echo -e "\a" ';

# Helpful Short-cut not related to Git

# Clear Screen
alias c=clear

# Show Alias of Alias For Ease of Typing
alias a=alias

# Goes to WorkSpace Directory
alias Workspace="cd $WORKSPACE"

# Utility Function to Support Other Aliases
# Validate Number of Input Provided
alias Validator='function Validator() { actual_parameters=`expr $# - 2`; if [ $actual_parameters -lt $1 ]; then echo -e "\t $2" >&2; echo return; fi }; Validator'

# Utility Function to Support Other Aliases
# Confirms Whether User Wants to Continue
alias Confirmer='function Confirmer() { echo -e "\n\t Press \"Y\" to Continue\n" >&2; read confirm; if [ "$confirm"T != "YT" ]; then echo -e "\t Action Cancelled\n" >&2; echo return; fi }; Confirmer'

###### ------------------------------------------ HELP SECTION ------------------------------------------ ######

# Just type "Help" on Terminal
# If Help is Followed By Some Special Command then it will Show Help for that Command
# Else Displaying Help with Pagination ( Press Enter or Space to Scroll, "q" to Quite )
# If you Add, Update and Command in this Utility with Proper Comment, it will Automatically Visible in Help as well. 
	# Example
		# 1. Help
		# 2. Help Commit
alias Help='function JASOL() { Document=`Help_Document`; if [ M"$1" = "M" ]; then echo "$Document"| less; return; fi;  echo ""; echo "$Document" | sed -n "/^"$1"/,/^$/p"; }; JASOL'

# Utility Function which Parses this Git File and Generates The Help Documents to Help, The Command "Help"
# Generating Help Document from the Source on Runtime
alias Help_Document='function MB() { Comment_Character="#"; Alias_Character="alias"; Help=""; Alias=""; while read line; do if [[ $line == $Comment_Character* ]]; then Help="$Help""\n""$line"; else Alias_Found=`echo "$line"| grep $Alias_Character`; if [[ M"$Alias_Found" != "M" ]]; then Alias=`echo "$line"| cut -d"=" -f1 | tr -s " "| cut -d" " -f2`; if [[ M"$Alias" != "M" ]]; then echo -e "\n$Alias" : "$Help"; Help=""; fi; else Help=""; fi; fi; done < "$FILENAME"; }; MB'



###### ***************************************** GIT ALIASES ***************************************** ###### 

# Set Alias "Gitter" to Open this File
# No Parameter
alias Gitter="vi $FILENAME";

# Open Git GUI
# No Parameter
alias Git="git gui"

# Publish Git Commits to Gerrit
# Optional Parameter
alias Publish='function BHAWANA() { echo -e "\n\t Do You Want Publish Now ( Recommended to \"Combine ( All Commits )\" First, Ignore if Already Combined ) ?\n"; `Confirmer`; git publish; }; BHAWANA'

# Show Difference for Particular File
# Need Parameter
# Example
	# Diff README.html
alias Diff="git diff"

# Goes to Workspace, Pulls from Remote, Comes Back 
alias Sync='Workspace; Pull; Back';

# Shows All Branches in Repository
# No Parameter
alias Bbranch="git branch";

# Another Short Hand For briefing git Branches
alias B=Bbranch;

# Rename a Branch
# Need 2 Parameters (1. SourceName  2. NewName )
# Example
	# Rename OLD_NAME NEW_NAME
alias Rename='function MARWAR() { `Validator 2 "Need 2 Parameters (1. SourceName  2. NewName )" $@`; git branch -fm $1 $2; }; MARWAR'

# Show All Branches ( including remote )
# No Parameter
alias All='git branch -a'

# Shows current git branch
# No Parameter
alias Current='Branch| grep \* | cut -d" " -f2;'

# Checkout to a git branch
# Also Useful For Reverting Local Changes for a Particular File
# Need Parameter
# Example
	# 1.	Checkout Master
	# 2.	Checkout REAME.html
alias Checkout='From=`Current`; git checkout'

# Creates and checks out the same git branch
# You can switch to your branch any time by just typing it's Jira id
# Example 
#        Branch Name : NGCONT-1745_Infiniti-Create-new-homepage-outlines
#        Just Fire Command : Create NGCONT-1745_Infiniti-Create-new-homepage-outlines
# Now if I type "1745" on terminal Anytime, I am switched to this Branch
# Need Parameter      
alias Create='function MBMB(){ `Validator 1 "Need a Parameters ( Branch Name )" $@`; story=`echo $1| cut -d'_' -f1`; echo "alias $story=\"From=`Current`; git checkout $1 \"" >> $FILENAME; git checkout -b $1 $origin/$master; echo -e "\t\tType " \"$story\" " to Jump to this Branch, Anytime"; source $FILENAME; };MBMB'

# Goes to PREVIOUS git branch
# No Parameter
alias Previous='Present=$From; Checkout $Present';

# Goes to Master/Main Branch
# No Parameter
alias Master='Checkout $master';

# Pulls origin Master/Main ( Merge Latest From Master Branch )
# No Parameter
alias Origin='git pull $origin $master';

# Remove git branch
# Need Parameter
# Example
	# Remove OLD_BRANCH
alias Remove="git branch -D";

# Deletes the branch you are currently on
# Need Confirmation
alias Delete='Me=`Current`; echo -e "\n\t Do You Want to Delete Branch \"$Me\" \n"; `Confirmer`; Master; Remove $Me;'

# Adds files to Commit
# Need Parameter(s)
# Example
	# Add README.html
alias Add='git add';

# Commits Added File in Branch for Permanent Changes
# Need Message Parameter
# Example
	# Commit "Changes to Improve Performance"
alias Commit='git commit -m';

# Amends Last Commit in Branch for Permanent Changes
# Need Message Parameter
# Example
	# Aamend "Amending Changes to Improve Performance"
alias Aamend='git commit --amend -m'

# Combine Multiple Commits in one
# Need 2 Parameters ( 1. Number of Commits, 2. Commit Message )
# Example
	# Combine 4 "Combining 4 Commits into one Single Commit"
alias Combine='function JODHPUR() { `Validator 2 "Need 2 Parameters ( 1. Number of Commits, 2. Commit Message )" $@`; if [ "$#" -lt 2 ]; then echo -e "\n\t Please Provide 2 parameters.\n\t 1. Number Of Commits to be Combined.\n\t 2. Commit Message.\n"; return; fi; git reset --soft HEAD~$1; git commit -m "$2"; }; JODHPUR'
		
# Push Current Branch
# No Parameter
alias Push='me=`Current`; git push --set-upstream origin $me'

# It Needs "Commit Message" in double quotes as Parameter.
# Add, Commit and Push in 1 Shot ( Makes Our Branch Available in Remote Server, Also Used in Recovery, Share and Review Changes )
# Need Confirmation and Commit Message
# Example
	# Stage "Issue Resolved"
alias Stage='function MKBJ(){ `Validator 1 "Need a Parameters ( Commit Message )" $@`; changes=`M|wc -l`; if [ "$changes" -eq 0 ]; then echo -e "\n\tNo Changes to Stage\n"; return; fi; echo -e "\n\t$changes file(s) are identified to Stage\n"; M; `Confirmer`; Add .; Commit "$1";}; MKBJ'


# It Needs "Commit Message" in double quotes as Parameter.
# Add, Commit and Push in 1 Shot ( Makes Our Branch Available in Remote Server, Also Used in Recovery, Share and Review Changes )
# Need Confirmation and Commit Message
# Example
	# Amend "Refactoring Done"
alias Amend='function VIMLESH(){ `Validator 1 "Need a Parameters ( Commit Message )" $@`; changes=`M|wc -l`; if [ "$changes" -eq 0 ]; then echo -e "\n\tNo Changes to Stage\n"; return; fi; echo -e "\n\t$changes file(s) are identified to Stage\n"; M; `Confirmer`; Add .; Aamend "$1";}; VIMLESH'


# Briefs for all current local git branches
# No Parameter
alias Branch='git branch -vv';

# Fetches Remote Branch into your Local But DO NOT Merge Changes into Your Local Branch.
# No Parameter
alias Ffetch='git fetch';

# Before fetching, remove any remote-tracking references that no longer exist on the remote ( Recommended )
# Need Parameter
alias Fetch='git fetch --prune';

# Merges Changes into Branch
# Need Parameter
alias Merge='git merge';

# Fetches Remote Branch into your Local and Merges Changes into Your Local Branch ( Fetch + Merge ) .
# No Parameter
alias Pull='git pull';

# Gives List of All Modified Files only ( File Should be in Remote Repository )
# No Parameter
alias M='function Changes() { git status | grep -E "deleted|modified"; git ls-files . --exclude-standard --others; }; Changes';

# Gives List of All Local Changes ( Whether it is not in Remote Repository )
# No Parameter
alias ?="git status"

# Delete All Local git branches except Master
# No Parameter
alias Delete_But='Master; git branch | tr -s " "| cut -d" " -f2 | grep -v $master | xargs git branch -d;'

# List all the Stashes
# No Parameter
alias List="git stash list"

# Saves Change Point to Rollback in Future
# No Parameter
alias Sstash='git stash';

# Saves Change Point with Name to Rollback in Future, If Needed ( Needs a Parameter, Checkpoint Name )
# No Parameter
alias Ssave='BranchName=`Current`; git stash save $BranchName'

# Stash Changes including untracked file ( -u )
# Untracked files are the Files which are not in remote repositories ( Newly Added Files ) etc.
# Undo local changes
# No Parameter
alias Save='BranchName=`Current`; git stash save -u $BranchName';

# Goes to Latest Saved Change Point
# No Parameter
alias Pop='Sstash pop';

# Apply a Stash Number
# Need Parameter
# Example
	# Apply 0
alias Apply='function BHANSALI() { git stash apply stash@{$1}; }; BHANSALI'

# Remove a Stash From Stash List
# Need Parameter
# Example
	# Drop 0
alias Drop='function BHANSALI() { git stash drop stash@{$1}; }; BHANSALI'

# Clean UnTracked Files and Directories
# No Parameter
alias Clean='git clean -fdx';

# Un Stage given File ( Changes will remain but it will be removed from added files )
# Need Parameter(s)
alias Rreset='git reset'

# Un Stage given File ( Changes will remain but it will be removed from added files )
# No Parameter
alias RRESET='git reset .'

# Un Stage an un-committed File and Undo Changes from that file
# Need Parameter(s)
# Example
	# Reset Git.sh
alias Reset='function MUKESH() { `Validator 1 "Need a Parameters ( File Name )" $@`; Rreset $1; Checkout $1; }; MUKESH'

# Un Stage all un-committed Files and Undo Changes
# No Parameter
alias RESET='RRESET; Checkout .'

# Revert Code to Origin Master
# No Parameter
alias Hard_Reset='Fetch; git reset --hard $origin/$master; Clean'

		# Rebase to Origin Master Branch
		# No Parameter
		alias Rebase='git rebase $origin $master;'
		
# Abort Rebase Operation
# No Parameter
alias Abort_Rebase='git rebase --abort'
		
# Rewrite Commit History, To Undo Commit, Edit Message and More
# Need Parameter ( Go How Many Commits Behind, To Rewrite History )
# Example
	# Rewrite 5
alias Rewrite='function OK() { `Validator 1 "Need a Parameters ( Number of Commits )" $@`; head=""; commits=$1; commit=0; while [ $commit -lt $commits ]; do head="$head"^; commit=`expr $commit + 1`; done; git rebase -i HEAD$head ; }; OK'

# DANGEROUS COMMAND : One Should Not Use it on Public/Remote Repositories
# Rollback Commits, You May Lose Changes done in Last Specified Number of Commits which you Specifies
# It is What is Expected from this Command to Rollback Some Commits.
# You Need to Specify, How Many Commits Needs to be Rolled Back as Parameter
# Need Parameter ( Go How Many Commits Needs to be Rolled Back )
# Example
	# ROLLBACK 2
alias ROLLBACK='function OK() { `Validator 1 "Need a Parameters ( Number of Commits )" $@`; head=""; commits=$1; commit=0; while [ $commit -lt $commits ]; do head="$head"^; commit=`expr $commit + 1`; done; git reset --hard HEAD$head ; }; OK'

# Link Missing Jars
# No Parameter
alias Link='git phat init; git phat link'

# Git Log
# No Parameter
alias Log='git log';

# Shows git logs related to YOU only ( Filtered Logs )
# No Parameter
alias My='git log --author $NAME; Back'

# git Logs for specific Author
# Need Parameter
# Example
	# Author MUKESH
alias Author='git log --author';

# git logs since $date
# Need Date Parameter
alias Since='git log --since';

# git Logs for TODAY's changes
# No Parameter
alias Today='git log --after="yesterday"';

# git Logs for Changes Since YESTERDAY
# No Parameter
alias Yesterday='git log --since=yesterday.midnight';

# Set up product-root environment
#alias SETUP_ROOT='git clone http://'"$USER"'@stash.cdk.com/scm/bhansali/product-root.git; npm run setup';

# Set up Repositories
# No Parameter
alias CLONE='function KUMAR() { Workspace; cd ..; remotes=`git remote show`; for remote in $remotes; do echo "Cloning $remote ..."; remote_url=`git remote show $remote | grep -im1 URL | rev | cut -d" " -f1| rev`; git clone $remote_url; done; }; KUMAR'
	
# Creates a New Commit which will nullify the effect of Last Commit
# No Parameter
alias Revert_Last_Commit='Last_Commit=`git log | head -n 1 | cut -d" " -f2`; git revert $Last_Commit';

# In case if you change your password and git doesn't know it
# Erase git cached Password ( Press Enter Twice )
# No Parameter
alias Git_Erase_Password='git credential-osxkeychain erase';

# Your Local Git Branch's Aliases Goes Here
