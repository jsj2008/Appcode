//
//  AUVQuestionViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/09/12.
//
//

#import "AUVQuestionViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UILabel+MultiLineAutoSize.h"
#import "AUVAnswerViewController.h"
#import "AUVwebservice.h"
#import "AUVLogin.h"
#import "JSON.h"
#import "SVProgressHUD.h"
#import "AUVAppWallController.h"
#import "AUVDevsViewController.h"
#import "AUVSuggestAppController.h"
#import "UILabel+MultiLineAutoSize.h"

#import "SVPullToRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "StyledPullableView.h"
#import "AUVAskViewController.h"
#import "AUVQuestionChoiceViewController.h"
@interface AUVQuestionViewController ()

@end

@implementation AUVQuestionViewController
@synthesize questionId,info,tableArray,follow,answerTable,newlyadded;

Facebook *fb;

NSString *userid;
NSString *appid;
NSString *categoryid;
NSString *iconValue;
int *position;

int start=0;



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
    //icon.layer.cornerRadius=10.0f;
    icon.clipsToBounds=YES;
    tableArray=[[NSMutableArray alloc] init];
    answerTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [infoview setBackgroundColor:[UIColor clearColor]];
    
    self.title=@"Discussion";
    
    [super viewDidLoad];
    
   // [self setup];
    
    // Do any additional setup after loading the view from its nib.
    
    
       // livelyTableView.backgroundColor=[UIColor greenColor];
    __unsafe_unretained AUVQuestionViewController *qv=self;
    [self.answerTable addInfiniteScrollingWithActionHandler:^{
        
        
        [qv performSelectorOnMainThread:@selector(loadAnswers) withObject:nil waitUntilDone:YES];
        
        [answerTable.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];

    UIBarButtonItem *back =[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackPage:)];
    
    self.navigationItem.leftBarButtonItem=back;

    addans.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
    addans.layer.cornerRadius=5.0f;
    
    
    suggestbutton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
    suggestbutton.layer.cornerRadius=5.0f;
    
    if (IS_IPHONE_5) {
        
        bottomview.frame=CGRectMake(bottomview.frame.origin.x, bottomview.frame.origin.y+90, bottomview.frame.size.width,bottomview.frame.size.height);
        
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadAnswers];
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
    [super viewDidDisappear:animated];
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


-(void)setup
{
    
    //[self setupfollow:nil];
}

-(IBAction)suggestquestion:(id)sender
{
    
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    position=2;
    
    /*AUVSuggestAppController *suggest=[[AUVSuggestAppController alloc] initWithFrame:self.view.bounds];
    
    
    suggest.delegate=self;
    suggest.appid=questionId;
    suggest.type=@"1";
    [self.view addSubview:suggest];
    
    [suggest showFromPoint:[sender center]];*/
    
    AUVAskViewController *ask=[[AUVAskViewController alloc]initWithNibName:@"AUVAskViewController" bundle:nil];
    ask.questionid=questionId;
    [self.navigationController pushViewController:ask animated:YES];
    

}

-(IBAction)addAnswer
{
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    
    position=1;
    AUVAnswerViewController *panel=[[AUVAnswerViewController alloc] initWithFrame:self.view.bounds];
    panel.delegate=self;
    panel.questionId=questionId;
    panel.questionView=self;
    [self.view addSubview:panel];
    [panel showFromPoint:[self.view center]];
}

-(IBAction)shareQuestion
{
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Wall",nil];
    
    actionSheet.actionSheetStyle=UIActionSheetStyleAutomatic;
    
    [actionSheet showInView:self.view];

}
-(IBAction)homePage
{
    
    if(![AUVLogin isAccessAllowed])
    {
        //AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        //[self.navigationController pushViewController:notification animated:YES];

        
        [self GoaToSignInPage];
        return;
    }else
    {
    
    
     AUVAppWallController *home = [[AUVAppWallController alloc]initWithNibName:@"AUVAppWallController_iPhone" bundle:nil];
    
     [self.navigationController pushViewController:home animated:YES];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self loadFB];
        
    } else if (buttonIndex == 1) {
        [self loadWall];
        //NSLog(@"Wall");
        
    } else if (buttonIndex == 2) {
        
    }
}
-(void)loadWall
{
    
    AUVwebservice *service=[AUVwebservice service];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    service.logging=NO;
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    [service wall_question_share:self action:@selector(loadWallHandler:) user_id:[prefs valueForKey:@"user_id"] question_id:questionId];
    
   // [service appshare:self action:@selector(loadWallHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:appId];
    
}


