//
//  AUVDealsViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 15/11/12.
//
//

#import "AUVDealsViewController.h"
#import "DAKeyboardControl.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "UIImageView+AFNetworking.h"
#import "AUVQuestionViewController.h"
#import "AUVAnswerViewController.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "AUVDetailViewController.h"
#import "StrikeLabel.h"
#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVAddQuestionViewController.h"
#import "AUVNotificationViewController.h"
#import "AUVSearchViewController.h"
#import "AUVQuestionSearchViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVHelpViewController.h"
#import "AUVScrollTabBar.h"
#import "AUVwallcontrollerViewController.h"

@interface AUVDealsViewController (){
    UILabel *appname;
    StrikeLabel *oldprice;
    UILabel *dealprice;
    UIImageView *icon;
    UIView *baseView;
}

@end

@implementation AUVDealsViewController
@synthesize tableArray;
@synthesize pageposition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *settingsBtn =[[UIBarButtonItem alloc] initWithTitle:@"settings" style:UIBarButtonItemStyleBordered target:self action:@selector(Settingspage)];
        self.navigationItem.rightBarButtonItem = settingsBtn;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    tableArray=[[NSMutableArray alloc] init];
    dealsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.navigationController.navigationBarHidden=NO;
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.title=@"Today's Deals";
//    self.navigationItem.backBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:@"Back"
//                                     style:UIBarButtonItemStyleBordered
//                                    target:nil
//                                    action:nil];
//    if([pageposition isEqualToString:@"menu"])
//    {
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
//    }
//    else{
//      
//    }
    
        AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 360, 320, 104)];
        [custombar.button3 setImage:[UIImage imageNamed:@"deals1.png"] forState:UIControlStateNormal];
        custombar.delegate= self;
        [self.view addSubview:custombar];
    
    [self loadDeals];

}
-(void)Settingspage{
    
    AUVHelpViewController *help=[[AUVHelpViewController alloc]initWithNibName:@"AUVHelpViewController" bundle:nil];
    [self.navigationController pushViewController:help animated:YES];

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
-(void)addQuestion:(id)sender
{
    if ([sender tag] == 2)
    {
        //NSLog(@"%@",@"Category");
        
        AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc] initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
        obj.questiontype=@"category";
        
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if ([sender tag] == 1)
    {
        //NSLog(@"%@",@"App");
        
        AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc] initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
        obj.questiontype=@"app";
        
        [self.navigationController pushViewController:obj animated:YES];
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    
    AUVQuestionSearchViewController *searchView=[[AUVQuestionSearchViewController alloc] initWithNibName:@"AUVQuestionSearchViewController" bundle:nil];
    
    [self.navigationController pushViewController:searchView animated:YES];
    return NO;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar*)searchBar
{
    //[searchController setActive:NO];
    return YES;
}
-(void)btnTap:(UIButton*)buttonId

{
    //NSLog(@"bbb %d",buttonId.tag);
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 1) {
        
        AUVwallcontrollerViewController *notification = [[AUVwallcontrollerViewController alloc]initWithNibName:@"AUVwallcontrollerViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 2){
        
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        
        
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

-(void)loadDeals
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    service.logging = YES;
    
    [service deals:self action:@selector(loadDealsHandler:)];
    
}

-(void)loadDealsHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    

    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    NSLog(@"arr %@",arr);
    
        NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSLog(@"result : %@",[result JSONValue]);
        
        [tableArray removeAllObjects];
        
        
        for (NSDictionary * dict in [result JSONValue]) {
            
            
            [tableArray addObject:dict];
        }
    
   [dealsTableView  reloadData];
        
        [SVProgressHUD dismiss];

    }
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableArray.count;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 75.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
   
    
	if(cell !=nil){
		cell=nil;
	}
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.backgroundColor=[UIColor clearColor];
        
        baseView=[[UIView alloc] initWithFrame:cell.frame];
        
        baseView.backgroundColor=[UIColor clearColor];
        icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 64, 65)];
        icon.layer.cornerRadius=10;
        icon.clipsToBounds=YES;
        [icon.layer setBorderWidth:1.0f];
        
        appname =[[UILabel alloc] initWithFrame:CGRectMake(85, 5, 258, 15)];
        appname.numberOfLines=1;
        appname.font=[UIFont systemFontOfSize:15];
        appname.backgroundColor=[UIColor clearColor];
        
        oldprice =[[StrikeLabel alloc] initWithFrame:CGRectMake(85, 30, 50, 15)];
        oldprice.numberOfLines=1;
        oldprice.font=[UIFont systemFontOfSize:12];
        oldprice.textColor=[UIColor blackColor];
        oldprice.backgroundColor=[UIColor clearColor];
        
        dealprice=[[UILabel alloc] initWithFrame:CGRectMake(85, 50, 50, 15)];
        dealprice.font=[UIFont systemFontOfSize:12];
        dealprice.backgroundColor=[UIColor clearColor];
        dealprice.textColor=[UIColor blackColor];
        
        UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, 75, 320, 2)];
        line.image=[UIImage imageNamed:@"seprater"];
               
        UIImageView *arrow=[[UIImageView alloc] initWithFrame:CGRectMake(300, 35, 20, 20)];
        arrow.image=[UIImage imageNamed:@"bluearrow.png"];
        
        appname.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"title"];
        oldprice.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"price"];
        dealprice.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"offer_price"];
        
        [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
//        int k=150;
//        float total =[[[tableArray objectAtIndex:indexPath.row] valueForKey:@"starrating"] floatValue];
//        int result =(int)ceilf(total);
//         NSLog(@"tofal %2f value of result %d",total,result);
//        for (int j=0; j<result;j++)
//        {
//            UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button5 addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
//            button5.tag = 6;
//            [button5 setImage:Rating_full forState:UIControlStateNormal];
//            button5.frame = CGRectMake((j*20)+k , 35, 20, 20);
//            [cell addSubview:button5];
//            k=10+k;
//        }
//        int l=150;
//        for (int p=0; p<5; p++)
//        {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
//            button.tag =p;
//            [button setImage:Rating_empty forState:UIControlStateNormal];
//            button.frame = CGRectMake((p*20)+l, 35, 20, 20);
//            [cell addSubview:button];
//            l=10+l;
//        }


        
        
        [baseView addSubview:icon];
        [baseView addSubview:appname];
        [baseView addSubview:oldprice];
        [baseView addSubview:dealprice];
        [baseView addSubview:line];
        [baseView addSubview:arrow];
        [cell addSubview:baseView];
    }
    
    return cell;
    
}




-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:@"AUVDetailViewController" bundle:nil];
    detailView.appId=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"trackid"];
    [self.navigationController pushViewController:detailView animated:YES];

}




@end
