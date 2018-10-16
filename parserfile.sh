#jshon -k < stackoverflow.txt

#jshon -l < stackoverflow.txt 

#echo $loopvar
# jshon -a 1 -e answer

# for index in $( jshon -k < stackoverflow.txt )
# do
#     jshon -e $index -e tags < stackoverflow.txt
# done

filename=stackoverflow.txt




view_solution() {
    # answer=`jshon -e $index -e answer < $filename`
    # answer=$(echo $answer | sed 's/^.\(.*\).$/\1/')
    #echo $answer
    jshon -e $index -e answer < $filename | sed -e '/^\[$/d' -e  '/^\]$/d' -e 's/\,$//' -e 's/\\//g' -e 's/^ "//g' -e 's/"$//g'
    
    
}


list_questions() {

    for index in $( jshon -k < $filename | sort -n )
    do
	# question=`jshon -e $index -e question < $filename`
	# question=$(echo $question | sed 's/^.\(.*\).$/\1/'| sed 's/^.\(.*\).$/\1/' | sed 's/^.\(.*\).$/\1/')
	# echo $index $question
	
	# if jshon -e $index -e tags | grep -q  $tags
	#    then
	if jshon -e $index -e tags < $filename | grep -q $tags
	then
	       printf $index
	       jshon -e $index -e question < $filename | sed -e '/^\[$/d' -e  '/^\]$/d' -e 's/\,$//' -e 's/\\//g' -e 's/^ "/ /g' -e 's/"$//g'
	fi
    done 
   
}

list_tags() {
    
for index in $( jshon -k < $filename )
do
    tags=`jshon -e $index -e tags < $filename`
    tags=$(echo $tags | sed 's/^.\(.*\).$/\1/')
    for tag in $tags
    do
	tag=$(echo $tag  | sed '$s/,$//')
	echo $tag | sed 's/^.\(.*\).$/\1/'
    done 
done | sort | uniq

}


# list_tags
# list_questions
# read index
# view_solution

usage(){

    echo " --all | -a {tags,questions}"
}



if [ $# -gt 0 ];
then
    while [ "$1" != "" ]; do
	case $1 in
            -f | --file )           shift 
                                    filename=$1
                                    ;;
	    -a | --all )
			shift
			key=$1
			list_tags
			;;
			
            -t | --tags )   
			     shift
			     tags=" -e "$1$tags
                                    ;;
            -h | --help )           usage
                                    exit
                                    ;;
            * )                     usage
                                    exit 1
	esac
	shift
    done
else
    echo "your command line"
fi


if [ ! -z ${tags+x} ];
then
    list_questions
fi



cat stackoverflow.txt | jshon -a tags | grep$tags
echo "grep"$tags
