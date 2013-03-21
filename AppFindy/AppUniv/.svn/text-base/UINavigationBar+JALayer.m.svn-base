//
//  UINavigationBar+JALayer.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+JALayer.h"

@implementation UINavigationBar(JAGADEESH)


// callback for CreateImagePattern.
static void drawPatternImage (void *info, CGContextRef ctx)
{
    CGImageRef image = (CGImageRef) info;
    CGContextDrawImage(ctx, 
                       CGRectMake(0,0, CGImageGetWidth(image),CGImageGetHeight(image)),
                       image);
}

// callback for CreateImagePattern.
static void releasePatternImage( void *info )
{
    CGImageRelease((CGImageRef)info);
}

//assume image is the CGImage you want to assign as the layer background
+ (UINavigationBar *)JALayerofNavigationBar:(UINavigationBar *)nav withImage:(UIImage*)fromImage withHeight:(CGFloat)height andWidth:(CGFloat)width;
{
    
    
        if (height == 0)
            return nil;
        
        // create a bitmap graphics context the size of the image
        //CGContextRef mainViewContentContext = createBitmapContext(fromImage.bounds.size.width, height);
        
      //  CGImageRef gradientMaskImage = createGradientImage(1, height);
        
   /* UIImage*    backgroundImage = fromImage;
    CALayer*    aLayer = [CALayer layer];
    CGFloat nativeWidth = CGImageGetWidth(backgroundImage.CGImage);
    CGFloat nativeHeight = CGImageGetHeight(backgroundImage.CGImage);
    CGRect      startFrame = CGRectMake(0.0, 0.0, nav.frame.size.width, nav.frame.size.height);
    aLayer.contents = (id)backgroundImage.CGImage;
    aLayer.frame = startFrame;
    
    nav.tintColor=[aLayer c]
    
    
    CALayer *layer=[nav layer];
        
    [layer addSublayer:aLayer];
        */
  //  CALayer *layer=[nav layer];
    
    int widthw = CGImageGetWidth(fromImage.CGImage);
    int heightw = CGImageGetHeight(fromImage.CGImage);
    static const CGPatternCallbacks callbacks = {0, &drawPatternImage, &releasePatternImage};
    CGPatternRef pattern = CGPatternCreate (fromImage.CGImage,
                                            CGRectMake (0, 0, widthw, heightw),
                                            CGAffineTransformMake (1, 0, 0, 1, 0, 0),
                                            widthw,
                                            heightw,
                                            kCGPatternTilingConstantSpacing,
                                            true,
                                            &callbacks);
    CGColorSpaceRef space = CGColorSpaceCreatePattern(NULL);
    CGFloat components[1] = {1.0};
    CGColorRef color = CGColorCreateWithPattern(space, pattern, components);
    CGColorSpaceRelease(space);
    CGPatternRelease(pattern);
    nav.tintColor = [UIColor colorWithCGColor:color];//color; //set your layer's background to the image
    CGColorRelease(color);

        
        
        return nav;


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
