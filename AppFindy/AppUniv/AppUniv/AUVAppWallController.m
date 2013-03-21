//
//  AUVAppWallController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVAppWallController.h"
#import "SVPullToRefresh.h"

#import "UIImageView+AFNetworking.h"
#import "AUVSearchViewController.h"
#import "AUVwebservice.h"
#import "AUVAppDelegate.h"
#import "DYRateView.h"
#import "JSON.h"
#import "AUVPopOverViewController.h"
#import "MKNumberBadgeView.h"
#import "SVProgressHUD.h"
#import "AFHTTPRequestOperation.h"
#import "AUVQuestionViewController.h"
#import "AUVDetailViewController.h"
#import "AUVSuggestAppController.h"
#import "AUVAddQuestionViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVScreenShotsViewController.h"
#import "AUVNotificationViewController.h"
#import <QuartzCore/QuartzCore.h> 
#import "SCNavigationBar.h"
#import "AUVCustomTabbar.h"
#import "AUVHelpViewController.h"
#import "AUVDealsViewController.h"
#import "AUVTredingAppsViewController.h"
#import "AUVAppsRecommendViewController.h"
#import "AUVMyAppSectionViewController.h"
#import "AUVFindFriendsViewController.h"
#import "AUVInviteFriendsViewController.h"
#import "AUVAskViewController.h"
#import "AUVwallcontrollerViewController.h"

@interface AUVAppWallController ()

@end

@implementation AUVAppWallController
@synthesize tableView,label,searchField,popoverController,bannerView,bannerinnerview;

int sections=1;
MKNumberBadgeView *number3;
NSInteger likedItem;

int walldataloadingflag=0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UILabel *tlabel = [[UILabel alloc] initWithFrame:CGRectZero];
        tlabel.backgroundColor = [UIColor clearColor];
       // tlabel.font = [UIFont boldSystemFontOfSize:20.0];
        tlabel.font=[UIFont fontWithName:@"AlexBrush-Regular" size:30.0];
        tlabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        tlabel.textAlignment = UITextAlignmentCenter;
        tlabel.textColor = [UIColor whiteColor]; // change this color
        self.navigationItem.titleView = tlabel;
        tlabel.text = NSLocalizedString(@"Appfindee", @"");
        [tlabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    if([AUV_DELEGATE notified])
    {
        [AUV_DELEGATE setNotified:NO];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=[AUV_DELEGATE notificationType];
        [self btnTap:btn];
        
    }
    [super viewDidLoad];
    
    startvalue=0;
    [self updateApps];
      // self.view.backgroundColor=[UIColor whiteColor];
    
    //[bottomview setBackgroundColor:[UIColor colorWithRed:43.0f green:43.0f blue:43.0f alpha:1.0f]];
    
    wallArray=[[NSMutableArray alloc] init];
    searchField=[[UITextField alloc] initWithFrame:CGRectMake(50, 7, 200, 27)];
    searchField.layer.cornerRadius=18;
    searchField.borderStyle=UITextBorderStyleRoundedRect;
    searchField.delegate=self;
    
    
   [self.view setBackgroundColor:[UIColor colorWithRed:222.0f/255.0f green:223.0f/255.0f blue:227.0f/255.0f alpha:1.0f]];
    
        [wallArray removeAllObjects];
    
    [self setupNavigationBar];

    [(UITableView*)tableView addPullToRefreshWithActionHandler:^(void){
         [(UITableView*)tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
    }];
    

     
  
    
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
  __unsafe_unretained AUVAppWallController *wall = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
    
        
        [wall performSelectorOnMainThread:@selector(updateWall) withObject:nil waitUntilDone:NO];
        
        [tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:10];
    }];
    

    //[self.view addSubview:tableView];
    
     
    tableView.backgroundColor = [UIColor clearColor];
    bottomview.backgroundColor=[UIColor blackColor];
    

    
    //CUSTOM TABBAR
    
    AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
    [custombar.button1 setImage:[UIImage imageNamed:@"home1.png"] forState:UIControlStateNormal];
 
    custombar.delegate= self;
    
    [self.view addSubview:custombar];
    
    [wallArray removeAllObjects];
    walldataloadingflag=0;
    
    [self performSelectorOnMainThread:@selector(updateWall) withObject:nil waitUntilDone:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    walldataloadingflag=0;
    
    if(bannerarray.count!=0)
    {
        sections=2;
        
    }else
    {
    sections=1;
    }
    // self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
    // self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
   /* UIImageView *logoimage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 43)];
    logoimage.image=[UIImage imageNamed:@"nav_logo.png"];
    self.navigationItem.titleView = logoimage;
    */
    
    
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 105, 28)];
    imageview.image=[UIImage imageNamed:@"nav_logo.png"];
    
    UILabel *navTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 105, 30)];
    [navTitle sizeToFit];
    [navTitle setFont:[UIFont fontWithName:@"alluraregular" size:17.0]];
    //[navTitle adjustsFontSizeToFitWidth];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setTextColor:[UIColor whiteColor]];
    [navTitle setTextAlignment:UITextAlignmentCenter];
    [navTitle setText:@"Appfindee"];
    //[self.navigationController.navigationBar.topItem setTitleView:imageView];
    //self.navigationItem.titleView = imageview;
    //[self.navigationItem setTitleView:navTitle];
   // self.title=@"AppFindee";
    
