//
//  AUVUserInterstViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 10/10/12.
//
//

#import "AUVUserInterstViewController.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "AUVLogin.h"
#import "UIImageView+AFNetworking.h"
#import "AUVDevsViewController.h"
#import "SVProgressHUD.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"

@interface AUVUserInterstViewController ()

@end

@implementation AUVUserInterstViewController
@synthesize type;
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
    categoryArray=[[NSMutableArray alloc] init];
    [super viewDidLoad];
   // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    [self reload];
    
    self.title=@"Categories";
    // Do any additional setup after loading the view from its nib.
    AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
    custombar.delegate= self;
    
    [self.view addSubview:custombar];
    // Do any additional setup after loading the view from its nib.
}

-(void)btnTap:(UIButton*)buttonId

{
    
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 1) {
        
        AUVAppWallController *notification = [[AUVAppWallController alloc]initWithNibName:@"AUVAppWallController_iPhone" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 2){
        
        AUVNotificationViewController *notification = [[AUVNotificationViewController alloc]initWithNibName:@"AUVNotificationViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        
        AUVQuestionChoiceViewController *notification = [[AUVQuestionChoiceViewController alloc]initWithNibName:@"AUVQuestionChoiceViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 4){
        
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 5){
        
        AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
        
        [self.navigationController pushViewController:deal animated:YES];
    }
    else{
        
        //NSLog(@"nothing");
        
    }
    
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




-(void)reload
{
    [self getCategories:nil];
}

-(void)getCategories:(id)sender
{
    
    [AUVwebservice cancelPreviousPerformRequestsWithTarget:self];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
            [service get_user_interest:self action:@selector(getCategoriesHandler:) user_id:[AUVLogin valueforKey:@"user_id"]];
    
    
}


-(void)getCategoriesHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray *arr=(SoapArray*)value;
    NSString *result=[[[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\\" withString:@""] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        
    NSDictionary *dict=[result JSONValue];
    
       [categoryArray removeAllObjects];
    
    NSPredicate *predicate;
    if(self.type==Android)
    predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
       
        
        return  [[(NSDictionary*)obj  valueForKey:@"apptype"] isEqualToString:@"android"] ;
    }];
    
    else if(self.type==iPhone)
      predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
    
     
     return  [[(NSDictionary*)obj  valueForKey:@"apptype"] isEqualToString:@"iphone"] ;
     }];
     
     
     
    NSArray *categories=[(NSArray*)[dict valueForKey:@"category_list"] filteredArrayUsingPredicate:predicate];
    
    [categoryArray addObjectsFromArray:categories];
    
    //NSLog(@"%@",categoryArray);
    
    [self.tableview reloadData];
    [SVProgressHUD dismiss];
    }
    
}









#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return categoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell  *cell=nil;
    UIView *baseCell;
    UIImageView *imageV;
    UILabel *category_Name;
    UILabel *apptype;
    UIButton *btn;
    static NSString *identifier = @"defaultcell";
    cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell=nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        CGRect rect =[cell bounds];
        baseCell=[[UIView alloc] initWithFrame:rect];
        
        imageV=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 64, 64)];
        imageV.layer.cornerRadius=10;
        imageV.layer.borderWidth=1.0;
        imageV.clipsToBounds=YES;
        
        category_Name=[[UILabel alloc] initWithFrame:CGRectMake(80, 7, 200, 30)];
        category_Name.backgroundColor=[UIColor clearColor];
        category_Name.textColor=[UIColor blackColor];
        category_Name.font=[UIFont systemFontOfSize:15];
        apptype=[[UILabel alloc] initWithFrame:CGRectMake(80, 35, 180, 30)];
        apptype.backgroundColor=[UIColor clearColor];
        
        
        apptype.textColor=[UIColor grayColor];
        apptype.font=[UIFont systemFontOfSize:15];
        
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, 80, 26);
       // btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blue_btn"]];
        // btn.titleLabel.textColor=[UIColor whiteColor];
        
        [btn setBackgroundImage:[[UIImage imageNamed:@"blue_btn"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        
        [baseCell addSubview:imageV];
        [baseCell addSubview:category_Name];
        [baseCell addSubview:apptype];
        
        [cell addSubview:baseCell];
        
        //[baseCell addSubview:btn];
    }
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@",[[categoryArray objectAtIndex:indexPath.row] valueForKey:@"image"]];
    
    
//    if([urlString length]==0)
//    {
//        urlString = @"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/41736_771863010_2112689660_t.jpg";
//    }
    
    [imageV setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    // cell.textLabel.text=@"Contacts";
    // cell.title2.text=@"Add friends from your contact list";
    
    
    category_Name.text=[[categoryArray objectAtIndex:indexPath.row] valueForKey:@"category_name"];//[NSString stringWithFormat:@"sathish89",indexPath.row];
    
    btn.tag=indexPath.row;
    
    
        apptype.text=[NSString stringWithFormat:@"%@",[[categoryArray objectAtIndex:indexPath.row] valueForKey:@"apptype"]];
    
    
    
        if([[[categoryArray objectAtIndex:indexPath.row] valueForKey:@"interest"] boolValue])
        {
            [btn setTitle:@"Unfollow" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(unfollowActionUser:) forControlEvents:UIControlEventTouchDown];
            
            
        }
        else
        {
            [btn setTitle:@" + Follow " forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(followActionUser:) forControlEvents:UIControlEventTouchDown];
        }
    btn.tag=indexPath.row;
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    
    cell.accessoryView=btn;
    
    return cell;
    
}
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
    
    
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AUVDevsViewController *devsView=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil type:AUVTYPECATEGORY];
    //devsView.detailController=self;
    devsView.categoryId=[[categoryArray objectAtIndex:indexPath.row] valueForKey:@"category_id"];
    devsView.category=[[categoryArray objectAtIndex:indexPath.row] valueForKey:@"category_name"];
    [self.navigationController pushViewController:devsView animated:YES];
}

-(void)followActionUser:(id)sender
{
    AUVwebservice *service =[AUVwebservice service];
       [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //[service user_interest:self action:@selector(followActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"] category_id:[[categoryArray objectAtIndex:[sender tag]]valueForKey:@"category_id" ]];
    [service follow_category:self action:@selector(followActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"] category_id:[[categoryArray objectAtIndex:[sender tag]]valueForKey:@"category_id" ]];
}


-(void)unfollowActionUser:(id)sender
{
    AUVwebservice *service=[AUVwebservice service];
       [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [service unfollow_category:self action:@selector(followActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"] category_id:[[categoryArray objectAtIndex:[sender tag]]valueForKey:@"category_id" ]];
}

-(void)followActionHandler:(id)value
{
    
    
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    //[SVProgressHUD dismiss];
    
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    //NSLog(@"result : %@",[result JSONValue]);
    
    /* if(follow==1)
     {
     follow=0;
     followBtn.title=@"follow";
     
     
     }
     else
     {
     follow=1;
     followBtn.title=@"Unfollow";
     
     }*/
    [SVProgressHUD dismiss];
    [self getCategories:nil];
    }
}

@end
