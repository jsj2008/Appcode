//
//  AUVPasswordViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 01/10/12.
//
//

#import "AUVPasswordViewController.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "AUVValidation.h"
@interface AUVPasswordViewController ()

@end

@implementation AUVPasswordViewController

UITextField *activeField;
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
    if (textField==oldPass) {
        [textField resignFirstResponder];
        [newPass becomeFirstResponder];
    }
    else if (textField==newPass) {
        [textField resignFirstResponder];
        [retype becomeFirstResponder];
    }
    
    else if (textField==retype) {
        [textField resignFirstResponder];
    }
    [textField resignFirstResponder];
    
    
    return YES;
}




-(IBAction)changePass:(id)sender
{
//    if(![newPass.text isEqualToString:retype.text])
//    {
//        newPass.layer.borderWidth=1.0;
//        newPass.layer.borderColor=[UIColor redColor].CGColor;
//        retype.layer.borderWidth=1.0;
//        retype.layer.borderColor=[UIColor redColor].CGColor;
//    }
//    else if((newPass.text==nil || [newPass.text isEqualToString:[[NSString stringWithFormat:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]))
//    {
//        newPass.layer.borderWidth=1.0;
//        newPass.layer.borderColor=[UIColor redColor].CGColor;
//        
//    }
//    else if(oldPass.text==nil || [oldPass.text isEqualToString:[[NSString stringWithFormat:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]])
//    {
//        oldPass.layer.borderWidth=1.0;
//        oldPass.layer.borderColor=[UIColor redColor].CGColor;
//        
//    }
//    else if(retype.text==nil || [retype.text isEqualToString:[[NSString stringWithFormat:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]])
//    {
//        retype.layer.borderWidth=1.0;
//        retype.layer.borderColor=[UIColor redColor].CGColor;
//        
//    }
//    
//    else{
        
    
    NSMutableArray *err=[[NSMutableArray alloc] init];
    
       if([AUVValidation isEmpty:oldPass.text]){
        NSString *msg=@"Password field should not be empty.";
        [err addObject:msg];
        
    }
    else if(![AUVValidation fieldMinLength:6 fieldString:oldPass.text]){
        NSString *msg=@"Password should be more than 6 characters long.";
        [err addObject:msg];
        
    }
    if([AUVValidation isEmpty:newPass.text]){
        NSString *msg=@"Password verification field should not be empty.";
        [err addObject:msg];
        
    }
    else  if(![AUVValidation fieldMinLength:6 fieldString:newPass.text]){
        NSString *msg=@"Password verification should be more than 6 characters long.";
        [err addObject:msg];
        
    }
    
    else  if(![AUVValidation fieldString:newPass.text matchesString:retype.text])
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
        
        [service change_password:self action:@selector(changePassHandler:) user_id:[AUVLogin valueforKey:@"user_id"] current_password:oldPass.text new_password:newPass.text];
  //  }
    
}



-(void)changePassHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    else{
    SoapArray *arr=(SoapArray*)value;
    
   // //NSLog(@"%@",arr);
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSDictionary *dict=[result JSONValue];
    
    if([[dict valueForKey:@"status"] boolValue])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    else{
        msg.text=[dict valueForKey:@"message"];
    }
    [activeField resignFirstResponder];
    }
}

@end