//    [tableView.pullToRefreshView triggerRefresh];
//    tableView.pullToRefreshView.lastUpdatedDate = [NSDate date];

   
}

-(void) viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)btnTap:(UIButton*)buttonId

{
 
    
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 1) {
        
      
        
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
    
    
    
    else if(buttonselect==100){
        
        NSString *nibName;
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            nibName=@"AUVDetailViewController";
        }
        else {
            nibName=@"AUVDetailViewController_iPad";
        }
        AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:nibName bundle:nil];
        detailView.appId=[AUV_DELEGATE notificationAppId];
        [self.navigationController pushViewController:detailView animated:YES];
      
        
    }
    else
    {
        
    }
    
}



#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(sections==2)
    if(section==0) return 1;
    return 2*(wallArray.count)-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if(sections==2){
    if(indexPath.section==0)
    {
        
        UITableViewCell *cell=nil;
        
        static NSString *identifier = @"mycell";
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            bannerinnerview.layer.cornerRadius=4.0f;
            
            bannerviewtext.text=[[bannerarray objectAtIndex:0] valueForKey:@"text"];
            
            [cell.contentView addSubview:bannerView];
        }
        
        
        return cell;

    
    }
    }
    
    
    UITableViewCell *cell=nil;
    if(indexPath.row%2==0){
         static NSString *identifier = @"AUVWallTableCell";
     cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
       // DYRateView *rateView;
        cell=nil;
    if (cell == nil)
    {
               NSString *nibName;
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            nibName=@"AUVWallTableCell_iPhone";
        }
        else {
            nibName=@"AUVWallTableCell_iPad";
        }
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        
        cell=(AUVWallTableCell*)[topLevelObjects objectAtIndex:0];
               
    }
        
        
        cell.contentView.backgroundColor = [UIColor clearColor];
       
 
    
        
        AUVWallTableCell* customcell=(AUVWallTableCell*)cell;
        
      // //NSLog(@"%@",wallArray);
                      
        customcell.type=[[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"type"] integerValue];
        
        if(customcell.type==QuestionComment||customcell.type==QuestionFollow||customcell.type==QuestionLike||customcell.type==RaiseQuestion||customcell.type==QuestionShare){
            
            customcell.questionContainer.frame=CGRectMake(0, 45, 310, 143);
            
            [customcell.appContainer removeFromSuperview];
            customcell.baseView.frame=CGRectMake(6, 4, 308, 188);
            [customcell.baseView addSubview:customcell.questionContainer];
            
            customcell.questionroundedview.layer.borderWidth=0.5f;
            customcell.questionroundedview.layer.borderColor=[UIColor grayColor].CGColor;
            customcell.questionroundedview.layer.cornerRadius=10.0f;
            
            
            customcell.questionappimg.layer.cornerRadius=8.0f;
            
            
            
            customcell.lineview.hidden=YES;
            
            
            customcell.suggest1.tag=indexPath.row;
            [customcell.suggest1 addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
            customcell.suggest1.hidden=NO;
            }
        else{
            customcell.lineview.hidden=NO;
            customcell.lineview.layer.borderWidth=0.5f;
            customcell.lineview.layer.borderColor=[UIColor grayColor].CGColor;
            customcell.lineview.layer.cornerRadius=10.0f;
            
            customcell.suggest.hidden=NO;
            customcell.suggest.tag=indexPath.row;
            [customcell.suggest addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
           

            
        }
        customcell.baseView.layer.cornerRadius=4.0f;

        customcell.commentBtn.tag=indexPath.row;
        [customcell.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        
        customcell.likeBtn.tag=indexPath.row;
        [customcell.likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        customcell.questionansimg.tag=indexPath.row;
        [customcell.questionansimg addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        
        customcell.questionlikeimg.tag=indexPath.row;
        [customcell.questionlikeimg addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        customcell.questionfollowerbutton.tag=indexPath.row;
        [customcell.questionfollowerbutton addTarget:self action:@selector(FollowerListAction:) forControlEvents:UIControlEventTouchUpInside];

        customcell.appfollowerbutton.tag=indexPath.row;
        [customcell.appfollowerbutton addTarget:self action:@selector(FollowerListAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //customcell.backgroundColor=[UfIColor redColor];

       // [customcell.sharedUserIcon.layer setBorderWidth:1.0f];
       // customcell.sharedUserIcon.layer.cornerRadius=10.0f;
        
        customcell.profileview.tag=indexPath.row;
        [customcell.profileview addTarget:self action:@selector(profileViewEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString * namewithmsg=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"firstname"] ;
        
        namewithmsg=[namewithmsg stringByAppendingFormat:@" %@",[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"message"]];
        
        
        customcell.sharedUser.font=[UIFont systemFontOfSize:14];
        customcell.sharedUser.text=namewithmsg;
        
        //customcell.sharedUser.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"username"] ;//@"SathishKumar M";
        
        customcell.sharedTime.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"timestamp"];
        // customcell.message.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"message"] ;
        customcell.appfollowercount.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"no_of_follow"];
        
        
        customcell.noOfLikes.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"no_of_likes"];
        customcell.noOfComments.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"no_of_comment"];
        
         customcell.appName.font=[UIFont systemFontOfSize:15];
        customcell.appName.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"appName"];//@"Angry Birds";
     

        [customcell.sharedUserIcon  setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"picture"] ] ]  placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        
        
        customcell.QuestionView.font=[UIFont systemFontOfSize:15];
        customcell.QuestionView.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"question"];
        
        customcell.questionlikecount.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"no_of_likes"];
        customcell.questionanscount.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"no_of_comment"];
        customcell.questionfollowercount.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"no_of_follow"];
        
        customcell.questionappname.font=[UIFont systemFontOfSize:15];
        customcell.questionappname.text=[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"appName"];//@"Angry Birds";
       
        
        
      
        
        [customcell.questionappimg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"appLogo"]] ] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        
        
        
        
        customcell.sharedUserIcon.contentMode = UIViewContentModeScaleAspectFit;

       
        customcell.appIcon.layer.cornerRadius=8.0f;

       
        
        NSInteger count=[[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"wall_count"]integerValue];
        
        number3.value=count;
        

        
        [customcell.appIcon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"appLogo"]] ] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        [customcell.appImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"images"]] ] placeholderImage:[UIImage imageNamed:@"loading"]];
        
        customcell.appImage.contentMode = UIViewContentModeScaleAspectFill;
        

    
    
    customcell.selectionStyle=UITableViewCellSelectionStyleNone;
       // [customcell setBackgroundColor:[UIColor redColor]];
        
        customcell.contentView.backgroundColor=[UIColor clearColor];
        
    
    return customcell;
        
        
        
    }
    else {
         static NSString *identifier = @"defaultcell";
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        cell=nil;
        if (cell == nil)
        {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        
        return cell;
    }
    
}



