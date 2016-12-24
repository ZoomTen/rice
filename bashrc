# Modified from http://ayozone.org/2008/02/25/bash-fancy-prompt-and-improvments/

export TERM=xterm-256color

function pre_prompt {
newPWD="${PWD}"
user="whoami"
host=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
datenow=$(date "+%a, %d %b %y")
let promptsize=$(echo -n "--($user@$host ddd, DD mmm YY)---(${PWD})---" \
                 | wc -c | tr -d " ")
let fillsize=${COLUMNS}-${promptsize}
fill=""
while [ "$fillsize" -gt "0" ] 
do 
    fill="${fill}─"
	let fillsize=${fillsize}-1
done
if [ "$fillsize" -lt "0" ]
then
    let cutt=3-${fillsize}
    newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cutt\}\)\(.*\)/\2/")"
fi
}

PROMPT_COMMAND=pre_prompt

export green="\[\033[0;38;5;2m\]"
export cyan="\[\033[0;38;5;6m\]"
export iceblue="\[\033[0;38;5;45m\]"
export bold=$(tput bold)
export normal=$(tput sgr0)

PS1="$green┌─($iceblue$bold\u@\h $normal\$(date \"+%a, %d %b %y\")$green)←\${fill}→($cyan$bold\$newPWD\
$green)─────\n$green└─($coldblue\$(date \"+%H:%M\")$green)→ $normal"
