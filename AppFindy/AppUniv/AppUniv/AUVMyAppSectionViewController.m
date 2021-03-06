//
//  AUVMyAppSectionViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/11/12.
//
//

#import "AUVMyAppSectionViewController.h"
#import "Soap.h"
#import "SoapArray.h"
#import "AUVwebservice.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "AUVLogin.h"
#import "AUVValidation.h"
#import "AUVConstants.h"
#import "AUVDetailViewController.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"

@interface AUVMyAppSectionViewController ()

@end

@implementation AUVMyAppSectionViewController
@synthesize myappspageposition;

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
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBarHidden=NO;
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.title=@"Share Your Apps";
    //tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    if([myappspageposition isEqualToString:@"menu"])
    {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    }
    [self getMyappsdetail];

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
        
    }/*else if (buttonselect == 2){
        
        AUVNotificationViewController *notification = [[AUVNotificationViewController alloc]initWithNibName:@"AUVNotificationViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        
        AUVQuestionChoiceViewController *notification = [[AUVQuestionChoiceViewController alloc]initWithNibName:@"AUVQuestionChoiceViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }*/else if (buttonselect == 4){
        
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

-(IBAction)getMyappList:(id)sender
{
    [SVProgressHUD showWithStatus:@"Detecting your apps"];
    [self updateAppsList];
    
    
    
}

-(void)updateAppsList
{
    appEngine = [[iHasApp alloc] initWithDelegate:self andKey:@"TXTZQT36TZEK"];
    appEngine.country = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    [self detectApps];
    
}




#pragma mark - iHasApp methods

- (void)detectApps
{
    
    [appEngine beginDetection];
    
    //NSLog(@"appDetectionDidBegin");
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

- (void)appDetectionDidSucceed:(NSArray *)appsDetected
{
    //NSLog(@"appDetectionDidSucceed:");
    detectedApps = appsDetected;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    //NSLog(@"%@",detectedApps);
    //NSMutableArray *appArray=[[NSMutableArray alloc] initWithCapacity:detectedApps.count];
    NSMutableString *apps=[[NSMutableString alloc] init];
    for(int i=0;i<detectedApps.count;i++)
    {
        // [appArray addObject:[[detectedApps objectAtIndex:i] valueForKey:@"artistId"]];
        [apps appendFormat:@"%@,",[[detectedApps objectAtIndex:i] valueForKey:@"trackId"]];
    }
    
    [apps deleteCharactersInRange:NSMakeRange([apps length]-1, 1)];
    
    [self uploadMyAppsDetails:apps];
    
    //[self.tableView reloadData];
}

- (void)appDetectionDidFail:(iHasAppError)detectionError
{
    //NSLog(@"appDetectionDidFail:");
    detectedApps = [NSArray array];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *error;
    switch (detectionError)
    {
        case iHasAppErrorUnknown:
            error = @"iHasAppError: Unknown";
            break;
        case iHasAppErrorConnection:
            error = @"iHasAppError: Connection";
            break;
        case iHasAppErrorInvalidKey:
            error = @"iHasAppError: InvalidKey";
            break;
        case iHasAppErrorReachedLimit:
            error = @"iHasAppError: ReachedLimit";
            break;
            
        default:
            break;
    }
    
    [SVProgressHUD showErrorWithStatus:error];
}



-(void)uploadMyAppsDetails:(NSString*)apps
{
    AUVwebservice *service=[AUVwebservice service];
    
    service.logging=NO;
    
    [service myapps:self action:@selector(Uploadhandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:apps type:@"2"];
}

-(void)Uploadhandler:(id)value
{
    
    SoapArray *arr=(SoapArray*)value;
    
    //NSLog(@"Arr : %@",arr);
    
    
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else
    [self getMyappsdetail];
    
}

-(void)getMyappsdetail
{

    AUVwebservice *service=[AUVwebservice service];
    
    [service get_myapps_details:self action:@selector(loadMyAppsHandler:) user_id:[AUVLogin valueforKey:@"user_id"]];
}
-(void)loadMyAppsHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray* arr = (SoapArray*)value;
    
    
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    myappslist=[[NSMutableArray alloc]init];
    
   
    [myappslist addObjectsFromArray:[[result JSONValue] valueForKey:@"app_deatails"]];
    
    //NSLog(@"%@",myappslist);
    
 
    if(myappslist.count!=0)
    {
        NSString *text=@"We have identified ";
        text=[text stringByAppendingFormat:@"%d",myappslist.count];
        text=[text stringByAppendingFormat:@" of your apps"];
        myappscount.text=text;
        [myappstableview reloadData];

    }
        [SVProgressHUD dismiss];
    }
    
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return myappslist.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    
       UIImageView *appicon;
       UILabel *appname;
       UILabel *appprice;
       UILabel *appratingcount;
       UIImageView *arrowicon;
       UIImageView *lineicon;
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
        
        appicon=[[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 64, 65)];
        appicon.layer.cornerRadius=10;
        appicon.layer.borderWidth=1.0f;
        appicon.clipsToBounds=YES;
        
        appname =[[UILabel alloc] initWithFrame:CGRectMake(79, 13, 215, 21)];;
        appname.numberOfLines=1;
        appname.font=[UIFont systemFontOfSize:13];
        appname.backgroundColor=[UIColor clearColor];
        
        appprice =[[UILabel alloc] initWithFrame:CGRectMake(79, 32, 145, 21)];
        appprice.numberOfLines=1;
        appprice.font=[UIFont systemFontOfSize:12];
        appprice.textColor=[UIColor clearColor];
        appprice.backgroundColor=[UIColor clearColor];
        
        appratingcount=[[UILabel alloc] initWithFrame:CGRectMake(81, 51, 150, 24)];
        appratingcount.font=[UIFont systemFontOfSize:12];
        appratingcount.backgroundColor=[UIColor clearColor];
        appratingcount.textColor=[UIColor clearColor];
       

        lineicon=[[UIImageView alloc] initWithFrame:CGRectMake(0, 83, 320, 2)];
        lineicon.image=[UIImage imageNamed:@"seprater.png"];
        
        arrowicon=[[UIImageView alloc] initWithFrame:CGRectMake(280, 29, 20, 20)];
        arrowicon.image=[UIImage imageNamed:@"bluearrow.png"];

    
        [baseView addSubview:appicon];
        
        [baseView addSubview:appname];
        [baseView addSubview:appprice];
        [baseView addSubview:appratingcount];
        //[baseView addSubview:lineicon];
        [baseView addSubview:arrowicon];
        [cell addSubview:baseView];
    }
    
    
    
    // NSString* day = [foo objectAtIndex: 0];
    
    

    
    
    
    appname.text=[[myappslist objectAtIndex:indexPath.row] valueForKey:@"appname"];
    appprice.text=[[myappslist objectAtIndex:indexPath.row] valueForKey:@"formattedPrice"];

    //NSString *rate=
    //rate=[rate stringByAppendingFormat:@" Rating"];
        
    appratingcount.text=[[myappslist objectAtIndex:indexPath.row] valueForKey:@"userRatingCount"];
    
   // //NSLog(@"%@",[[myappslist objectAtIndex:indexPath.row] valueForKey:@"userRatingCount"]);
    
    [appicon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[myappslist objectAtIndex:indexPath.row] valueForKey:@"applogo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
        return cell;

}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
        NSString *nibName;
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            nibName=@"AUVDetailViewController";
        }
        else {
            nibName=@"AUVDetailViewController_iPad";
        }
        AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:nibName bundle:nil];
        detailView.appId=[[myappslist objectAtIndex:indexPath.row] valueForKey:@"appid"];
            [self.navigationController pushViewController:detailView animated:YES];
  
}



-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
            
    return 90;
    
}


@end
