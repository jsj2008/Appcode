//
//  AUVDevsViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVDevsViewController.h"
#import "AUVViewController.h"
#import "BHTabStyle.h"
#import "AUVGridViewController.h"
#import "AUVwebservice.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "AFNetworking.h"
#import "NSString+ParamHandling.h"
#import "AUVFollowersList.h"
#import "AUVLogin.h"
#import "AUVQuestionViewController.h"
#import "AUVNewGridViewController.h"
#import <iHasApp/iHasApp.h>
#import "AUVAddQuestionViewController.h"
#import "AUVAnswerViewController.h"

#import "SVPullToRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "StyledPullableView.h"

#import "AUVMyAppSectionViewController.h"
#import "AUVQuestionChoiceViewController.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"

@interface AUVDevsViewController ()

@end

@implementation AUVDevsViewController
@synthesize type,detailController,userId,developer,category,name,followers,questions,follow,icon,uid,developerId,categoryId,start,questionsTable;
//AUVGridViewController *src1,*src2,*src3;
AUVNewGridViewController *src4,*src5,*src6;
NSMutableDictionary *contentDicitionary;

NSString *sellerurl;
NSString *supporturl;

int questionstart=0;
int questionlloadingflag=0;
int developerpageappload=0;

int profilepageload=0;