-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(sections==2)if(indexPath.section==0) return;
        
    if(indexPath.row%2!=0)
    {
        return;
    }
    else{
      
        
        AUVWallTableCell* customcell=(AUVWallTableCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        if(customcell.type==AppComment||customcell.type==AppFollow||customcell.type==AppLiked||customcell.type==AppShare)
        {
            NSString *nibName;
            if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
                nibName=@"AUVDetailViewController";
            }
            
            AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:nibName bundle:nil];
            detailView.appId=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"appid"] ];
            [self.navigationController pushViewController:detailView animated:YES];
        }
        else{
           
            
            AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
            question.questionId=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"question_id"] ];
            // question.info=[[NSMutableDictionary alloc] initWithDictionary:[tableArray objectAtIndex:indexPath.row]];
            //question.follow=[[[tableArray objectAtIndex:indexPath.row] valueForKey:@"question_follow"] boolValue];
            
            [self.navigationController pushViewController:question animated:YES];
        }
        
    }
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %d", section];
}
 */

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
if(sections==2) if(indexPath.section==0) return bannerView.frame.size.height+2;
    
    if(indexPath.row%2==0){
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            NSInteger type=[[[wallArray objectAtIndex:indexPath.row/2] valueForKey:@"type"] integerValue];
            
            if(type==QuestionComment||type==QuestionFollow||type==QuestionLike||type==RaiseQuestion||type==QuestionShare){
                
                return 193;
            }
            else{
                return 346;
            }
        }
        else {
            return 420;
        }
    }
    else {
        return 5;
    }
}

