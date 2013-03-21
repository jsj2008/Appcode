//
//  AUVViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVViewController.h"
#import "AUVFriendsViewController.h"
//#import "DMViewController.h"
#import "SVProgressHUD.h"
#import "RearViewController.h"
#import "RevealController.h"
#import "AUVwebservice.h"
#import "AUVAppWallController.h"
#import "JSON.h"
#import "AUVDevsViewController.h"
#import "AUVSettingsViewController.h"
#import "AUVCategoriesViewController.h"
#import "UIDevice+test.h"
#import "AUVLinkedAccountsViewController.h"
#import "AUVTabViewController.h"
#import "AUVLogin.h"
#import "MasterViewController.h"
#import "AUVFBRegViewController.h"
#import "AUVFriendsListViewController.h"
#import "SCNavigationBar.h"
#import "AUVDealsViewController.h"
#import "AUVTredingAppsViewController.h"
#import "AUVHelpViewController.h"
#import "AUVImageHelpViewController.h"
#import "AUVNotificationViewController.h"
#import "AUVDetailViewController.h"
@interface AUVViewController ()
{
    UIView *v1,*v2,*v3,*v4,*v5,*v6,*v7,*v8,*v9,*v10,*v11,*v12,*v13,*v14,*v15;
    UIImageView *img1,*img2,*img3,*img4,*img5,*img6,*img7,*img8,*img9,*img10,*img11,*img12,*img13,*img14,*img15,*img16,*img17,*img18,*img19,*img20,*img21,*img22,*img23,*img24;
    UILabel *lbl1,*lbl2,*lbl3,*lbl4,*lbl5,*lbl6,*lbl7,*lbl8,*lbl9,*lbl10,*lbl11,*lbl12;
    NSMutableArray *varr,*imgsrc,*titlearr,*lblarr,*imgarr,*imgsrc1;
    int cnt,scnt,lcnt,ycnt;
    NSTimer *timer,*timer1,*timer2,*timer3;
}
@end

@implementation AUVViewController

@synthesize searchField,searchBar,searchController;

- (void)viewDidLoad
{
    [self homeanimationdesign];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbLogin:) name:AUVFBNotification object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(twitterLogin:) name:AUVTwitterNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friendsSuggest:) name:AUVCategoryNotification object:nil];

   
    facebook= [AUV_DELEGATE facebook];
       

    searchBar.delegate=self;
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
 

    sugArray=[[NSMutableArray alloc] init];
    [super viewDidLoad];
       
   // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"images (4).jpg"]];
    
     [self.view setBackgroundColor:[UIColor blackColor]];

    self.navigationItem.title=@"AppFindee";
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
      /* UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 10, 100, 40);
    [btn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:@"Logout" forState:UIControlStateNormal];
    [self.view addSubview:btn];*/
	// Do any additional setup after loading the view, typically from a nib.
    
}


- (void)viewDidUnload
{
    [timer invalidate];
    [timer1 invalidate];
    [timer2 invalidate];
    [timer3 invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [timer invalidate];
    [timer1 invalidate];
    [timer2 invalidate];
    [timer3 invalidate];
    [UIView setAnimationDuration:0.15];
    [SVProgressHUD dismiss];
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   // if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
   /* } else {
        return YES;
    }*/
}
     
-(void)viewWillAppear:(BOOL)animated
{
   

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;

    if([AUVLogin isAccessAllowed])
    {
        if([AUVLogin isNewUSer])
        {
            [self settings:nil];
        }
        else
        {
            [self goToWall:nil];
        }
    }

    //NSLog(@"anim");
}
 
-(void) viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    [self createUI];
    //[searchField resignFirstResponder];
    [searchBar resignFirstResponder];
    [self installedApps];

    
    if([AUV_DELEGATE notified])
    {
        if([AUV_DELEGATE notificationType]==100){
            [AUV_DELEGATE setNotified:NO];
            
            
            AUVDetailViewController *detail=[[AUVDetailViewController alloc] initWithNibName:@"AUVDetailViewController" bundle:nil];
            detail.appId=[AUV_DELEGATE notificationAppId];
            
            [self.navigationController pushViewController:detail animated:YES];
        }
    }

}



     
-(void)logOut
{
    
    if([facebook isSessionValid]){
        [facebook logout:self];
    }
         
}


-(void) createUI
{
    //NSLog(@"Created UI");
    
   // self.view.backgroundColor=[UIColor blackColor];
   /* 
    UIView *baseView=[[UIView alloc] initWithFrame:CGRectMake(10,10,AUVFRAME.size.width-20,AUVFRAME.size.height-20)];
    baseView.layer.cornerRadius=10.0f;
    baseView.backgroundColor=[UIColor whiteColor];
     if(![facebook isSessionValid]){
    UIButton *fbbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [fbbtn setImage:[UIImage imageNamed:@"fbconnect.png"] forState:UIControlStateNormal];
    [fbbtn addTarget:self action:@selector(connectWithFacebook:) forControlEvents:UIControlEventTouchDown];
    fbbtn.layer.cornerRadius=10.0f;
    fbbtn.frame=CGRectMake(10, 100, 280, 50);
    
    [baseView addSubview:fbbtn];
    
    
    
    UIButton *signUpLaterBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signUpLaterBtn setTitle:@"Sign Up Later" forState:UIControlStateNormal];
    signUpLaterBtn.frame=CGRectMake(10, 180, 280, 50);
    [baseView addSubview:signUpLaterBtn];
     }*/
//   / [self.view addSubview:baseView];

    
    
    if([facebook isSessionValid]){

        
      //  [self connectWithFacebook:nil];
       
        
    }
    
     else {
        // //NSLog(@"Load Friends");
         
        // [facebook requestWithGraphPath:@"me/friends" andDelegate:self];
     }
    
        
    
    
    //UIButton *btn=[]
    
}



