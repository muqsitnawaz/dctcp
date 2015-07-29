set terminal postscript color eps enhanced
set output "plot-qmon-util3431.ps"
set title "Plot of Link Utilization"
set ylabel "Link Utilization"
set xlabel "Number of RTTs" # 0,0.5"
plot "qmon.util3431" title "link utilization" with lines,