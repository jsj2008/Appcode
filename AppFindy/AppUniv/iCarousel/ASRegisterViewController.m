//
//  ASRegisterViewController.m
//  AppSnatch
//
//  Created by Innoppl Technologies on 24/02/13.
//  Copyright (c) 2013 Innoppl Technologies. All rights reserved.
//

#import "ASRegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AUVwebservice.h"
#import "JSON.h"
#import "SVProgressHUD.h"

@interface ASRegisterViewController ()<UITextFieldDelegate>{
    UITextField *firstName;
    UITextField *emailId;
    UITextField *passWord;
    UITextField *repassWord;
    UITextField *selectTextField;
    UIAlertView *alert;
}

@end

@implementation ASRegisterViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    self.title= @"Sign Up";
    
  
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
       
    emailId =[self customtxtfield:@" " placeholder:@"Email Id" initFrame:CGRectMake(60, 50, 200, 35)];
    emailId.keyboardType=UIKeyboardTypeEmailAddress;
    [self.view addSubview:emailId];
    
    passWord=[self customtxtfield:@"" placeholder:@"Password" initFrame:CGRectMake(60, 90, 200, 35)];
    passWord.secureTextEntry=YES;
    [self.view addSubview:passWord];
    
    repassWord =[self customtxtfield:@"" placeholder:@"Confirm Password" initFrame:CGRectMake(60, 130, 200, 35)];
    repassWord.secureTextEntry = YES;
    [self.view addSubview:repassWord];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame=CGRectMake(120, 200, 80, 30);
    [submit setBackgroundImage:[[UIImage imageNamed:@"black_button.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [[submit titleLabel] setFont:[UIFont fontWithName:@"Arial" size:15.0]];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];


    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)submitbtn:(id)sender
{
    
    NSString *emailregex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,4}";
    NSPredicate *expre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailregex];
    BOOL emailval = [expre evaluateWithObject:emailId.text];
    NSMutableString *errmsg = [[NSMutableString alloc]init];
    
    if([[emailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [errmsg appendFormat:@"Please Enter Email id \n"];
    }
    if([[emailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0 && !emailval)
    {
        [errmsg appendFormat:@"Please Enter Valid Email id \n"];
    }
    if([[passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [errmsg appendFormat:@"Please Enter Password \n"];
    }
    if([[repassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [errmsg appendFormat:@"please Enter Confirm Password \n"];
    }
    if(([[passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0 && [[repassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0) && ![passWord.text isEqualToString:repassWord.text])
    {
        [errmsg appendFormat:@"Password didn't matched"];
    }
   
    if(![errmsg isEqualToString:@""])
    {
        NSLog(@"fill");
        UIAlertView *msgalert =[[UIAlertView alloc]initWithTitle:@"Alert" message:errmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [msgalert show];
        
    }
    else
    {
        [self performSelector:@selector(registration) withObject:nil afterDelay:0.5];
    }
    
}
-(void)registration{
    [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    
    AUVwebservice *service=[AUVwebservice service];
    service.logging=YES;
    [service register:self action:@selector(registerHandler:) email_id:emailId.text password:passWord.text ];
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
            
            NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
            [defaultstd setValue:[dict valueForKey:@"user_id"] forKey:@"user_id"];
            alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Register successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 10;
            [alert show];
            
        }else if([[dict valueForKey:@"login"] intValue]==0)
        {
            
            // message.text= [NSString stringWithFormat:@"%@",[dict valueForKey:@"error"]];
            [SVProgressHUD dismiss];
            
            
        }
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  //  NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        NSLog(@"close");
	}
    if (alertView ==alert) {
        if (buttonIndex ==0) {
            [self dismissViewControllerAnimated:YES completion:nil];
           // [[self delegate] RatingsViewalues:[defaultstd objectForKey:@"AppUserId"] ];
            
        }
    }
    
}




-(void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    textField.layer.borderColor=[[UIColor purpleColor] CGColor];
    textField.layer.borderWidth= 1.0f;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    textField.layer.borderWidth= 0.0f;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)hideKeyboard
{
    [selectTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
