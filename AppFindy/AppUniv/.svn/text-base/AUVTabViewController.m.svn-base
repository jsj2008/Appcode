//
//  AUVTabViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 29/09/12.
//
//

#import "AUVTabViewController.h"
#import "AUVwebservice.h"
#import "AUVLogin.h"
#import "JSON.h"
#import "AUVConstants.h"
#import "SVProgressHUD.h"
@interface AUVTabViewController ()

@end

@implementation AUVTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    

    
    categoriesiPhone=[[AUVCategoriesViewController alloc] initWithNibName:@"AUVCategoriesViewController" bundle:nil];
    categoriesiPhone.title=@"iPhone";
    categoriesiPhone.parentTab=self;
    /*categoriesAndroid=[[AUVCategoriesViewController alloc] initWithNibName:@"AUVCategoriesViewController" bundle:nil];
    categoriesAndroid.title=@"Android";
    categoriesAndroid.parentTab=self;*/
    
    
    
    [self setViewControllers:[NSArray arrayWithObjects:categoriesiPhone, nil]];
        [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [AUVwebservice cancelPreviousPerformRequestsWithTarget:self];
    
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)doneAction:(id)sender
{
    //NSLog(@"%@",categoriesiPhone.selectedArray);
    //NSLog(@"%@",categoriesAndroid.selectedArray);


    
    
    
    AUVwebservice *service=[AUVwebservice service];
    
    [service user_interest:self action:@selector(userInterestHandler:) user_id:[NSString stringWithFormat:@"%@",[AUVLogin valueforKey:@"user_id"]] category_id:[NSString stringWithFormat:@"%@",[[categoriesiPhone selectedArray] componentsJoinedByString:@","]]];
}



-(void)userInterestHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray *arr=(SoapArray*)value;
    
    //NSLog(@"%@",arr);
    NSString *result=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"\\" withString:@""]];
    
    NSDictionary *dict=[result JSONValue];
    
    //NSLog(@"Insert %@",dict);
    
    if([[dict valueForKey:@"status"] boolValue])
    {
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"new_user"];
        [defaults synchronize];
        
            [[self  navigationController] popViewControllerAnimated:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:AUVCategoryNotification object:nil];
    }
   // //NSLog(@"%@",value);
    }
}
@end
