PROPERTY_FILE=server.properties
/utils.sh || exit 403
source /utils.sh || exit 403

max_players=$(getProperty max-players)
motd=$(getProperty motd)

TZ=${TZ:-UTC}
export TZ

cd /home/container || exit 1
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

logo=$(figlet OdysseyNodes | lolcat -f)
echo "$logo ${RESET}- ${GRAY}MC Hosting${RESET}"
echo -e "\n"
echo "-----------------------------------------------------------------"
echo "${RESET}Website: ${CYAN}https://odysseynodes.com"
echo "${RESET}Discord: ${CYAN}https://odysseynodes.com/discord"
echo -e "\n"
echo "-----------------------------------------------------------------"

echo -e "\n${CYAN}Odyssey Server Helper${RESET}: ${YELLOW}Launching${RESET}..."
sleep 2;
echo -e "\n${CYAN}Odyssey Server Helper${RESET}: ${GREEN}Launched${RESET}..."
sleep 1;
echo -e "\n${CYAN}Odyssey Server Helper${RESET}: ${BLUE}Parsing Configs${RESET}..."
if [[ -z ${max_players} ]];
then
	# cant be bothered to rename the variable, PLAYER_LIMIT is just the recommended limit
	echo "max-players=${PLAYER_LIMIT}" >> server.properties # PLAYER_LIMIT is env variable on ptero
	echo "${MAGENTA}[DEBUG] ${gray}Set First-Boot MAX Players${reset}"
fi
if [[ "${max_players}" -gt "${PLAYER_LIMIT}" ]];
then
	echo "${RED}[WARN] ${gray}You are over the recommended player cap.${reset}"
fi
if [[ -z ${motd} ]];
then
	echo "motd=Server hosted on OdysseyNodes.com" >> server.properties
	echo "${MAGENTA}[DEBUG] ${gray}Set First-Boot MOTD${reset}"
fi

sleep 2;
echo -e "\n${CYAN}Odyssey Server Helper${RESET}... ${MAGENTA}Starting Server${RESET}..."

echo "-----------------------------------------------------------------"

if [[ ! -f "eula.txt" ]];
then
	echo "${CYAN}Do you agree to the Minecraft EULA: ${RESET}"
 	select agree in Yes No
  	do
		case $agree in
  			"Yes")
     				echo "eula=true" > eula.txt;
	 			break;;
			"No")
   				echo "${RED}[WARN] ${gray}You must agree to the EULA to run minecraft.${reset}"
       				exit 403;;
	   		*)
      				echo "${RED}[WARN] ${gray}Not a valid input.${reset}"
	  			exit 404;;
      		esac
  	done;
fi

eval ${PARSED}