-(void)connectWithFacebook:(id)sender
{
    
    [timer invalidate];
    [timer1 invalidate];
    [timer2 invalidate];
    [timer3 invalidate];
    

    if(![facebook isSessionValid]){
        
       // facebook = [[Facebook alloc] initWithAppId:AUVFB_APPID andDelegate:self];

        //[facebook d]
        
       [facebook authorize:[AUV_DELEGATE fbPermission]];
       /* NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:AUVFB_APPID forKey:@"client_id"];
        [facebook dialog:@"oauth" andParams:params  andDelegate:self];*/
        
        
    }
    else
    {
       // [ self  loadFriendsView];
        
        [self fbLogin:nil];
    }
    

}


- (void)fbDialogLogin:(NSString *)token expirationDate:(NSDate *)expirationDate {
    
    //NSLog(@"token : %@",token);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    //NSLog(@"%@",[defaults valueForKey:@"FBAccessTokenKey"]);
}

- (void)fbDialogNotLogin:(BOOL)cancelled {
    
   
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    
   // NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small,is_app_user FROM user WHERE  uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(is_app_user,first_name,last_name) asc"];
    
   /*  NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small FROM user WHERE is_app_user = 1 AND uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(first_name,last_name) asc"];
     */
       [defaults synchronize];
    
    
   // NSString *fql = [NSString stringWithFormat:@"SELECT name,first_name,last_name,uid, pic_small,location,website,mobile,timezone FROM user WHERE  uid=me()"];
    
    //AUVwebservice *service=[AUVwebservice service];
    
   // [service facebook_auth:self action:@selector(<#selector#>)  access_key:[facebook accessToken]];
  //   [service fb_registration:<#(id)#> action:<#(SEL)#> facebook_user_id:<#(NSString *)#> access_key:<#(NSString *)#> firstname:<#(NSString *)#> lastname:<#(NSString *)#> username:<#(NSString *)#> email_id:<#(NSString *)#> date_of_birth:<#(NSString *)#> picture:<#(NSString *)#> location:<#(NSString *)#> website:<#(NSString *)#> mobile:<#(NSString *)#> timezone:<#(NSString *)#>]

}





-(void)fbLogin:(id)sender
{
      [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
     NSString *fql = [NSString stringWithFormat:@"SELECT first_name,last_name,username,uid, pic,current_location,website,email,timezone,birthday_date  FROM user WHERE  uid=me()"];
    
    //user_location
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:fql ,@"query", [facebook accessToken], @"access_token", nil];
    
    [facebook requestWithMethodName:@"fql.query" andParams:params andHttpMethod:@"GET" andDelegate:self];
}
-(void)fbLoggedIn:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
}

-(IBAction)linkedIn:(id)sender
{
    AUVLinkedAccountsViewController *link=[[AUVLinkedAccountsViewController alloc] initWithNibName:@"AUVLinkedAccountsViewController" bundle:nil];
    
    [self.navigationController pushViewController:link animated:YES];
}




#pragma FBRequestDelegate Methods


- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"res");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    //NSLog(@"Err : %@",[error localizedDescription]);
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    
    //NSLog(@"test  %@",[result objectAtIndex:0]);
    
   // NSString *str=[NSString stringWithFormat:@"%@",[result objectAtIndex:0]];
    
    NSDictionary *dict=[result objectAtIndex:0];
    
    fbUserName=[dict valueForKey:@"username"];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    //[service fb_registration:self action:@selector(fbLoginHandler:) facebook_user_id:[dict valueForKey:@"uid"] access_key:[facebook accessToken] firstname:[dict valueForKey:@"first_name"] lastname:[dict valueForKey:@"last_name"] username:[dict valueForKey:@"username"] email_id:[dict valueForKey:@"email"] date_of_birth:[dict valueForKey:@"birthday_date"] picture:[dict valueForKey:@"pic"] location:[[dict valueForKey:@"current_location"] valueForKey:@"city"] website:[dict valueForKey:@"website"] mobile:@"" timezone:[dict valueForKey:@"timezone"]];
    
    [service fb_registration:self action:@selector(fbLoginHandler:) facebook_user_id:[dict valueForKey:@"uid"] access_key:[facebook accessToken] firstname:[dict valueForKey:@"first_name"] lastname:[dict valueForKey:@"last_name"] username:[dict valueForKey:@"username"] email_id:[dict valueForKey:@"email"] timezone:[dict valueForKey:@"timezone"]];
    
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data
{
    
}



