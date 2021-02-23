foo=bar
echo "$foo"
# prints bar
echo '$foo'
# prints $foo

false || echo "Oops, fail"
# Oops, fail

true || echo "Will not be printed"
#

true && echo "Things went well"
# Things went well

false && echo "Will not be printed"
#

# $0 - Name of the script
# $1 to $9 - Arguments to the script. $1 is the first argument and so on.
# $@ - All the arguments
# $# - Number of arguments
# $? - Return code of the previous command
# $$ - Process identification number (PID) for the current script


# command output can be save to a file by putting $( ) around it as follows:
files=$(ls)

ArrayName=("element 1" "element 2" "element 3")
echo "first element is ${ArrayName[0]}"
echo "array length is ${#ArrayName[@]}"
echo "Looping through elements:"
for f in "${ArrayName[@]}"
do
  echo "$f"
done

