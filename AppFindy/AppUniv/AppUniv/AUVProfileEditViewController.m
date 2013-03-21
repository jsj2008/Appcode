//
//  AUVProfileEditViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/08/12.
//
//

#import "AUVProfileEditViewController.h"
#import "AUVwebservice.h"
@interface AUVProfileEditViewController ()

@end

@implementation AUVProfileEditViewController
@synthesize fieldValue,labelName,type;
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
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    btn.frame=CGRectMake(100, 150, 80, 40);
    [btn setBackgroundImage:[UIImage imageNamed:@"blue_btn"] forState:UIControlStateNormal];
    btn.titleLabel.textColor=[UIColor whiteColor];
    [btn setTitle:@"Update" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(update) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
    
    label=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 200, 30)];
    label.text=labelName;
    
    label.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:label];
    
    textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 25)];
    textField.borderStyle=UITextBorderStyleRoundedRect;
    textField.text=fieldValue;
    [self.view addSubview:textField];
    [textField becomeFirstResponder];

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

-(void)dismissView
{
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)update
{
    if(textField.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the value" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }else
    {
        AUVwebservice *service=[AUVwebservice service];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [service update_profile:self action:@selector(updateHandler:) user_id:[defaults valueForKey:@"user_id"] param_name:type param_value:textField.text];
    }
}



-(void)updateHandler:(id)value
{
    SoapArray *arr=(SoapArray*) value;
    
    
    //NSLog(@"Result : %@",arr);
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)fieldType:(NSString *)str
{
    
    
}
@end