-(void)loadWallHandler:(id)value
{
    
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
	// Do something with the Array* result
   // SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    
   // NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    }
    //NSLog(@"Res : %@",[result JSONValue]);
    
       
}

-(void)sharebtn{
    
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    
    
    //    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    //   NSString *strj= [defaultstd objectForKey:AUVFBACCESSTOKENKEY];
    //    //NSLog(@"string val %@",strj);
    /* NSString *str = https://graph.facebook.com/me/feed?access_token=AAAAAAITEghMBAIZBrGS5jmunXOoSZCR4P0tr0sSqIuZBp6P7x7V3xXnpP0lpFmCXMkTPvyWjHij3H45Q8Yc8WwA5TM5k2MAh7ers9CmLksGqPZCmF56u */
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   questiontitle.text, @"name",
                                  [NSString stringWithFormat:@"http://appfindee.com/en/index.php/question/home/index/%@",questionId], @"link", iconValue, @"picture",
                                   nil];
    
    
    // Invoke the dialog
    [fb dialog:@"feed" andParams:params andDelegate:self];
    //NSLog(@"params %@",params);
    
    
}
-(void)loadFB
{
    fb=  [AUV_DELEGATE facebook];
    //fbFriends=[[NSMutableArray alloc] init];
    //auvFriends=[[NSMutableArray alloc] init];
    [SVProgressHUD dismiss];
    if(!fb.isSessionValid)
    {
        fb=[[Facebook alloc] initWithAppId:AUVFB_APPID andDelegate:self];
        [fb authorize:[AUV_DELEGATE fbPermission]];
        
        [AUV_DELEGATE setFacebook:fb];
    }
   
    else
        [self sharebtn];
    
    
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[fb accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[fb expirationDate] forKey:@"FBExpirationDateKey"];
    
    // NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small,is_app_user FROM user WHERE  uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(is_app_user,first_name,last_name) asc"];
    
    /*  NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small FROM user WHERE is_app_user = 1 AND uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(first_name,last_name) asc"];
     */
    [defaults synchronize];
    
    [self sharebtn];
    
    /* if(self.type==AUVInviteFBFriends)
     [self InviteFBFriends];
     else
     [self loadFBFriends];*/
}

#pragma FBRequestDelegate Methods


- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"res");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    //NSLog(@"Err : %@",[error localizedDescription]);
    [SVProgressHUD dismiss];
    
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    //NSLog(@"response : %@",result);
    
    
//    NSPredicate *predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
//        
//        
//        return  [[(NSDictionary*)obj  valueForKey:@"is_app_user"] intValue]==1 ;
//    }];
//    
//    NSPredicate *predicate2=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
//        
//        
//        return  [[(NSDictionary*)obj  valueForKey:@"is_app_user"] intValue]==0 ;
//    }];
//    
    
    
    //NSArray *usersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate];
    //NSArray *nonusersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate2];
    
    
    //    if([usersofApp isKindOfClass:[NSArray class]]){
    //        [auvFriends addObjectsFromArray:usersofApp];
    //    }
    //    else [auvFriends addObject:usersofApp];
    //    if([nonusersofApp isKindOfClass:[NSArray class]])
    //        [fbFriends addObjectsFromArray:nonusersofApp];
    //    else [fbFriends addObject:nonusersofApp];
    
    ////NSLog(@"Users Of App  :  %@",usersofApp);
    // NSMutableArray *array=[NSMutableArray arrayWithArray:result];
    /* [dataArray removeAllObjects];
     [tableArray removeAllObjects];
     if(self.type==AUVInviteFBFriends) {
     for(NSDictionary *dict in nonusersofApp)
     {
     NSDictionary *dt=[NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"name"],@"username",[dict valueForKey:@"pic_small"],@"usericon",[dict valueForKey:@"uid"],@"uid",nil];
     
     [dataArray addObject:dt];
     
     
     
     
     }
     //[dataArray addObjectsFromArray:fbFriends];
     [tableArray addObjectsFromArray:dataArray];
     [SVProgressHUD dismiss];
     [friendsTable reloadData];
     
     }
     else{
     for(NSDictionary *dict in usersofApp)
     {
     // NSDictionary *dt=[NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"name"],@"username",[dict valueForKey:@"pic_small"],@"usericon",[dict valueForKey:@"uid"],@"uid",nil];
     
     [auvFriends addObject:[dict valueForKey:@"uid"]];
     
     
     
     }
     
     [self fbLoadAUVContacts];
     
     }*/
    
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data
{
    
}



#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(indexPath.row!=0){
        
    UILabel *name;
    UILabel *vote;
    UILabel *comment;
    UILabel *time;
    UIView *baseView;
    UIImageView *icon;
	UIButton *up;
    UIButton *down;
        UIImageView *line;
	if(cell !=nil){
		cell=nil;
	}
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        
        cell.backgroundColor=[UIColor clearColor];
        baseView=[[UIView alloc] initWithFrame:CGRectMake(0,0,320,105)];
        
        baseView.backgroundColor=[UIColor clearColor];
        
        name=[[UILabel alloc] initWithFrame:CGRectMake(65, 10, 250, 23)];
        name.textColor=[UIColor blueColor];
        name.font=[UIFont systemFontOfSize:12];
        
        name.backgroundColor=[UIColor clearColor];
        comment =[[UILabel alloc] initWithFrame:CGRectMake(5, 65, 310, 10)];
        //comment.numberOfLines=2;
        comment.font=[UIFont systemFontOfSize:13];
        comment.backgroundColor=[UIColor clearColor];
       
        
        icon=[[UIImageView alloc] initWithFrame:CGRectMake(4, 2, 40, 40)];
       // icon.layer.cornerRadius=10;
        icon.clipsToBounds=YES;
        time=[[UILabel alloc] initWithFrame:CGRectMake(4, 60, 310, 25)];
        time.font=[UIFont systemFontOfSize:10];
        time.backgroundColor=[UIColor clearColor];
        time.textColor=[UIColor grayColor];
        time.textAlignment=UITextAlignmentRight;
        
        
        
        line=[[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, 2)];
        line.image=[UIImage imageNamed:@"seprater"];
        
        up=[UIButton buttonWithType:UIButtonTypeCustom];
        [up setImage:[UIImage imageNamed:@"up1"] forState:UIControlStateNormal];
        
        up.showsTouchWhenHighlighted = YES;
       up.frame=CGRectMake(290, 5, 25, 20);
                [up addTarget:self action:@selector(Upaction:) forControlEvents:UIControlEventTouchUpInside];
    
     
    
        vote =[[UILabel alloc] initWithFrame:CGRectMake(300, 20, 25, 20)];
        vote.numberOfLines=1;
        vote.font=[UIFont systemFontOfSize:13];
        vote.backgroundColor=[UIColor clearColor];
        
       down=[UIButton buttonWithType:UIButtonTypeCustom];
        [down setImage:[UIImage imageNamed:@"down1"] forState:UIControlStateNormal];
        
        down.showsTouchWhenHighlighted = YES;
        down.frame=CGRectMake(290, 35, 25, 20);
     
        [down addTarget:self action:@selector(Downaction:) forControlEvents:UIControlEventTouchUpInside];
    
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [baseView addSubview:vote];
        [baseView addSubview:down];
        [baseView addSubview:up];
        [baseView addSubview:name];
        [baseView addSubview:icon];
        [baseView addSubview:comment];
        [baseView addSubview:time];
        [baseView addSubview:line];
        
        
        
        
    }
    //
    //cell.backgroundColor=[UIColor redColor];
    //    CALayer *layer = cell.layer;
    //    layer.borderColor = [[UIColor blackColor] CGColor];
    //    layer.borderWidth = 1.0f;
    //    //layer.cornerRadius = 20.0f;
    //    cell.layer.cornerRadius=10;
    //    cell.layer.shadowRadius=10.0f;
    //
    
    // NSDictionary *tableDict=[tableArray objectAtIndex:indexPath.row];
   //  //NSLog(@"Table dict : %@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"answer_id"]);
    
    up.tag=[[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"answer_id"]integerValue];
     down.tag=[[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"answer_id"]integerValue];

    //NSLog(@"Vote : %@",[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"vote"]);
    vote.text=[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"vote"];

        
    if([[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"user_id"]count]!=0)
    {
        
    name.text=@"By ";
    
    name.text=[name.text stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"%@",[[[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"user_id"] objectAtIndex:0] valueForKey:@"firstname"]]];
    
    
    name.tag=[[[[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"user_id"] objectAtIndex:0] valueForKey:@"user_id"] integerValue];
    [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"user_id"] objectAtIndex:0] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    }
        comment.text=[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"comment"];
    time.text=[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"added_time"];
    
               
         [comment adjustHeightToFit];
        time.frame=CGRectMake(time.frame.origin.x, time.frame.origin.y+comment.frame.size.height-10, time.frame.size.width, time.frame.size.height);
        line.frame=CGRectMake(line.frame.origin.x, line.frame.origin.y+comment.frame.size.height-10, line.frame.size.width, line.frame.size.height);
        baseView.frame=CGRectMake(0, 0, 320, baseView.frame.size.height+comment.frame.size.height-10);
        [cell.contentView addSubview:baseView];
    }
    else
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        [questionView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        [cell.contentView addSubview:questionView];
        
        //cell.
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        

    }
    return cell;
    
}