#pragma Load List

-(void) loadFriendsView
{
    /*****************************************************************

    
    NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small FROM user where uid=me()"];
    //NSLog(@"%@",[facebook accessToken]);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:fql ,@"query", [facebook accessToken], @"access_token", nil];

    [facebook requestWithMethodName:@"fql.query" andParams:params andHttpMethod:@"GET" andDelegate:self];

    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     AUVwebservice *service=[AUVwebservice service];
//    
    service.logging=NO;
//    
   // [service facebook_auth:self action:@selector(fbLoginHandler:) auth_key:[defaults valueForKey:@"FBAccessTokenKey"] secret_key:[defaults valueForKey:@"FBAccessTokenKey"]];
    
//
    
   
    
    *****************************************************************/
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AUVwebservice *service=[AUVwebservice service];
    //
    service.logging=NO;
    //
    // [service facebook_auth:self action:@selector(fbLoginHandler:) auth_key:[defaults valueForKey:@"FBAccessTokenKey"] secret_key:[defaults valueForKey:@"FBAccessTokenKey"]];
   // [service facebook_auth:self action:@selector(fbLoginHandler:) user_id:nil auth_key:[facebook accessToken] secret_key:nil];
    [service facebook_auth:self action:@selector(fbLoginHandler:) access_key:[facebook accessToken]];
    //[service facebook_auth:service action:@selector(fbLoginHandler:) auth_key:[facebook accessToken] secret_key:nil];
    //

}


-(void)fbLoginHandler:(id)value
{
    
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    ////NSLog(@"result : %@",value);
    
    NSDictionary * dict = [[result stringByReplacingOccurrencesOfString:@"\\" withString:@""] JSONValue];
    
    //NSLog(@" Dict : %@",dict);
    // //NSLog( @"%@: %@",[dict valueForKey:@"key"],[dict valueForKey:@"value"]);
    //  [appDic setValue:[dict valueForKey:@"value"] forKey:[dict valueForKey:@"key"]];
    
    if([[dict valueForKey:@"message"] isEqualToString:@"success"]){
        
        
        [AUVLogin Login:dict];

        {
            AUVwebservice *service=[AUVwebservice service];
            service.logging=YES;
            if([AUV_DELEGATE deviceToken])
                [service update_DeviceToken:self action:@selector(tokenUpdateHandler:) user_id:[AUVLogin valueforKey:@"user_id"] token:[AUV_DELEGATE deviceToken]];
            
            else{
                [SVProgressHUD showErrorWithStatus:@"Could not able to get APN token. Try Logout And Login Again."];
                
                
                
                
                if([AUVLogin isNewUSer])
                {
                    [self updateUserName:fbUserName];
                    
                }
                else
                    
                {
                    [self goToWall:nil];
                }

                
            }
            
            
        }

       
            
                   
        
        
        
       // //NSLog(@"%@ , %d ",[defaults valueForKey:@"user_id"],[[defaults valueForKey:@"user_id"] intValue]);
        
    }
    }
       // likeBtn.enabled=NO;
    
//    if([[dict valueForKey:@"status"] boolValue])
//    {
//        [self goToWall:nil];
//        
//    }
}



-(void)tokenUpdateHandler:(id)value
{
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray* arr = (SoapArray*)value;
    
    NSLog(@"JAD  %@",arr);
    
    
    
    if([AUVLogin isNewUSer])
    {
        [self updateUserName:fbUserName];
        
    }
    else
        
    {
        [self goToWall:nil];
    }

    }
    
   
}



//
//-(IBAction)loginWithTwiter:(id)sender
//{
//
//
//    [self.twitterEngine authenticateWithCompletionBlock:^(NSError* err){
//        //NSLog(@"Sucees : %@ : %@ : %@ : %@ ",self.twitterEngine.consumerKey,self.twitterEngine.consumerSecret,[self.twitterEngine token],[self.twitterEngine tokenSecret]);
////        
////    MKNetworkOperation *op=   [self.twitterEngine operationWithURLString:[NSString stringWithFormat: @"https://api.twitter.com/1/followers/ids.json?cursor=-1&screen_name=%@",[self.twitterEngine screenName]]];
////        
////               [op onCompletion:^(MKNetworkOperation *completedOperation) {
////          
////            
////            //NSLog(@" %@",completedOperation.responseString);
////        } onError:^(NSError *error) {
////            //NSLog(@"errrrrrrr %@",error.localizedDescription);
////           
////        }];
////[self.twitterEngine enqueueSignedOperation:op];
//        
//         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setValue:[self.twitterEngine token] forKey:@"TwitterAuthKey"];
//        [defaults setValue:[self.twitterEngine tokenSecret] forKey:@"TwitterSecretKey"];
//        [defaults setValue:[self.twitterEngine screenName] forKey:@"TwitterScreenName"];
//        if([defaults synchronize])
//        {
//            [self twitterLogin:nil];
//        }
//  }];
//
//   
//}
//


