//
//  ASSignViewController.h
//  AppSnatch
//
//  Created by Innoppl Technologies on 25/02/13.
//  Copyright (c) 2013 Innoppl Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RatingViewDelegate <NSObject>

@optional
-(void)RatingsViewalues:(NSString*)rating;
@end


@interface ASSignViewController : UIViewController{
    id <RatingViewDelegate>delegate;
}
@property(retain)id delegate;


-(UITextField*)customtxtfield:(NSString*)filedtype placeholder:(NSString*)str initFrame:(CGRect)frame;

@end
