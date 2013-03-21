//
//  AUVMyQuestionAnsAnswerViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 13/12/12.
//
//

#import "AUVMyQuestionAnsAnswerViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "AUVQuestionViewController.h"

#import "SVPullToRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "StyledPullableView.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"

@interface AUVMyQuestionAnsAnswerViewController ()

@end

@implementation AUVMyQuestionAnsAnswerViewController

@synthesize tableview,type;

int myquestionstart=0;
int myanswerstart=0;
int myquestionflag=0;
int myanswerflag=0;

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
    
    questionarray=[[NSMutableArray alloc]init];
    answerarray=[[NSMutableArray alloc]init];
    
    tableview=[[UITableView alloc] initWithFrame:container.bounds style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource=self;
   // tableview.separatorStyle=UITableViewCellSeparatorStyleNone;

    
    [container addSubview:tableview];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    self.title=@"My Q & A ";
    
    [segmentedControl addTarget:self
                         action:@selector(action:)
               forControlEvents:UIControlEventValueChanged];
    __unsafe_unretained AUVMyQuestionAnsAnswerViewController *myq=self;
    [self.tableview addInfiniteScrollingWithActionHandler:^{
        
        
        [myq performSelectorOnMainThread:@selector(loadQuestionandAnswer) withObject:nil waitUntilDone:YES];
        
        [tableview.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];

    
    [self loadQuestionandAnswer];
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
        
    }
    /*else if (buttonselect == 2){
        
        AUVNotificationViewController *notification = [[AUVNotificationViewController alloc]initWithNibName:@"AUVNotificationViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        
        AUVQuestionChoiceViewController *notification = [[AUVQuestionChoiceViewController alloc]initWithNibName:@"AUVQuestionChoiceViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }
     */else if (buttonselect == 4){
        
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
-(void)action:(id)sender {
    
    
    if(segmentedControl.selectedSegmentIndex==0){
        
        type=Question;
    }
    else if(segmentedControl.selectedSegmentIndex==1)
    {
        type=Answer;
    }
    if(type==Question)
    {
        if(questionarray.count!=0)
        {
            [self.tableview reloadData];
        }else
        {
            [self loadQuestionandAnswer];
        }
    }else if(type==Answer)
    {
        if (answerarray.count!=0) {
            [self.tableview reloadData];
        }else
        {
            [self loadQuestionandAnswer];
        }
    }

    
}

-(void)loadQuestionandAnswer
{
    if(type==Question)
    {
        if(myquestionflag==0)
        {
            if(questionarray.count==0)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
                myquestionstart=0;
            }
            else
            {
                myquestionstart=myquestionstart+10;
            }
            
            myquestionflag=1;
            [self myQuestion];
           
        }
    }else if(type==Answer)
    {
        if(myanswerflag==0)
        {
            if(answerarray.count==0)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
                myanswerstart=0;
            }
            else
            {
                myanswerstart=myanswerstart+10;
            }
            myanswerflag=1;
            [self myAnswer];
        }
    }
}
-(void)myAnswer
{
    AUVwebservice *service=[AUVwebservice service];
    
    [service get_user_answer:self action:@selector(loadAnswerHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:@"10" offset:[NSString stringWithFormat:@"%d",myanswerstart]];
    
    
}
-(void)loadAnswerHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray* arr = (SoapArray*)value;
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    myanswerflag=0;
    
    for (NSDictionary * dict in [[result JSONValue] valueForKey:@"question_details"]) {
        
        [answerarray addObject:dict];
    }
  
    
    [self.tableview reloadData];
        [SVProgressHUD dismiss];
    }
}


