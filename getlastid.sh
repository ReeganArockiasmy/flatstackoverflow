#read -s key  # -s: do not echo input character. -n 1: read only 1 character (separate with space)

# double brackets to test, single equals sign, empty string for just 'enter' in this case...
# if [[ ... ]] is followed by semicolon and 'then' keyword

#value=""
value=""
keystroke=0

while read -s key
do
    if [[ $key = "" ]]; then 
	let "keystroke=keystroke+1"
	if [[ $keystroke -eq 1 ]];
	then
	    # value=""
	    # keystroke=0
	    break
	fi
	
    else
	#value=$value$key$" -i 0"
	value=" -s "\"$key\"" -i 0"$value
    fi
done
#value=${value%?????}
value="jshon -n []"$value" -i a <<< \"{}\""
echo $value
eval $value
# if [ $linecount -gt 2 ]
#    then
#   newvalue="["
#   while IFS= read -r line;
#    do
#        newvalue=$newvalue\"$line\"","
#        echo $newvalue
#   done < <(echo "$value")
#   newvalue=${newvalue%????} # remove last 4 character
#   newvalue=$newvalue"]"
# fi