#pragma mark UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}

-(void)textFieldDidEndEditing:(UITextField*)textField
{
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
        [textField resignFirstResponder];
        
    return YES;
}
-(void)textFieldShow
{
    
    if([searchField superview]){
        [searchField removeFromSuperview];
        [self searchForApps];
        
        
    }
    else {
        [self.navigationController.navigationBar addSubview:searchField];
    }
    }

-(void)profileViewEvent:(id)sender
{
    AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
    profile.userId=[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"user_id"];
    
    //if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
    profile.follow=1;
    
    [self.navigationController pushViewController:profile animated:YES];

    
}


-(void) searchForApps
{
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVSearchViewController";
    }
    else {
        nibName=@"AUVSearchViewController_iPad";
    }
     AUVSearchViewController *searchView=[[AUVSearchViewController alloc] initWithNibName:nibName bundle:nil];
    
    [self.navigationController pushViewController:searchView animated:NO];
}


-(void)addQuestion
{
    
   /* UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add a discussion for category",@"Add a discussion for app",nil];
    
    actionSheet.actionSheetStyle=UIActionSheetStyleAutomatic;
    
    [actionSheet showInView:self.view];*/
    
    AUVQuestionChoiceViewController *obj=[[AUVQuestionChoiceViewController alloc] initWithNibName:@"AUVQuestionChoiceViewController" bundle:nil];
    
        [self.navigationController pushViewController:obj animated:YES];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)
    {
     
        AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc] initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
        obj.questiontype=@"category";
         
         [self.navigationController pushViewController:obj animated:YES];
    }
    else if (buttonIndex == 1)
    {
     
        AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc] initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
        obj.questiontype=@"app";
        
        [self.navigationController pushViewController:obj animated:YES];
    }
}



-(void)updateWall{
    
    
    if(walldataloadingflag==0)
    {
        if([wallArray count]==0)
        {
       
            startvalue=0;
        }else{
            startvalue+=10;
        }
        NSString *start=[NSString stringWithFormat:@"%d",startvalue];
        
        walldataloadingflag=1;
    
        AUVwebservice *service=[AUVwebservice service];
    //service.logging=NO;
        [service wall:self action:@selector(wallHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:start offset:@"10"];
    }
   
    
    
   
    
}

-(void)updateWall:(NSInteger)offset{
    
    
    if(walldataloadingflag==0)
    {
        if([wallArray count]==0)
        {
            
            startvalue=0;
        }else{
            startvalue+=10;
        }
        NSString *start=[NSString stringWithFormat:@"%d",startvalue];
        
        walldataloadingflag=1;
        
        AUVwebservice *service=[AUVwebservice service];
        // service.logging=NO;
        [service wall:self action:@selector(wallHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:start offset:[NSString stringWithFormat:@"%d",offset]];
    }
    
    
    
    
    
}


-(void)wallHandler:(id)value
{
   
    
    
  
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
         walldataloadingflag=0;
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    else{
    SoapArray* arr = (SoapArray*)value;
 
  
     [SVProgressHUD dismiss];
    
    if([arr count]!=0)
    {
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
 
    
        walldataloadingflag=0;
    
    [wallArray addObjectsFromArray:[[result JSONValue] valueForKey:@"app_deatails"]];
        
    
       
        
        bannerarray=[[NSMutableArray alloc]init];
        
       [bannerarray addObjectsFromArray:[[result JSONValue]valueForKey:@"top_details"]];
        
        
        
        
        if(bannerarray.count!=0)
        {
            sections=2;
        }else
        {
            sections=1;
        }
        
    [tableView reloadData];
    }
    }
   }
-(void) createMenu
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:self];
}


