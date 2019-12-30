set term png
set size .75,1
set output "MTCNNContROC.png"
set ytics .1
set grid
set ylabel "True positive rate"
set xlabel "False positives"
set yr [0:1]
set key right bottom
plot "MTCNNContROC.txt" using 2:1 with linespoints title "MTCNN"
