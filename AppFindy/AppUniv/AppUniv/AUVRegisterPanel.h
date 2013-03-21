//
//  AUVRegisterPanel.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAModalPanel.h"
#import "UATitledModalPanel.h"
#import "ASSignViewController.h"
@protocol RatingViewDelegate <NSObject>

@optional
-(void)RatingsViewalues:(NSString*)rating;
@end



@interface AUVRegisterPanel : UATitledModalPanel<UIScrollViewDelegate,RatingViewDelegate>
{
    
    IBOutlet UIView *view;
    IBOutlet UIScrollView *baseScroll;
    IBOutlet UILabel *message;
   IBOutlet UITextField *uname;
   IBOutlet UITextField *pass;
   IBOutlet UITextField *vpass;
   IBOutlet UITextField *mail;
    IBOutlet UITextField *firstname;
    IBOutlet UIButton *submit;
}
@property(nonatomic) BOOL loggedIn;
@end

