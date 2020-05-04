imds=imageDatastore('raw_images', ...
    'IncludeSubfolders',true);
box_file=datastore('out1');

for i=1:length(box_file.Files)
    text_file=fopen(char(box_file.Files(i)));
    line_ex = fgetl(text_file);
    flag=0;
    
    while line_ex~=-1
        line_ex = strsplit(line_ex, ' ');
        image_file_short=char(line_ex(1));
        condition=char(line_ex(2));
        x1=str2double(cell2mat(line_ex(3)));
        y1=str2double(cell2mat(line_ex(4)));
        x2=str2double(cell2mat(line_ex(5)));
        y2=str2double(cell2mat(line_ex(6)));
        image_file = fullfile('F:\Program\mask\raw_images',image_file_short);
        if flag==0    
            if exist(image_file, 'file')~=2
                break;
            end
            
            I=imread(image_file);
           
            if condition=="none"
                color='yellow';
                condition="WMI";
            elseif condition=="good"
                color='green';
                condition="WMC";
            elseif condition=="bad"
                color='red';
                condition="NWM";
            end
            
            IFaces = insertObjectAnnotation(I,'rectangle',[x1-(x2-x1)/10,y1-(y2-y1)/4,(x2-x1)*1.3,1.3*(y2-y1)], condition,...
                'TextBoxOpacity',0.8,'FontSize',24, 'LineWidth', 5, 'Color', color, 'Font', 'Times New Roman'); 
        else
            if condition=="none"
                color='yellow';
                condition="WMI";
            elseif condition=="good"
                color='green';
                condition="WMC";
            elseif condition=="bad"
                color='red';
                condition="NWM";
            end

            IFaces = insertObjectAnnotation(IFaces,'rectangle',[x1-(x2-x1)/10,y1-(y2-y1)/4,(x2-x1)*1.3,1.3*(y2-y1)], condition,...
                'TextBoxOpacity',0.8,'FontSize',24, 'LineWidth', 5, 'Color', color, 'Font', 'Times New Roman'); 
        end
        line_ex = fgetl(text_file);
        flag=1;
%         imshow(IFaces)
    end
%     figure(1)
%     imshow(IFaces)
%     title('Detected faces');
    imwrite(IFaces, fullfile('F:\Program\mask\Database_show_Result',image_file_short));
    fclose(text_file);
end