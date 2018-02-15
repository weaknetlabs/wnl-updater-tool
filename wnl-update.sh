#!/bin/bash
#
# WeakNet LINUX 8 CAFFEINE Updater tool.
# Please run frequently, but I leave the control up to the user.
#
# Douglas Berdeaux - WeakNetLabs@Gmail.com
#
###
# globals for printing pretty text:
info="\e[1m[*]\e[0m"
green="\e[32m"	# Green Text
red="\e[31m"	# Red Text
yellow="\e[93m"	# Yellow Text
blue="\e[34m"	# Blue Text
reset="\e[0m"	# Reset text to console
badInfo="\e[31m[!]\e[0m"
question="\e[1m[?]\e[0m"
# keep the URL in a single place to be updated by git:
url="https://weaknetlabs.com/linux/wnl8/updates"
printf "\e[1m\nWelcome to the WNL Update tool.\e[0m\n\n";
# Check internet connection
printf "$info Checking internet connection to WeakNet Labs... "
# Get the current (server) version
cv=$(curl -s $url/current.txt)
if [ "$cv" == '' ]
	then
		printf "$red [FAILED] $reset\n"
		printf "$badInfo Internet connection required; cannot continue.\n\n"
		exit;
fi
# Flow-Through OK here:
printf "$green [OK] $reset\n"
# compare to stored version in /etc/wnl/version
mv=$(cat /etc/wnl/version) # my (local) version
if [ "$mv" -eq "$cv" ]
	then
		printf "$green$info$green Your WeakNet LINUX is completely up to date.\n$reset";
		status=1 # 1 for OK/true
else
	printf "$red$info$red Your version is not the latest.\n$reset"
	status=0 # 0 for BAD/false
fi
#
printf "$info Your version is $green$mv$reset and the latest version from WeakNet Labs is $green$cv$reset.\n"
if [ "$status" -eq "0" ]
	then
	# get the latest update information:
	uv=$(($mv + 1)) # update version
	printf "$info Gathering information for updating $green$mv$reset to the $green$uv$reset version details...\n"
	printf "$yellow"
	curl -s $url/$uv/readme.txt|less
	printf "$reset"
	printf "$question Continue with update [Y/n]? ";
	read cont
	if [ "$cont" == "Y" ] || [ "$cont" == "y" ];
		then
			printf "$info Performing system update now, please wait...\n"
			status=1
	else
		status=0
	fi
	# If the user confirmed, let's perform the udpate:
	if [ "$status" -eq 1 ]
		then # perform the update:
			printf "$info Performing Debian updates...\n"
			printf "$info Updating package lists...\n"
			apt-get update >/dev/null
			printf "$info Performing updates... \n"
			apt-get upgrade -y >/dev/null
			wget --quiet $url/$uv/script.txt -O /tmp/wt-update-script.sh
			# Is the file even here?
			if [[ -f "/tmp/wt-update-script.sh" ]]
				then
					chmod +x /tmp/wt-update-script.sh
					/tmp/wt-update-script.sh
			else
				printf "$badInfo Something went wrong downloading the update script.\n"
				printf "$badInfo Please check your internet connection and try the update again.\n"
			fi
			# cleanup the files:
			rm -rf /tmp/wt-update-script.sh
			printf "$info Updating the local version file.\n"
			echo $uv > /etc/wnl/version
			printf "$info Update script completed. Starting over to check current version matching.\n\n";
			wnl-update.sh
	else
		printf "$info Updates declined. Exiting.\n\n"
	fi
else
	printf "\n\n$info Update script completed.\n\n"
fi
