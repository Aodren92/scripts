#!/bin/sh
# the first file is the header
# add .h if does not exist
header=`expr "$1" : ".*.h"`;
if [ $header -ne 0 ]
then
str="${1}";
else
str="${1}"".h";
fi

# build define
name=`echo $str | sed 's/\./_/'`;
name=`echo $name | tr '[:lower:]' '[:upper:]'`;

# create header
echo "#ifndef $name" > $str;
echo "#define $name" >> $str;
# shift the header
shift
# recover line whitout ; main while and if whithin (
for i in "$@"
do
grep -e "(" $i | grep -v ";" | grep -v "while" | grep -v "static" | grep -v "\*\* " | grep -v "/\*" | grep -v "if" | grep -v "main" | grep -v "for" | sed  's/)/);/'>> $str;
done
echo "#endif" >> $str;