/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */

-(IBAction)userProfileEvent:(id)sender
{
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    
    AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
    profile.userId=userid;
    
    //if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
        profile.follow=1;
    
    [self.navigationController pushViewController:profile animated:YES];
}

-(IBAction)moveToAppPage:(id)sender
{
    
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVDetailViewController";
    }
    else {
        nibName=@"AUVDetailViewController_iPad";
    }
    if([appid isEqualToString:@"0"])
    {
        AUVDevsViewController *devsView=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil type:AUVTYPECATEGORY];
      //  devsView.detailController=self;
        devsView.categoryId=categoryid;
        devsView.category=appname.text;
        [self.navigationController pushViewController:devsView animated:YES];

        
    }else
    {
        AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:nibName bundle:nil];
        detailView.appId=appid;
    
        [self.navigationController pushViewController:detailView animated:YES];
    }
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row==0)return;
    
    
    if([[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"user_id"]count]!=0)
    {
    AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
    profile.userId=[[[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"user_id"] objectAtIndex:0] valueForKey:@"user_id"];
    
    if([[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"follow"] boolValue])
        profile.follow=1;
    
    [self.navigationController pushViewController:profile animated:YES];
    }
   
         
}


-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   if(indexPath.row!=0)
   {
       UILabel *lbl=[[UILabel alloc] init];
       lbl.font=[UIFont systemFontOfSize:13];
      // comment.backgroundColor=[UIColor clearColor];
       lbl.text=[[tableArray objectAtIndex:indexPath.row-1] valueForKey:@"comment"];
       [lbl adjustHeightToFit];
       
     //  UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
       
      // baseView.frame=CGRectMake(0, 0, 320, baseView.frame.size.height+comment.frame.size.height-10);

        return lbl.frame.size.height+90-10;
   }
   else return questionView.frame.size.height;
}

