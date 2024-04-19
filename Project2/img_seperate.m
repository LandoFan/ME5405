function [count, s] = img_seperate(label_matrix)

count = 0;
label = [];
[h,w] = size(label_matrix);
% get the number of segmentation
for i = 1 : h
    for j = 1 : w
        if label_matrix(i,j) == 0
            continue;
        else
            if ~ismember(label_matrix(i,j), label)
                label = [label, label_matrix(i,j)];
                count = count + 1;
            end
        end
    end
end


s(count) = struct('image',[],'address',[],'center',[],'boundingbox',[]);
for i=1:count
    [h,w] = find(label_matrix == label(i));
    s(i).address = [h,w];

    hh  = h-min(h)+1;
    ww = w-min(w)+1;
    s(i).image = zeros(max(hh)+20,max(ww)+20);
    %move the image into the middle of the picture
    s(i).boundingbox=[min(h)-0.5,min(w)-0.5,max(h)+0.5,max(w)+0.5];
    for k=1:size(hh)
        s(i).image(hh(k)+10,ww(k)+10)=1;
    end  
    s(i).center=[mean(h),mean(w)];
     
end


end

