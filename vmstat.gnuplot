reset
set grid
set output "vmstat.png"
set term png small size 1200,600 truecolor 
set title "VMStat Info"  
set ylabel "memory usage by function"
set key outside
set format y "%.2f"

set multiplot layout 5,1

plot './vmstat-sles11-sp2' using 0:4 every ::1 title 'free'  with lines, '' using 0:5 every ::1 title 'buff' with lines, '' using 0:6 every ::1 title 'Cache' with lines
plot './vmstat-sles11-sp2' using 0:7 every ::1 title 'Swap In'  with lines, '' using 0:8 every ::1 title 'Swap Out' with lines
plot './vmstat-sles11-sp2' using 0:9 every ::1 title 'Blocks In'  with lines, '' using 0:10 every ::1 title 'Blocks Out' with lines
plot './vmstat-sles11-sp2' using 0:11 every ::1 title 'Interupts'  with lines, '' using 0:12 every ::1 title 'Context Swtches' with lines
plot './vmstat-sles11-sp2' using 0:13 every ::1 title 'User Time'  with lines, '' using 0:14 every ::1 title 'system/kernel Time' with lines, '' using 0:15 every ::1 title 'Idle' with lines, '' using 0:16 every ::1 title 'Waiting for IO' with lines, '' using 0:17 every ::1 title 'Stolen time' with lines

stats './vmstat-sles11-sp2' using 0:6
