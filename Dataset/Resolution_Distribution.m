% read images
imds=imageDatastore('Image/WMI', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
result1=0;
result2=0;
result3=0;
result4=0;
for i=1:length(imds.Files)
    img=readimage(imds, i);
    [row, col, layers]=size(img);
    
    if row<=64 || col<=64
        result1=result1+1;
    elseif row<=112 || col<=112
        result2=result2+1;
    elseif row<=150 || col<=150
        result3=result3+1;
    elseif row<=224 || col<=224
        result4=result4+1;
    end
end