# 数字图像处理作业：图像检索系统

一开始的计划为利用直方图进行图像检索。

~~缺点：如果数据集内的图像十分相似，这会导致直方图也十分相似，而出现按相似度排序失败的情况。~~所以追加利用纹理特征通过 LBP 方法来进行提取，成功率大大上升。

## How to run

Build success on Matlab R2015b & R2019b.

Run `window.m`.

First, you need to copy your images to `img` folder. Then, you need to manually create a `data` folder.

Plase switch your MATLAB locale to GBK.

## Others

`theta` 为选择纹理作为特征进行图像检索时的参数。这个参数接近 1 时，则特征全为颜色特征，theta 接近 0 时则特征全为纹理，当值介于两者之间时，既有纹理又有颜色特征。

## License

All Rights Reserved.

You CANNOT modify or redistribute this code without explicit permission from the copyright holder. You however, CAN clone and view the code.

## Links

 - https://zhuanlan.zhihu.com/p/27474514