% Obtained through Github, available at: https://github.com/cmanso/MedianCut_Matlab
function labels = MCR(image, labels, id, iteration, last)
idA = id;
idB = bitset(id, iteration+1);
%disp('Voy a cambiar las ids:')
%disp(idA)
%disp('Voy a poner las ids:')
%disp(idB)
%disp('Y estoy en la iteración:')
%disp(iteration)
[szx, szy]= size(image(:,:,1));


%Longest range channel and fill pixelVec
pixelVec= [];
maxRange=-1;
for k=1:3
    temp=1;
    minV= 255;
    maxV= 0;
    for x=1:szx
        for y=1:szy
            if labels(x,y) == id
                pixelVec(temp, k)= image(x,y,k);
                temp=temp+1;
                if image(x,y,k) < minV
                    minV= image(x,y,k);
                end
                if image(x,y,k) > maxV
                    maxV= image(x,y,k);
                end
            end
        end
    end
    
    maxRangeTemp= maxV-minV;
    if maxRangeTemp> maxRange
        maxRange= maxRangeTemp;
        channel= k;
    end
end


%sort pixelVec and store median value
pixelVec= sortrows(pixelVec, channel);
cut= pixelVec( round(   size(pixelVec, 1)   /2), channel );

if pixelVec(size(pixelVec, 1), channel) == pixelVec(round(   size(pixelVec, 1)   /2), channel )
    disp('Can''t follow branch')
    return
end

%change labels acording to cut
for x= 1:szx
    for y= 1:szy
        if image(x,y,channel) > cut && labels(x,y) == id
            labels(x,y)= idB;
        end
    end
end

%disp('Y me ha quedado tal que así:')
%disp(labels)
if iteration < last
    labels=  MCR(image, labels, idA, iteration+1, last);
    labels=  MCR(image, labels, idB, iteration+1, last);
end

end
