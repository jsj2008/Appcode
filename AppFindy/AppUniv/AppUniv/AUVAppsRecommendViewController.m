//
//  AUVAppsRecommendViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 15/11/12.
//
//

#import "AUVAppsRecommendViewController.h"
#import "DAKeyboardControl.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "UIImageView+AFNetworking.h"
#import "AUVQuestionViewController.h"
#import "AUVAnswerViewController.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "AUVDetailViewController.h"
#import "SVPullToRefresh.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"
#import "ASSignViewController.h"
#import "AUVScrollTabBar.h"
#import "AUVHelpViewController.h"

@interface AUVAppsRecommendViewController ()

@end

@implementation AUVAppsRecommendViewController
@synthesize tableArray;
@synthesize recommenedpageposition;
int page;
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
    
    tableArray=[[NSMutableArray alloc] init];
    appsrecommends.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.navigationController.navigationBarHidden=NO;
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.title=@"Recommended App";
    //tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    if([recommenedpageposition isEqualToString:@"menu"])
    {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    }
    [self loadAppRecommend];

    __unsafe_unretained AUVAppsRecommendViewController *rec = self;
    [appsrecommends addInfiniteScrollingWithActionHandler:^{
        
        
        [self performSelectorOnMainThread:@selector(loadAppRecommend) withObject:nil waitUntilDone:NO];
        
        [appsrecommends.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:10];
    }];
    
    
    AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 360, 320, 104)];
    [custombar.button2 setImage:[UIImage imageNamed:@"tab_search.png"] forState:UIControlStateNormal];
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
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
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


-(void)loadAppRecommend
{
    
    if(tableArray.count==0)
    {
        page=0;
    }
    else
    {
        page+=10;
    }
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    [service apps_recommend:self action:@selector(loadAppRecommendHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:@"10" offset:[NSString stringWithFormat:@"%d",page]];
}

-(void)loadAppRecommendHandler:(id)value
{
    
    // Handle errors
	if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}

    else{
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    //NSLog(@"arr %@",arr);
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //NSLog(@"result : %@",[result JSONValue]);
    
   // [tableArray removeAllObjects];
    
    
    for (NSDictionary * dict in [[result JSONValue]valueForKey:@"app_details"]) {
        
        
        [tableArray addObject:dict];
    }
    
    //NSLog(@"Count : %d",[tableArray count]);
    
    [SVProgressHUD dismiss];
   [appsrecommends  reloadData];
    }
    
}
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    UILabel *appname;
    UILabel *price;
    UIImageView *icon;
    UIView *baseView;
    
	if(cell !=nil){
		cell=nil;
	}
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        
        cell.backgroundColor=[UIColor clearColor];
        baseView=[[UIView alloc] initWithFrame:cell.frame];
        
        baseView.backgroundColor=[UIColor clearColor];
        
        appname =[[UILabel alloc] initWithFrame:CGRectMake(80, 5, 258, 15)];
        appname.numberOfLines=2;
        appname.font=[UIFont systemFontOfSize:13];
        appname.backgroundColor=[UIColor clearColor];
        
        price =[[UILabel alloc] initWithFrame:CGRectMake(80, 30, 200, 20)];
        price.numberOfLines=1;
        price.font=[UIFont systemFontOfSize:12];
        price.textColor=[UIColor grayColor];
        price.backgroundColor=[UIColor clearColor];
        
        icon=[[UIImageView alloc] initWithFrame:CGRectMake(8, 2, 64, 65)];
        //icon.layer.cornerRadius=10;
        icon.clipsToBounds=YES;
        
                
        UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 2)];
        line.image=[UIImage imageNamed:@"seprater"];
        
        
        [icon.layer setBorderWidth:1.0f];
        icon.layer.cornerRadius=10.0f;
        
        UIImageView *arrow=[[UIImageView alloc] initWithFrame:CGRectMake(300, 20, 20, 20)];
        arrow.image=[UIImage imageNamed:@"bluearrow.png"];
        
        
        
        [baseView addSubview:icon];
        [baseView addSubview:appname];
        [baseView addSubview:price];
        [baseView addSubview:line];
        [baseView addSubview:arrow];
        [cell addSubview:baseView];
    }
    
    
    
    // NSString* day = [foo objectAtIndex: 0];
    
    
    
    
    appname.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"appName"];
    price.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"price"];

    
    [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"appLogo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
    // totalcreditsLabel.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"total_credits"];
    
    return cell;
}




/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:@"AUVDetailViewController" bundle:nil];
    detailView.appId=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"appId"];
    [self.navigationController pushViewController:detailView animated:YES];
    
}


-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    return 72;
}



@end
