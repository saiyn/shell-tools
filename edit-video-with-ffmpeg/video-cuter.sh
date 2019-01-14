#!/bin/sh

start=$1
duration=$2
length=$3
input=$4
outprefix=$5

end=`expr $start + $length`

next=$start

if [ $# -lt 5 ];then
	echo "Usage:$0 <start> <duration> <length> <input> <output>\n"
	exit 1
fi


i=$start

output=""
starttime=""
endtime=""
durtime=`expr $duration \* 60`

while [ $next -le $end ]; do
	i=`expr $i + 1`
	next=`expr $start + $duration`

	starttime="`expr $start / 60`:`expr $start % 60`:00"
	endtime="`expr $next / 60`:`expr $next % 60`:00"

	output=$outprefix$i.mp4
	ffmpeg  -ss $starttime -i $input -vcodec copy -acodec copy  -t $durtime  $output

	echo "$i cut $starttime to $endtime as $output ok\n"

	start=$next
done

while [ $i -gt $1 ];do
	input=$outprefix$i.mp4

	output=$outprefix"-sl"$i.mp4
	
	ffmpeg -i $input -r 25 -b 3M -ar 24000 -s 768x432 $output

	echo "turn $input to $output"

	rm $input

	i=`expr $i - 1`

done