NSMutableArray *tableArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(AUVViewType)vType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.type=vType;
    }
    
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//
//    if(userId==nil) userId=[defaults valueForKey:@"user_id"];
//    [self loadProfile];
//
    self.start=0;
    developerpageappload=0;
    profilepageload=0;
    
    if(userId.length==0) {
        
        //NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
       
        userId=[NSString stringWithFormat:@"%@",[AUVLogin valueforKey:@"user_id"]];//[defaults valueForKey:@"user_id"];
    }

    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    
    //[self loadDeveloper:developer];
    if(self.type==AUVTYPEDEVELOPER)
    {
        [self loadDeveloper:developer];
    }
    else if(self.type==AUVTYPECATEGORY)
    {
     //[self loadCategory:category];
        [self loadCategoryDetailandHotapps:categoryId];
        
    }
    else if(self.type==AUVTYPEPROFILE)
    {
        [self loadProfile];
        
    }
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    contents=[[NSMutableArray alloc] init];
    contents1=[[NSMutableArray alloc] init];
    contentDicitionary=[[NSMutableDictionary alloc] init];
    tableArray=[[NSMutableArray alloc] init];
    
    [contentDicitionary setObject:[[NSMutableArray alloc] init] forKey:@"myapps"];
    [contentDicitionary setObject:[[NSMutableArray alloc] init] forKey:@"Loved"];
    [contentDicitionary setObject:[[NSMutableArray alloc] init] forKey:@"Questions"];
    
  

    
    self.navigationController.navigationBarHidden=NO;

    
    if(self.type==AUVTYPEDEVELOPER || self.type==AUVTYPECATEGORY ){
        src4=[[AUVNewGridViewController alloc] initWithNibName:@"AUVNewGridViewController" bundle:nil];
        src4.parentController=self;
        src4.contents=contents;
        
        
         UITableViewController *src3=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        if(self.type==AUVTYPEDEVELOPER)
        {
            followingbutton.hidden=YES;
            followers.hidden=YES;
            src4.title=@"Info";
            
            adddiscussion.hidden=YES;
            self.title=@"Developer";
            
        }else
        {
            src4.title=@"Apps";
            
            
           
            questionsTable=src3.tableView;
            src3.tableView.frame=CGRectMake(0, 0, 320, 280);
            src3.tableView.delegate=self;
            src3.tableView.dataSource=self;
            src3.title=@"Questions";
               self.title=@"Category";

        }
        
        src5=[[AUVNewGridViewController alloc] initWithNibName:@"AUVNewGridViewController" bundle:nil];
        src5.parentController=self;
        src5.contents=contents1;
        if(self.type==AUVTYPEDEVELOPER)
        {
            [icon setImage:[UIImage imageNamed:@"developer_icon.png"]];
            
            src5.title=@"Apps";
        }else
        {
             src5.title=@"Hot";
        }
        
        if(self.type==AUVTYPEDEVELOPER)
        {
            tabController=[[BHTabsViewController alloc] initWithViewControllers:[NSArray  arrayWithObjects:src5,src4,nil] style:[BHTabStyle defaultStyle]];
        }else
        {
            tabController=[[BHTabsViewController alloc] initWithViewControllers:[NSArray  arrayWithObjects:src5,src4,src3,nil] style:[BHTabStyle defaultStyle]];
        }
        
        tabController.delegate=self;
        //tabController.view.frame=CGRectMake(0, 80, 320, 310);
        if (IS_IPHONE_5) {
            
            tabController.view.frame=CGRectMake(0, 80, 320, 380);
            
        }else{
            
            tabController.view.frame=CGRectMake(0, 80, 320, 310);
            
        }
        [self.view addSubview:tabController.view];
    }
      icon.layer.borderWidth=1.0f;
    icon.clipsToBounds=YES;
    
    self.userName.font=[UIFont systemFontOfSize:12];
    self.followers.font=[UIFont systemFontOfSize:13];
    self.following.font=[UIFont systemFontOfSize:13];
    self.name.font=[UIFont systemFontOfSize:15];
   
    __unsafe_unretained AUVDevsViewController *dev=self;
    
   
    [self.questionsTable addInfiniteScrollingWithActionHandler:^{
        
        
        [dev performSelectorOnMainThread:@selector(loadQuestions) withObject:nil waitUntilDone:YES];
        
        [questionsTable.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];

    
  //  AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
   // custombar.delegate= self;
    
    //[self.view addSubview:custombar];
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
        
        NSLog(@"nothing");
        
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


-(void)loadProfile
{
    [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    if(self.type!=AUVFBPROFILE){
    [service user_profile_page:self action:@selector(profleLoadHandler:) user_id:userId logged_user_id:[AUVLogin valueforKey:@"user_id"]];
    }
    
    else{
        
        AUVwebservice *service=[AUVwebservice service];
        
        [service facebook_find_friends:self action:@selector(profleLoadHandler:) user_id:[AUVLogin valueforKey:@"user_id"] facebook_user_id:uid];
       // [service use]
    }
}

-(void)profleLoadHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;

    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];

    //NSLog(@" LOG %@",[result JSONValue]);
    
    
 
    if(profilepageload==0)
    {
        UITableViewController *src3=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        if(self.type==AUVTYPEPROFILE){
            
            self.title=@"Profile";
            
            src4=[[AUVNewGridViewController alloc] initWithNibName:@"AUVNewGridViewController" bundle:nil];
            
            
            src4.parentController=self;
            src4.type=Profile;
            src4.contents=[contentDicitionary valueForKey:@"myapps"];
            src4.title=@"Used";
            
            src5=[[AUVNewGridViewController alloc] initWithNibName:@"AUVNewGridViewController" bundle:nil];
            src5.parentController=self;
            src5.type=Profile;
            
            src5.contents=[contentDicitionary valueForKey:@"Loved"];
            src5.title=@"Loved";
            
            
            //UITableViewController *src3=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
            questionsTable=src3.tableView;
            src3.tableView.frame=CGRectMake(0, 0, 320, 280);
            src3.tableView.delegate=self;
            src3.tableView.dataSource=self;
            src3.title=@"Questions";
        }

        profilepageload=1;
        
        if([[[result JSONValue]valueForKey:@"special"]boolValue])
        {
        
            if(tabController)
            {
                tabController.tabBarController.viewControllers =[NSArray array];
            
                [tabController.view removeFromSuperview];
            }
            tabController=[[BHTabsViewController alloc] initWithViewControllers:[NSArray  arrayWithObject:src5] style:[BHTabStyle defaultStyle]];
            tabController.delegate=self;
           // tabController.view.frame=CGRectMake(0, 80, 320, 310);
            if (IS_IPHONE_5) {
                
                tabController.view.frame=CGRectMake(0, 80, 320, 380);
                
            }else{

                tabController.view.frame=CGRectMake(0, 80, 320, 310);
                
            }
        // tabController.view.clipsToBounds=YES;
        
        
            [self.view addSubview:tabController.view];

        }else
        {
            if(tabController)
            {
                tabController.tabBarController.viewControllers =[NSArray array];
                [tabController.view removeFromSuperview];
            }
            tabController=[[BHTabsViewController alloc] initWithViewControllers:[NSArray  arrayWithObjects:src5,src4,src3,nil] style:[BHTabStyle defaultStyle]];
            tabController.delegate=self;
           // tabController.view.frame=CGRectMake(0, 80, 320, 310);
            if (IS_IPHONE_5){
                tabController.view.frame=CGRectMake(0, 80, 320, 380);
            }else{
                tabController.view.frame=CGRectMake(0, 80, 320, 310);
            }
        // tabController.view.clipsToBounds=YES;
            
            [self.view addSubview:tabController.view];
        
               
        }
    
    }
    
    __unsafe_unretained AUVDevsViewController *dev=self;
    
    [self.questionsTable addInfiniteScrollingWithActionHandler:^{
        
        [dev performSelectorOnMainThread:@selector(loadQuestions) withObject:nil waitUntilDone:YES];
        
        [questionsTable.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];

    NSArray * dict = [result JSONValue];
        
    [[contentDicitionary objectForKey:@"Loved"] removeAllObjects];
    [[contentDicitionary objectForKey:@"Loved"] addObjectsFromArray:[dict valueForKey:@"app_details"]];
    
    [self updateUserProfile:dict];
    
    if([[contentDicitionary objectForKey:@"Loved"]count]==0)
    {
       
        if([self.userId integerValue]==[[AUVLogin valueforKey:@"user_id"] integerValue])
        {
            UIButton *findapps=[UIButton buttonWithType:UIButtonTypeCustom];
            findapps.frame=CGRectMake(130, 45, 70, 35);
            [findapps setBackgroundImage:[[UIImage imageNamed:@"blue_btn"] stretchableImageWithLeftCapWidth:13.0 topCapHeight:0.0] forState:UIControlStateNormal];
            findapps.tag=3;
            [findapps setTitle:@"Find" forState:UIControlStateNormal];
            findapps.titleLabel.font=[UIFont systemFontOfSize:13];
            [findapps addTarget:self action:@selector(supportanddeveloperpageevent:) forControlEvents:UIControlEventTouchUpInside];
        
            UILabel *findlabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 20, 250, 20)];
            findlabel.text=@"You can find the best apps you loved";
            findlabel.backgroundColor=[UIColor clearColor];
            findlabel.font=[UIFont systemFontOfSize:15];
        
            [src5.view addSubview:findlabel];
            [src5.view addSubview:findapps];
        }else
        {
            
            
            UILabel *findlabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 20, 250, 20)];
            findlabel.text=@"User has not liked any apps";
            findlabel.backgroundColor=[UIColor clearColor];
            findlabel.font=[UIFont systemFontOfSize:15];
            
            [src5.view addSubview:findlabel];

        }
        [src5.gmGridView reloadData];
        [src5.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
        
    }
    else
    {
     [src5.gmGridView reloadData];
     [src5.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
    }
    }
    
    [SVProgressHUD dismiss];

}