//#pragma UITextFieldDelegate methods
//
//
//
//#pragma mark UITextField Delegate
//
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//     [textField resignFirstResponder];
//    [self loadSearchView];
//    
//}
//
//-(void)textFieldDidEndEditing:(UITextField*)textField
//{
//    
//  //  [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeGradient];
//    
//}
//
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//   
//    [textField resignFirstResponder];
//       
//    return YES;
//}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //[searchController setActive:YES animated:YES];
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVSearchViewController";
    }
    else {
        nibName=@"AUVSearchViewController_iPad";
    }
    AUVSearchViewController *searchView=[[AUVSearchViewController alloc] initWithNibName:nibName bundle:nil];
    
    searchView.type=NotLoggedIn;
    searchView.searching=@"";
    [self.navigationController pushViewController:searchView animated:YES];
    return NO;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar*)searchBar
{
    //[searchController setActive:NO];
    return YES;
}

-(IBAction)signupView:(id)sender
{
    [UIView setAnimationDuration:0.14];
    AUVRegisterPanel *panel=[[AUVRegisterPanel alloc] initWithFrame:self.view.bounds];
    
    panel.delegate=self;
    ///////////////////////////////////
	// Add the panel to our view
	[self.view addSubview:panel];
	
	///////////////////////////////////
	// Show the panel from the center of the button that was pressed
	[panel showFromPoint:[sender center]];
}

-(IBAction) TredingPage:(id)sender
{
    AUVTredingAppsViewController *trending=[[AUVTredingAppsViewController alloc]initWithNibName:@"AUVTredingViewController" bundle:nil];
    
    [self.navigationController pushViewController:trending animated:YES];
}

-(IBAction) todayDealsPage:(id)sender
{
    AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
    
    [self.navigationController pushViewController:deal animated:YES];
}

-(IBAction)loginView:(id)sender
{
    [UIView setAnimationDuration:0.14];
    AUVLoginPanel *panel=[[AUVLoginPanel alloc] initWithFrame:self.view.bounds];
    panel.delegate=self;
    [self.view addSubview:panel];
    [panel showFromPoint:[sender center]];
}

#pragma mark - UAModalDisplayPanelViewDelegate 

// Optional: This is called before the open animations.
//   Only used if delegate is set.
- (void)willShowModalPanel:(UAModalPanel *)modalPanel {
    [UIView setAnimationDuration:0.14];
    [timer invalidate];
    [timer1 invalidate];
    [timer2 invalidate];
    [timer3 invalidate];
    
	UADebugLog(@"willShowModalPanel called with modalPanel: %@", modalPanel);
}

// Optional: This is called after the open animations.
//   Only used if delegate is set.
- (void)didShowModalPanel:(UAModalPanel *)modalPanel {
    [UIView setAnimationDuration:0.14];
	UADebugLog(@"didShowModalPanel called with modalPanel: %@", modalPanel);
}

// Optional: This is called when the close button is pressed
//   You can use it to perform validations
//   Return YES to close the panel, otherwise NO
//   Only used if delegate is set.
- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel {
    [UIView setAnimationDuration:0.14];
	UADebugLog(@"shouldCloseModalPanel called with modalPanel: %@", modalPanel);
	return YES;
}

// Optional: This is called when the action button is pressed
//   Action button is only visible when its title is non-nil;
//   Only used if delegate is set and not using blocks.
- (void)didSelectActionButton:(UAModalPanel *)modalPanel {
    [UIView setAnimationDuration:0.14];
	UADebugLog(@"didSelectActionButton called with modalPanel: %@", modalPanel);
}

// Optional: This is called before the close animations.
//   Only used if delegate is set.
- (void)willCloseModalPanel:(UAModalPanel *)modalPanel {
    [UIView setAnimationDuration:0.14];
	UADebugLog(@"willCloseModalPanel called with modalPanel: %@", modalPanel);
}

// Optional: This is called after the close animations.
//   Only used if delegate is set.
- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
    [UIView setAnimationDuration:0.14];
	UADebugLog(@"didCloseModalPanel called with modalPanel: %@", modalPanel);
    
    if([AUVLogin HelpResponse])
    {
        [AUVLogin Help:false];
        AUVHelpViewController *help=[[AUVHelpViewController alloc]initWithNibName:@"AUVHelpViewController" bundle:nil];
        [self.navigationController pushViewController:help animated:YES];
        return;
    }
    
    if([AUVLogin isAccessAllowed])
    {
        if([AUVLogin isNewUSer])
        {
            [self settings:nil];
        }
    else [self goToWall:nil];
        
    }
    else{
       // [self homeanimationdesign];
    }
}


-(void)loadSearchView:(NSString*)text
{
    [UIView setAnimationDuration:0.0];
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVSearchViewController";
    }
    else {
        nibName=@"AUVSearchViewController_iPad";
    }
    AUVSearchViewController *searchView=[[AUVSearchViewController alloc] initWithNibName:nibName bundle:nil];
    searchView.searching=text;
    searchView.type=NotLoggedIn;
    [self.navigationController pushViewController:searchView animated:YES];
    [SVProgressHUD dismiss];
}