-(NSString*)dateTimeFormatter:(NSString*)datetime
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateStyle:NSDateFormatterShortStyle];
    //	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [ dateFormatter setDateFormat:@"yyyy-mm-dd HH:MM:SS"];
    
    dateFormatter.locale = [NSLocale allocWithZone:[[NSTimeZone timeZoneWithName:@"GMT"] zone]];
    NSDate *date=[dateFormatter dateFromString:datetime];
    NSDate *currentDate=[NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:date
                                                  toDate:currentDate options:0];
    NSInteger year=[components year];
    NSInteger months = [components month];
    NSInteger days = [components day];
    NSInteger hour=[components hour];
    NSInteger minutes=[components minute];
    NSInteger seconds=[components second];
    
    NSString *date_time;
    if(year>0)date_time=[NSString stringWithFormat:@"%d year(s) ago",year];
    else{
        if(months>0)date_time=[NSString stringWithFormat:@"%d month(s) ago",months];
        
            else{
            if(days>0) date_time=[NSString stringWithFormat:@"%d day(s) ago",days];
            else{
                if(hour>0)date_time=[NSString stringWithFormat:@"%d hour(s) ago",hour];
                
                else
                {
                    if(minutes>0)date_time=[NSString stringWithFormat:@"%d minute(s) ago",minutes];
                    else{
                        if(seconds>0) date_time=[NSString stringWithFormat:@"%d seconds(s) ago",seconds];
                            }
                }
            }
        }
    }

 

    return date_time;
    
}

-(void)helpEvent{
    
//    AUVHelpViewController *help=[[AUVHelpViewController alloc]initWithNibName:@"AUVHelpViewController" bundle:nil];
//    [self.navigationController pushViewController:help animated:YES];
    AUVwallcontrollerViewController *imageview =[[AUVwallcontrollerViewController alloc]initWithNibName:@"AUVwallcontrollerViewController" bundle:nil];
    imageview.title = @"Image Show";
    [self.navigationController pushViewController:imageview animated:YES];
    
    
 
}


