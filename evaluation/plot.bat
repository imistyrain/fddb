@echo off

set Method=MTCNN

if NOT "%~1%"=="" (
Method=%~1%
)
"D:/Program Files/gnuplot/bin/gnuplot" "%Method%ContROC.p"
"D:/Program Files/gnuplot/bin/gnuplot" "%Method%iscROC.p"
pause