function exitstatus {

    local EXITSTATUS="$?"

    local BOLD="\e[1m"
    local DIM="\e[2m"
    local UNDERLINE="\e[4m"
    local BLINK="\e[5m"

    local DEFAULT="\e[39m"
    local BLACK="\e[30m"
    local RED="\e[31m"
    local GREEN="\e[32m"
    local GOLD="\e[33m"
    local BLUE="\e[34m"
    local MAGENTA="\e[35m"
    local CYAN="\e[36m"
    local WHITE="\e[97m"


    local OFF="\e[0m"

    if [ "${EXITSTATUS}" -eq 0 ]
    then
       local FACE="${BOLD}${GREEN}^_^${OFF}"
    else
       local FACE="${BOLD}${BLINK}${RED}O_O${OFF}"
    fi

    local LINE1="${GOLD}[ ${BLUE}\u${GOLD}@${GREEN}\h ${WHITE}\w${GOLD} ]"
    local LINE2="${GOLD}[\!][ ${FACE}${GOLD} ] $ ${OFF}"
    PS1="${LINE1}\n${LINE2}"
}

PROMPT_COMMAND=exitstatus


