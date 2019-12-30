# Compare your continuous ROC curves with other methods
# At terminal: gnuplot contROC.p
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
set output "contROC.png"
plot  "rocCurves/MTCNN-ContROC.txt" using 2:1 title 'Zheng et al.' with lines lw 2 , \
"rocCurves/cvit_ContROC.txt" using 1:2 title 'Kumar et al.' with lines lw 2 , \
"rocCurves/FDDB_FSA4_2_ContROC.txt" using 2:1 title 'Barbu et al. 2' with lines lw 2 , \
"rocCurves/DP2MFD_ContROC.txt" using 2:1 title 'DP2MFD' with lines lw 2 , \
"rocCurves/CCFContROC.txt" using 2:1 title 'CCF' with lines lw 2 , \
"rocCurves/Faceness-ContROC.txt" using 2:1 title 'Faceness' with lines lw 2 , \
"rocCurves/npdfaceContROC.txt" using 2:1 title 'NPDFace' with lines lw 2 , \
"rocCurves/MultiresHPM-ContROC.txt" using 2:1 title 'MultiresHPM' with lines lw 2 , \
"rocCurves/FDDB_FSA4_1_ContROC.txt" using 2:1 title 'Barbu et al.' with lines lw 2 , \
"rocCurves/DDFD_ContROC.txt" using 2:1 title 'DDFD' with lines lw 2 , \
"rocCurves/CasCNN-ContROC.txt" using 2:1 title 'CascadeCNN' with lines lw 2 , \
"rocCurves/jjyan_allROC_ContROC.txt" using 2:1 title 'Yan et al.' with lines lw 2 , \
"rocCurves/AcfContROC.txt" using 2:1 title 'ACF-multiscale' with lines lw 2 , \
"rocCurves/pico-ContROC.txt" using 2:1 title 'Pico' with lines lw 2 , \
"rocCurves/HeadHunter_ContROC.txt" using 2:1 title 'HeadHunter' with lines lw 2 , \
"rocCurves/JointCascade_ContROC.txt" using 2:1 title 'Joint Cascade' with lines lw 2 , \
"rocCurves/BoostedExamplerBased-ContROC.txt" using 2:1 title 'Boosted Exemplar' with lines lw 2 , \
"rocCurves/SURF_GentleBoost_FTContROC.txt" using 2:1 title 'SURF-frontal' with lines lw 2 , \
 "rocCurves/SURF_GentleBoost_MVContROC.txt" using 2:1 title 'SURF-multiview' with lines lw 2 , \
 "rocCurves/PEPAdapt_ContROC.txt" using 2:1 title 'PEP-Adapt' with lines lw 2 , \
 "rocCurves/XZJY_ContROC.txt" using 2:1 title 'XZJY' with lines lw 2 , \
 "rocCurves/dr40ContROC.txt" using 2:1 title 'Zhu et al.' with lines lw 2 , \
 "rocCurves/santiContROC.txt" using 2:1 title 'Segui et al.' with lines lw 2, \
 "rocCurves/koestingerContROC.txt" using 2:1 title 'Koestinger et al.' with lines lw 2, \
 "rocCurves/LiIntelContROC.txt" using 2:1 title 'Li et al.' with lines lw 2, \
 "rocCurves/jainContROC.txt" using 2:1 title 'Jain et al.' with lines lw 2, \
 "rocCurves/subburamanContROC.txt" using 2:1 title 'Subburaman et al.' with lines lw 2, \
 "rocCurves/ViolaJonesScore_n0_ContROC.txt" using 2:1 title 'Viola-Jones' with lines lw 2, \
 "rocCurves/MikolajczykContROC.txt" using 2:1 title 'Mikolajczyk et al.' with lines lw 2, \
 "rocCurves/kienzleContROC.txt" using 2:1 title 'Kienzle et al.' with lines lw 2


 