-(void)setupNavigationBar
{
    
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
  //  UIBarButtonItem *infoBtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"blue_btn.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *infoBtn=[[UIBarButtonItem alloc] initWithTitle:@"Image" style:UIBarButtonItemStylePlain target:self action:@selector(helpEvent)];

    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(0, 0, 29, 20);
    [btn1 setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(searchForApps) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, 0, 29, 20);
    [btn2 setImage:[UIImage imageNamed:@"dplus"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(addQuestion) forControlEvents:UIControlEventTouchUpInside];
  //  MKNumberBadgeView *number2= [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(25, 00, 25,25)];
   // number2.value = 10;
   // [btn2 addSubview:number2];
    

    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(0, 0, 29, 31);
    [btn3 setImage:[UIImage imageNamed:@"notify"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(openNotifications:) forControlEvents:UIControlEventTouchUpInside];
    number3 = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(25, 00, 25,25)];
    number3.value = 0;
    
    [btn3 addSubview:number3];

    // UIBarButtonItem *searchBtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wall_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchForApps)];
//    UIBarButtonItem *searchBtn=[[UIBarButtonItem alloc]initWithCustomView:btn1];
//    UIBarButtonItem *addquestionbtn = [[UIBarButtonItem alloc] initWithCustomView:btn2];
//    
//    UIBarButtonItem *butt3 = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    //UIBarButtonItem *space0=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
//    UIBarButtonItem *space1=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem *space2=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem *space3=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //[butt1 ]
    // self.navigationItem.rightBarButtonItem = rightButton;
    
    // MKNumberBadgeView *n = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(60, 00, 30,20)];
    //n.value = 10;
    
    UILabel *space0=[[UILabel alloc]init];
    space0.frame=CGRectMake(50, 0, 20, 30);
    space0.backgroundColor=[UIColor clearColor];
  //  UIBarButtonItem *but = [[UIBarButtonItem alloc] initWithCustomView:space0];
    
                             
    UIButton *logo=[UIButton buttonWithType:UIButtonTypeCustom];
    logo.frame=CGRectMake(50, 0, 140, 30);
    [logo setImage:[UIImage imageNamed:@"nav_logo"] forState:UIControlStateNormal];
   // UIBarButtonItem *lobut=[[UIBarButtonItem alloc]initWithCustomView:logo];
    
    // self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:infoBtn,menu,nil];
    
  // self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:infoBtn,space1,lobut,but,menu,nil];
    
   self.navigationItem.leftBarButtonItem=menu;
  self.navigationItem.rightBarButtonItem=infoBtn;
    
   // self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:infoBtn,space0,searchBtn,space1,addquestionbtn,space2,butt3,space3,menu,nil];
    


   //self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    
    // [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
}




-(void)openNotifications:(id)sender
{
    if(self.popoverController)
    {
        [self.popoverController dismissPopoverAnimated:YES];
		//self.popoverController = nil;
    }

    AUVPopOverViewController *contentViewController = [[AUVPopOverViewController alloc] initWithNibName:@"AUVPopOverViewController" bundle:nil];
    contentViewController.parent=self;
    //self.popoverController.contentViewController.
    self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
    
    popoverController.popoverContentSize=CGSizeMake(280, 380);
    
    [self.popoverController presentPopoverFromRect:CGRectMake([sender frame].origin.x, -30, [sender frame].size.width, [sender frame].size.height)
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
   // [self.popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
   

}


-(void)updateApps
{
   // [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //[AUV_DELEGATE updateAppsList];
}


-(void)likeAction:(id)sender
{
 

    
    
    if([sender tag]%2!=0)
    {
        return;
    }
    else{
        likedItem=[sender tag];
        
        NSInteger type=[[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"type"] integerValue];
        
        
        if(type==AppComment||type==AppFollow||type==AppLiked||type==AppShare)
        {
            
            startvalue=0;
            
            AUVwebservice *service=[AUVwebservice service];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
          //  service.logging=NO;
            NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
         
            [service applike:self action:@selector(favoriteHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"appid"] ]];
            
           
        }
        else{
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            AUVwebservice *service=[AUVwebservice service];
           // service.logging=NO;
            
            startvalue=0;
            
            [service questionlike:self action:@selector(questionLikeHandler:) user_id:[AUVLogin valueforKey:@"user_id"] question_id:[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"question_id"] ]];
        }
        
    }    
}

-(void)favoriteHandler:(id)value
{
    
    
	// Handle errors
	if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
	// Do something with the Array* result
    else{
        
    
    SoapArray* arr = (SoapArray*)value;
    
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    NSDictionary *dict=[result JSONValue];
    if([[dict valueForKey:@"status"] boolValue]){
    NSString *appId=[dict valueForKey:@"app_id"];
    
    for(NSDictionary* obj in wallArray)
    {
        
         NSInteger type=[[obj valueForKey:@"type"] integerValue];
       
        if([[obj valueForKey:@"appid"] compare:appId options:NSUTF8StringEncoding]==NSOrderedSame)
        {
            if(type==AppComment||type==AppFollow||type==AppLiked||type==AppShare){

           int  likes=  [[obj valueForKey:@"no_of_likes"] integerValue]+1;
            //NSLog(@"liked : %d",likes);
            [obj setValue:[NSString stringWithFormat:@"%d",likes] forKey:@"no_of_likes"];
              //NSLog(@"liked : %@",[obj valueForKey:@"no_of_likes"]);
            }
        }
    }
        
        
        [tableView reloadData];
    
    }
    else if(![[dict valueForKey:@"status"] boolValue]){
        
        [SVProgressHUD showErrorWithStatus:@"You have already liked this app."];
    }
        
        [SVProgressHUD dismiss];
    //NSLog(@"JAG : %@",result);
//    wallcount=wallArray.count;
//
//    //NSLog(@"wallcount  : %d",wallcount);
//    [wallArray removeAllObjects];
   // [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //[self updateWall:wallcount];
        
    }
}


