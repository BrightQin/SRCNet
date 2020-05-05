function dataOut = commonPreprocessing(data)

dataOut = cell(size(data));
for col = 1:size(data,2)
    for idx = 1:size(data,1)
%         if size(data,3)==1
%             data = cat(3, data, data, data);
%         end

        temp = single(data{idx,col});
        temp = imresize(temp,[224,224]);
        temp = rescale(temp);
        dataOut{idx,col} = temp;
    end
end
end