-(void)updateUserProfile:(NSDictionary*)dict
{
  
    
   // self.name.text=[dict valueForKey:@"username"];
    self.userId=[NSString stringWithFormat:@"%@",[dict valueForKey:@"user_id"]];//[dict valueForKey:@"user_id"];
    if([[[dict valueForKey:@"firstname"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0)
    self.name.text=[dict valueForKey:@"firstname"];
    else self.name.text=[dict valueForKey:@"username"];
    self.followers.text=[NSString stringWithFormat:@"%@ Followers",[dict valueForKey:@"no_of_followers"]];
    self.following.text=[NSString stringWithFormat:@"%@ Following",[dict valueForKey:@"no_of_following"]];
    if([[[dict valueForKey:@"firstname"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0)
    self.userName.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"username"]];
    else self.userName.text=@"";
    
    self.website.font=[UIFont systemFontOfSize:15];
    self.website.text=[NSString stringWithFormat:@"%@ credits",[dict valueForKey:@"credits"]];

    [self.icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
   
    followBtn =[[UIBarButtonItem alloc] initWithTitle:@"Follow" style:UIBarButtonItemStylePlain target:self action:@selector(followActionUser:)];
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    if([self.userId integerValue]==[[AUVLogin valueforKey:@"user_id"] integerValue])
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    }else
    {
       

        
    }
    
    if([userId integerValue]!=[[AUVLogin valueforKey:@"user_id"] integerValue])
    {
   
        if([[dict valueForKey:@"follow"] boolValue]){
            followBtn.title=@"Unfollow";
            follow=1;
        }
    
        else{
            follow=0;
            followBtn.title=@"follow";
        }
       self.navigationItem.rightBarButtonItem=followBtn;

    }
    else
    {
        UIBarButtonItem *back =[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonEvent:)];
        self.navigationItem.rightBarButtonItem=back;
    }
}

-(void)backbuttonEvent:(id)sender
{
      [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadDeveloper:(NSString*)developerName

{
    
     
    if (developerpageappload==0) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        
        /*
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@  "http://approot:Ate3A9e*@appfindee.com:9264/solr/appfindee/select?wt=json&omitHeader=true&sort=scoring+desc&start=0&rows=25&fl=trackId,trackNameExact,artworkUrl60,artistName,sellerUrl,supportUrl,trackCensoredName&q=*:*&fq=artistId:%@",developerId]];
        */
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://admin:hu5AsWud@appfindee.com/searchquery.php?index=developer_apps&query=*:*&start=0&artistId=%@",developerId]];
        
        
       // NSLog(@"%@",url);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest :request ];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            id JSON= [[operation responseString] JSONValue];
            
            [self processDictionary:[[JSON valueForKey:@"response"] valueForKey:@"docs"]];
            
            developerpageappload=1;
            
            
            [SVProgressHUD dismiss];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
          //  NSLog(@"error %@",error);
            [SVProgressHUD dismiss];
        }];
        
        [operation start];
        
        if(self.type==AUVTYPEDEVELOPER){
            
            followers.hidden=YES;
            
            src5.contents = contents1;
            [src5.gmGridView reloadData];
            [src5.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
        }else
        {
            [src4.gmGridView reloadData];
            //[src4.gmGridView setBackgroundColor:[UIColor blackColor]];
            [src4.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
            
            
        }
    }
    
}

-(void)loadCategoryDetailandHotapps:(NSString*)categoryid
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    
    AUVwebservice *service=[AUVwebservice service];
    //service.logging=NO;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [service category_page:self action:@selector(CategoryDetailandHotapphandler:) user_id:[defaults valueForKey:@"user_id"] category_id:categoryId];
    
}
-(void) CategoryDetailandHotapphandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
        // Do something with the Array* result
        SoapArray* arr = (SoapArray*)value;
        //[SVProgressHUD dismiss];
        
        
        NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
  

    
    
    name.text=[[result JSONValue]valueForKey:@"category_name"];
    
    
    
    [self.icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[result JSONValue] valueForKey:@"category_logo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    //[[contentDicitionary objectForKey:@"myapps"] addObjectsFromArray:[[result JSONValue] valueForKey:@"app_deatails"]];
    
    self.followers.text=[NSString stringWithFormat:@"%@ Followers",[[result JSONValue] valueForKey:@"no_of_category_followers"]];
    Boolean s=[[[result JSONValue]valueForKey:@"follow_check"]boolValue];
    if(s)
    {
        follow=1;
        followBtn =[[UIBarButtonItem alloc] initWithTitle:@"Unfollow" style:UIBarButtonItemStylePlain target:self action:@selector(followActionUser:)];
    }else
    {
        follow=0;
        followBtn =[[UIBarButtonItem alloc] initWithTitle:@"Follow" style:UIBarButtonItemStylePlain target:self action:@selector(followActionUser:)];
    }
    
    self.navigationItem.rightBarButtonItem=followBtn;

   
    
        id isArray = [[result JSONValue] valueForKey:@"hot_apps"];
   
    
    if ([isArray isKindOfClass:[NSDictionary class]]) {
    
        contents1 = [[NSMutableArray alloc] init];
        [contents1 addObject:[[result JSONValue] valueForKey:@"hot_apps"]];
        
    }else if ([isArray isKindOfClass:[NSArray class]]) {
  
        contents1 = [[NSMutableArray alloc] initWithArray:[[result JSONValue] valueForKey:@"hot_apps"]];
    }

   
      
    [SVProgressHUD dismiss];
    
    
     
    
    src5.contents = contents1;
    [src5.gmGridView reloadData];
    [src5.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
    }
  
}

-(void)loadCategory:(NSString*)categoryName
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    /*
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/appfindee/select?wt=json&omitHeader=true&sort=scoring+desc&start=%d&rows=12&q=*:*&fl=trackId,artworkUrl60,trackCensoredName&fq=primaryGenreId:%@",self.start,[[[NSString stringWithFormat:@"%@",categoryId]encodeParameter] processQuote]]];
    */
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://admin:hu5AsWud@appfindee.com/searchquery.php?index=category_apps&query=*:*&start=%d&primaryGenreId=%@",self.start,[[[NSString stringWithFormat:@"%@",categoryId]encodeParameter] processQuote]]];
    
   // NSLog(@"%@",url);
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest :request ];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      id JSON= [[operation responseString] JSONValue];
        
      [self processDictionary:[[JSON valueForKey:@"response"] valueForKey:@"docs"]];
      
      
      
      [SVProgressHUD dismiss];

  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
    //  NSLog(@"error %@",error);
      [SVProgressHUD dismiss];
  }];

    [operation start];
    
}

