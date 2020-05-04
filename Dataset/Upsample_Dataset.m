imds=imageDatastore('Mask', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

for i=1:length(imds.Files)
    img=readimage(imds, i);
    [row, col, layers]=size(img);
    
    if row<=150 || col<=150
        img = single(img);
        img = imresize(img,[224,224]);
        img = rescale(img);
        ypred = predict(net,img);
        imwrite(ypred,char(imds.Files(i)));
    end
end