-(void)questionLikeHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}

    else{
    SoapArray *arr=(SoapArray*)value;
   

    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    //wallcount=wallArray.count;
    
    
    NSDictionary *dict=[result JSONValue];
    if([[dict valueForKey:@"type"] integerValue]==1 ){
        NSString *qID=[dict valueForKey:@"question_id"];
        
        for(NSDictionary* obj in wallArray)
        {
            
            
            
            if([[obj valueForKey:@"question_id"] compare:qID options:NSUTF8StringEncoding]==NSOrderedSame)
            {
                NSInteger type=[[obj valueForKey:@"type"] integerValue];

                 if(type==RaiseQuestion||type==QuestionFollow||type==QuestionLike||type==QuestionShare){
           
                int  likes=  [[obj valueForKey:@"no_of_likes"] integerValue]+1;
                 //NSLog(@"liked : %d",likes);
                [obj setValue:[NSString stringWithFormat:@"%d",likes] forKey:@"no_of_likes"];
                
                //NSLog(@"liked : %@",[obj valueForKey:@"no_of_likes"]);
                     
                 }

            }
        }   
        
        
        [tableView reloadData];
        
    }
    else{
      //  //NSLog(@"NO");
        
        [SVProgressHUD showErrorWithStatus:@"You have already liked this question."];
        
    }
        [SVProgressHUD dismiss];

    }

    //NSLog(@"JAG : %@",result);

   // //NSLog(@"wallcount  : %d",wallcount);

   // [wallArray removeAllObjects];
   // [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //[self updateWall:wallcount];
  
}

-(void)FollowerListAction:(id)sender
{
   
    NSInteger type=[[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"type"] integerValue];
    if(type==AppComment||type==AppFollow||type==AppLiked||type==AppShare)
    {
    
        AUVFollowersList *panel=[[AUVFollowersList alloc] initWithFrame:self.view.bounds];
        panel.delegate=self;
        panel.type=AUVAppFollowers;
        panel.appId=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"appid"] ];
        [self.view addSubview:panel];
        [panel showFromPoint:[self.view center]];
    }else
    {
        
        AUVFollowersList *panel=[[AUVFollowersList alloc] initWithFrame:self.view.bounds];
        panel.delegate=self;
        panel.type=AUVQuestionFollowers;
        panel.questionid=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"question_id"] ];;
        [self.view addSubview:panel];
        [panel showFromPoint:[self.view center]];
    }
}

-(void)commentAction:(id)sender
{
    if([sender tag]%2!=0)
    {
        return;
    }
    else{

        NSInteger type=[[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"type"] integerValue];
      
        
        if(type==AppComment||type==AppFollow||type==AppLiked||type==AppShare)
        {
            NSString *nibName;
            
            if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
                nibName=@"AUVCommentsViewController";
            }
            
            AUVCommentsViewController *detailView=[[AUVCommentsViewController alloc] initWithNibName:nibName bundle:nil];
            
            detailView.appId=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"appid"] ];
            detailView.type=Comment;
            [self.navigationController pushViewController:detailView animated:YES];
        }
        else{
         
            
            AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
            question.questionId=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"question_id"] ];
          
            
            [self.navigationController pushViewController:question animated:YES];
        }
        
    }
}

-(void)detailAction:(id)sender
{
    
    NSInteger type=[[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"type"] integerValue];
    
    
    if(type==AppComment||type==AppFollow||type==AppLiked||type==AppShare)
    {
        AUVSuggestAppController *suggest=[[AUVSuggestAppController alloc] initWithFrame:self.view.bounds];
        
        suggest.delegate=self;
        suggest.appid=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"appid"] ];
        suggest.type=@"0";
        [self.view addSubview:suggest];
        
        [suggest showFromPoint:[sender center]];
    }
    else
    {
        
        
       /* AUVSuggestAppController *suggest=[[AUVSuggestAppController alloc] initWithFrame:self.view.bounds];
     
        
        suggest.delegate=self;
        suggest.appid=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"question_id"] ];
        suggest.type=@"1";
        [self.view addSubview:suggest];
        
        [suggest showFromPoint:[sender center]];*/
        
        AUVAskViewController *ask=[[AUVAskViewController alloc]initWithNibName:@"AUVAskViewController" bundle:nil];
        ask.questionid=[NSString stringWithFormat:@"%@",[[wallArray objectAtIndex:[sender tag]/2] valueForKey:@"question_id"] ];
        [self.navigationController pushViewController:ask animated:YES];


        
    }
    
    
  

}