-(IBAction)addDiscussionEvent:(id)sender
{
    
   /* AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc] initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
    obj.questiontype=@"category";
    
    [self.navigationController pushViewController:obj animated:YES];*/
    
    AUVAnswerViewController *panel =[[AUVAnswerViewController alloc] initWithFrame:self.view.bounds withType:TypeCatQn];
    
    
    panel.delegate=self;
    panel.parent=self;
    
    [self.view addSubview:panel];
    [panel showFromPoint:[self.view center]];

}

-(void)commentsAction:(NSString*)comment withArg2:(NSString*)apptitle
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    AUVwebservice *service=[AUVwebservice service];
   
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [service question:self action:@selector(commentActionHandler:) category_id:categoryId app_id:@"0" user_id:    [defaults valueForKey:@"user_id"] question:apptitle description:comment];
    
}
-(void)commentActionHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    {
    
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
 
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
  
    
    NSDictionary *dict=[result JSONValue];
    
    AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
    question.questionId=[NSString stringWithFormat:@"%@",[dict valueForKey:@"question_id"]];
    question.info=[[NSMutableDictionary alloc] initWithDictionary:dict];
    
    [self.navigationController pushViewController:question animated:YES];
    }
    
}


-(void)getCategory:(id)sender
{
    //AUVwebservice *service=[AUVwebservice service];
    
    //[service ]
}

