# fddb

## 简介

[fddb](http://vis-www.cs.umass.edu/fddb/index.html)是Face Detection Data Set and Benchmark的缩写,包含了2845张图片，包含彩色以及灰度图，其中的人脸总数达到5171个。这些人脸所呈现的状态多样，包括遮挡、罕见姿态、低分辨率以及失焦的情况.评价细节可参见[FDDB人脸检测算法评价标准](https://yinguobing.com/fddb/).

## evaluation

[官网下载的代码](http://vis-www.cs.umass.edu/fddb/evaluation.tgz)仅支持OpenCV2.*，3.*后命名发生了变化，需要用cv::Scalar代替CV_RGB.

### Ubuntu & Mac

```
cd evaluation
make -j4
```

### Windows
双击打开Windows/evaluation.sln编译即可