-(IBAction)homeEvent
{
    
}
-(IBAction)notificatonEvent
{
     AUVNotificationViewController *notify=[[AUVNotificationViewController alloc] initWithNibName:@"AUVNotificationViewController" bundle:nil];
    [self.navigationController pushViewController:notify animated:YES];
}
-(IBAction)searchEvent
{
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVSearchViewController";
    }
    else {
        nibName=@"AUVSearchViewController_iPad";
    }
    AUVSearchViewController *searchView=[[AUVSearchViewController alloc] initWithNibName:nibName bundle:nil];
    
    [self.navigationController pushViewController:searchView animated:NO];
}
-(IBAction)discussionEvent
{
    
    AUVQuestionChoiceViewController *obj=[[AUVQuestionChoiceViewController alloc] initWithNibName:@"AUVQuestionChoiceViewController" bundle:nil];
    
    [self.navigationController pushViewController:obj animated:YES];
}
-(IBAction)profileEvent
{
    
}



-(IBAction)bannerSkip:(id)sender
{
    sections=1;
    [self.tableView reloadData];
    
    AUVwebservice *service=[AUVwebservice service];
    
    [service skip_wall:self action:@selector(skipWallHandler:) unique_id:[[bannerarray objectAtIndex:0]valueForKey:@"unique_id"] user_id:[AUVLogin valueforKey:@"user_id"]];
    
}

-(void)skipWallHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    
//    SoapArray* arr = (SoapArray*)value;
//    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//    
        
}

-(IBAction)bannerGo:(id)sender
{
    sections=1;

    if(bannerarray.count!=0)
    {
        if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"1"]){
            
            AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
            question.questionId=[[bannerarray objectAtIndex:0] valueForKey:@"id"];
                       [self.navigationController pushViewController:question animated:YES];
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"2"])
        {
            NSString *nibName;
            if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
                nibName=@"AUVDetailViewController";
            }
            else {
                nibName=@"AUVDetailViewController_iPad";
            }
            AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:nibName bundle:nil];
            detailView.appId=[[bannerarray objectAtIndex:0] valueForKey:@"id"];
            [self.navigationController pushViewController:detailView animated:YES];
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"3"])
        {
            AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
            profile.userId=[[bannerarray objectAtIndex:0] valueForKey:@"id"];
            //if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
            profile.follow=1;
            
            [self.navigationController pushViewController:profile animated:YES];
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"4"])
        {
            AUVDevsViewController *devsView=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil type:AUVTYPECATEGORY];
            devsView.categoryId=[[bannerarray objectAtIndex:0] valueForKey:@"id"];
            [self.navigationController pushViewController:devsView animated:YES];
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"5"])
        {
            AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
            
            [self.navigationController pushViewController:deal animated:YES];
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"6"])
        {
            AUVTredingAppsViewController *trending=[[AUVTredingAppsViewController alloc]initWithNibName:@"AUVTredingViewController" bundle:nil];
            
            [self.navigationController pushViewController:trending animated:YES];
           
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"7"])
        {
           AUVAppsRecommendViewController *recommended = [[AUVAppsRecommendViewController alloc] initWithNibName:@"AUVAppsRecommendViewController" bundle:nil];
            
            [self.navigationController pushViewController:recommended animated:YES];
            
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"8"])
        {
            AUVMyAppSectionViewController *myapps = [[AUVMyAppSectionViewController alloc] initWithNibName:@"AUVMyAppSectionViewController" bundle:nil];
            
            [self.navigationController pushViewController:myapps animated:YES];
            
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"9"])
        {
            AUVFindFriendsViewController *friendsViewController = [[AUVFindFriendsViewController alloc] initWithNibName:@"AUVFindFriendsViewController" bundle:nil];
            friendsViewController.type=FindFriends;
            
            [self.navigationController pushViewController:friendsViewController animated:YES];
            
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"10"])
        {
            AUVInviteFriendsViewController *friendsViewController = [[AUVInviteFriendsViewController alloc] initWithNibName:@"AUVInviteFriendsViewController" bundle:nil];
            
            [self.navigationController pushViewController:friendsViewController animated:YES];
            
        }
        else if([[[bannerarray objectAtIndex:0]valueForKey:@"type"] isEqualToString:@"11"])
        {
            [NSURL URLWithString:@"itms://itunes.com/apps/appname"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[bannerarray objectAtIndex:0] valueForKey:@"id"]]]];
            
        }
    }
}

@end
