
function [theta,BW,imgO,x,quality] = imageProcess(camObj,range,rangeTable)

imgO = step(camObj);

img = im2double(imgO);

imR = squeeze(img(:,:,1));
imG = squeeze(img(:,:,2));
imB = squeeze(img(:,:,3));

imBinaryR = imbinarize(imR);
imBinaryG = imbinarize(imG);
imBinaryB = imbinarize(imB);

imBinary = (imBinaryR&imBinaryG&imBinaryB);
%imBinary =  bwareafilt(imcomplement(imBinary),rangeTable)
imBinary =  bwareaopen(imcomplement(imBinary),rangeTable(1));

BW = bwmorph(imBinary,'hbreak',Inf);
BW = bwmorph(BW,'spur',Inf);
BW = bwmorph(BW, 'clean', Inf); %Changed

AxisLength = regionprops(BW, 'MinorAxisLength','MajorAxisLength');

if ~isempty(AxisLength)
    x=AxisLength(2).('MinorAxisLength');
    theta = -0.03898*x^3+6.84125*x^2-400.91004*x+7874.05175;
    quality = 1;
else
    x = 0;
    theta = 0;
    quality = 0;
end


end