-(void)Upaction:(id)sender{
    
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    
    //NSLog(@"%@",@"UP ACTION");
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    //[sender tag];
    
    NSString *ansid = [NSString stringWithFormat:@"%d", [sender tag]];
    //NSLog(@"%@",ansid);
    [service add_answer_point:self action:@selector(loadUpActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"]  answer_id:ansid positive_negative:@"0"];

}

-(void)Downaction:(id)sender{
    
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    
    //NSLog(@"%@",@"DOWN ACTION");
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    //[sender tag];
    
    NSString *ansid = [NSString stringWithFormat:@"%d", [sender tag]];
    //NSLog(@"%@",ansid);
    [service add_answer_point:self action:@selector(loadUpActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"]  answer_id:ansid positive_negative:@"1"];
}

-(void)loadUpActionHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    else{
    //SoapArray *arr=(SoapArray*)value;
   // NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    [SVProgressHUD dismiss];
    //NSLog(@"%@",[result JSONValue]);
    [tableArray removeAllObjects];
    start=0;
    [self loadAnswers];
    }
}
-(void)loadAnswers
{
    
    if(tableArray.count!=0)
    {
        start=start+10;
    }
    else
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        start=0;
    }
        

    AUVwebservice *service=[AUVwebservice service];
   // service.logging=NO;
    [service answer:self action:@selector(loadAnswerHandler:) question_id:questionId user_id:[AUVLogin valueforKey:@"user_id"] comment:@"0" start:[NSString stringWithFormat:@"%d",start] end:@"10"];


}
static CGFloat padding = 15.0;

-(void)loadAnswerHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{

    SoapArray *arr=(SoapArray*)value;
   
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    

    if(start==0)
    {
    
    [self setupfollow:[[[result JSONValue] valueForKey:@"question_follow"]boolValue]];
    
    CGSize  textSize = {256.0, 150.0};
    
    CGSize size = [[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"question"]] sizeWithFont:qn.font constrainedToSize:textSize lineBreakMode:UILineBreakModeCharacterWrap];
    
    
    
   if(size.height>100)
   {
       CGRect newFrame = qn.frame;
       newFrame.size.height = size.height;
       qn.frame = newFrame;
       
       [answerTable setFrame:CGRectMake(15, size.height+40, 27, 22)];
   }
        
    qn.font=[UIFont systemFontOfSize:14];
    
    qn.text=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"description"]];
       
    [qn adjustHeightToFit];
        
        iconValue=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"logo"]];
    [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    appid=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"app_id"]];
    categoryid=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"category_id"]];
    
    if([appid isEqualToString:@"0"])
    {
        appname.text=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"category_name"]];
   
    }else{
    appname.text=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"app_name"]];
    }
    
     userid=[[[[result JSONValue] valueForKey:@"user_details"] objectAtIndex:0] valueForKey:@"user_id"];
    
    if((NSString*)[[[[result JSONValue] valueForKey:@"user_details"] objectAtIndex:0] valueForKey:@"firstname"]
       !=[NSNull null])
    {
        username.text=@"By ";
        username.text=[username.text stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"%@",[[[[result JSONValue] valueForKey:@"user_details"] objectAtIndex:0] valueForKey:@"firstname"]]];
        questiontitle.text=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"question"]];
        
       
    }
    else
    {
        username.text=@"By ";
        username.text=[username.text stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"%@",[[[[result JSONValue] valueForKey:@"user_details"] objectAtIndex:0] valueForKey:@"firstname"]]];
        
        questiontitle.text=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"question"]];
    }
    
    username.font=[UIFont systemFontOfSize:12];
    
    questiontitle.font=[UIFont  systemFontOfSize:18];
    ans.font=[UIFont systemFontOfSize:14];
    followed.font=[UIFont systemFontOfSize:13];
    
    ans.text=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"answer_count"]];
    followcount.text=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"question_follow_count"]];

  
    followed.text=[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"questionlike_count"]];
    
    
   
    
    infoview.frame=CGRectMake(0, 88+qn.frame.size.height+10, infoview.frame.size.width, infoview.frame.size.height);
    questionView.frame=CGRectMake(0, 0, questionView.frame.size.width, 158+qn.frame.size.height+10);
    }
    
   [tableArray addObjectsFromArray:[[result JSONValue] objectForKey:@"answer_details"]];
    
    
    [self.answerTable reloadData];

    }
    [SVProgressHUD dismiss];
}

