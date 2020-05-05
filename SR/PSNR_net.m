PSNR_result=zeros(size(imdsTest.Files));
SSIM_result=zeros(size(imdsTest.Files));
w=fspecial('gaussian',[5 5], 10);

parfor i=1:length(imdsTest.Files)
    ori_img = readimage(imdsTest,i);
    ori_img=imresize(ori_img,[224,224]);
    img = imfilter(ori_img,w);
    img = imresize(img,[112,112]);
    img = single(img);
    img = imresize(img,[224,224],'bicubic');
    img = rescale(img);
    img = predict(net,img, 'ExecutionEnvironment', 'gpu');
    img = uint8(img.*255);
    
    PSNR_result(i)=psnr(img, ori_img);
    SSIM_result(i)=ssim(img, ori_img);
    
end