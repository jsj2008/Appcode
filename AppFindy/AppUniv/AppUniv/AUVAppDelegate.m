//
//  AUVAppDelegate.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVAppDelegate.h"

#import "AUVViewController.h"
#import "UINAvigationBar+JALayer.h"
#import "AUVwebservice.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "SCNavigationBar.h"


@implementation AUVAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize facebook,fbPermission,viewControllers,notified,notificationType,notificationAppId;

 NSString* device_token=nil;
NSMutableDictionary *localData;

void uncaughtExceptionHandler (NSException *exception) {
    [Flurry logError:@"uncaught" message:@"Crash!" exception:exception];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    //[TestFlight takeOff:@"4666b83a93a8a7fe6854e787b0ffaf53_MTM3NjQ1MjAxMi0wOS0yOSAxMDoyOToyNC4xOTYyNTc"];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge )];
    [Flurry startSession:FLURRYKEY];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //[self performSelectorInBackground:@selector(uploadMyAppsDetails) withObject:nil];
    viewControllers=[[NSMutableArray alloc] init];
    
    facebook=[[Facebook alloc] initWithAppId:AUVFB_APPID andDelegate:self];
    fbPermission=[[NSArray alloc] initWithObjects:@"user_about_me",@"email",@"user_hometown",@"read_friendlists",@"publish_stream",@"user_location",@"user_website", nil];
  //  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([defaults objectForKey:AUVFBACCESSTOKENKEY]
//        && [defaults objectForKey:AUVFBEXPIRATIONDATEKEY]) {
//        facebook.accessToken = [defaults objectForKey:AUVFBACCESSTOKENKEY];
//        facebook.expirationDate = [defaults objectForKey:AUVFBEXPIRATIONDATEKEY];
//    }
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        //self.viewController = [[AUVViewController alloc] initWithNibName:@"AUVViewController_iPhone" bundle:nil];
//         self.viewController = [[AUVViewController alloc] initWithNibName:nil bundle:nil];
//    } else {
//        self.viewController = [[AUVViewController alloc] initWithNibName:@"AUVViewController_iPad" bundle:nil];
//    }
//    
//   // [self updateAppsList];
//    
//    
//  //  UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:self.viewController];
//    //[nav.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg"]]];
//    // UIImageView *bg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigation_bg"]];
//    
//    UINavigationController *nav=[self customizedNavigationController];
//    [nav setViewControllers:[NSArray arrayWithObject:self.viewController]];
//    
//    //[UINavigationBar JALayerofNavigationBar:nav.navigationBar withImage:[UIImage imageNamed:@"navigation_bg"] withHeight:44 andWidth:320];
//    
//    
//    if (launchOptions != nil)
//	{
//		NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//		if (dictionary != nil)
//		{
//			NSLog(@"Launched from push notification: %@", dictionary);
//			[self addMessageFromRemoteNotification:dictionary updateUI:NO];
//		}
//	}
//    else{
//        self.window.rootViewController = nav;
//        [self.window makeKeyAndVisible];
//    }
   
     self.viewController = [[AUVwallcontrollerViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
    UINavigationController *nav=[self customizedNavigationController];
    [nav setViewControllers:[NSArray arrayWithObject:self.viewController]];
     self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}

- (UINavigationController *)customizedNavigationController
{
    UINavigationController *navController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    
    // Ensure the UINavigationBar is created so that it can be archived. If we do not access the
    // navigation bar then it will not be allocated, and thus, it will not be archived by the
    // NSKeyedArchvier.
    [navController navigationBar];
    
    // Archive the navigation controller.
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:navController forKey:@"root"];
    [archiver finishEncoding];
    // [archiver release];
    //[navController release];
    
    // Unarchive the navigation controller and ensure that our UINavigationBar subclass is used.
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [unarchiver setClass:[SCNavigationBar class] forClassName:@"UINavigationBar"];
    UINavigationController *customizedNavController = [unarchiver decodeObjectForKey:@"root"];
    [unarchiver finishDecoding];
    // [unarchiver release];
    
    // Modify the navigation bar to have a background image.
    SCNavigationBar *navBar = (SCNavigationBar *)[customizedNavController navigationBar];
    [navBar setTintColor:[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsLandscapePhone];
    
    return customizedNavController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url];
    
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook handleOpenURL:url];
}


#pragma mark FBDelegate Methods

- (void)fbDidLogin {
    //NSLog(@"Logged In");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:AUVFBACCESSTOKENKEY];
    [defaults setObject:[facebook expirationDate] forKey:AUVFBEXPIRATIONDATEKEY];
    [defaults synchronize];
    
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AUVFBNotification object:nil];
}


- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:AUVFBACCESSTOKENKEY]) {
        [defaults removeObjectForKey:AUVFBACCESSTOKENKEY];
        [defaults removeObjectForKey:AUVFBEXPIRATIONDATEKEY];
        [defaults synchronize];
    }
    
    // //NSLog(@"Logged Out");
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    
}

-(void)fbDidNotLogin:(BOOL)cancelled
{
    
}

-(void)fbSessionInvalidated
{
    
}

-(void)updateAppsList
{
      
    
    
    appEngine = [[iHasApp alloc] initWithDelegate:self andKey:@"TXTZQT36TZEK"];
    appEngine.country = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    [self detectApps];

}




#pragma mark - iHasApp methods

- (void)detectApps
{
    
    [appEngine beginDetection];
   
    //NSLog(@"appDetectionDidBegin");
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
   
}

