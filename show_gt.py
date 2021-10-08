import os
import sys
import math
import cv2
import numpy as np
from tqdm import tqdm
from xml.dom.minidom import Document

rootdir="./"
origimagedir=rootdir+"/originalPics"
imagesdir=rootdir+"/images"
annotationdir=rootdir+"/FDDB-folds"
labelsdir=rootdir+"/labels"
Annotationsdir=rootdir+"/Annotations"
datasetprefix="images/"

def filterCoordinate(c,m):
    if c < 0:
    	return 0
    elif c > m:
    	return m
    else:
    	return c

def show_annotations(bsavexmlanno=1,bsavetxtanno=1,savegt=1):
    if not os.path.exists(Annotationsdir):
        os.mkdir(Annotationsdir)
    if not os.path.exists(labelsdir):
        os.mkdir(labelsdir)
    for i in range(10):
        annotationfilepath=annotationdir+"/FDDB-fold-%0*d-ellipseList.txt"%(2,i+1)
        annotationfile=open(annotationfilepath)
        while(True):
            filename=annotationfile.readline()[:-1]+".jpg"
            if not filename:
                break
            line=annotationfile.readline()
            if not line:
                break
            #print(filename)
            sys.stdout.write("\r"+str(i)+": "+filename)
            facenum=(int)(line)
            img=cv2.imread(origimagedir+"/"+filename)
            filename=filename.replace('/','_')
            #cv2.imwrite(imagesdir+"/"+filename,img)
            w = img.shape[1]
            h = img.shape[0]
            if bsavetxtanno:
                labelpath=labelsdir+"/"+filename.replace('/','_')[:-3]+"txt"
                labelfile=open(labelpath,'w')
            if bsavexmlanno:
                xmlpath=Annotationsdir+"/"+filename.replace('/','_')[:-3]+"txt"
                xmlpath=xmlpath[:-3]+"xml"
                doc = Document()
                annotation = doc.createElement('annotation')
                doc.appendChild(annotation)
                folder = doc.createElement('folder')
                folder_name = doc.createTextNode('fddb')
                folder.appendChild(folder_name)
                annotation.appendChild(folder)
                filenamenode = doc.createElement('filename')
                filename_name = doc.createTextNode(filename)
                filenamenode.appendChild(filename_name)
                annotation.appendChild(filenamenode)
                source = doc.createElement('source')
                annotation.appendChild(source)
                database = doc.createElement('database')
                database.appendChild(doc.createTextNode('fddb Database'))
                source.appendChild(database)
                annotation_s = doc.createElement('annotation')
                annotation_s.appendChild(doc.createTextNode('PASCAL VOC2007'))
                source.appendChild(annotation_s)
                image = doc.createElement('image')
                image.appendChild(doc.createTextNode('flickr'))
                source.appendChild(image)
                flickrid = doc.createElement('flickrid')
                flickrid.appendChild(doc.createTextNode('-1'))
                source.appendChild(flickrid)
                owner = doc.createElement('owner')
                annotation.appendChild(owner)
                flickrid_o = doc.createElement('flickrid')
                flickrid_o.appendChild(doc.createTextNode('yanyu'))
                owner.appendChild(flickrid_o)
                name_o = doc.createElement('name')
                name_o.appendChild(doc.createTextNode('yanyu'))
                owner.appendChild(name_o)
                size = doc.createElement('size')
                annotation.appendChild(size)
                width = doc.createElement('width')
                width.appendChild(doc.createTextNode(str(img.shape[1])))
                height = doc.createElement('height')
                height.appendChild(doc.createTextNode(str(img.shape[0])))
                depth = doc.createElement('depth')
                depth.appendChild(doc.createTextNode(str(img.shape[2])))
                size.appendChild(width)
                size.appendChild(height)
                size.appendChild(depth)
                segmented = doc.createElement('segmented')
                segmented.appendChild(doc.createTextNode('0'))
                annotation.appendChild(segmented)
            for j in range(facenum):
                line=annotationfile.readline().strip().split()
                a=float(line[0])
                b=float(line[1])
                angle=float(line[2])
                center_x=float(line[3])
                center_y=float(line[4])
                score=float(line[5])
                degree = angle / math.pi*180
                cv2.ellipse(img, ((int)(center_x), (int)(center_y)), ((int)(a), (int)(b)), degree, 0., 360.,(0, 255, 0)) 
                
                tan_t = -(b/a)*math.tan(angle)
                t = math.atan(tan_t)
                x1 = center_x + (a*math.cos(t)*math.cos(angle) - b*math.sin(t)*math.sin(angle))
                x2 = center_x + (a*math.cos(t+math.pi)*math.cos(angle) - b*math.sin(t+math.pi)*math.sin(angle))
                x_max = filterCoordinate(max(x1,x2),w)
                x_min = filterCoordinate(min(x1,x2),w)
                
                if math.tan(angle) != 0:
                    tan_t = (b/a)*(1/math.tan(angle))
                else:
                    tan_t = (b/a)*(1/(math.tan(angle)+0.0001))
                t = math.atan(tan_t)
                y1 = center_y + (b*math.sin(t)*math.cos(angle) + a*math.cos(t)*math.sin(angle))
                y2 = center_y + (b*math.sin(t+math.pi)*math.cos(angle) + a*math.cos(t+math.pi)*math.sin(angle))
                y_max = filterCoordinate(max(y1,y2),h)
                y_min = filterCoordinate(min(y1,y2),h)
                cv2.rectangle(img,(int(x_min),int(y_min)),(int(x_max),int(y_max)),(255,0,0))
                xcenter=(x_min+y_min)//2
                ycenter=(x_max+y_max)//2
                if bsavetxtanno:
                    labelline="0"+"\t"+str(xcenter*1.0/w) + '\t' + str(ycenter*1.0/h) + '\t' + str((x_max-x_min)*1.0/w) + '\t' + str((y_max-y_min)*1.0/h)	+ '\n'
                    labelfile.write(labelline)
                if bsavexmlanno:
                    object = doc.createElement('object')
                    annotation.appendChild(object)
                    object_name = doc.createElement('name')
                    object_name.appendChild(doc.createTextNode('face'))
                    object.appendChild(object_name)
                    pose = doc.createElement('pose')
                    pose.appendChild(doc.createTextNode('Unspecified'))
                    object.appendChild(pose)
                    truncated = doc.createElement('truncated')
                    truncated.appendChild(doc.createTextNode('1'))
                    object.appendChild(truncated)
                    difficult = doc.createElement('difficult')
                    difficult.appendChild(doc.createTextNode('0'))
                    object.appendChild(difficult)
                    bndbox = doc.createElement('bndbox')
                    object.appendChild(bndbox)
                    xmin = doc.createElement('xmin')
                    xmin.appendChild(doc.createTextNode(str(x_min)))
                    bndbox.appendChild(xmin)
                    ymin = doc.createElement('ymin')
                    ymin.appendChild(doc.createTextNode(str(y_min)))
                    bndbox.appendChild(ymin)
                    xmax = doc.createElement('xmax')
                    xmax.appendChild(doc.createTextNode(str(x_max)))
                    bndbox.appendChild(xmax)
                    ymax = doc.createElement('ymax')
                    ymax.appendChild(doc.createTextNode(str(y_max)))
                    bndbox.appendChild(ymax)          
            if bsavetxtanno:
                labelfile.close()
            if bsavexmlanno:
                f=open(xmlpath,"w")
                f.write(doc.toprettyxml(indent = ''))
                f.close() 
            #cv2.imshow("img",img)
            #cv2.waitKey(1)
            if savegt:
                cv2.imwrite("gt/"+filename,img)

