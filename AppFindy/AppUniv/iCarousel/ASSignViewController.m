//
//  ASSignViewController.m
//  AppSnatch
//
//  Created by Innoppl Technologies on 25/02/13.
//  Copyright (c) 2013 Innoppl Technologies. All rights reserved.
//

#import "ASSignViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AUVConstants.h"
#import "ASIHTTPRequest.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import "JSON.h"
#import <Social/Social.h>
#import "AUVwebservice.h"
#import "SVProgressHUD.h"
#import "AUVValidation.h"
#import "AUVAPPSnatchView.h"
#import "ASRegisterViewController.h"
#import "AUVScrollTabBar.h"
#import "AUVHelpViewController.h"
#import "AUVDealsViewController.h"
#import "AUVSearchViewController.h"
#import "SVProgressHUD.h"

@interface ASSignViewController ()<UITextFieldDelegate,UIWebViewDelegate>{
    UIScrollView *scrll;
    UITextField  *emai_txt;
    UITextField  *pass_txt;
    UITextField  *selectTextField;
    UIWebView    *webview;
    UIActivityIndicatorView *_spinner;
    BOOL Redirect;
    UIAlertView *alert;
    NSString *userid;
    NSString *username;
    NSString *emailid;
    NSString *timezone;
    NSString *firstname;
    NSString *lastname;
    UITextField *rePassword_txt;
    UIAlertView *signInAlert;
    NSString *name,*pswd;

}
@property(strong,nonatomic) UITextField  *emai_txt;

@end

@implementation ASSignViewController
@synthesize emai_txt;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        UIBarButtonItem *closeBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeClick)];
//        self.navigationItem.rightBarButtonItem = closeBtn;
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title=@"Sign In";
    
   

    scrll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 480)];
    scrll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrll];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [scrll addGestureRecognizer:gestureRecognizer];
    
    emai_txt =[self customtxtfield:@" " placeholder:@" Email Id" initFrame:CGRectMake(60, 30, 200, 35)];
    emai_txt.keyboardType=UIKeyboardTypeEmailAddress;
    [scrll addSubview:emai_txt];
    
    pass_txt=[self customtxtfield:@"" placeholder:@"Password" initFrame:CGRectMake(60, 80, 200, 35)];
    pass_txt.secureTextEntry=YES;
    [scrll addSubview:pass_txt];
    