-(void) processDictionary:(NSDictionary*)test
{
    
  
    if(self.start==0)
    [contents  removeAllObjects];
    
   /* NSArray *array=[NSArray arrayWithArray:[test valueForKey:@"doc"]];
    NSString *typeName=nil;
    for(NSDictionary *dict in array)
    {
       
        
              [self dataParse:[dict valueForKey:@"field"]];
       
        
        for(int i=0;i<[[dict valueForKey:@"field"] count];i++){
               }
         }*/
    
    
        
  /*  if(self.type==AUVTYPEDEVELOPER)
    {
        self.name.text=[dataDict valueForKey:@"artistName"];
        sellerurl=[dataDict valueForKey:@"sellerUrl"];
        supporturl=[dataDict valueForKey:@"sellerUrl"];
        
        [ contents1 addObject:dataDict];
        
    }
    
    else if (self.type==AUVTYPECATEGORY)
    {
        self.name.text = [dataDict valueForKey:@"primaryGenreName"];
        [ contents addObject:dataDict];
    }*/
    
    
 

    
    if(self.type==AUVTYPEDEVELOPER){
    
        self.name.text=developer;
        
      
        
        [contents1 removeAllObjects];
     
        [contents1 addObjectsFromArray:test];
        
        sellerurl=[[contents1 objectAtIndex:0]valueForKey:@"sellerUrl"];
        supporturl=[[contents1 objectAtIndex:0]valueForKey:@"supportUrl"];
        
       // NSLog(@"%@",test);
        
        followers.hidden=YES;
        
        src5.contents = contents1;
        [src5.gmGridView reloadData];
        [src5.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
    }else
    {
         [contents addObjectsFromArray:test];
       
        
        
         src4.contents=contents;
        [src4.gmGridView reloadData];
        //[src4.gmGridView setBackgroundColor:[UIColor blackColor]];
        [src4.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];

        
    }
    
 }


-(IBAction)followActionUser:(id)sender
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    AUVwebservice *service=[AUVwebservice service];
   // service.logging=NO;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //[service appcomment:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] app_id:appId comment:comment];
    
    if(self.type==AUVTYPEPROFILE){
        if(follow==0)
    [service follow_users:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] follow_user_id:userId];
        else if(follow==1)
            [service unfollow_users:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] unfollow_user_id:userId];
    }
   else  if(self.type==AUVTYPEDEVELOPER)
    
       [service follow_developers:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] developer_id:developerId];
    
    else  if(self.type==AUVTYPECATEGORY)
    {
        if(follow==0)
        {
            [service follow_category:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] category_id:categoryId];
        //[service user_interest:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] category_id:categoryId];
        }else{
            [service unfollow_category:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] category_id:categoryId];
        }
    }
    // [service app_details:self action:@selector(detailHandler:) appid:appId];
    //[service get_appdetails:self action:@selector(detailHandler:) appid:appId];
}










-(void)followActionHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
    
	// Do something with the Array* result
   // SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    
    
    //NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];

    
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
    
    if(self.type==AUVTYPEDEVELOPER)
        [self loadDeveloper:developer];
    else if(self.type==AUVTYPECATEGORY)
       [self loadCategoryDetailandHotapps:categoryId];
        //[self loadCategory:category];
    else if(self.type=AUVTYPEPROFILE)
        [self loadProfile];
    }
   
}

