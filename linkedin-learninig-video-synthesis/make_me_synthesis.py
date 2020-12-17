import cv2
import numpy as np
import os


if not os.path.exists('output'):
    os.makedirs('output')

# TAKE CAPTURE
loop_time = 0 
loop_incremet = 3000 # 3000ms = 3s
loop = True

path_or_url_to_video = input("url or path : ")
print("Ne touche pas au dossier 'output', ainsi que son contenu !")

# vidcap = cv2.VideoCapture('0.mp4') # 611 000ms || 10:11 || 611s
vidcap = cv2.VideoCapture(path_or_url_to_video)

frame_number = vidcap.get(cv2.CAP_PROP_FRAME_COUNT)
fps = int(vidcap.get(cv2.CAP_PROP_FPS))
ms_long= int(frame_number / fps) * 1000

while loop:
    try:
        vidcap.set(cv2.CAP_PROP_POS_MSEC,loop_time) 
        success,image = vidcap.read()
        if success:
            cv2.imwrite("output/at"+str(loop_time)+".jpg", image)     # save frame as JPEG file
            #cv2.imshow("3sec",image)
            #cv2.waitKey()
        loop_time+=loop_incremet # take a pic every X ms (3000ms = 3s)
        if loop_time > ms_long:
            loop=False
    except Exception as e:  
        loop=False
        print(e)
        print("fin de boucle")

print("CAPTURES ARE DONE")
# DELETE DUPLICATION
previous = 0
tested = loop_incremet

loop = True

while loop:

    try :
        duplicate = cv2.imread("output/at"+str(previous)+".jpg")
        original = cv2.imread("output/at"+str(tested)+".jpg")
        # 1) Check if 2 images are equals
        if original.shape == duplicate.shape:
            # print("The images have same size and channels")
            difference = cv2.subtract(original, duplicate)
            b, g, r = cv2.split(difference)

            if cv2.countNonZero(b) == 0 and cv2.countNonZero(g) == 0 and cv2.countNonZero(r) == 0:
                print("Duplication detected and removed")
                os.remove("output/at"+str(tested)+".jpg")

            else:
                # print("The images are not Equal")
                previous=tested
                
        # cv2.waitKey(0)
        # cv2.destroyAllWindows()
        
    except:
        pass

    if tested+5000 > ms_long:
            loop=False
    else:
        tested+=loop_incremet     

print("DELETIONS ARE DONE")