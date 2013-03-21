//
//  AUVNotificationViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 10/10/12.
//
//

#import "AUVNotificationViewController.h"
#import "Three20/Three20.h"
#import "UIImageView+AFNetworking.h"
#import "AUVDevsViewController.h"
#import "AUVQuestionViewController.h"
#import "SVPullToRefresh.h"
#import "AUVCustomTabbar.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVAppWallController.h"
#import "AUVDealsViewController.h"



@interface AUVNotificationViewController ()

@end

@implementation AUVNotificationViewController
@synthesize notifications,type,parent,tableView;


int notificationstart=0;
int notificationflag=0;

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
    //[self.navigationItem setHidesBackButton:YES];
    
   // [super viewWillAppear:animated];
        
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    notifications=[[NSMutableArray alloc] init];
    [(UITableView*)self.tableView addPullToRefreshWithActionHandler:^(void){
        [self performSelector:@selector(loadNotifications) withObject:nil afterDelay:2];
    }];
    
    [self.tableView.pullToRefreshView triggerRefresh];
    self.tableView.pullToRefreshView.lastUpdatedDate = [NSDate date];
    self.title=@"Notifications";
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil];
    // Do any additional setup after loading the view from its nib.
    
    
  
/// tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    // livelyTableView.backgroundColor=[UIColor greenColor];
    
   __unsafe_unretained AUVNotificationViewController *notify=self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
        
        [notify performSelectorOnMainThread:@selector(loadNotifications) withObject:nil waitUntilDone:YES];
        
        [tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];

    
    
    AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
    [custombar.button2 setImage:[UIImage imageNamed:@"notification1.png"] forState:UIControlStateNormal];
    custombar.delegate= self;
    
    [self.view addSubview:custombar];
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


-(void)btnTap:(UIButton*)buttonId

{
    
    for (UIViewController *VC in self.navigationController.viewControllers) {
      
        
    }
    
  
    
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 1) {
        
        AUVAppWallController *notification = [[AUVAppWallController alloc]initWithNibName:@"AUVAppWallController_iPhone" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 2){
        
                
         //NSLog(@"same View");
        
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIImageView *icon;
    //  UILabel *name;
    //UILabel *message;
    TTStyledTextLabel *date;
    // UIWebView *webView;
    //TTStyledText *text;
    TTStyledTextLabel *message;
    
    if(cell!=nil)
    {
        cell=nil;
    }
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        icon=[[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 45, 45)];
       // icon.layer.cornerRadius=10.0f;
       // icon.clipsToBounds=YES;
        //name=[[UILabel alloc] initWithFrame:CGRectMake(52, 2, 228, 22)];
        //webView=[[UIWebView alloc] initWithFrame:cell.frame];
        message=[[TTStyledTextLabel alloc] initWithFrame:CGRectMake(61, 2, 222, 40)];
        message.font=[UIFont systemFontOfSize:13];
        
        message.backgroundColor=[UIColor clearColor];
        //message.text=[NSString stringWithFormat:@"<b></b> is Calling"];
        
        date=[[TTStyledTextLabel alloc] initWithFrame:CGRectMake(250, 40, 70, 22)];
       // date.textAlignment=UITextAlignmentRight;
        date.font=[UIFont systemFontOfSize:11];
        date.textColor=[UIColor grayColor];
        date.backgroundColor=[UIColor clearColor];
        [cell addSubview:message];
        [cell addSubview:date];
        [cell addSubview:icon];
        
    }
    
    if(indexPath.row==notifications.count){
        //NSLog(@"test");
        /* UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
         btn.frame=CGRectMake(5, 5, 120, 40);
         [btn setBackgroundImage:[UIImage imageNamed:@"new_btn.png"] forState:UIControlStateNormal];
         btn.titleLabel.textColor=[UIColor whiteColor];
         [btn setTitle:@"View all notifications" forState:UIControlStateNormal];
         
         [cell addSubview:btn];*/
        
        cell.textLabel.text=@"View more...";
        cell.textLabel.textAlignment=UITextAlignmentCenter;
        
        return cell;
    }
    
    // Configure the cell...
    
    // cell.text=[NSString stringWithFormat:@"%d",indexPath.row];
    // [webView loadHTMLString:[self composeMessageWithUser:[[notifications objectAtIndex:indexPath.row] valueForKey:@"firstname"] andType:[[[notifications objectAtIndex:indexPath.row] valueForKey:@"type"] integerValue]] baseURL:nil];
    else{
        [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[notifications objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] ];
        message.text=[TTStyledText textFromXHTML:[self composeMessageWithUser:[[notifications objectAtIndex:indexPath.row] valueForKey:@"firstname"] andType:[[[notifications objectAtIndex:indexPath.row] valueForKey:@"type"] integerValue] andUserName:[[notifications objectAtIndex:indexPath.row] valueForKey:@"username"] andMessage:[[notifications objectAtIndex:indexPath.row] valueForKey:@"message"]]];
        date.text=[TTStyledText textFromXHTML:[NSString stringWithFormat:@" <span style='alignment:right;'>%@</span>",[[notifications objectAtIndex:indexPath.row] valueForKey:@"date"]]];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //NSLog(@"%@",[notifications objectAtIndex:indexPath.row]);
    if(indexPath.row<notifications.count){
        [self tableSelectLoad:[[[notifications objectAtIndex:indexPath.row] valueForKey:@"type"] integerValue] andId:[[notifications objectAtIndex:indexPath.row] valueForKey:@"value"]];
        
    }
}



-(void)loadNotifications
{
    //NSLog(@"dsds");
    if(notificationflag==0)
    {
        notificationflag=1;
        if(notifications.count==0)
        {
            notificationstart=0;
        }
        else{
            notificationstart=notificationstart+10;
        }
        AUVwebservice *service=[AUVwebservice service];
        service.logging=NO;
        [service notification:self action:@selector(notificationHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:[NSString stringWithFormat:@"%d",notificationstart] offset:@"10"];
    }
}

-(void)notificationHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray *arr=(SoapArray*)value;
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    ////NSLog(@"Notifi : %@",[[result JSONValue] valueForKey:@"notification"]);
    notificationflag=0;
    //[notifications removeAllObjects];
    
    [notifications addObjectsFromArray:[[result JSONValue] valueForKey:@"notification"]];

    [self.tableView reloadData];
    
    [(UITableView*)self.tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:0 forKey:@"badgecount"];
    [defaults synchronize];
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[defaults integerForKey:@"badgecount"]];


    }
}



