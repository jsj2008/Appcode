//
//  AUVLoginPanel.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVLoginPanel.h"
#import "AUVwebservice.h"
#import "SoapArray.h"
#import "JSON.h"
#import "SVProgressHUD.h"
#import "AUVLogin.h"
#import "AUVValidation.h"
#import <QuartzCore/QuartzCore.h>
#import "AUVConstants.h"
#import "AUVHelpViewController.h"

@implementation AUVLoginPanel

@synthesize loginData;  
@synthesize  loggedIn;
@synthesize login;
@synthesize btnHelp;

UITextField *activeField;

-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        self.margin = UIEdgeInsetsMake( 10.0f,  10.0f, 10.0f,10.0f);
        
        // Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
        self.padding = UIEdgeInsetsMake(10.0f,  10.0f, 10.0f,10.0f);
        
        // Border color of the panel. Default = [UIColor whiteColor]
        //self.borderColor = [UIColor whiteColor];
        self.headerLabel.text=@"Login";
        self.headerLabel.font=[UIFont boldSystemFontOfSize:18];
        // Border width of the panel. Default = 1.5f;
        self.borderWidth = 2.0f;
        
        // Corner radius of the panel. Default = 4.0f
        self.cornerRadius = 10;
        
        //self.backgroundColor=[UIColor whiteColor];
        // Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
        //self.contentColor = [UIColor colorWithRed:(arc4random() % 2) green:(arc4random() % 2) blue:(arc4random() % 2) alpha:1.0];
        
        // Shows the bounce animation. Default = YES
        self.shouldBounce = YES;
        
        // Shows the actionButton. Default title is nil, thus the button is hidden by default
        //[self.actionButton setTitle:@"Login" forState:UIControlStateNormal];
        //self.actionButton.userInteractionEnabled=NO;

        NSString *nibName;
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            nibName=@"AUVLoginPanel_iPhone";
        }
        else {
            nibName=@"AUVLoginPanel_iPad";
        }
        
        

        
        loginData=[[NSMutableDictionary alloc] init];
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        [self setupField:uname];
        [self setupField:password];
        
        login.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
        login.layer.cornerRadius=5.0f;
        
        [self.contentView addSubview:view ];
        
        baseScroll.contentSize=CGSizeMake(0, 400);
        baseScroll.delegate=self;

    }
    
    
    
    return self;
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [activeField resignFirstResponder];
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    ////NSLog(@"test");
    
     activeField=textField;
    
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        
        baseScroll.contentOffset=CGPointMake(0,textField.frame.origin.y);
        
    }
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField
{
    baseScroll.contentOffset=CGPointMake(0,0);
    
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==uname) {
        [textField resignFirstResponder];
        [password becomeFirstResponder];
    }
    else if (textField==password) {
        [textField resignFirstResponder];
        
       // [self performSelectorInBackground:@selector(login:) withObject:nil];
        }
        [textField resignFirstResponder];
    
    
    return YES;
}


-(IBAction)login:(id)sender
{
    
    NSMutableArray *err=[[NSMutableArray alloc] init];
    
    if([AUVValidation isEmpty:uname.text]){
        NSString *msg=@"Username field should not be empty.";
        
        [err addObject:msg];
    }
    else if(![AUVValidation fieldMinLength:6 fieldString:uname.text]){
        NSString *msg=@"Username should be more than 6 characters long.";
        [err addObject:msg];
    }
    
    if([AUVValidation isEmpty:password.text]){
        NSString *msg=@"Password field should not be empty.";
        [err addObject:msg];
        
    }
    else if(![AUVValidation fieldMinLength:6 fieldString:password.text]){
        NSString *msg=@"Password should be more than 6 characters long.";
        [err addObject:msg];
        
    }
        
    
    if([err count]>0)
    {
        [SVProgressHUD showErrorWithStatus:[err objectAtIndex:0]];
        
        return;
    }

    [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    
    [service login:self action:@selector(loginHandler:) username:uname.text password:password.text];
    
  
}

-(void)loginHandler:(id)value
{
    
	 if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    
     else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    //[SVProgressHUD dismiss];
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"//" withString:@""];
   
    
    NSDictionary *status=[result JSONValue];
    
    if([[status valueForKey:@"login"] boolValue]){
        [AUVLogin Login:status];
        loggedIn=YES;
        {
        AUVwebservice *service=[AUVwebservice service];
        if([AUV_DELEGATE deviceToken])
        [service update_DeviceToken:self action:@selector(tokenUpdateHandler:) user_id:[AUVLogin valueforKey:@"user_id"] token:[AUV_DELEGATE deviceToken]];
            
        else{
            [SVProgressHUD showErrorWithStatus:@"Could not able to get APN token. Try Logout And Login Again."];
              [self hide];
        }
        }
        
        
    }
    
    else {
        message.text=@"Sorry,Could not match that credentials. Please try again.";
        [SVProgressHUD dismiss];

        [AUVLogin Logout];
       
        
    }
     
     }
}


-(void)tokenUpdateHandler:(id)value
{
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
        [SVProgressHUD dismiss];
    SoapArray* arr = (SoapArray*)value;
    
    NSLog(@"%@",arr);
    

    [self hide];
    }
}
-(void)hide
{
 [SVProgressHUD dismiss];
    if(!loggedIn)
        
    {
        //NSLog(@"teeet");
        [AUVLogin Logout];

    }
    [super hide];
}

-(void) setupField:(UITextField*)searchField
{
    searchField.rightView=[[UIView alloc] initWithFrame:CGRectMake(210, 0, 10, 5)];
    searchField.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    searchField.leftViewMode=UITextFieldViewModeAlways;
    searchField.rightViewMode=UITextFieldViewModeAlways;
}



-(IBAction)forgotPassword:(id)sender
{
   
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Forgot Password" message:@"Please enter username or email:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    alertTextField.placeholder = @"Username or Email";
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   
   // //NSLog(@"String is: %@", alertTextField.text);
    if (buttonIndex == 0){
        return;
    }
    
    if (buttonIndex == 1 && alertTextField.text.length!=0) {
        
        [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
        AUVwebservice *service=[AUVwebservice service];
        service.logging=NO;
        
        [service forgot_password:self action:@selector(forgotPasswordHandler:) username:alertTextField.text];
           
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter username!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];

    }
}

-(IBAction)btnHelp_Clicked:(id)sender
{
    [AUVLogin Help:true];
    [self hide];
}


-(void)forgotPasswordHandler:(id)value
{
    

    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{

    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    if(arr.count==0){
        [SVProgressHUD showErrorWithStatus:@"No response from server."];
        
     
    }
   /// NSLog(@"Arr %@",arr);
    else{
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"//" withString:@""];
    
    Boolean status=[[[result JSONValue]valueForKey:@"status"]boolValue];
    if(status)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"We've sent password reset instructions to your email address.If you don't receive instructions within a minute or two, check your email's spam and junk filters." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Oh, snap! We couldn't find you using the information you entered. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    }
    }
    //NSLog(@"Stat  %@",[result JSONValue]);
        
}

@end
