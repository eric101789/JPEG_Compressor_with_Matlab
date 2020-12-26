# JPEG_Compressor_with_Matlab
In this project, we try to improve the compress rate for JPEG compressor.
After input image, we do the discrete cosine transform function to transform the pixel value into frequency domain.
Then, we use the quantization table to delete the data behind the decimal point.
Eventually, we do the inverse DCT function to transform frequency back into pixel value.
Later, we can output the image by imwrite function in MATLAB and compare the two images.
