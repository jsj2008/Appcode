//
//  AUVTrendingCategoryListViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 11/12/12.
//
//

#import "AUVTrendingCategoryListViewController.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "AUVLogin.h"
#import "UIImageView+AFNetworking.h"
#import "AUVDevsViewController.h"
#import "SVProgressHUD.h"
#import "AUVTredingAppsViewController.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"
#import "ASSignViewController.h"
#import "AUVHelpViewController.h"
#import "AUVScrollTabBar.h"

@interface AUVTrendingCategoryListViewController ()

@end

@implementation AUVTrendingCategoryListViewController

@synthesize trendingpageposition;

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
    
    self.navigationController.navigationBarHidden=NO;
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.title=@"Trending";
    //tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    if([trendingpageposition isEqualToString:@"menu"])
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    }

    [self getCategories];
    AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 375, 320, 44)];
  //  [custombar.button3 setImage:[UIImage imageNamed:@"deals1.png"] forState:UIControlStateNormal];
    custombar.delegate= self;
    [self.view addSubview:custombar];
    // Do any additional setup after loading the view from its nib.
}

-(void)btnTap:(UIButton*)buttonId

{
    
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 1) {
        
        AUVwallcontrollerViewController *notification = [[AUVwallcontrollerViewController alloc]initWithNibName:@"AUVwallcontrollerViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 2){
        
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
        
        [self.navigationController pushViewController:deal animated:YES];
        
    }else if (buttonselect == 4){
        ASSignViewController *signIn =[[ASSignViewController alloc] initWithNibName:@"ASSignViewController" bundle:nil];
        [self.navigationController pushViewController:signIn animated:YES];
        
    }else if (buttonselect == 5){
            AUVHelpViewController *helpView =[[AUVHelpViewController alloc] initWithNibName:@"AUVHelpViewController" bundle:nil];
            [self.navigationController pushViewController:helpView animated:YES];
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


-(void)getCategories
{
    
    [AUVwebservice cancelPreviousPerformRequestsWithTarget:self];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    [service get_all_category:self action:@selector(getCategoriesHandler:)];
    
    
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
    

    
    
    trendingcategoryarray=[[NSMutableArray alloc]init];
    [trendingcategoryarray addObjectsFromArray:[[result JSONValue]valueForKey:@"category_list"]];
    
    
    
    [tredingcategorytableview reloadData];
        
        
    
    }
    [SVProgressHUD dismiss];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return trendingcategoryarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell  *cell=nil;
    UIView *baseCell;
    UIImageView *imageV;
    UILabel *category_Name;
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
        
        category_Name=[[UILabel alloc] initWithFrame:CGRectMake(80, 20, 200, 30)];
        category_Name.backgroundColor=[UIColor clearColor];
        category_Name.textColor=[UIColor blackColor];
        category_Name.font=[UIFont systemFontOfSize:13];
        
        UIImageView *arrow=[[UIImageView alloc] initWithFrame:CGRectMake(300, 30, 20, 25)];
        arrow.image=[UIImage imageNamed:@"bluearrow.png"];
                
        [baseCell addSubview:imageV];
        [baseCell addSubview:category_Name];
        [baseCell addSubview:arrow];
        [cell addSubview:baseCell];

    }
    
    category_Name.text=[[trendingcategoryarray objectAtIndex:indexPath.row]valueForKey:@"category_name"];
    
    [imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[trendingcategoryarray objectAtIndex:indexPath.row] valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    
    return cell;
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
    
    
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AUVTredingAppsViewController *trendingapp=[[AUVTredingAppsViewController alloc]initWithNibName:@"AUVTredingViewController" bundle:nil];
   
    [self.navigationController pushViewController:trendingapp animated:nil];
}

@end