-(IBAction)goToWall:(id)sender 
{
    
    NSString *nibName;
   
  ///  [[(AUVAppDelegate*) [[UIApplication sharedApplication] delegate] viewControllers] addObject:wall];
    //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:wall];
    
    UINavigationController *navigationController=[self customizedNavigationController];
    
    
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            nibName=@"AUVAppWallController_iPhone";
        }
        else {
            nibName=@"AUVAppWallController_iPad";
        }
        AUVAppWallController *wall=[[AUVAppWallController alloc] initWithNibName:nibName bundle:nil];
    [navigationController setViewControllers:[NSArray arrayWithObject:wall]];
    
    
    // navigationController.navigationBar.frame=CGRectMake(0, 0, navigationController.navigationBar.frame.size.width, 100);
    // AUVMenuViewController *sideMenuViewController = [[AUVMenuViewController alloc] init];
   // [navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
    
   /* AUVDevsViewController *dev=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil];
    [self.navigationController pushViewController:dev animated:YES];*/
    
   
	RearViewController *rearViewController = [[RearViewController alloc] initWithNibName:@"RearViewController" bundle:nil];
  
    UINavigationController *controller=[[UINavigationController alloc] initWithRootViewController:rearViewController];
		
	RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigationController rearViewController:rearViewController];
    
	[self presentModalViewController:revealController animated:YES];
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







-(void)twitterLogin:(id)sender
{
   // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults valueForKey:@"TWitterUserId"];
    //[defaults valueForKey:@"TwitterSecretKey"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AUVwebservice *service=[AUVwebservice service];
    //
    service.logging=NO;
    
      
    [service twitter_auth:self action:@selector(twitterLoginHandler:) user_id:[defaults valueForKey:@"TwitterScreenName"] auth_key:[defaults valueForKey:@"TwitterAuthKey"] secret_key:[defaults valueForKey:@"TwitterSecretKey"]];
}


-(IBAction)twitterLoginHandler:(id)value
{
    
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		//NSLog(@"%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		//NSLog(@"%@", value);
		return;
	}
    
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    //NSLog(@"result : %@",result);
    
    NSDictionary * dict = [result JSONValue];
    
    if([[dict valueForKey:@"status"] boolValue])
    {
        [self goToWall:nil];
    }
    
}

-(IBAction)aboutAppfindee:(id)sender
{

    AUVImageHelpViewController *image=[[AUVImageHelpViewController alloc]initWithNibName:@"AUVImageHelpViewController" bundle:nil];
    
    [self.navigationController pushViewController:image animated:YES];
}


-(void)updateUserName:(NSString*)usrName;
{
    AUVFBRegViewController *auvfb=[[AUVFBRegViewController alloc] initWithNibName:@"AUVFBRegViewController" bundle:nil];
    auvfb.userNameString=usrName;
    
    [self.navigationController pushViewController:auvfb animated:YES];
}

-(IBAction)settings:(id)sender
{
   // AUVTabViewController *tabbar=[[AUVTabViewController alloc] init];
   
   AUVCategoriesViewController* categoriesiPhone=[[AUVCategoriesViewController alloc] initWithNibName:@"AUVCategoriesViewController" bundle:nil];
    //categoriesiPhone.title=@"iPhone";
    
    [self.navigationController pushViewController:categoriesiPhone animated:YES];
    

}
- (NSArray *)installedApps {
    
    //NSLog(@"test");
    
   
    return nil;
   
}







#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //[self filterContentForSearchText:searchString scope:nil];
    
    [self performSelectorInBackground:@selector(loadSuggestionList:) withObject:searchString];
    
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self performSelectorInBackground:@selector(loadSuggestionList:) withObject:[self.searchController.searchBar text] ];
    // [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:nil];
    return YES;
}
- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
   	[self.searchController.searchResultsTableView setDelegate:self];
    
     self.searchController.searchResultsTableView.frame=CGRectMake(0, 0, 320, 300);
    //self.searchController.searchBar.frame=CGRectMake(0, 0, 320, 44);
    
}
-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController*)controller
{
     //self.searchController.searchBar.frame=CGRectMake(0, 150, 320, 44);
    
}


- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView  {
    
    //self.searchController.searchBar.frame=CGRectMake(0, 0, 320, 44);
    
}



-(void)loadSuggestionList:(NSString*)str
{
    if(str.length<3)return;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://23.23.149.136:8081/autocompletion?use=iphone_data&query=%@&login=appuniv&key=eaf0240551d8ec89df0d0713745c2d04",[self processText:str]]];
    ////NSLog(@"%@",url);
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody:postData];
    
    
    NSError *error;
    NSURLResponse *response;
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    if(returnData)
    {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
        //Parse your response here.
        //Is desired response obtain call the second Request, as described above
        if (TRUE) {  //on success
            
            //  //NSLog(@"%@",[returnString JSONValue]);
            //filterDic =[self parseFilterDictionary:[[[returnString JSONValue] valueForKey:@"response"] valueForKey:@"faceting"]];
            
            //dataArray= [self parseJsonToDictionary:[[[[returnString JSONValue] valueForKey:@"response"] valueForKey:@"result"] valueForKey:@"doc"] ];
            
            ////NSLog(@"returnString : %@",returnString);
            [sugArray removeAllObjects];
            NSArray *arr=[returnString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            
            NSArray *myFilteredArray = [arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]]; //Non-destructive, myStrings is still intact
            
            [sugArray addObjectsFromArray:myFilteredArray];
        }
        
        
        [self.searchController.searchResultsTableView reloadData];
    }
    
    
}


