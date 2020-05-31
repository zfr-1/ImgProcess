clc
clear
matname = 'data/data.mat';

path = './img/';
filename = [dir([path, '*.jpg']);dir([path, '*.png'])];
pic_filename = {filename.name};
num=length(pic_filename);
Istatxture = zeros(256,num);
IcolorMom = zeros(225,num);

%pictures = zeros(length(pic_filename),90,90,3);
for i = 1 :num
    path_data=char(strcat(path,pic_filename(i)));
    picture = imread(path_data);
    Istatxture(:,i)=lbp(picture);
    IcolorMom(:,i)=colorMom(picture);

   % pictures(i,:,:,:)=picture;
   img=rgb2gray(picture);
   count=imhist(img);
   hist_features{i,1}=path_data;
   hist_features{i,2}=count;
end
 save(matname, 'hist_features', 'Istatxture', 'IcolorMom');