-(void)myQuestion
{
     AUVwebservice *service=[AUVwebservice service];
      
    [service get_user_question:self action:@selector(loadQuestionsHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:@"10" offset:[NSString stringWithFormat:@"%d",myquestionstart]];
}
-(void)loadQuestionsHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray* arr = (SoapArray*)value;
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    myquestionflag=0;

    for (NSDictionary * dict in [[result JSONValue] valueForKey:@"question_details"]) {
        
        [questionarray addObject:dict];
    }
  

 [self.tableview reloadData];
        [SVProgressHUD dismiss];
    }
    
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(type==Question)
    return questionarray.count;
    else if(type==Answer)
        return answerarray.count;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    UILabel *qHeader;
    UILabel *question;
    //UILabel *questiondate;
    UILabel *ans;
    UILabel *loved;
    UILabel *time;
    
    UIImageView *lovedI;
    UIImageView *ansI;
    
    UIImageView *appicon;
    
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
        
        appicon=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 40, 40)];
        
        qHeader=[[UILabel alloc] initWithFrame:CGRectMake(50, 2, 265, 30)];
        qHeader.numberOfLines=1;
        qHeader.font=[UIFont systemFontOfSize:15];
        qHeader.backgroundColor=[UIColor clearColor];
        
        
        question =[[UILabel alloc] initWithFrame:CGRectMake(50, 15, 265, 50)];
        question.numberOfLines=2;
        question.font=[UIFont systemFontOfSize:12];
        question.backgroundColor=[UIColor clearColor];
        
        ansI=[[UIImageView alloc] initWithFrame:CGRectMake(50, 58, 15, 15)];
        [ansI setImage:[UIImage imageNamed:@"wall_com_icon.png"]];
        
        
        ans=[[UILabel alloc] initWithFrame:CGRectMake(68, 57, 30, 15)];
        ans.font=[UIFont systemFontOfSize:10];
        ans.backgroundColor=[UIColor clearColor];
        ans.textColor=[UIColor grayColor];
        
        lovedI=[[UIImageView alloc] initWithFrame:CGRectMake(120, 58, 15, 15)];
        [lovedI setImage:[UIImage imageNamed:@"wall_heart.png"]];
        
        loved=[[UILabel alloc] initWithFrame:CGRectMake(140, 57, 50, 15)];
        loved.font=[UIFont systemFontOfSize:10];
        loved.backgroundColor=[UIColor clearColor];
        loved.textColor=[UIColor grayColor];
        
        
        time=[[UILabel alloc] initWithFrame:CGRectMake(5, 55, 310, 15)];
        time.font=[UIFont systemFontOfSize:10];
        time.backgroundColor=[UIColor clearColor];
        time.textColor=[UIColor grayColor];
        time.textAlignment=UITextAlignmentRight;
        
        
        
        
        [baseView addSubview:qHeader];
        [baseView addSubview:question];
        [baseView addSubview:appicon];
        
        [baseView addSubview:ansI];
        [baseView addSubview:ans];
        // [baseView addSubview:lovedI];
        
        //[baseView addSubview:loved];
        [baseView addSubview:time];
        
        [cell addSubview:baseView];
    }
    
    if(type==Question)
    {
        qHeader.text=[NSString stringWithFormat:@"%@",[[questionarray objectAtIndex:indexPath.row] valueForKey:@"question"]];
        time.text=[NSString stringWithFormat:@"%@",[[questionarray objectAtIndex:indexPath.row] valueForKey:@"added_date"]];
        question.text=[NSString stringWithFormat:@"%@",[[questionarray objectAtIndex:indexPath.row] valueForKey:@"description"]];
        [appicon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[questionarray objectAtIndex:indexPath.row] valueForKey:@"appLogo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        ans.text=[NSString stringWithFormat:@"%@",[[questionarray objectAtIndex:indexPath.row] valueForKey:@"answer_count"]];
        loved.text=[NSString stringWithFormat:@"%@",[[questionarray objectAtIndex:indexPath.row] valueForKey:@"questionlike_count"]];
    }else if(type==Answer)
    {
        qHeader.text=[NSString stringWithFormat:@"%@",[[answerarray objectAtIndex:indexPath.row] valueForKey:@"question"]];
        time.text=[NSString stringWithFormat:@"%@",[[answerarray objectAtIndex:indexPath.row] valueForKey:@"added_date"]];
        question.text=[NSString stringWithFormat:@"%@",[[answerarray objectAtIndex:indexPath.row] valueForKey:@"description"]];
        [appicon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[answerarray objectAtIndex:indexPath.row] valueForKey:@"appLogo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        ans.text=[NSString stringWithFormat:@"%@",[[answerarray objectAtIndex:indexPath.row] valueForKey:@"answer_count"]];
        loved.text=[NSString stringWithFormat:@"%@",[[answerarray objectAtIndex:indexPath.row] valueForKey:@"questionlike_count"]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
    if(type==Question)
    {
        question.questionId=[NSString stringWithFormat:@"%@",[[questionarray objectAtIndex:indexPath.row] valueForKey:@"question_id"]];
    }else if(type==Answer)
    {
         question.questionId=[NSString stringWithFormat:@"%@",[[answerarray objectAtIndex:indexPath.row] valueForKey:@"question_id"]];
    }
    
    [self.navigationController pushViewController:question animated:YES];
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



@end