-(void)dataParse:(NSArray*)arr
{
  
    NSMutableDictionary *dataDict=[[NSMutableDictionary alloc] init];
    for(NSDictionary *dict in arr)
    {
        [dataDict setObject:[dict valueForKey:@"value"] forKey:[dict valueForKey:@"name"]];
        
    }
    
    if(self.type==AUVTYPEDEVELOPER)
    {
        self.name.text=[dataDict valueForKey:@"artistName"];
        sellerurl=[dataDict valueForKey:@"sellerUrl"];
        supporturl=[dataDict valueForKey:@"sellerUrl"];
        
          [ contents1 addObject:dataDict];
       
    }
               
    else if (self.type==AUVTYPECATEGORY)
    {
        self.name.text = [dataDict valueForKey:@"primaryGenreName"];
         [ contents addObject:dataDict];
    }
    
       
   }






-(IBAction)followersList:(id)sender
{
    /* AUVwebservice *service=[AUVwebservice service];
     
     [service app_followers_list:self action:@selector(followersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:appId];*/
    
    AUVFollowersList *panel=[[AUVFollowersList alloc] initWithFrame:self.view.bounds];
    panel.delegate=self;
    panel.userId=self.userId;
    panel.catId=self.categoryId;
    panel.parent=self;
    if([sender tag]==101)
    {
       panel.type=AUVUserFollowing;
    }
    else if([sender tag]==102)
    {
         panel.type=AUVUserFollowers;
        
    }
    if([sender tag]==103)
    {
        if(self.type==AUVTYPECATEGORY)
        {
        panel.type=AUVCatagoryFollowers;
        }else if(self.type==AUVTYPEDEVELOPER)
        {
            panel.type=AUVDevFollowers;
        }
    }
    else if([sender tag]==104)
    {
        panel.type=AUVDevFollowers;
    }
   
    [self.view addSubview:panel];
    [panel showFromPoint:[self.view center]];
}




#pragma Mark BHTabbedView delegate methods
- (BOOL)shouldMakeTabCurrentAtIndex:(NSUInteger)index
                         controller:(UIViewController *)viewController
                   tabBarController:(BHTabsViewController *)tabBarController
{
    
    
    return YES;
}