-(NSString*)composeMessageWithUser:(NSString*)user andType:(NSInteger)ntype andUserName:(NSString*)userName andMessage:(NSString*)msg
{
//    NSString *str;
//    if(user==[NSNull null] )
//    {
//        user=userName;
//    }
//    if(ntype==NUSER_FOLLW)
//    {
//        str=[NSString stringWithFormat:@"<b>%@</b> is following you.",user];
//    }
//    else if(ntype==NQUESTION_FOLLOW)
//    {
//        str=[NSString stringWithFormat:@"<b>%@</b> is following your question.",user];
//    }
//    else if(ntype==NQUESTION_COMMENT)
//    {
//        str=[NSString stringWithFormat:@"<b>%@</b> is commented on your question.",user];
//    }
//    else if(ntype==NAPP_SUGGEST)
//    {
//        str=[NSString stringWithFormat:@"<b>%@</b> is suggested on this app.",user];
//
//    }else if(ntype==NQUESTION_SUGGEST)
//    {
//        str=[NSString stringWithFormat:@"<b>%@</b> is suggested on this question.",user];
//
//    }
//    else if(ntype==NQUESTION_ASK)
//    {
//        str=[NSString stringWithFormat:@"<b>%@</b> is Asked you to comment on this question.",user];
//        
//    }
//    
//    return str;
    
    NSString *str=[NSString stringWithFormat:@"<b>%@</b>%@",user,msg];
    return  str;
}


-(void)tableSelectLoad:(NSInteger)ntype andId:(NSString*)mId
{
    if(ntype==NUSER_FOLLW)
    {
        AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
        profile.userId=mId;
        
        [[self navigationController] pushViewController:profile animated:YES];
        
    }
    else if(ntype==NQUESTION_FOLLOW)
    {
        AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
        question.questionId=[NSString stringWithFormat:@"%@",mId];
        // question.info=[[NSMutableDictionary alloc] initWithDictionary:[tableArray objectAtIndex:indexPath.row]];
        
        
        [[self navigationController] pushViewController:question animated:YES];
        
        
    }
    else if(ntype==NQUESTION_COMMENT)
    {
        AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
       
        
        question.questionId=[NSString stringWithFormat:@"%@",mId];
        // question.info=[[NSMutableDictionary alloc] initWithDictionary:[tableArray objectAtIndex:indexPath.row]];
        
        
        [[self navigationController] pushViewController:question animated:YES];
    }
    else if(ntype==NAPP_SUGGEST)
    {
        
        AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:@"AUVDetailViewController" bundle:nil];
        detailView.appId=mId;
        
        [self.navigationController pushViewController:detailView animated:YES];
    }else if(ntype==NQUESTION_SUGGEST)
    {
        AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
        
         //NSLog(@"id %@",[NSString stringWithFormat:@"%@",mId]);
        
        question.questionId=[NSString stringWithFormat:@"%@",mId];
        // question.info=[[NSMutableDictionary alloc] initWithDictionary:[tableArray objectAtIndex:indexPath.row]];
        
        
        [[self navigationController] pushViewController:question animated:YES];

        
    }else if(ntype==NQUESTION_ASK)
    {
        AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
        
        //NSLog(@"id %@",[NSString stringWithFormat:@"%@",mId]);
        
        question.questionId=[NSString stringWithFormat:@"%@",mId];
                [[self navigationController] pushViewController:question animated:YES];
        
        
    }
    
    
    
}


@end
