@echo off

set METHOD=MTCNN

cd ../FDDB-folds/
copy FDDB-fold-??.txt "../evaluation/imList.txt"
copy FDDB-fold-??-ellipseList.txt "../evaluation/ellipseList.txt"
cd ../evaluation

cd "../outputs/%METHOD%/"
copy *.txt "../../evaluation/Dets.txt"

cd ../../evaluation
"D:/MRUtil/Perl/bin/perl" runEvaluate-Windows.pl
move ContROC.png "../outputs/%METHOD%ContROC.png"
move DiscROC.png "../outputs/%METHOD%DiscROC.png"
pause