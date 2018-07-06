function rainbowify_gif (gif_name, out_folder = ".", base_name = "out")

pkg load image;

[images, base_map] = imread(gif_name, 'gif', 'Frames', 'all');
gray_images = ind2gray(images, base_map);
s = size(gray_images);
map = colormap(hsv);
step = floor(length(map(:,1)) / s(4));

img_counter = 1;
for i = 1:step:length(map(:,1))
    newmap = [ map(i:end, :) ; map(1:(i-1), :) ];
    outfile = strcat([out_folder "/" base_name num2str(i, "%02d") ".png"]);
    gray_img = 1 + gray2ind(gray_images(:,:,:,img_counter));
    imwrite(gray_img, newmap, outfile);
    img_counter = img_counter + 1;
end

end
