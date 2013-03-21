//
//  AUVCreditsViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 23/10/12.
//
//

#import "AUVCreditsViewController.h"
#import "DAKeyboardControl.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "UIImageView+AFNetworking.h"
#import "AUVQuestionViewController.h"
#import "AUVAnswerViewController.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"

#import "SVPullToRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "StyledPullableView.h"

@interface AUVCreditsViewController ()

@end

@implementation AUVCreditsViewController;
@synthesize tableArray,creditTableView;


int creditstart=0;
int creditflag=0;

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
    creditTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBarHidden=NO;
   // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.title=@"Your Credits";
    //tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
    __unsafe_unretained AUVCreditsViewController *credit=self;
    
    
    [self.creditTableView addInfiniteScrollingWithActionHandler:^{
        
        [credit performSelectorOnMainThread:@selector(loadCredits) withObject:nil waitUntilDone:YES];
        
        [creditTableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];

    
    
    [self loadCredits];
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

-(void)loadCredits
{
    if (creditflag==0)
    {
        creditflag=1;
    
        if(tableArray.count==0)
        {
            creditstart=0;
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        }else
        {
            creditstart=creditstart+10;
        }
    
        AUVwebservice *service=[AUVwebservice service];
        [service credit_transactions:self action:@selector(loadCreditHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:@"10" offset:[NSString stringWithFormat:@"%d",creditstart]];
    }
}
    
-(void)loadCreditHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    

    else{
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];

    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];

    for (NSDictionary * dict in [[result JSONValue] valueForKey:@"transaction_details"])
    {
       [tableArray addObject:dict];
    }
    
    creditflag=0;
    
    [creditTableView  reloadData];
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
    
    
    UILabel *credit;
    UILabel *message1;
     UILabel *message2;
    UILabel *time;
    UIView *baseView;
    UIImageView *icon;
    
	if(cell !=nil){
		cell=nil;
	}
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        
        cell.backgroundColor=[UIColor clearColor];
        baseView=[[UIView alloc] initWithFrame:cell.frame];
        
        baseView.backgroundColor=[UIColor clearColor];
        
        message1 =[[UILabel alloc] initWithFrame:CGRectMake(58, 5, 258, 15)];
        message1.numberOfLines=1;
        message1.font=[UIFont systemFontOfSize:13];
        message1.backgroundColor=[UIColor clearColor];
        
        message2 =[[UILabel alloc] initWithFrame:CGRectMake(58, 11, 258, 45)];
        message2.numberOfLines=3;
        message2.font=[UIFont systemFontOfSize:14];
        message2.textColor=[UIColor blueColor];
        message2.backgroundColor=[UIColor clearColor];
        
        icon=[[UIImageView alloc] initWithFrame:CGRectMake(4, 2, 48, 54)];
        icon.layer.cornerRadius=10;
        icon.clipsToBounds=YES;
        
        time=[[UILabel alloc] initWithFrame:CGRectMake(4, 60, 310, 25)];
        time.font=[UIFont systemFontOfSize:10];
        time.backgroundColor=[UIColor clearColor];
        time.textColor=[UIColor grayColor];
        time.textAlignment=UITextAlignmentRight;
        
        
        
        UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, 2)];
        line.image=[UIImage imageNamed:@"seprater"];
        
        credit =[[UILabel alloc] initWithFrame:CGRectMake(300, 25, 25, 20)];
        credit.numberOfLines=1;
        credit.font=[UIFont systemFontOfSize:13];
        credit.backgroundColor=[UIColor clearColor];
        
                
        [baseView addSubview:credit];
      
        [baseView addSubview:icon];
        [baseView addSubview:message1];
        [baseView addSubview:message2];
        [baseView addSubview:time];
        [baseView addSubview:line];
        [cell addSubview:baseView];
    }
    
   
       
   // NSString* day = [foo objectAtIndex: 0];
    
   
    
    
    time.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"datetime"];
    
    NSString *minusorplus=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"transaction_type"];
   
    if([minusorplus isEqualToString:@"1"])
    {
       credit.text=@"+";
       
    }
    else
    {
         credit.text=@"-";
       

    }
    
    if ([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"type_id"] isEqualToString:@"1"]) {
        message1.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"message1"];
    }else
    {
        
        message1.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"message1"];
        
        message2.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"message2"];
    }
   
    
    credit.text=[credit.text stringByAppendingString:[[tableArray objectAtIndex:indexPath.row] valueForKey:@"points"]];
    
    [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
    totalcreditsLabel.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"total_credits"];
    
    return cell;
    
}




/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(![[[tableArray objectAtIndex:indexPath.row] valueForKey:@"question_id"] isEqualToString:@"0"])
    {
      AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
     question.questionId=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"question_id"]];
     question.info=[[NSMutableDictionary alloc] initWithDictionary:[tableArray objectAtIndex:indexPath.row]];
     
     [self.navigationController pushViewController:question animated:YES];
    }
     
     
}


-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    return 90;
}

@end
