# Compare your discrete ROC curves with other methods
# At terminal: gnuplot discROC.p
set terminal png size 1280, 960 enhanced font 'Verdana,18'
set size 1,1
set xtics 500
set ytics 0.1
set grid
set ylabel "True positive rate"
set xlabel "False positive"
set xr [0:2000]
set yr [0:1.0]
set key below
set output "discROC.png"
plot  "rocCurves/MTCNN-DiscROC.txt" using 2:1 title 'Zheng et al.' with lines lw 2 , \
"rocCurves/cvit_DiscROC.txt" using 1:2 title 'Kumar et al.' with lines lw 2 , \
"rocCurves/FDDB_FSA4_2_DiscROC.txt" using 2:1 title 'Barbu et al. 2' with lines lw 2 , \
"rocCurves/DP2MFD_DiscROC.txt" using 2:1 title 'DP2MFD' with lines lw 2 , \
"rocCurves/CCFDiscROC.txt" using 2:1 title 'CCF' with lines lw 2 , \
"rocCurves/Faceness-DiscROC.txt" using 2:1 title 'Faceness' with lines lw 2 , \
"rocCurves/npdfaceDiscROC.txt" using 2:1 title 'NPDFace' with lines lw 2 , \
"rocCurves/MultiresHPM-DiscROC.txt" using 2:1 title 'MultiresHPM' with lines lw 2 , \
"rocCurves/FDDB_FSA4_1_DiscROC.txt" using 2:1 title 'Barbu et al.' with lines lw 2 , \
"rocCurves/DDFD_DiscROC.txt" using 2:1 t
