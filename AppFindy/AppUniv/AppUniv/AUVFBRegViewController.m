//
//  AUVFBRegViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 27/09/12.
//
//

#import "AUVFBRegViewController.h"
#import "AUVCategoriesViewController.h"
#import "AUVwebservice.h"
#import "SVProgressHUD.h"
#import "AUVValidation.h"
#import "AUVLogin.h"
@interface AUVFBRegViewController ()

@end

@implementation AUVFBRegViewController
@synthesize userNameString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    userName.text=userNameString;
    self.title=@"Update Details";
    self.navigationController.navigationBarHidden=NO;
   // self.navigationItem.backBarButtonItem=nil;
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==userName) {
        [textField resignFirstResponder];
        [password becomeFirstResponder];
    }
    else if (textField==password) {
        [textField resignFirstResponder];
        [verifyPass becomeFirstResponder];
    }
    else if (textField==verifyPass) {
        [textField resignFirstResponder];
    }
        [textField resignFirstResponder];
    
    return YES;
}



-(IBAction)updateUser:(id)sender
{
    
    NSMutableArray *err=[[NSMutableArray alloc] init];
    
    if([AUVValidation isEmpty:userName.text]){
        NSString *msg=@"Username field should not be empty.";
        
        [err addObject:msg];
    }
    else if(![AUVValidation fieldMinLength:6 fieldString:userName.text]){
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
    if([AUVValidation isEmpty:verifyPass.text]){
        NSString *msg=@"Password verification field should not be empty.";
        [err addObject:msg];
        
    }
    else  if(![AUVValidation fieldMinLength:6 fieldString:verifyPass.text]){
        NSString *msg=@"Password verification should be more than 6 characters long.";
        [err addObject:msg];
        
    }
    
    else  if(![AUVValidation fieldString:password.text matchesString:verifyPass.text])
    {
        NSString *msg=@"Password and Password verification fields did not match";
        [err addObject:msg];
        
    }
        
    
    if([err count]>0)
    {
        [SVProgressHUD showErrorWithStatus:[err objectAtIndex:0]];
        
        return;
    }

    AUVwebservice *service=[AUVwebservice service];
    
    [service facebook_username_update:self action:@selector(fbUpdateHandler:) user_id:[AUVLogin valueforKey:@"user_id"] username:userName.text password:password.text];
    
    
    //[self settings:nil];
    
}



-(void)fbUpdateHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
   // SoapArray *arr=(SoapArray*) value;
    
    ////NSLog(@"%@",arr);
    [self settings:nil];
    
    }
}
-(IBAction)settings:(id)sender
{
    //    AUVSettingsViewController *sett=[[AUVSettingsViewController alloc] initWithNibName:@"AUVSettingsViewController" bundle:nil];
    //
    //    [self.navigationController pushViewController:sett animated:YES];
    
  //  AUVTabViewController *tabbar=[[AUVTabViewController alloc] init];
    
   // [self presentModalViewController:categories animated:YES];
    
    //[self.navigationController pushViewController:tabbar    animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];

}



#pragma mark UITextField Delegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    ////NSLog(@"test");
   // activeField=textField;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        
        scrollview.contentOffset=CGPointMake(0,textField.frame.origin.y);
        
    }
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField
{
    scrollview.contentOffset=CGPointMake(0,0);
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewDidDisappear:animated];
}


@end
