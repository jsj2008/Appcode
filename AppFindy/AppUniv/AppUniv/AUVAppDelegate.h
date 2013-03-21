//
//  AUVAppDelegate.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AUVConstants.h"
#import "Flurry.h"
#import <iHasApp/iHasApp.h>
#import "AUVAppWallController.h"
#import "AUVwallcontrollerViewController.h"
@class AUVwallcontrollerViewController;

@interface AUVAppDelegate : UIResponder <UIApplicationDelegate,FBSessionDelegate,iHasAppDelegate>
{
    Facebook *facebook;
    NSArray *fbPermission;
    NSMutableArray *viewControllers;
   iHasApp *appEngine;
    NSArray *detectedApps;
    BOOL notified;
    AUVwallcontrollerViewController *viewController;
     UIView         *spinnerView;
    UIActivityIndicatorView *indicator;
    
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic)BOOL notified;
@property (strong, nonatomic) AUVwallcontrollerViewController *viewController;
@property(strong,nonatomic) Facebook *facebook;
@property(strong,nonatomic) NSArray *fbPermission;
@property (strong,nonatomic) NSMutableArray *viewControllers;
@property(nonatomic)NSInteger notificationType;
@property(nonatomic,retain) NSString *notificationAppId;

-(void)uploadMyAppsDetails;
-(void)updateAppsList;
-(NSString*)deviceToken;
-(BOOL)notified;
-(NSInteger)notificationType;
-(NSString*)notificationAppId;
-(void)startSpinner;
-(void)stopSpinner;

@end
