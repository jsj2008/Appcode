//
//  AUVRegisterPanel.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVRegisterPanel.h"
#import "Soap.h"
#import "SoapArray.h"
#import "AUVwebservice.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "AUVLogin.h"
#import "AUVValidation.h"
#import "AUVConstants.h"
#import "AUVAppDelegate.h"
#import "AUVAPPSnatchView.h"
@implementation AUVRegisterPanel
@synthesize  loggedIn;
UITextField *activeField;
UIAlertView *alert;
-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        
        self.margin = UIEdgeInsetsMake( 20.0f,  20.0f, 20.0f,20.0f);
        
        // Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
        self.padding = UIEdgeInsetsMake(10.0f,  10.0f, 10.0f,10.0f);
        
        // Border color of the panel. Default = [UIColor whiteColor]
        //self.borderColor = [UIColor whiteColor];
        
        // Border width of the panel. Default = 1.5f;
        self.borderWidth = 2.0f;
        
        // Corner radius of the panel. Default = 4.0f
        self.cornerRadius = 10;
        self.headerLabel.text=@"Signup";
        self.headerLabel.font=[UIFont boldSystemFontOfSize:18];
        
        self.shouldBounce = YES;
        
             
        NSString *nibName;
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            nibName=@"AUVRegisterPanel";
        }
        else {
            nibName=@"AUVRegisterPanel_iPad";
        }

        [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
       
        [self setupField:firstname];
        [self setupField:uname];
         [self setupField:pass];
         [self setupField:vpass];
         [self setupField:mail];
        
        
       // baseScroll.frame=self.contentViewFrame;
      //  baseScroll.frame=CGRectMake(0, 0, 0, 0);
       // //NSLog(@"%f",baseScroll.frame.origin.y);
        submit.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
        submit.layer.cornerRadius=5.0f;

        [self.contentView addSubview:view ];
        // [baseScroll sizeToFit];
        
        baseScroll.contentSize=CGSizeMake(0, 400);
        baseScroll.delegate=self;

              
    }
    
    return self;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [activeField resignFirstResponder];
}



#pragma mark UITextField Delegate


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
    if(textField==firstname){
        [textField resignFirstResponder];
        [uname becomeFirstResponder];
    }
   else if (textField==mail) {
        [textField resignFirstResponder];
        [pass becomeFirstResponder];
    }
    else if (textField==pass) {
        [textField resignFirstResponder];
        [vpass becomeFirstResponder];
    }
    else if (textField==vpass) {
        [textField resignFirstResponder];
    }
    
    [textField resignFirstResponder];
    
     
    return YES;
}

-(IBAction)btnHelp_Clicked:(id)sender
{
    [AUVLogin Help:true];
    [self hide];
}

-(IBAction)validateFields
{
    NSMutableArray *err=[[NSMutableArray alloc] init];
    
    if([AUVValidation isEmpty:firstname.text])
    {
        //NSString *msg=@"First Name field should not be empty.";
    }
    if([AUVValidation isEmpty:mail.text]){
        NSString *msg=@"Email field should not be empty.";
        [err addObject:msg];
        
    }
    
    else  if(![AUVValidation emailRegEx:mail.text])
    {
        NSString *msg=@"Error in entered email format please check again.";
        [err addObject:msg];
        
    }
    
//    else if(![AUVValidation fieldMinLength:6 fieldString:uname.text]){
//        NSString *msg=@"Username should be more than 6 characters long.";
//        [err addObject:msg];
//    }
    
    if([AUVValidation isEmpty:pass.text]){
        NSString *msg=@"Password field should not be empty.";
        [err addObject:msg];

    }
   else if(![AUVValidation fieldMinLength:6 fieldString:pass.text]){
       NSString *msg=@"Password should be more than 6 characters long.";
       [err addObject:msg];

    }
   if([AUVValidation isEmpty:vpass.text]){
       NSString *msg=@"Password verification field should not be empty.";
       [err addObject:msg];

    }
  else  if(![AUVValidation fieldMinLength:6 fieldString:vpass.text]){
      NSString *msg=@"Password verification should be more than 6 characters long.";
      [err addObject:msg];

    }
    
  else  if(![AUVValidation fieldString:pass.text matchesString:vpass.text])
    {
        NSString *msg=@"Password and Password verification fields did not match";
        [err addObject:msg];

    }
       
    if([err count]>0)
    {
        [SVProgressHUD showErrorWithStatus:[err objectAtIndex:0]];
        
        return;
    }
    [activeField resignFirstResponder];
    
     [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    //[SVProgressHUD setStatus:@"Please wait..."];
    AUVwebservice *service=[AUVwebservice service];
    
    service.logging=YES;
   // [service register:self action:@selector(registerHandler:) username:uname.text password:pass.text retype_password:vpass.text email:mail.text];
    
   
    //[service register:self action:@selector(registerHandler:) firstname:firstname.text email_id:mail.text password:pass.text ];
}



- (void) registerHandler: (id) value {
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
	NSLog(@"register returned the value: %@", arr);
      [SVProgressHUD dismiss];
  NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
   NSDictionary *dict=[result JSONValue];
  NSLog(@"%@",dict);
  
   if([[dict valueForKey:@"login"] intValue]==1)
    {
    
      //  [AUV_DELEGATE updateAppsList];
       // [AUVLogin Login:dict];
         [self hide];
        NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
        [defaultstd setValue:[dict valueForKey:@"user_id"] forKey:@"AppUserId"];
       // alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Register Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       // alert.tag = 10;
      //  [alert show];
//        loggedIn=YES;
//        {
//            AUVwebservice *service=[AUVwebservice service];
//            if([AUV_DELEGATE deviceToken])
//                [service update_DeviceToken:self action:@selector(tokenUpdateHandler:) user_id:[AUVLogin valueforKey:@"user_id"] token:[AUV_DELEGATE deviceToken]];
//            
//            else{
//                [SVProgressHUD showErrorWithStatus:@"Could not able to get APN token. Try Logout And Login Again."];
//                [self hide];
//            }
//
//            
//        }
    
        
    }else if([[dict valueForKey:@"login"] intValue]==0)
    {
        
        message.text= [NSString stringWithFormat:@"%@",[dict valueForKey:@"error"]];
          [SVProgressHUD dismiss];
    }
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (alertView ==alert) {
//        if (buttonIndex ==0) {
//           
//           
//
//    }
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
    
    
    [self hide];
    }
}


-(void)hide
{
    NSLog(@"close");
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

@end
