#!/bin/bash

################ mac software build out ################
##       _           _ _     _             _          ##
##      | |__  _   _(_) | __| | ___  _   _| |_        ##
##      | '_ \| | | | | |/ _' |/ _ \| | | | __|       ##
##      | |_) | |_| | | | (_| | (_) | |_| | |_        ##
##      |_.__/ \__,_|_|_|\__,_|\___/ \__,_|\__|       ##
##                                               v0.1 ##
########################################################

#
# PRINT WELCOME MESSAGE (SCRIPT HEADER ABOVE)
#
grep "\##" $0 | grep -v "grep"


#
# STEP 1: INSTALL AND UPDATE COMMAND LINE TOOLS
#
echo "Installing HomeBrew"
if test ! $(which brew)
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


echo "Updating existing homebrew receipes and formulas"
brew update
brew upgrade


echo "Installed from packages.txt list"
# curl -sS https://raw.githubusercontent.com/yevrah/mac-setup/master/packages.brew.txt | xargs brew install
cat packages.brew.txt | xargs brew install


#
# STEP 2: INSTALL GUI APPS
#
echo "Install brew cask plugin"
brew install cask


echo "Installed from packages.cask.txt list"
# curl -sS https://raw.githubusercontent.com/yevrah/mac-setup/master/packages.cask.txt | xargs brew cask install
cat packages.cask.txt | xargs brew install --cask


#
# STEP 3: INSTALL APP STORE APPS
#

# Install mas-cli using below when 1.42 is released
echo "Installing mas-cli tool for app store packages"
brew install mas

echo ""
echo "Please log into the Mac App Store"
open -a '/System/Applications/App Store.app'

until (mas account > /dev/null); do
    sleep 3
done


echo "Installing from packages.mas.txt list"
# curl -sS https://raw.githubusercontent.com/yevrah/mac-setup/master/packages.mas.txt | sed 's/ .*//' | xargs mas install
cat packages.mas.txt | sed 's/ .*//' | xargs mas install


#
# FINALISE
#

# Remove brew leftovers
echo "Cleanup brew left overs"
brew cleanup


# 
# Install ClassHive App dependencies
# 
npm install -g cordova
npm install -g @ionic/cli



# 
# Manuall Install Xcode Instruction
# 
echo " 
========================
Install Xcode (Manually)
========================
This applies only if the OSX is not using the latest version.
1. Go to https://xcodereleases.com
2. Download the corresponding Xcode version depending on the OSX Version.
eg. If you are using OSX v11.6.7 You should use Xcode ver 13.2.1 as the latest.
3. Move the downloaded *.XPI to /Applications folder and extract it there.
4. Run the Xcode at /Applications/Xcode.app
   If you experienced issue, run the below command in terminal:
   sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
   This fixes an issue -> Required content for iOS Simulator is missing 
   It is due to command tools path are incorrect."