- (void)didMakeTabCurrentAtIndex:(NSUInteger)index
                      controller:(UIViewController *)viewController
                tabBarController:(BHTabsViewController *)tabBarController
{
      if(index==1)
    {
         [addyourquestion setHidden:YES];
        [questionlabel setHidden:YES];
             
        if(self.type==AUVTYPECATEGORY)
        {
            if(contents.count==0)
            {
                [self loadCategory:category];
            }
        }else if(self.type==AUVTYPEPROFILE)
        {
            if([[contentDicitionary valueForKey:@"myapps"]count]==0)
            {
                [self myApps];
            }
        }else if(self.type==AUVTYPEDEVELOPER)
        {
            UIButton *supportpage=[UIButton buttonWithType:UIButtonTypeCustom];
            supportpage.frame=CGRectMake(90, 50, 150, 40);
            [supportpage setBackgroundImage:[[UIImage imageNamed:@"blue_btn"] stretchableImageWithLeftCapWidth:13.0 topCapHeight:0.0] forState:UIControlStateNormal];
            supportpage.tag=1;
            [supportpage setTitle:@"Support Page" forState:UIControlStateNormal];
            supportpage.titleLabel.font=[UIFont systemFontOfSize:13];
            [supportpage addTarget:self action:@selector(supportanddeveloperpageevent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *developerpage=[UIButton buttonWithType:UIButtonTypeCustom];
            developerpage.frame=CGRectMake(90, 110, 150, 40);
            [developerpage setBackgroundImage:[UIImage imageNamed:@"blue_btn"] forState:UIControlStateNormal];
            developerpage.tag=2;
            developerpage.font=[UIFont systemFontOfSize:13];
            [developerpage setTitle:@"Developer Page" forState:UIControlStateNormal];
            [developerpage addTarget:self action:@selector(supportanddeveloperpageevent:) forControlEvents:UIControlEventTouchUpInside];
           
            

            [src4.view addSubview:supportpage];
            [src4.view addSubview:developerpage];
            
        }
    }
    
    if(index==0)
    {
        [addyourquestion setHidden:YES];
         [questionlabel setHidden:YES];
        //[src2 reload];
        [src5.gmGridView reloadData];
        [src5.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
    }
    if(index==2)
    {
       if(tableArray.count==0)
       {
        [self loadQuestions];
       }
    }
}

-(void)supportanddeveloperpageevent:(id)sender
{
    if([sender tag]==1)
    {
        
        if(![supporturl isEqualToString:@""]&&sellerurl!=nil)
        {
            NSURL *url = [NSURL URLWithString:supporturl];
            [[UIApplication sharedApplication] openURL:url];
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Sorry! Not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        
    }else if([sender tag]==2)
    {
        if(![sellerurl isEqualToString:@""]&&sellerurl!=nil)
        {
            NSURL *url = [NSURL URLWithString:sellerurl];
            [[UIApplication sharedApplication] openURL:url];
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Sorry! Not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if([sender tag]==3)
    {
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
    }
    else if([sender tag]==4)
    {
        AUVMyAppSectionViewController *myapps = [[AUVMyAppSectionViewController alloc] initWithNibName:@"AUVMyAppSectionViewController" bundle:nil];
        
        [self.navigationController pushViewController:myapps animated:YES];

    }
    else if([sender tag]==5)
    {
        AUVQuestionChoiceViewController *notification = [[AUVQuestionChoiceViewController alloc]initWithNibName:@"AUVQuestionChoiceViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];    }
}

-(void) myApps
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    // [service question:self action:@selector(loadQuestionsHandler:) category_id:@"0" app_id:@"0" user_id:self.userId question:<#(NSString *)#>]
    //service.logging=NO;
    
    if(self.type==AUVTYPEPROFILE)
    {
        
        [service get_myapps_details:self action:@selector(loadMyAppsHandler:) user_id:self.userId];
    }
            
    if(self.type==AUVTYPECATEGORY){
        [SVProgressHUD dismiss];
        
    }
    if(self.type==AUVTYPEDEVELOPER){
        [SVProgressHUD dismiss];
        
    }
    
    // [service]
    
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
     [SVProgressHUD dismiss];
        
 
  
    [[contentDicitionary objectForKey:@"myapps"] removeAllObjects];
    [[contentDicitionary objectForKey:@"myapps"] addObjectsFromArray:[[result JSONValue] valueForKey:@"app_deatails"]];
    
    if([[contentDicitionary objectForKey:@"myapps"]count]==0)
    {
        if([self.userId integerValue]==[[AUVLogin valueforKey:@"user_id"] integerValue])
        {
            UIButton *findapps=[UIButton buttonWithType:UIButtonTypeCustom];
            findapps.frame=CGRectMake(130, 45, 70, 35);
            [findapps setBackgroundImage:[[UIImage imageNamed:@"blue_btn"] stretchableImageWithLeftCapWidth:13.0 topCapHeight:0.0] forState:UIControlStateNormal];
            findapps.tag=4;
            [findapps setTitle:@"Share" forState:UIControlStateNormal];
            findapps.titleLabel.font=[UIFont systemFontOfSize:13];
            [findapps addTarget:self action:@selector(supportanddeveloperpageevent:) forControlEvents:UIControlEventTouchUpInside];
        
            UILabel *findlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 290, 20)];
            findlabel.text=@"Share your apps to friends and community";
            findlabel.backgroundColor=[UIColor clearColor];
            findlabel.font=[UIFont systemFontOfSize:15];
        
            [src4.view addSubview:findlabel];
        
            [src4.view addSubview:findapps];
        }else
        {
            UILabel *findlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 290, 40)];
            findlabel.text=@"User has not shared any of his apps with his friends";
            findlabel.numberOfLines=2;
            findlabel.backgroundColor=[UIColor clearColor];
            findlabel.font=[UIFont systemFontOfSize:15];
            
            [src4.view addSubview:findlabel];
        }
    }
    else{
     [src4.gmGridView reloadData];
     [src4.gmGridView  layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
    }
    }

}
-(void) loadQuestions
{
    if(questionlloadingflag==0)
    {
    
        AUVwebservice *service=[AUVwebservice service];
   
        if(tableArray.count==0)
        {
            questionstart=0;
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        }else
        {
            questionstart=questionstart+10;
        }
    
            questionlloadingflag=1;
    
        if(self.type==AUVTYPEPROFILE)
            [service get_user_question:self action:@selector(loadQuestionsHandler:) user_id:self.userId limit:@"10" offset:[NSString stringWithFormat:@"%d",questionstart]];
    
        if(self.type==AUVTYPECATEGORY){
            [service get_question:self action:@selector(loadCategoryQuestionsHandler:) category_id:categoryId app_id:@"0" user_id:self.userId start:[NSString stringWithFormat:@"%d",questionstart] end:@"10"];
        }
        if(self.type==AUVTYPEDEVELOPER){
            [SVProgressHUD dismiss];

        }
    }
       
   
}


-(void)loadCategoryQuestionsHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
  //  NSLog(@"Cat %@",categoryId);
    //NSLog(@"Id %@",self.userId);
    
    [SVProgressHUD dismiss];
    SoapArray* arr = (SoapArray*)value;
    
  // NSLog(@"%@",arr);
    
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    questionlloadingflag=0;

    for (NSDictionary * dict in [[result JSONValue] valueForKey:@"question_list"]) {
        
        [tableArray addObject:dict];
    }
    
  //  NSLog(@"%@",tableArray);
    [self.questionsTable reloadData];
   
    }
}





-(void)loadQuestionsHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    [SVProgressHUD dismiss];
    SoapArray* arr = (SoapArray*)value;
    

    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
   
     questionlloadingflag=0;
   
        for (NSDictionary * dict in [[result JSONValue] valueForKey:@"question_details"]) {
         
            [tableArray addObject:dict];
        }
    
    if([tableArray count]==0)
    {
        if([self.userId integerValue]==[[AUVLogin valueforKey:@"user_id"] integerValue])
        {
            addyourquestion=[UIButton buttonWithType:UIButtonTypeCustom];
            addyourquestion.frame=CGRectMake(130, 175, 70, 35);
            [addyourquestion setBackgroundImage:[[UIImage imageNamed:@"blue_btn"] stretchableImageWithLeftCapWidth:13.0 topCapHeight:0.0] forState:UIControlStateNormal];
            addyourquestion.tag=5;
            [addyourquestion setTitle:@"Add" forState:UIControlStateNormal];
            addyourquestion.titleLabel.font=[UIFont systemFontOfSize:13];
            [addyourquestion addTarget:self action:@selector(supportanddeveloperpageevent:) forControlEvents:UIControlEventTouchUpInside];
        
        
            questionlabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 150, 305, 20)];
            questionlabel.text=@"Start your discussion on any app or category";
            questionlabel.backgroundColor=[UIColor clearColor];
            questionlabel.font=[UIFont systemFontOfSize:15];
        
            [self.view addSubview:questionlabel];
        
            [self.view addSubview:addyourquestion];
        }else
        {
            questionlabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 150, 305, 20)];
            questionlabel.text=@"No questions have been raised by user";
            questionlabel.backgroundColor=[UIColor clearColor];
            questionlabel.font=[UIFont systemFontOfSize:15];
            
            [self.view addSubview:questionlabel];
        }
        [self.questionsTable setHidden:YES];
        
    }else
    {
     [self.questionsTable reloadData];
    }
    }
}

