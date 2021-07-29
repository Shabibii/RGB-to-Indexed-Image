% Obtained through Github, available at: https://github.com/cmanso/MedianCut_Matlab
function Y= checkcolours(im)
[szx, szy]= size(im(:,:,1));
temp=1;
for x=1:szx
    for y=1:szy
        for k=1:3
            colours_unique(temp,k)= im(x,y,k);
        end
        temp= temp+1;
    end
end
Y= length(unique(colours_unique, 'rows'));
end