
function [theta,BW,x,quality] = imageProcess(myImage,range,rangeTable)

    Dist = range;
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
    
%     Length=-67.828*Dist^3+390.13*Dist^2-777.23*Dist+623.71;
    Length=-67.828*Dist^3+390.13*Dist^2-777.23*Dist+620.0;
    
    AxisLength = regionprops(BW, 'MinorAxisLength', 'MajorAxisLength');
    
    % Default values
    x = 0;
    theta = 0;
    quality = 0;
    
    if ~isempty(AxisLength)
        for i=1:length(AxisLength)
           if (AxisLength(i).('MajorAxisLength') >= Length) && (AxisLength(i).('MajorAxisLength') <= (Length+10))
                x = AxisLength(i).('MinorAxisLength');
                y = AxisLength(i).('MajorAxisLength');
                diff = x/y;
                theta = -212244.05252*diff^5+870839.52192*diff^4-1423270.72883*diff^3+1157901.45123*diff^2-468883.28852*diff+75654.61750;
                
                quality = 1;
            end
        end
    end

end