- (void)appDetectionDidSucceed:(NSArray *)appsDetected
{
    //NSLog(@"appDetectionDidSucceed:");
    detectedApps = appsDetected;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    //NSLog(@"%@",detectedApps);
    //NSMutableArray *appArray=[[NSMutableArray alloc] initWithCapacity:detectedApps.count];
    NSMutableString *apps=[[NSMutableString alloc] init];
    for(int i=0;i<detectedApps.count;i++)
    {
       // [appArray addObject:[[detectedApps objectAtIndex:i] valueForKey:@"artistId"]];
        [apps appendFormat:@"%@,",[[detectedApps objectAtIndex:i] valueForKey:@"trackId"]];
    }
    
    [apps deleteCharactersInRange:NSMakeRange([apps length]-1, 1)];
    
    [self uploadMyAppsDetails:apps];
    
    [SVProgressHUD dismiss];
    //[self.tableView reloadData];
}

- (void)appDetectionDidFail:(iHasAppError)detectionError
{
    //NSLog(@"appDetectionDidFail:");
    detectedApps = [NSArray array];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *error;
    switch (detectionError)
    {
        case iHasAppErrorUnknown:
            error = @"iHasAppError: Unknown";
            break;
        case iHasAppErrorConnection:
            error = @"iHasAppError: Connection";
            break;
        case iHasAppErrorInvalidKey:
            error = @"iHasAppError: InvalidKey";
            break;
        case iHasAppErrorReachedLimit:
            error = @"iHasAppError: ReachedLimit";
            break;
            
        default:
            break;
    }
    
    [SVProgressHUD showErrorWithStatus:error];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error
//                                                        message:nil
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//    [alertView show];
}



-(void)uploadMyAppsDetails:(NSString*)apps
{
    AUVwebservice *service=[AUVwebservice service];
    
   // service.logging=NO;
    //[service myApps:self action:@selector(Uploadhandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:apps];
    [service myapps:self action:@selector(Uploadhandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:apps type:@"2"];
}

-(void)Uploadhandler:(id)value
{
    //SoapArray *arr=(SoapArray*)value;
    
    //NSLog(@"Arr : %@",arr);
    
}


#pragma mark PushNotification

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
   // NSString* oldToken = [dataModel deviceToken];
    
	NSString* newToken = [deviceToken description];
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
	NSLog(@"My token is: %@", newToken);
    
    
	//[dataModel setDeviceToken:newToken];
    if(newToken)
    device_token=newToken;
    else
        device_token=nil;
    
    if(newToken){
    
    dispatch_async(dispatch_get_current_queue(), ^(void){
        [SVProgressHUD showWithStatus:@"Please wait..."];
        AUVwebservice *service=[AUVwebservice service];
        
        [service deviceToken:self action:@selector(deviceTokenHandler:) token:newToken];
        
    });
    }
//	if ([AUVLogin isAccessAllowed])
//	{
//		//[self postUpdateRequest];
//	}
	//NSLog(@"My token is: %@", deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}



- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	NSLog(@"Received notification: %@", userInfo);
    [application setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue]];
	[self addMessageFromRemoteNotification:userInfo updateUI:YES];
}

- (void)addMessageFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI
{
//	Message* message = [[Message alloc] init];
//	message.date = [NSDate date];
//    
	NSString* alertValue = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
//    
	NSMutableArray* parts = [NSMutableArray arrayWithArray:[alertValue componentsSeparatedByString:@": "]];
//	message.senderName = [parts objectAtIndex:0];
//	[parts removeObjectAtIndex:0];
//	message.text = [parts componentsJoinedByString:@": "];
//    
//	int index = [dataModel addMessage:message];
//    
//	if (updateUI)
//		[self.chatViewController didSaveMessage:message atIndex:index];
    
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    int count=[defaults integerForKey:@"badgecount"]+1;
//    [defaults setInteger:count forKey:@"badgecount"];
//    [defaults synchronize];
    NSLog(@"Push: %@",parts);
    
    
      if ( [UIApplication sharedApplication].applicationState == UIApplicationStateActive )
      {

        
      }
        else
        {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

            notified=YES;
            notificationType=[[[userInfo valueForKey:@"aps"] valueForKey:@"type"] integerValue];
            if(notificationType==100){
                [self setNotificationAppId:[[userInfo valueForKey:@"aps"] valueForKey:@"appid"]];
            }
            UINavigationController *nav=[self customizedNavigationController];
            [nav setViewControllers:[NSArray arrayWithObject:self.viewController]];
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];

        }
        
    

   
  
   // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[defaults integerForKey:@"badgecount"]];
}


-(NSString*)deviceToken
{
    if(device_token)
    return device_token;
    else return nil;
}
-(BOOL)notified
{
    return notified;
}

-(NSInteger)notificationType
{
    return notificationType;
}

-(NSString*)notificationAppId
{
    return notificationAppId;
}


-(void)deviceTokenHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
        SoapArray *arr=(SoapArray*)value;
        
        
        NSLog(@"%@",arr);
        
        
        [SVProgressHUD dismiss];
    }
    
}
#pragma mark - SpinnerView
-(void)startSpinner
{
    NSLog(@"Start");
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSLog(@"Screen Height %f",screenBounds.size.height);
    
    spinnerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    spinnerView.backgroundColor=[UIColor blackColor];
    spinnerView.alpha=0.5;
    
    indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    [indicator setCenter:CGPointMake(self.window.frame.size.width/2,self.window.frame.size.height/2)];
    [spinnerView addSubview:indicator];
    
    [self.window addSubview:spinnerView];
    
}

-(void)stopSpinner
{
    
    if (spinnerView!=nil)
    {
        [spinnerView removeFromSuperview];
        
    }
    
}




@end