//    rePassword_txt=[self customtxtfield:@"" placeholder:@"Confirm Password" initFrame:CGRectMake(60, 130, 200, 35)];
//    rePassword_txt.secureTextEntry=YES;
//    [scrll addSubview:rePassword_txt];
    
    UIButton *forgotpassword = [UIButton buttonWithType:UIButtonTypeCustom];
    forgotpassword.frame = CGRectMake(50,310, 150, 20);
    [forgotpassword addTarget:self action:@selector(forgotpassword) forControlEvents:UIControlEventTouchUpInside];
    [scrll addSubview:forgotpassword];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame=CGRectMake(120, 145, 80, 30);
    [submit setBackgroundImage:[[UIImage imageNamed:@"black_button.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [submit setTitle:@"Sign In" forState:UIControlStateNormal];
    [[submit titleLabel] setFont:[UIFont fontWithName:@"Arial" size:15.0]];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitbtn) forControlEvents:UIControlEventTouchUpInside];
    [scrll addSubview:submit];
    
    UIButton *Signup = [UIButton buttonWithType:UIButtonTypeCustom];
    Signup.frame=CGRectMake(200, 210, 100, 30);
    [Signup setTitle:@"Sign Up" forState:UIControlStateNormal];
    [Signup setBackgroundImage:[[UIImage imageNamed:@"black_button.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [Signup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[Signup titleLabel] setFont:[UIFont fontWithName:@"Arial" size:15.0]];
    [Signup addTarget:self action:@selector(singUp) forControlEvents:UIControlEventTouchUpInside];
    [scrll addSubview:Signup];
    
    UIButton *fb = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    fb.frame = CGRectMake(20, 210, 120, 30);
    [fb addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
  //  [fb setImage:[UIImage imageNamed:@"fb"] forState:UIControlStateNormal];
    [fb setTitle:@"Facebook" forState:UIControlStateNormal];
    [scrll addSubview:fb];
    
    UIButton *twitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twitBtn.frame = CGRectMake(20, 250, 120, 30);
    [twitBtn addTarget:self action:@selector(twlogin) forControlEvents:UIControlEventTouchUpInside];
    //  [fb setImage:[UIImage imageNamed:@"fb"] forState:UIControlStateNormal];
    [twitBtn setTitle:@"Twitter" forState:UIControlStateNormal];
    [scrll addSubview:twitBtn];
    
    AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 360, 320, 104)];
    [custombar.button1 setImage:[UIImage imageNamed:@"tab_home.png"] forState:UIControlStateNormal];
    custombar.delegate= self;
    [scrll addSubview:custombar];



    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)singUp{
   //
  //  [self dismissViewControllerAnimated:YES completion:nil];
    ASRegisterViewController *registerView =[[ASRegisterViewController alloc]initWithNibName:@"ASRegisterViewController" bundle:nil];
//    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:registerView];
    [self.navigationController pushViewController:registerView animated:YES];
   
}
-(void)btnTap:(UIButton*)buttonId

{
    
    int buttonselect = buttonId.tag;
    if (buttonselect == 1) {
        
        AUVwallcontrollerViewController *notification = [[AUVwallcontrollerViewController alloc]initWithNibName:@"AUVwallcontrollerViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 2){
        
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
        
        [self.navigationController pushViewController:deal animated:YES];
        
        
    }else if (buttonselect == 4){
        
        
    }else if (buttonselect == 5){
               AUVHelpViewController *helpView =[[AUVHelpViewController alloc] initWithNibName:@"AUVHelpViewController" bundle:nil];
              [self.navigationController pushViewController:helpView animated:YES];
    }
    else{
        //NSLog(@"nothing");
    }
    
    
}


/* Registration */
-(void)submitbtn{
    
    NSString *emailregex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,4}";
    NSPredicate *expre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailregex];
    BOOL emailval = [expre evaluateWithObject:emai_txt.text];
    NSMutableString *errmsg = [[NSMutableString alloc]init];
    
    
    if([[emai_txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [errmsg appendFormat:@"Please Enter Email id \n"];
    }
    if([[emai_txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0 && !emailval)
    {
        [errmsg appendFormat:@"Please Enter Valid Email id \n"];
    }
    if([[pass_txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [errmsg appendFormat:@"Please Enter Password \n"];
    }
    if(![errmsg isEqualToString:@""])
    {
        NSLog(@"fill");
        UIAlertView *msgalert =[[UIAlertView alloc]initWithTitle:@"Alert" message:errmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [msgalert show];
    }
    else
    {
        [self login];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        NSLog(@"close");
	}
        if (alertView ==alert) {
        if (buttonIndex ==0) {
           // [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
            [[self delegate] RatingsViewalues:[defaultstd objectForKey:@"user_id"] ];
            
        }
    }
    
}


-(void)login{
     [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=YES;
    
    [service login:self action:@selector(loginHandler:) username:emai_txt.text password:pass_txt.text];

}
-(void)loginHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    
    else{
        
        // Do something with the Array* result
        SoapArray* arr = (SoapArray*)value;
        [SVProgressHUD dismiss];
        NSLog(@"array %@",arr);
        
        NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"//" withString:@""];
        
        
        NSDictionary *status=[result JSONValue];
        NSLog(@"status %@",status);
        if ([[status objectForKey:@"login"] intValue] == 1) {
            NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
            [defaultstd setValue:[status valueForKey:@"user_id"] forKey:@"user_id"];
            alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Login successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 10;
            [alert show];
        }else{
            NSLog(@"error");
        }
    }
}


- (void)buttonClickHandler:(id)sender {
    
    NSString *appId = AUVFB_APPID;
    NSString *permissions = @"publish_stream,user_birthday,email";
    
    webview =[[UIWebView alloc]initWithFrame:CGRectMake(10, 10, 300, 430)];
    _spinner.center=CGPointMake(160, 240);
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(279,-7,28, 28);
    [btn setImage:[UIImage imageNamed:@"close@2x.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btclose:) forControlEvents:UIControlEventTouchUpInside];
    [webview addSubview:btn];
    webview.scalesPageToFit=YES;
    webview.layer.cornerRadius = 6;
    webview.layer.borderColor = [UIColor blackColor].CGColor;
    webview.layer.borderWidth = 1;
    webview.delegate=self;
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                UIActivityIndicatorViewStyleGray];
    [webview addSubview:_spinner];
    
    NSString *redirectUrlString = @"http://www.facebook.com/connect/login_success.html";
    NSString *authFormatString = @"https://graph.facebook.com/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@&type=user_agent&display=touch";
    
    NSString *urlString = [NSString stringWithFormat:authFormatString, appId, redirectUrlString, permissions];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webview loadRequest:request];
    [self.view addSubview:webview];
    
    // amimations to show a webview
    CABasicAnimation *scaoleAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaoleAnimation.duration = 0.5;
    scaoleAnimation.autoreverses = NO;
    scaoleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaoleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.autoreverses = NO;
    group.duration = 1.0;
    group.animations = [NSArray arrayWithObjects: scaoleAnimation, nil];
    [webview.layer addAnimation:group forKey:@"stop"];
    
}
-(void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)btclose:(id)sender{
    webview.hidden=YES;
}
-(void)hideKeyboard
{
    [selectTextField resignFirstResponder];
}

// Web view delegate methods
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    webview.hidden=YES;
    [_spinner stopAnimating];
    if (Redirect) {
        [self performSelector:@selector(fblogin)];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [_spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_spinner stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = request.URL.absoluteString;
    [self checkForAccessToken:urlString];
    return TRUE;
    
}
// Getting the access token of facebook and storing in nsuserdefaults
-(void)checkForAccessToken:(NSString *)urlString {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"access_token=(.*)&" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange accessTokenRange = [firstMatch rangeAtIndex:1];
            NSString *accessToken = [urlString substringWithRange:accessTokenRange];
            accessToken = [accessToken stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@" aftr token ");
            
            if ([accessToken length]>0) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:accessToken forKey:AUVFBACCESSTOKENKEY];
                
                NSLog(@"value %@",accessToken);
                [self getfacebookprofile];
            }
        }
    }
}
// Fetching facebook details with the access token
-(void)getfacebookprofile
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *_accessToken=[defaults objectForKey:AUVFBACCESSTOKENKEY];
    
    NSLog(@"acestoken %@   ",_accessToken);
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@", [_accessToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDidFinishSelector:@selector(getFacebookProfileFinished:)];
    [request setDidFailSelector:@selector(errorprofile:)];
    [request setDelegate:self];
    [request setTimeOutSeconds:120];
    [request startAsynchronous];
}
-(void)errorprofile:(ASIHTTPRequest*)request
{
    NSLog(@" Error - Statistic failed: \"%@\"",[[request error] localizedDescription]);
    alert = [[UIAlertView alloc]initWithTitle:@"Error" message:[[request error] localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

- (void)getFacebookProfileFinished:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    NSLog(@"Got Facebook Profile: %@", responseString);
    
    
    NSMutableDictionary *responseJSON = [responseString JSONValue];
    userid    = [responseJSON objectForKey:@"id"];
    username  = [responseJSON objectForKey:@"username"];
    emailid   = [responseJSON objectForKey:@"email"];
    firstname = [responseJSON objectForKey:@"first_name"];
    lastname  = [responseJSON objectForKey:@"last_name"];
    timezone  = [responseJSON objectForKey:@"timezone"];
    if (userid==NULL) {
        [self  getfacebookprofile];
    }
   // NSLog(@" id%@ \n username %@ \n emailid%@ \nweblink %@ \nfirstname %@ \nlastname %@ \ngender %@\nbirth %@",userid,username,emailid,firstname,lastname);
    [self performSelector:@selector(callwebservices) withObject:nil afterDelay:0.5];
    
}
-(void)callwebservices{
     [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [service fb_registration:self action:@selector(fbLoginHandler:) facebook_user_id:userid access_key:[defaults objectForKey:AUVFBACCESSTOKENKEY] firstname:firstname lastname:lastname username:username email_id:emailid timezone:timezone];

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
        NSLog(@"arr %@",arr);
        NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"//" withString:@""];
        
        
        NSDictionary *status=[result JSONValue];
        NSLog(@"status %@",status);
        if ([[status objectForKey:@"login"] intValue] == 1) {
            NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
            [defaultstd setValue:[status valueForKey:@"user_id"] forKey:@"user_id"];
            alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Login successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 10;
            [alert show];
        }else{
            NSLog(@"error");
        }

        
    }
}
#pragma Twitter Login Functions

-(void)twlogin
{
    NSLog(@"Twitter login");
    if ([TWTweetComposeViewController canSendTweet])
    {
        
        ACAccountStore  *account = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        // Request access from the user to use their Twitter accounts.
        [account requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error)
         {
             // Did user allow us access?
             if (granted == YES)
             {
                 // Populate array with all available Twitter accounts
                 NSArray   *arrayOfAccounts = [account accountsWithAccountType:accountType];
                 
                 // Populate the tableview
                 NSLog(@"Twiter details-- %@",arrayOfAccounts);
                 ACAccount *ac=[arrayOfAccounts objectAtIndex:0];
                 NSLog(@"arrayOfAccounts %@",[(ACAccount*)[arrayOfAccounts objectAtIndex:0] username]);
                 
                 [[NSUserDefaults standardUserDefaults] setObject:ac.username forKey:@"Twitter_name"];
                 
                 NSString *userstr = [(ACAccount*)[arrayOfAccounts objectAtIndex:0] username];
                 NSString *userID = [[ac valueForKey:@"properties"] objectForKey:@"user_id"];
                 NSString *fullName = [[ac valueForKey:@"properties"] objectForKey:@"fullName"];
                 NSLog(@"user id %@",userID);
                 
                 NSLog(@"STR %@ %@",userstr,fullName);
                 
                 
             }
             
         }];
    }else{
        alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please create your Twitter account." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
    
}


/**************Custom Label ****************/
-(UILabel*)customlabel:(NSString*)str initframe:(CGRect)frame totallines:(int)lines
{
    UILabel *customlabel =[[UILabel alloc]initWithFrame:frame];
    customlabel.text=str;
    customlabel.numberOfLines=lines;
    customlabel.backgroundColor=[UIColor clearColor];
    customlabel.font=[UIFont fontWithName:@"Arial" size:16.0f];
    customlabel.textColor=[UIColor blackColor];
    return customlabel;
}
/***************Custom Text Field***************/
-(UITextField*)customtxtfield:(NSString*)filedtype placeholder:(NSString*)str initFrame:(CGRect)frame
{
    UITextField *customtextfield = [[UITextField alloc]initWithFrame:frame];
    customtextfield.borderStyle=UITextBorderStyleRoundedRect;
    customtextfield.clearButtonMode=UITextFieldViewModeWhileEditing;
    customtextfield.autocapitalizationType=UITextAutocapitalizationTypeWords;
    customtextfield.autocorrectionType=UITextAutocorrectionTypeDefault;
    customtextfield.returnKeyType=UIReturnKeyDefault;
    customtextfield.enablesReturnKeyAutomatically=NO;
    customtextfield.placeholder=NSLocalizedString(str, nil);
    customtextfield.keyboardType=UIKeyboardTypeDefault;
    customtextfield.font=[UIFont fontWithName:@"Arial" size:16.0f];
    customtextfield.textColor=[UIColor blackColor];
    customtextfield.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    customtextfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    customtextfield.delegate=self;
    
    return customtextfield;
}


/***********Text Field Delegate *************/
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    selectTextField = textField;
    textField.layer.borderColor=[[UIColor blackColor] CGColor];
    textField.layer.borderWidth= 1.0f;
    [scrll setContentOffset:CGPointMake(0, textField.frame.origin.y) animated:YES];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    textField.layer.borderWidth= 0.0f;
    [scrll setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