#pragma mark UAModelPanel delegate

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel
{
    
    
    if(position==1)
    {
         [tableArray removeAllObjects];
        start=0;
        [self loadAnswers];
    }else if(position==2){
        
    }
    else
    {
    if([modalPanel isKindOfClass:[AUVSuggestAppController class]])
        return;
    if( [[(AUVFollowersList*)modalPanel selectedUserId] integerValue]!=0)
    {
        AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
        profile.userId=[(AUVFollowersList*)modalPanel selectedUserId];
        
        [self.navigationController pushViewController:profile animated:YES];
    }
    }

}


-(void)setupfollow:(BOOL)following
{
    followBtn =[[UIBarButtonItem alloc] initWithTitle:@"Follow" style:UIBarButtonItemStylePlain target:self action:@selector(followAction:)];
    
    if(following){
        followBtn.title=@"Unfollow";
        follow=YES;
    }
    
    else{
        follow=NO;
        followBtn.title=@"Follow";
    }
    
    
    
    
    
   
        self.navigationItem.rightBarButtonItem=followBtn;
    
    
}

-(IBAction)followuserbutton_click:(id)sender
{
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    AUVFollowersList *panel=[[AUVFollowersList alloc] initWithFrame:self.view.bounds];
    panel.delegate=self;
    panel.type=AUVQuestionFollowers;
    panel.questionid=questionId;
    [self.view addSubview:panel];
    [panel showFromPoint:[self.view center]];
}

-(void)followAction:(id)sender
{
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    if(!follow)
    {
        [service follow_question:self action:@selector(followActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"] question_id:questionId];
    }
    else{
        [service unfollow_question:self action:@selector(followActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"] question_id:questionId];
    }
}

-(void)followActionHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{

    //SoapArray *arr=(SoapArray*)value;
    //NSLog(@"%@",arr);
     [tableArray removeAllObjects];
    start=0;
    [self loadAnswers];
    }
}

-(IBAction)questionLike
{
    if(![AUVLogin isAccessAllowed])
    {
        [self GoaToSignInPage];
        return;
    }
   
        
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    
    [service questionlike:self action:@selector(questionLikeHandler:) user_id:[AUVLogin valueforKey:@"user_id"] question_id:questionId];

}

-(void)questionLikeHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{

    SoapArray *arr=(SoapArray*)value;
   
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    if([result JSONValue])
    {
        if([[[result JSONValue] valueForKey:@"message"] isEqualToString:@"Success"])
        {
            [tableArray removeAllObjects];
            start=0;
            [self loadAnswers];
            
        }
        else
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"message"] ]];
    }
    }
   // [tableArray removeAllObjects];
   // start=0;
    //[self loadAnswers];
}

-(void)GoaToSignInPage
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please login" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if(buttonIndex==1)
    {
        return;
    }
}



-(void)goBackPage:(id)sender
{
  if(newlyadded)
   {
       [self.navigationController popToRootViewControllerAnimated:YES];
         
   }
    else
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