-(NSString*)processText:(NSString*)string
{
    NSArray *arr=[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(arr.count>1)
        
        return [arr  componentsJoinedByString:@"+"];
    else return string;
}






#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sugArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell  *cell=nil;
    
    static NSString *identifier = @"defaultcell";
    cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                
        //[baseCell addSubview:btn];
    }
    
    cell.textLabel.text=[sugArray objectAtIndex:indexPath.row];
    
    
    return cell;
    
}
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
    
}



-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self loadSearchView:[sugArray objectAtIndex:indexPath.row]];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)sBar
{
    [self loadSearchView:sBar.text];
    [sBar resignFirstResponder];
    
}
-(void)friendsSuggest:(id)sender
{ 
    AUVFriendsListViewController *friendsList=[[AUVFriendsListViewController alloc] initWithNibName:@"AUVFriendsListViewController" bundle:nil type:AUVSuggestionList];
    friendsList.parent=self;
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:friendsList action:@selector(goToWall:)];
    right.title=@"Done";
    
    friendsList.navigationItem.rightBarButtonItem=right;
    
    UINavigationController *navigationController=[self customizedNavigationController];
     [navigationController setViewControllers:[NSArray arrayWithObject:friendsList]];

  //  UINavigationController *cnt=[[UINavigationController alloc] initWithRootViewController:friendsList];
    
    [self presentModalViewController:navigationController animated:YES];
}

-(void)searchpageEvent:(id)sender
{
    [UIView setAnimationDuration:0.14];
    [timer invalidate];
    [timer1 invalidate];
    [timer2 invalidate];
    [timer3 invalidate];
    
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVSearchViewController";
    }
    else {
        nibName=@"AUVSearchViewController_iPad";
    }
    AUVSearchViewController *searchView=[[AUVSearchViewController alloc] initWithNibName:nibName bundle:nil];
    
    searchView.type=NotLoggedIn;
    searchView.searching=@"";
    [self.navigationController pushViewController:searchView animated:YES];
  
}

