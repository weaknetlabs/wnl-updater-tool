# wnl-updater-tool
To be used with WeakNet LINUX 8+
This tool will 
* Check the local version in /etc/wnl/version
* Check the current version from my server at ./linux/wnl8/updates/version
* Compare the two numbers and determine how to proceed
* Pull down the readme.txt file from ./linux/wnl8/updates/n/readme.txt where "n" is the version number.
* Use the <code>less</code> command to display the readme and all of the update information
* Require the user to confirm the updates
* pull down the entire update script from ./linux/wnl8/updates/n/script.txt
* run the script
* run a YAD script that says thanks.

<img src="https://weaknetlabs.com/images/wnl-updater-screenshot.PNG"  />

<img src="https://weaknetlabs.com/images/wnl-updater-screenshot-2.PNG" />

<img src="https://weaknetlabs.com/images/wnl-updater-screenshot-3.PNG" />
