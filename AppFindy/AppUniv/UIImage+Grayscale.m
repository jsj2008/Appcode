//
//  UIImage+Grayscale.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 26/09/12.
//
//

#import "UIImage+Grayscale.h"

@implementation UIImage(GrayscaleExtensions)


- (UIImage *)grayScaleImage {
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, self.size.width * self.scale, self.size.height * self.scale);
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, self.size.width * self.scale, self.size.height * self.scale, 8, 0, colorSpace, kCGImageAlphaNone);
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [self CGImage]);
    // Create bitmap image info from pixel data in current context
    CGImageRef grayImage = CGBitmapContextCreateImage(context);
    // release the colorspace and graphics context
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    // make a new alpha-only graphics context
    context = CGBitmapContextCreate(nil, self.size.width * self.scale, self.size.height * self.scale, 8, 0, nil, kCGImageAlphaOnly);
    // draw image into context with no colorspace
    CGContextDrawImage(context, imageRect, [self CGImage]);
    // create alpha bitmap mask from current context
    CGImageRef mask = CGBitmapContextCreateImage(context);
    // release graphics context
    CGContextRelease(context);
    // make UIImage from grayscale image with alpha mask
    UIImage *grayScaleImage = [UIImage imageWithCGImage:CGImageCreateWithMask(grayImage, mask) scale:self.scale orientation:self.imageOrientation];
    // release the CG images
    CGImageRelease(grayImage);
    CGImageRelease(mask);
    // return the new grayscale image
    return grayScaleImage;
}


-(UIImage *) getImageWithTintedColorwithTint:(UIColor *)color withIntensity:(float)alpha {
    CGSize size = self.size;
    
    UIGraphicsBeginImageContextWithOptions(size, FALSE, 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGContextSetAlpha(context, alpha);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(CGPointZero.x, CGPointZero.y, self.size.width, self.size.height));
    
    UIImage * tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}



- (UIImage *) changeColor :(NSInteger)colorSelected{
    
    UIImage *image=self;
    UIGraphicsBeginImageContext(image.size);
    
    CGRect contextRect;
    contextRect.origin.x = 0.0f;
    contextRect.origin.y = 0.0f;
    contextRect.size = [image size];
    // Retrieve source image and begin image context
    CGSize itemImageSize = [image size];
    CGPoint itemImagePosition;
    itemImagePosition.x = ceilf((contextRect.size.width - itemImageSize.width) / 2);
    itemImagePosition.y = ceilf((contextRect.size.height - itemImageSize.height) );
    
    UIGraphicsBeginImageContext(contextRect.size);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    // Setup shadow
    // Setup transparency layer and clip to mask
    CGContextBeginTransparencyLayer(c, NULL);
    CGContextScaleCTM(c, 1.0, -1.0);
    CGContextClipToMask(c, CGRectMake(itemImagePosition.x, -itemImagePosition.y, itemImageSize.width, -itemImageSize.height), [image CGImage]);
    
    
   switch (colorSelected) {
        case 0:
            CGContextSetRGBFillColor(c, 0, 0, 1, 1);
            break;
            
        default:
            CGContextSetRGBFillColor(c, 1, 0, 0., 1);
            break;
    }
    //CGContextSetRGBFillColor(c, 0, 0, 1, 1);
    
    contextRect.size.height = -contextRect.size.height;
    contextRect.size.height -= 15;
    // Fill and end the transparency layer
    CGContextFillRect(c, contextRect);
    CGContextEndTransparencyLayer(c);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(UIImage*)invertImage{
    UIImage *image=self;

    UIGraphicsBeginImageContext(image.size);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),[UIColor whiteColor].CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height));
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}
@end