-(void)homeanimationdesign
{
    
    imgsrc = [[NSMutableArray alloc]initWithObjects:@"21.png",@"22.png",@"24.png",@"25.png",@"26.png",@"27.png",@"28.png",@"29.png",@"30.png",@"33.png",@"36.png",@"35.png",@"26.png",@"27.png",@"29.png" ,nil];
    
    imgsrc1 = [[NSMutableArray alloc]initWithObjects:@"31.png",@"32.png",@"33.png",@"34.png",@"35.png",@"37.png",@"38.png",@"31.png",@"36.png",@"30.png",@"37.png",@"23.png", nil];
    
    titlearr=[[NSMutableArray alloc]initWithObjects:@"Title1",@"Title2",@"Title3",@"Title4",@"Title5",@"Title6",@"Title7",@"Title8",@"Title9",@"Title10",@"Title11",@"Title12", nil];
    
    cnt=0;
    scnt=11;
    lcnt=3;
    ycnt=4;
    
    v1 = [[UIView alloc]init];
    v2 = [[UIView alloc]init];
    v3 = [[UIView alloc]init];
    v4 = [[UIView alloc]init];
    v5 = [[UIView alloc]init];
    v6 = [[UIView alloc]init];
    v7 = [[UIView alloc]init];
    v8 = [[UIView alloc]init];
    v9 = [[UIView alloc]init];
    v10 = [[UIView alloc]init];
    v11 = [[UIView alloc]init];
    v12 = [[UIView alloc]init];
    v13 = [[UIView alloc]init];
    v14 = [[UIView alloc]init];
    v15 = [[UIView alloc]init];
    
    img1 = [[UIImageView alloc]init];
    img2 = [[UIImageView alloc]init];
    img3 = [[UIImageView alloc]init];
    img4 = [[UIImageView alloc]init];
    img5 = [[UIImageView alloc]init];
    img6 = [[UIImageView alloc]init];
    img7 = [[UIImageView alloc]init];
    img8 = [[UIImageView alloc]init];
    img9 = [[UIImageView alloc]init];
    img10 = [[UIImageView alloc]init];
    img11 = [[UIImageView alloc]init];
    img12 = [[UIImageView alloc]init];
    img13 = [[UIImageView alloc]init];
    img14 = [[UIImageView alloc]init];
    img15 = [[UIImageView alloc]init];
    img16 = [[UIImageView alloc]init];
    img17 = [[UIImageView alloc]init];
    img18 = [[UIImageView alloc]init];
    img19 = [[UIImageView alloc]init];
    img20 = [[UIImageView alloc]init];
    img21 = [[UIImageView alloc]init];
    img22 = [[UIImageView alloc]init];
    img23 = [[UIImageView alloc]init];
    img24 = [[UIImageView alloc]init];
    
    lbl1 = [[UILabel alloc]init];
    lbl2 = [[UILabel alloc]init];
    lbl3 = [[UILabel alloc]init];
    lbl4 = [[UILabel alloc]init];
    lbl5 = [[UILabel alloc]init];
    lbl6 = [[UILabel alloc]init];
    lbl7 = [[UILabel alloc]init];
    lbl8 = [[UILabel alloc]init];
    lbl9 = [[UILabel alloc]init];
    lbl10 = [[UILabel alloc]init];
    lbl11 = [[UILabel alloc]init];
    lbl12 = [[UILabel alloc]init];
    
    varr = [[NSMutableArray alloc]initWithObjects:v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15, nil];
    imgarr = [[NSMutableArray alloc]initWithObjects:img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15, nil];
    //lblarr = [[NSMutableArray alloc]initWithObjects:lbl1,lbl2,lbl3,lbl4,lbl5,lbl6,lbl7,lbl8,lbl9,lbl10,lbl11,lbl12, nil];
    
    lblarr = [[NSMutableArray alloc]initWithObjects:img13,img14,img15,img16,img17,img18,img19,img20,img21,img22,img23,img24, nil];
    
    
    for (int i=0; i<15; i++) {
        
        UIView *vi =[varr objectAtIndex:i];
        UIImageView *img = [imgarr objectAtIndex:i];
        //UIImageView *img_1 = [lblarr objectAtIndex:i];
        //UILabel *labl = [lblarr objectAtIndex:i];
        if (i==0) {
            vi.frame = CGRectMake(5, 5, 100, 100);
        }else if(i>0 && i<3)
        {
            vi.frame = CGRectMake(5+105*i, 5, 100, 100);
            
        }else if(i==3)
        {
            vi.frame = CGRectMake(5, 110, 100, 100);
        }
        else if(i==4 || i==5)
        {
            vi.frame = CGRectMake(5+105*(i-3), 110, 100, 100);
        }else if(i==6)
        {
            vi.frame = CGRectMake(5, 215, 100, 100);
        }
        else if(i==7 || i==8)
        {
            vi.frame = CGRectMake(5+105*(i-6), 215, 100, 100);
        }else if(i==9)
        {
            vi.frame = CGRectMake(5, 320, 100, 100);
        }
        else if(i==10 || i==11)
        {
            vi.frame = CGRectMake(5+105*(i-9), 320, 100, 100);
        }
        else if(i==12)
        {
            vi.frame = CGRectMake(5, 425, 100, 100);
        }
        else if(i==13 || i==14)
        {
            vi.frame = CGRectMake(5+105*(i-12), 425, 100, 100);
        }
        
        [self.view addSubview:vi];
        
        //img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        img.frame = CGRectMake(0, 0, 100, 100);
        img.image=[UIImage imageNamed:[imgsrc objectAtIndex:i]];
        [vi addSubview:img];
        
        
//        img_1.frame = CGRectMake(0, 0, 100, 100);
//        img_1.image=[UIImage imageNamed:[imgsrc1 objectAtIndex:i]];
        
    }
    
    
    UIView *view1;// = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    if(IS_IPHONE_5) {
        view1= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
        view1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"final_home_2.png"]];

    }else{
        view1= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        view1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"final_home_1.png"]];

    }

    [self.view addSubview:view1];
    
    UIButton *searchpage = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5) {
        searchpage.frame=CGRectMake(40, 210, 240, 30);
    }else{
        searchpage.frame=CGRectMake(40, 168, 240, 30);
        
    }
    //[signup setTitle:@"signup" forState:UIControlStateNormal];
    [searchpage addTarget:self action:@selector(searchpageEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchpage];
    
    UIButton *facebooklogin = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5) {
        
        facebooklogin.frame=CGRectMake(40, 267, 238, 35);

    }else{
        
        facebooklogin.frame=CGRectMake(40, 215, 238, 35);
        
    }
    //[signup setTitle:@"signup" forState:UIControlStateNormal];
    [facebooklogin addTarget:self action:@selector(connectWithFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebooklogin];
    
    UIButton *todaydeals = [UIButton buttonWithType:UIButtonTypeCustom];
   // todaydeals.frame=CGRectMake(10, 400, 140, 63);
    if (IS_IPHONE_5) {
        
        todaydeals.frame=CGRectMake(10, 482, 140, 63);
    }else{
        todaydeals.frame=CGRectMake(10, 400, 140, 63);
    }

    //[signup setTitle:@"signup" forState:UIControlStateNormal];
    [todaydeals addTarget:self action:@selector(todayDealsPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:todaydeals];
    
    
    UIButton *trendingapp = [UIButton buttonWithType:UIButtonTypeCustom];
    //trendingapp.frame=CGRectMake(168, 400, 140, 63);
    if (IS_IPHONE_5) {
        
        trendingapp.frame=CGRectMake(168, 482, 140, 63);
    }else{
        trendingapp.frame=CGRectMake(168, 400, 140, 63);
    } 

    //[login setTitle:@"login" forState:UIControlStateNormal];
    [trendingapp addTarget:self action:@selector(TredingPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:trendingapp];
    
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    //login.frame=CGRectMake(50, 300, 100, 30);
    if (IS_IPHONE_5) {
        
        login.frame=CGRectMake(50, 330, 100, 30);
    }else{
        login.frame=CGRectMake(50, 280, 100, 30);
        
    }
    login.font=[UIFont boldSystemFontOfSize:15];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    login.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
    [login addTarget:self action:@selector(loginView:) forControlEvents:UIControlEventTouchUpInside];
    login.layer.cornerRadius=5.0f;
    [self.view addSubview:login];

    
    
    UIButton *signup = [UIButton buttonWithType:UIButtonTypeCustom];
    //signup.frame=CGRectMake(170, 300, 100, 30);
    if (IS_IPHONE_5) {
        
        signup.frame=CGRectMake(170, 330, 100, 30);
    }else{
        signup.frame=CGRectMake(170, 280, 100, 30);
    }
    signup.font=[UIFont boldSystemFontOfSize:15];
 
    [signup setTitle:@"Sign Up" forState:UIControlStateNormal];
    signup.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
    [signup addTarget:self action:@selector(signupView:) forControlEvents:UIControlEventTouchUpInside];
    signup.layer.cornerRadius=5.0f;
    [self.view addSubview:signup];
    
    UIButton *aboutappfindee = [UIButton buttonWithType:UIButtonTypeCustom];
    //signup.frame=CGRectMake(170, 300, 100, 30);
    if (IS_IPHONE_5) {
        
        aboutappfindee.frame=CGRectMake(118, 380, 170, 30);
    }else{
        aboutappfindee.frame=CGRectMake(118, 330, 170, 30);
        
    }
  
    [aboutappfindee addTarget:self action:@selector(aboutAppfindee:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:aboutappfindee];

    
}

- (void)curlanimation
{
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.0];
	
  //  //NSLog(@"curlup -- %d",cnt);
    
    UIView *vie = [varr objectAtIndex:cnt];
    UIImageView *imgv=[imgarr objectAtIndex:cnt];
    UILabel *lable = [lblarr objectAtIndex:cnt];
    
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:vie cache:YES];
	if ([lable superview])
	{
		[lable removeFromSuperview];
		[vie addSubview:imgv];
	}
	else
	{
		[imgv removeFromSuperview];
		[vie addSubview:lable];
	}
	
	[UIView commitAnimations];
    if (cnt==11) {
        cnt =0;
    }else
    {
        cnt++;
    }
    
}

- (void)curlupanimation
{
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.0];
	
    ////NSLog(@"curldown -- %d",ycnt);
    
    if (ycnt>=0 && ycnt<=11) {
        
        UIView *vie = [varr objectAtIndex:ycnt];
        UIImageView *imgv=[imgarr objectAtIndex:ycnt];
        UILabel *lable = [lblarr objectAtIndex:ycnt];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:vie cache:YES];
        if ([lable superview])
        {
            [lable removeFromSuperview];
            [vie addSubview:imgv];
        }
        else
        {
            [imgv removeFromSuperview];
            [vie addSubview:lable];
        }
        
        [UIView commitAnimations];
    }
    
    if (ycnt==0) {
        ycnt =11;
    }else if (ycnt==-1) {
        ycnt =10;
    }else if (ycnt==-2) {
        ycnt =9;
    }else
    {
        ycnt-=3;
    }
    
}


