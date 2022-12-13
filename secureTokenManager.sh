#!/bin/bash

#Obtaing user selection and input
echo "Gathering list of users on this machine..."
sleep 2
echo "$( ls /Users )" 
echo "From the list above, which user did you want to work with?"
read userSelection

echo -e "Did you want [enable], [disable], or check the current [status] of Secure Token for $userSelection \nor [exit]?"
read taskSelection


#Converting input to lowercase
taskSelectionLower=$(echo $taskSelection | tr '[:upper:]' '[:lower:]')


#Running commands
while [ true ]
do
if [[ $taskSelectionLower == "enable" ]]; then
	echo "What is $userSelection's password?"
	#Hiding User's Password
	stty -echo
	read userSelectionPassword
	stty echo
	echo "Enabling..."
	echo "$(sysadminctl -adminUser AdminUserName -adminPassword AdminPassword -secureTokenOn $userSelection -password $userSelectionPassword)"
	break
elif [[ $taskSelectionLower == "status" ]]; then
	echo "Displaying $userSelection current Secure Token status..."
	echo "$( sysadminctl -secureTokenStatus $userSelection )"
	break
elif [[ $taskSelectionLower == "disable" ]]; then
	echo "What is $userSelection's password?"
	#Hiding User's Password
	stty -echo
	read userSelectionPassword
	stty echo
	echo "Disabling..."
	echo "$(sysadminctl -adminUser AdminUserName -adminPassword AdminPassword -secureTokenOff $userSelection -password $userSelectionPassword)"
	break
elif [[ $taskSelectionLower == "exit" ]]; then
	echo "Exiting..."
	exit
else
	echo "Incorrect selection made..."
	echo "Did you want [enable], [disable], or check the current [status] of Secure Token for $userSelection?"
	read taskSelection
	taskSelectionLower=$(echo $taskSelection | tr '[:upper:]' '[:lower:]')
	continue
fi

done
