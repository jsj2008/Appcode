//
//  AUVSearchFriendController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 18/08/12.
//
//

#import "AUVSearchFriendController.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "SVProgressHUD.h"
#import "AUVFriendsListViewController.h"
@interface AUVSearchFriendController ()

@end

@implementation AUVSearchFriendController

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
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    searchField.delegate=self;
    searchField.rightView=[[UIView alloc] initWithFrame:CGRectMake(290, 0, 10, 5)];
    searchField.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    searchField.leftViewMode=UITextFieldViewModeAlways;
    searchField.rightViewMode=UITextFieldViewModeAlways;
    self.title=@"Search Friends";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
    [super viewDidDisappear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)searchUser:(id)sender
{
    //[SVProgressHUD show];
  /*  AUVwebservice *service=[AUVwebservice service];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    service.logging=NO;
    [service search_user:self action:@selector(searchHandler:) user_id:[defaults valueForKey:@"user_id"] search_term:searchField.text];
    */
    
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeGradient];
    AUVFriendsListViewController *flView=[[AUVFriendsListViewController alloc] initWithNibName:@"AUVFriendsListViewController" bundle:nil type:AUVSearchFriendList];
   
    flView.searchTerm=searchField.text;
    [self.navigationController pushViewController:flView animated:YES];

   // [service search_user:self action:@selector(searchHandler:) search_term:searchField.text];
}

-(void)searchHandler:(id)value
{
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    // Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    
    NSArray * dict = [result JSONValue];
 
    [SVProgressHUD dismiss];

    if(dict.count>0)
    {
        AUVFriendsListViewController *flView=[[AUVFriendsListViewController alloc] initWithNibName:@"AUVFriendsListViewController" bundle:nil type:AUVSearchFriendList];
        if([[dict valueForKey:@"user_details"] isKindOfClass:[NSArray class]])
        flView.dataArray=[[NSMutableArray alloc] initWithArray:[dict valueForKey:@"user_details"]];
        flView.searchTerm=searchField.text;
        [self.navigationController pushViewController:flView animated:YES];
    }
    }
    //  [appDic setValue:[dict valueForKey:@"value"] forKey:[dict valueForKey:@"key"]];
    
    //if([[dict valueForKey:@"message"] isEqualToString:@"success"])
      //  likeBtn.enabled=NO;
}



#pragma UITextFieldDelegate methods



#pragma mark UITextField Delegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField
{
     [textField resignFirstResponder];
    //[SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeGradient];

    
  //  [self searchUser:nil];
  
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self searchUser:nil];
    [textField resignFirstResponder];
    
    return YES;
}



@end
