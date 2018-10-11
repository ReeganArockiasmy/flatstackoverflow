#jshon -k < stackoverflow.txt

#jshon -l < stackoverflow.txt 

#echo $loopvar

# for index in $( jshon -k < stackoverflow.txt )
# do
#     jshon -e $index -e tags < stackoverflow.txt
# done

filename=stackoverflow.txt




view_solution() {
    answer=`jshon -e $index -e answer < $filename`
    answer=$(echo $answer | sed 's/^.\(.*\).$/\1/')
    echo $answer
}


list_questions() {

    for index in $( jshon -k < $filename )
    do
	question=`jshon -e $index -e question < $filename`
	question=$(echo $question | sed 's/^.\(.*\).$/\1/'| sed 's/^.\(.*\).$/\1/' | sed 's/^.\(.*\).$/\1/')
	echo $index $question
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

#list_tags
list_questions
read index
view_solution