- (void)slideanimation
{
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.0];
	
   // //NSLog(@"left -- %d",scnt);
    
    UIView *vie = [varr objectAtIndex:scnt];
    UIImageView *imgv=[imgarr objectAtIndex:scnt];
    UILabel *lable = [lblarr objectAtIndex:scnt];
    
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:vie cache:YES];
	if ([lable superview])
	{
		[lable removeFromSuperview];
		[vie addSubview:imgv];
	}
	else
	{
		[imgv removeFromSuperview];
		[vie addSubview:lable];
	}
	
	[UIView commitAnimations];
    if (scnt==0) {
        scnt =11;
    }else
    {
        scnt--;
    }
    
}



- (void)sliderightanimation
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.0];
	
   // //NSLog(@"right -- %d",lcnt);
    if (lcnt>=0 && lcnt<11) {
        
        UIView *vie = [varr objectAtIndex:lcnt];
        UIImageView *imgv=[imgarr objectAtIndex:lcnt];
        UILabel *lable = [lblarr objectAtIndex:lcnt];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:vie cache:YES];
        if ([lable superview])
        {
            [lable removeFromSuperview];
            [vie addSubview:imgv];
        }
        else
        {
            [imgv removeFromSuperview];
            [vie addSubview:lable];
        }
        
        
        [UIView commitAnimations];
    }
    if (lcnt==11) {
        lcnt =0;
    }else if (lcnt==12) {
        lcnt =1;
    }else if (lcnt==13) {
        lcnt =2;
    }else if (lcnt==14) {
        lcnt =3;
    }else
    {
        lcnt+=4;
    }
    
}



@end