def generatetxt(trainratio=0.7,valratio=0.2,testratio=0.1):
    files=os.listdir(labelsdir)
    ftrain=open(rootdir+"/"+"train.txt","w")
    fval=open(rootdir+"/"+"val.txt","w")
    ftrainval=open(rootdir+"/"+"trainval.txt","w")
    ftest=open(rootdir+"/"+"test.txt","w")
    for i in range(len(files)):
        filename=files[i]
        filename=datasetprefix+filename[:-3]+"jpg"+"\n"
        if i<trainratio*len(files):
            ftrain.write(filename)
            ftrainval.write(filename)
        elif i<(trainratio+valratio)*len(files):
            fval.write(filename)
            ftrainval.write(filename)
        elif i<(trainratio+valratio+testratio)*len(files):
            ftest.write(filename)
    ftrain.close()
    fval.close()
    ftrainval.close()
    ftest.close()

def generatevocsets(trainratio=0.7,valratio=0.2,testratio=0.1):
    if not os.path.exists(rootdir+"/ImageSets"):
        os.mkdir(rootdir+"/ImageSets")
    if not os.path.exists(rootdir+"/ImageSets/Main"):
        os.mkdir(rootdir+"/ImageSets/Main")
    ftrain=open(rootdir+"/ImageSets/Main/train.txt",'w')
    fval=open(rootdir+"/ImageSets/Main/val.txt",'w')
    ftrainval=open(rootdir+"/ImageSets/Main/trainval.txt",'w')
    ftest=open(rootdir+"/ImageSets/Main/test.txt",'w')
    files=os.listdir(labelsdir)
    for i in range(len(files)):
        imgfilename=files[i][:-4]
        ftrainval.write(imgfilename+"\n")
        if i<int(len(files)*trainratio):
            ftrain.write(imgfilename+"\n")
        elif i<int(len(files)*(trainratio+valratio)):
            fval.write(imgfilename+"\n")
        else:
            ftest.write(imgfilename+"\n")
    ftrain.close()
    fval.close()
    ftrainval.close()
    ftest.close()

if __name__=="__main__":
    show_annotations()
    #generatevocsets()
    #generatetxt()