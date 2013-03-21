//
//  UIImage+Grayscale.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 26/09/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage(GrayscaleExtensions)

-(UIImage *)grayScaleImage;
-(UIImage *) getImageWithTintedColorwithTint:(UIColor *)color withIntensity:(float)alpha ;
- (UIImage *) changeColor :(NSInteger)colorSelected;
-(UIImage*)invertImage;
@end
