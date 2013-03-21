//
//  UINavigationBar+JALayer.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface UINavigationBar (JALayer)
+ (UINavigationBar *)JALayerofNavigationBar:(UINavigationBar *)nav withImage:(UIImage*)fromImage withHeight:(CGFloat)height andWidth:(CGFloat)width;

@end
