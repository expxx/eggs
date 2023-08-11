
/utils.sh || exit 403
source /utils.sh || exit 403
TZ=${TZ:-UTC}
export TZ

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

cd /home/container || exit 1
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

PROPERTY_FILE=server.properties



max_players=$(getProperty max-players)

echo "${MAGENTA}[DEBUG] ${gray}${max_players}${reset}"

if [[ -z ${max_players} ]];
then
	echo "max-players: ${PLAYER_LIMIT}" # PLAYER_LIMIT is env variable on ptero
	echo "${MAGENTA}[DEBUG] ${gray}Set MAX Players${reset}"
fi

if [[ "${max_players}" -gt "${PLAYER_LIMIT}" ]];
then
	setProperty "max-players" "%{PLAYER_LIMIT}" "server.properties"
	echo "${MAGENTA}[DEBUG] ${gray}Player limit over max. Reset.${reset}"
fi



eval ${PARSED}