function dataOut = downsample(data)

dataOut = data;
w=fspecial('gaussian',[5 5], 10);
for idx = 1:size(data,1)
   %dataOut{idx} = imnoise(data{idx},'gaussian');
   dataOut{idx}=imfilter(data{idx},w);
   dataOut{idx}= imresize(dataOut{idx},[112,112]);
end

end