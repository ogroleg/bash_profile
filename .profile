source .profile_private  # execute sensitive code

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

parse_git_branch() {
     branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'`  # get branch name (if possible)
     branch="${branch// }"  # remove spaces
     if [[ -n $branch ]]; then echo " $branch "  # output branch name (if not empty)
     fi
}

show_weather_once_a_day() {
     day=`date '+%d'`  # get current day number
     stored_day=`cat .weather_stamp`  # get last stored day number
     
     if [[ $day -ne $stored_day ]]; then echo $day > .weather_stamp && curl "wttr.in/Kyiv?0&n&Q";  # write current day num to file, make query to wttr.in (only this day, silent mode)
     fi

     # see also: wttr.in/:help
}

export PS1="\h:\W \u\$(parse_git_branch)\$ "

show_weather_once_a_day  # run func
