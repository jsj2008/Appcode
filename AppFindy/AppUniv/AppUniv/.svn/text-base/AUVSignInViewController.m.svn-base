//
//  AUVSignInViewController.m
//  AppUniv
//
//  Created by Innoppl technologies on 06/12/12.
//
//

#import "AUVSignInViewController.h"
#import "AUVwebservice.h"
#import "SoapArray.h"
#import "JSON.h"
#import "SVProgressHUD.h"
#import "AUVLogin.h"
#import "AUVValidation.h"
#import "SCNavigationBar.h"
#import "AUVAppWallController.h"
#import "RearViewController.h"
#import "RevealController.h"

@interface AUVSignInViewController ()

@end

@implementation AUVSignInViewController
@synthesize loggedIn;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    ////NSLog(@"test");
    
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        
        scroll.contentOffset=CGPointMake(0,textField.frame.origin.y);
        
    }
    
}
-(IBAction)cancel:(id)sender
{
   
    [self dismissModalViewControllerAnimated:YES];
    
}
-(void)textFieldDidEndEditing:(UITextField*)textField
{
    scroll.contentOffset=CGPointMake(0,0);
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==username) {
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


-(IBAction)loginEvent:(id)sender
{
 
        NSMutableArray *err=[[NSMutableArray alloc] init];
        
        if([AUVValidation isEmpty:username.text]){
            NSString *msg=@"Username field should not be empty.";
            
            [err addObject:msg];
        }
        else if(![AUVValidation fieldMinLength:6 fieldString:username.text]){
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
        
        [service login:self action:@selector(loginHandler:) username:username.text password:password.text];
        
        
    }
    
    -(void)loginHandler:(id)value
    {
        
        // Handle errors
        if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
            
            [SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
        }
    
        else{
        
        // Do something with the Array* result
        SoapArray* arr = (SoapArray*)value;
        [SVProgressHUD dismiss];
        NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"//" withString:@""];
        
        NSDictionary *status=[result JSONValue];
        //NSLog(@"Stat  %@",status);
        if([[status valueForKey:@"login"] boolValue]){
            [AUVLogin Login:status];
            loggedIn=YES;
           
            [self dismissModalViewControllerAnimated:YES];
             //[self goToWall];
        }
        
        else {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Sorry,Could not match that credentials. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [AUVLogin Logout];
            
            
        }
        }
        
    }

    
    

-(IBAction)signupEvent:(id)sender
{
    
}
-(void)goToWall
{
    
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVAppWallController_iPhone";
    }
    else {
        nibName=@"AUVAppWallController_iPad";
    }
    AUVAppWallController *wall=[[AUVAppWallController alloc] initWithNibName:nibName bundle:nil];
  
    UINavigationController *navigationController=[self customizedNavigationController];
    [navigationController setViewControllers:[NSArray arrayWithObject:wall]];
    
    RearViewController *rearViewController = [[RearViewController alloc] initWithNibName:@"RearViewController" bundle:nil];
    
    UINavigationController *controller=[[UINavigationController alloc] initWithRootViewController:rearViewController];
    
	RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigationController rearViewController:rearViewController];
    
	[self presentModalViewController:revealController animated:YES];
}

- (UINavigationController *)customizedNavigationController
{
    UINavigationController *navController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    
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


@end
