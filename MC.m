% Obtained through Github, available at: https://github.com/cmanso/MedianCut_Matlab
function final= MC(im, n_colours)
[szx, szy]= size(im(:,:,1));


if floor(log2(n_colours)) ~= log2(n_colours)
    error('Number of colours must be power of 2');
end


n_unique_colours= checkcolours(im);
if n_unique_colours < n_colours
    error('Number of colours especified is greater than number of colours of the image');
end

final= zeros(szx,szy,3);
im= double(im);
labels= zeros(szx, szy);

labels= MCR(im, labels, 0, 0, log2(n_colours)-1);

colours= zeros(n_colours, 3);
n_pixels= zeros(n_colours, 1);
for x=1:szx
    for y=1:szy
        n_pixels(labels(x,y)+1)= n_pixels(labels(x,y)+1)+1;
        %colours(labels(x,y)+1, :)= colours(labels(x,y)+1, :) + im(x,y,:);
        colours(labels(x,y)+1, 1)= colours(labels(x,y)+1, 1) + im(x,y,1);
        colours(labels(x,y)+1, 2)= colours(labels(x,y)+1, 2) + im(x,y,2);
        colours(labels(x,y)+1, 3)= colours(labels(x,y)+1, 3) + im(x,y,3);
    end
end

for i=1:size(colours,1)
    colours(i,:)= round(colours(i,:)/n_pixels(i));
end

for x=1:szx
    for y=1:szy
        final(x, y, :)= colours(labels(x,y)+1, :);
    end
end
final=uint8(final);
end