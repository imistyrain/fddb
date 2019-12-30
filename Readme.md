# fddb 人脸检测评估

## 简介

[fddb](http://vis-www.cs.umass.edu/fddb/index.html)是Face Detection Data Set and Benchmark的缩写,包含了2845张图片，包含彩色以及灰度图，其中的人脸总数达到5171个。这些人脸所呈现的状态多样，包括遮挡、罕见姿态、低分辨率以及失焦的情况.评价细节可参见[FDDB人脸检测算法评价标准](https://yinguobing.com/fddb/).

## 结构

[originalPics](http://tamaraberg.com/faceDataset/originalPics.tar.gz)存储了网站下载的原始格式, 由于其是多级目录形式，不符合主流的标准，外面用脚本将其转换成了二级目录的格式，[FDDB-folds](http://vis-www.cs.umass.edu/fddb/FDDB-folds.tgz)存储了原始的标注格式. images文件夹存储了将路径中的/替换为_的图片文件，Annotations存储了VOC格式的标注，labels存储了YOLO格式的标注, ImageSets为VOC格式的split，train.txt,val.txt等为YOLO格式的分批. *_lmdb为caffe训练所需的格式. Windows目录实现了Win下的一键式评估.

## evaluation

[官网下载的代码](http://vis-www.cs.umass.edu/fddb/evaluation.tgz)仅支持OpenCV2.\*，3.\*后命名发生了变化，需要用cv::Scalar代替CV_RGB.

### Ubuntu & Mac

```
cd evaluation
make -j4
perl runEvaluate.pl
```

### Windows
安装[ActivePerl](https://www.activestate.com/products/perl/downloads/)和[gnuplot](https://jaist.dl.sourceforge.net/project/gnuplot/gnuplot/5.2.8/gp528-win64-mingw.exe)
编译evaluation, 双击打开Windows/evaluation.sln编译即可
cd evaluation
双击运行RunEvaluation.bat, 绘制出的图在当前目录下