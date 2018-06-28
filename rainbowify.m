function rainbowify (img_name, out_folder = ".", base_name = "out", step=4)

if step >=64 || step <= 0
    step = 4
end

pkg load image;

gray_img = 1 + gray2ind(rgb2gray(imread(img_name)));

map = colormap(hsv);

for i = 1:step:length(map(:,1))
    newmap = [ map(i:end, :) ; map(1:(i-1), :) ];
    imwrite(gray_img, newmap, strcat([out_folder "/" base_name num2str(i, "%02d") ".png"]));

end

end
