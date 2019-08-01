
function [theta,BW,x,quality] = imageProcess(myImage,range,rangeTable)

    img = im2double(myImage);
% 
%     imR = squeeze(img(:,:,1));
%     imG = squeeze(img(:,:,2));
%     imB = squeeze(img(:,:,3));
% 
%     imBinaryR = imbinarize(imR);
%     imBinaryG = imbinarize(imG);
%     imBinaryB = imbinarize(imB);
%     imBinary = (imBinaryR&imBinaryG&imBinaryB);
    
    imBinary = imbinarize(img);
    
    %imBinary =  bwareafilt(imcomplement(imBinary),range); 
    imBinary = bwareaopen(imcomplement(imBinary),3000);
    
    BW = bwmorph(imBinary,'hbreak',Inf);
    BW = bwmorph(BW,'spur',Inf);
    BW = bwmorph(BW, 'clean', Inf); %Changed
    
    
    AxisLength = regionprops(BW, 'MinorAxisLength', 'MajorAxisLength');
    
    % Default values
    x = 0;
    theta = 0;
    quality = 0;
    
    if ~isempty(AxisLength)
        for i=1:length(AxisLength)
            if (AxisLength(i).('MajorAxisLength') >= 60) && (AxisLength(i).('MajorAxisLength') <= 150)
                x = AxisLength(i).('MinorAxisLength');
                y = AxisLength(i).('MajorAxisLength');
                diff = x/y;
                theta = -11723.69172*diff^3+30710.37033*diff^2-26860.97276*diff+7874.05175;
                quality = 1;
            end
        end
    end

end