#pragma mark UAModalPanel

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
    
    
    //if([userId integerValue]==[[AUVLogin valueforKey:@"user_id"] integerValue]){
    if(self.type==AUVTYPEDEVELOPER)
        NSLog(@"Developer");
      //  [self loadDeveloper:developer];
    else if(self.type==AUVTYPECATEGORY)
       
      [self loadCategoryDetailandHotapps:categoryId];
        //[self loadCategory:category];
    else if(self.type=AUVTYPEPROFILE)
        profilepageload=0;
        [self loadProfile];
   // }
}








#pragma mark -
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
        
        
        
               
        qHeader.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"question"]];
    
        time.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"added_date"]];
    
    
    
 
        question.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"description"]];
         if(type==AUVTYPECATEGORY)
        {
            [appicon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }else
        {
             [appicon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"appLogo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
    
    
        ans.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"answer_count"]];
        loved.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"questionlike_count"]];
      //  [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        
    
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
   
    AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
        question.questionId=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"question_id"]];
        question.info=[[NSMutableDictionary alloc] initWithDictionary:[tableArray objectAtIndex:indexPath.row]];
        
        [self.navigationController pushViewController:question animated:YES];
        
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 80;
}


-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewDidDisappear:animated];
}

-(void)reload
{
    if(self.type==AUVTYPEDEVELOPER)
        [self loadDeveloper:developer];
    else if(self.type==AUVTYPECATEGORY)
        [self loadCategory:category];
       // [self loadCategory:category];
    else if(self.type==AUVTYPEPROFILE)
        [self loadProfile];

}
@end
