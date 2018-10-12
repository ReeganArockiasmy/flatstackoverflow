#!/bin/sh

savefilename="stackoverflow.txt"

# It is create a file , is not exist
if [ ! -f $savefilename ]
then
    echo -e "{\n\n}" > $savefilename
fi


get_id() {
    id=`tac $savefilename | grep -m1 -oP ".*\"id\":.*" | grep -o '[[:digit:]]*'`
    if [ -z "id" ]
    then
	id=1
    else
	let "id=id+1"
    fi
}

get_user_input() {
    value=""
    keystroke=0

    while read -r key
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
	    #value=$value$key$'\n'
	    #value=`printf '%q\n' "$value"`
	    #echo $value
	    value=" -s "\"$key\"" -i 0"$value
	fi
    done
    #value=`printf '%q\n' "$value"`
    value=" -n []"$value
}

create_tag=( id question answer ref tags )

get_id

jshon_value="jshon -s $id -i id"


for tag in "${create_tag[@]:1}"
do
    echo $tag
    get_user_input
    #declare "${tag}"=$value
    value=$value" -i "$tag
    jshon_value=$jshon_value$value
done

eval $jshon_value" <<<\"{}\"" >> /dev/null # It is any error came terminal the code

sed -i '$d' $savefilename
echo ,\"$id\": >> $savefilename
eval $jshon_value" <<<\"{}\"" >> $savefilename 
echo -e "\n}" >> $savefilename
