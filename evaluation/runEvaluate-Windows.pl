#!/usr/bin/perl -w

use strict;

#### VARIABLES TO EDIT ####
# where gnuplot is
my $GNUPLOT = "gnuplot"; 
# where the binary is
my $evaluateBin = "evaluation"; 
# where the images are
my $imDir = "../originalPics/"; 
# where the folds are
my $fddbDir = "../FDDB-folds"; 
# where the detections are
my $detDir = "./";
###########################

my $detFormat = 0; # 0: rectangle, 1: ellipse 2: pixels

sub makeGNUplotFile
{
  my $rocFile = shift;
  my $gnuplotFile = shift;
  my $title = shift;
  my $pngFile = shift;

  open(GF, ">$gnuplotFile") or die "Can not open $gnuplotFile for writing\n"; 
  #print GF "$GNUPLOT\n";
  print GF "set term png\n";
  print GF "set size .75,1\n";
  print GF "set output \"$pngFile\"\n";
  #print GF "set xtics 500\n";
  #print GF "set logscale x\n";
  print GF "set ytics .1\n";
  print GF "set grid\n";
  #print GF "set size ratio -1\n";
  print GF "set ylabel \"True positive rate\"\n";
  print GF "set xlabel \"False positives\"\n";
  #print GF "set xr [0:50000]\n";
  print GF "set yr [0:1]\n";
  print GF "set key right bottom\n";
  print GF "plot \"$rocFile\" using 2:1 with linespoints title \"$title\"\n";
  close(GF);
}
my $annotFile = "ellipseList.txt";
my $listFile = "imList.txt";
my $gpFile = "createROC.p";
# read all the folds into a single file for evaluation
my $detFile = $detDir;
#$detFile =~ s/\//_/g;
$detFile = "Dets.txt";
# if(-e $detFile){
  # system("del", $detFile);
# }

# if(-e $listFile){
  # system("del", $listFile);
# }

# if(-e $annotFile){
  # system("del", $annotFile);
# }

# foreach my $fi (1..10){
  # my $foldFile = sprintf("%s/fold-%02d-out.txt", $detDir, $fi);
  # print $foldFile;
  # system("type $foldFile >> $detFile");
  # $foldFile = sprintf("%s/FDDB-fold-%02d.txt", $fddbDir, $fi);
  # system("type $foldFile >> $listFile");
  # $foldFile = sprintf("%s/FDDB-fold-%02d-ellipseList.txt", $fddbDir, $fi);
  # system("type $foldFile >> $annotFile");
# }

#die;
# run the actual evaluation code to obtain different points on the ROC curves
#system($evaluateBin, "-a", $annotFile, "-d", $detFile, "-f", $detFormat, "-i", $imDir, "-l", $listFile, "-r", $detDir, "-s");
system($evaluateBin, "-a", $annotFile, "-d", $detFile, "-f", $detFormat, "-i", $imDir, "-l", $listFile, "-r", $detDir);

# plot the two ROC curves using GNUplot
makeGNUplotFile($detDir."tempContROC.txt", $gpFile, $detDir, $detDir."ContROC.png");
system("$GNUPLOT $gpFile");

makeGNUplotFile($detDir."tempDiscROC.txt", $gpFile, $detDir, $detDir."DiscROC.png");
system("$GNUPLOT $gpFile");

# remove intermediate files
system("del",$annotFile);
system("del",$listFile);
system("del",$gpFile);
system("del",$detFile);