#!/bin/bash

#args;
#$1 = file to process
#$2 = device to filter for


dmlist=`cat $1 | awk '{print $1}' | grep $2 | sort | uniq`
output="/tmp/device_iostat_util_$1.csv"

#create a file for each device
for device in $dmlist
    do
        #set the header
        echo $device > /tmp/device_$device.txt 
        #grab the await column only
        egrep "^$device\s" $1 | awk '{print $14}' >> /tmp/device_$device.txt
        #transpose the columns
        paste -s /tmp/device_$device.txt  >> /tmp/device_$device.csv
        #clear up the un-transposed data
        rm /tmp/device_$device.txt
        #append to one big happy file
        cat /tmp/device_$device.csv >> $output
        # clear up the temporary data
        rm /tmp/device_$device.csv
    done

echo "created summary at $output"

#create the GNUPlot file
gnuplot << EOF
  reset
  set terminal png truecolor nocrop enhanced font Arial 
  set grid
  set output "/tmp/$1_$2_util.png"
  set title "iostat %Util"  
  set ylabel "dm- number"
  set xlabel "seconds elapsed"
  set zlabel "% device saturation"

  set view 50, 30

  set ticslevel 0
  set pm3d
  set style data pm3d
  set palette negative
  splot "$output" matrix

EOF

echo "created image at /tmp/$1_$2_util.png" 
