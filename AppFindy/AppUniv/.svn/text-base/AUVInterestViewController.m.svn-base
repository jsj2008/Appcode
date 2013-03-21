//
//  AUVInterestViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 11/10/12.
//
//

#import "AUVInterestViewController.h"

#import "AUVCategoryCell.h"
#import "AUVwebservice.h"
#import "SVProgressHUD.h"
#import "AUVLogin.h"
#import "JSON.h"
#import "UIImageView+AFNetworking.h"
#import "AUVDevsViewController.h"
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

@interface AUVInterestViewController ()

@end

@implementation AUVInterestViewController
NSMutableArray *questionArray;
NSMutableArray *appsArray;
NSMutableArray *friendsarray;

int intereststart=0;
int interestloadingflag=0;

int interestfirendsstart=0;
int interestfriendsflag=0;

@synthesize gmGridView,type;
@synthesize tableview;

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
    //self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    categoriesArray=[[NSMutableArray alloc] init];
    questionArray=[[NSMutableArray alloc] init];
    appsArray=[[NSMutableArray alloc] init];
    friendsarray=[[NSMutableArray alloc]init];
    
    [segmentedControl addTarget:self
                         action:@selector(action:)
               forControlEvents:UIControlEventValueChanged];
    
       
    
    self.title=@"Interest";
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [self GridViewSetUp];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu"] style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    // [self getCategories:nil];
    
    // Do any additional setup after loading the view from its nib.
    
      // livelyTableView.backgroundColor=[UIColor greenColor];
    
   __unsafe_unretained AUVInterestViewController *interest=self;
    [self.tableview addInfiniteScrollingWithActionHandler:^{
        
        
        [interest performSelectorOnMainThread:@selector(getFollowedQuestions) withObject:nil waitUntilDone:YES];
        
        [tableview.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];

    
  //  AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
    //custombar.delegate= self;
    
    //[self.view addSubview:custombar];
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

-(void)GridViewSetUp
{
    if(!gmGridView)
    {
        if (IS_IPHONE_5) {
            
            container.frame=CGRectMake(container.frame.origin.x, container.frame.origin.y, container.frame.size.width,container.frame.size.height+100);
            
        }
    gmGridView = [[GMGridView alloc] initWithFrame:container.bounds];
    //gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.style = GMGridViewStylePush;
    gmGridView.itemSpacing = 5;
   // gmGridView.frame=CGRectMake(0, 0, 320, 370);
    gmGridView.clipsToBounds=YES;
    gmGridView.pagingEnabled=YES;
    gmGridView.backgroundColor=[UIColor clearColor];//[UIColor colorWithWhite:0.1 alpha:0.2];

    //gmGridView.minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
      
 
    gmGridView.delegate=self;
    gmGridView.dataSource=self;
    gmGridView.actionDelegate=self;
    //gmGridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
        
         gmGridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontalPagedLTR];
        
        
        
        //GMGridViewLayoutHorizontalPagedTTB
    //[container addSubview:gmGridView];
   // self.gridView.centerGrid = control.on;
   // [self.gridView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
    }
    
    if(!tableview){
    
    tableview=[[UITableView alloc] initWithFrame:container.bounds style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
       
    }
    
    if(type!= Questions && type!=friends)
    {
        if(tableview) [tableview removeFromSuperview];
        [container addSubview:gmGridView];
       
    }

    else
    {
        if(gmGridView) [gmGridView removeFromSuperview];
    
        [container addSubview:tableview];
    }


    [self loadContentViews:type];

}





#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    if(type==Categories)
    return categoriesArray.count;
    else if(type==Apps)
        return appsArray.count;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(170, 135);
        }
        else
        {
            return CGSizeMake(150, 110);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(285, 205);
        }
        else
        {
            return CGSizeMake(230, 175);
        }
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
  
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    UIImageView *iconImage;
    UIView *textLabelBackgroundView ;
    UILabel* textLabel;
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    if(cell) cell=nil;
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        //cell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
        // cell.deleteButtonOffset = CGPointMake(-15, -15);
        // cell.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        //view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 1;
        
        
        view.backgroundColor = [UIColor whiteColor];
        //[view addSubview:self.backgroundView];
        /*self.baseContainer=[[[UIView alloc] initWithFrame:CGRectNull] autorelease];
         self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
         [self addSubview:self.backgroundView];*/
        
        iconImage=[[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 80, 80)];
        
       // [iconImage.layer setBorderWidth:1.0f];
        iconImage.layer.cornerRadius=10.0f;
        
        [view  addSubview:iconImage];
       // iconImage.layer.cornerRadius=10.0f;
        iconImage.clipsToBounds=YES;
        
        // Label
        textLabelBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 82, 140, 30)];
        
        
        //  self.textLabelBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        textLabelBackgroundView.backgroundColor=[UIColor clearColor];
        
        textLabel = [[UILabel alloc] initWithFrame:textLabelBackgroundView.frame];
        textLabel.textAlignment = UITextAlignmentCenter;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor blackColor];
        textLabel.font = [UIFont systemFontOfSize:13];
        textLabel.numberOfLines = 1;
        textLabel.lineBreakMode=UILineBreakModeWordWrap;
        
        [view addSubview:textLabel];
        [view addSubview:textLabelBackgroundView];
        cell.layer.borderWidth=1.0f;
        cell.layer.borderColor=[UIColor grayColor].CGColor;
        //cell.layer.cornerRadius=10.0f;
        cell.contentView = view;
    }
    
    //[[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    /* UIImageView *imageV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a_shopping"]];
     imageV.frame=CGRectMake(10,5, size.width-20, size.width-50);
     [cell.contentView addSubview:imageV];
     UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
     label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
     label.text = @"test";//(NSString *)[_currentData objectAtIndex:index];
     label.textAlignment = UITextAlignmentCenter;
     label.backgroundColor = [UIColor clearColor];
     label.textColor = [UIColor blackColor];
     label.highlightedTextColor = [UIColor whiteColor];
     label.font = [UIFont boldSystemFontOfSize:20];
     [cell.contentView addSubview:label];*/
    //[iconImage setImage:[UIImage imageNamed:@"a_shopping"]];
    
    if(type==Apps){
        
        textLabel.text = [[appsArray objectAtIndex:index] valueForKey:@"appname"];
        
     
        
        [iconImage setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[appsArray objectAtIndex:index] valueForKey:@"applogo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    }
    
    else if(type==Categories)
    {
        textLabel.text = [[categoriesArray objectAtIndex:index] valueForKey:@"category_name"];
        
        [iconImage setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[categoriesArray objectAtIndex:index] valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }

    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return NO; //index % 2 == 0;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
  
    if(type==Categories){
    AUVDevsViewController *devsView=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil type:AUVTYPECATEGORY];
    //devsView.detailController=self;
    devsView.categoryId=[[categoriesArray objectAtIndex:position] valueForKey:@"category_id"];
    devsView.category=[[categoriesArray objectAtIndex:position] valueForKey:@"category_name"];
        
   
    [self.navigationController pushViewController:devsView animated:YES];
    }
    else if(type==Apps)
    {
        AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:@"AUVDetailViewController" bundle:nil];
        detailView.appId=[[appsArray objectAtIndex:position] valueForKey:@"appid"];
        [self.navigationController pushViewController:detailView animated:YES];
    }
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{

}



//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    //NSObject *object = [_currentData objectAtIndex:oldIndex];
    //[_currentData removeObject:object];
    //[_currentData insertObject:object atIndex:newIndex];
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
   // [_currentData exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}


//////////////////////////////////////////////////////////////
#pragma mark DraggableGridViewTransformingDelegate
//////////////////////////////////////////////////////////////

- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index inInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(320, 210);
        }
        else
        {
            return CGSizeMake(300, 310);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(700, 530);
        }
        else
        {
            return CGSizeMake(600, 500);
        }
    }
}

- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIView *fullView = [[UIView alloc] init];
    fullView.backgroundColor = [UIColor yellowColor];
    fullView.layer.masksToBounds = NO;
    fullView.layer.cornerRadius = 8;
    
    CGSize size = [self GMGridView:gridView sizeInFullSizeForCell:cell atIndex:index inInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    fullView.bounds = CGRectMake(0, 0, size.width, size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:fullView.bounds];
    label.text = [NSString stringWithFormat:@"Fullscreen View for cell at index %d", index];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (INTERFACE_IS_PHONE)
    {
        label.font = [UIFont boldSystemFontOfSize:15];
    }
    else
    {
        label.font = [UIFont boldSystemFontOfSize:20];
    }
    
    [fullView addSubview:label];
    
    
    return fullView;
}

- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blueColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEnterFullSizeForCell:(UIView *)cell
{
    
}




-(void)getCategories:(id)sender
{
    [AUVwebservice cancelPreviousPerformRequestsWithTarget:self];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    //service.logging=NO;
    
    
    [service get_user_interest:self action:@selector(getCategoriesHandler:) user_id:[AUVLogin valueforKey:@"user_id"]];
    
    
}


-(void)getCategoriesHandler:(id)value
{
    
    SoapArray *arr=(SoapArray*)value;
    NSString *result=[[[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\\" withString:@""] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    
    
    NSDictionary *dict=[result JSONValue];
    
  
    [categoriesArray removeAllObjects];
    
    NSPredicate *predicate;
    predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
        
        
        return  [[(NSDictionary*)obj  valueForKey:@"interest"] isEqualToString:@"true"] ;
    }];

   
    NSArray *categories=[(NSArray*)[dict valueForKey:@"category_list"]  filteredArrayUsingPredicate:predicate ];
        [categoriesArray addObjectsFromArray:categories];
    
    
    
    [gmGridView reloadData];
    [gmGridView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
    
    if(categoriesArray.count==0)
{
       // [gmGridView removeFromSuperview];
        message.text=@"You are not following any Categories.";
    }
    [SVProgressHUD dismiss];
    
}

-(void) userFollowersList
{
    

    AUVwebservice *service=[AUVwebservice service];
    
  //  [service following_list:self action:@selector(userFollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:[NSString stringWithFormat:@"%d",interestfirendsstart] offset:@"10"];
    

    [service user_followers_list:self action:@selector(userFollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:[NSString stringWithFormat:@"%d",interestfirendsstart] offset:@"10"];
}


-(void)userFollowersListHandler:(id )value
{
    
    AUVArray *arr=(AUVArray*)value;
        
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];

    id jsResult;
   
        jsResult=[[result JSONValue] valueForKey:@"user_details"];
    
    if([jsResult isKindOfClass:[NSArray class]])
    {
        //[friendsarray removeAllObjects];
        [friendsarray addObjectsFromArray:jsResult];
    }
    interestfriendsflag=0;
    
       [self.tableview reloadData];
    
}

-(void)getFollowedQuestions
{
    if(type==Questions)
    {
    
        if(interestloadingflag==0)
        {
    
            if(questionArray.count!=0)
            {
                intereststart=intereststart+10;
            }else
            {
    
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
                intereststart=0;
            }
            interestloadingflag=1;
            AUVwebservice *service=[AUVwebservice service];
    
            [service get_follow_question:self action:@selector(userQuestionsHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:@"10" offset:[NSString stringWithFormat:@"%d",intereststart]];
        }
    }else if(type==friends)
    {
        if(interestfriendsflag==0)
        {
            interestfriendsflag=1;
            if(friendsarray.count==0)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
                interestfirendsstart=0;

            }else
            {
                interestfirendsstart=interestfirendsstart+10;
            }
            
            [self userFollowersList];
        }
    }
   
}


-(void)userQuestionsHandler:(id)value
{
    
    SoapArray *arr=(SoapArray*)value;
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
 
    interestloadingflag=0;
     //NSLog(@"%@",result);
    
    [questionArray addObjectsFromArray:[[result JSONValue] valueForKey:@"question_details"]];
    
  
    //NSLog(@"%@",questionArray);
    
    [SVProgressHUD dismiss];
    
    [self.tableview reloadData];
    
}


-(void)getFollowedApps
{
    message.text=@"";
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    AUVwebservice *service=[AUVwebservice service];
    [service get_follow_apps:self action:@selector(followedAppsHandler:) user_id:[AUVLogin valueforKey:@"user_id"] ];
    
    
}

-(void)followedAppsHandler:(id)value
{
    SoapArray *arr=(SoapArray*)value;
    
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
   
    NSArray *array=[[result JSONValue] valueForKey:@"app_details"];
    [appsArray removeAllObjects];
    [appsArray addObjectsFromArray:array];
   // if(appsArray.count!=0)
    [gmGridView reloadData];
    if(appsArray.count==0)
    {
        message.text=@"You are not following any apps";
    }
    [SVProgressHUD dismiss];
  // [gmGridView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
}


-(void)action:(id)sender {
    
    
    if(segmentedControl.selectedSegmentIndex==0){
        
        message.text=@"";
        type=Categories;
    }
    else if(segmentedControl.selectedSegmentIndex==1)
    {
        
        message.text=@"";
        type=Apps;
    }
    
    else if(segmentedControl.selectedSegmentIndex==2)
    {
        
        message.text=@"";
        type=Questions;
    }
    else if(segmentedControl.selectedSegmentIndex==3)
    {
        
        message.text=@"";
        type=friends;
    }
    [self GridViewSetUp];
}



-(void)loadContentViews:(ContentType)type
{
    if(type==Categories)
    {
        if(categoriesArray.count==0)
        [self getCategories:nil];
        else
        {
            [gmGridView reloadData];
            [gmGridView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
        }
        
    }
    else if(type==Apps)
    {
        if(appsArray.count==0)
        [self getFollowedApps];
        
        else
        {
            [gmGridView reloadData];
            [gmGridView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
        }

    }
    
    else if(type==Questions)
    {
        if(questionArray.count==0)
        [self getFollowedQuestions];
        
        else [self.tableview reloadData];
    }
    else if(type==friends)
    {
        if(friendsarray.count==0)
        {
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            [self userFollowersList];
        }else
        {
            [self.tableview reloadData];
        }
    }
}

-(void)followAction:(id)sender
{
   
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(type==Questions)
    {
        if(questionArray.count!=0)
        return questionArray.count;
        else return 1;
    }
    else
    {
        if(friendsarray.count!=0)
        return friendsarray.count;
        else return 1;
    }
    
    
        }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell=nil;

    static NSString *identifier = @"defaultcell";
    cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    UILabel *qHeader;
    UILabel *question;
    UILabel *ans;
    UILabel *loved;
    UIView *baseView;
    UIButton *followBtn;
    UIImageView *icon;
    
    if(cell !=nil){
        cell=nil;
    }
    
    
    if(type==Questions){
    if(questionArray.count>0){
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        
        cell.backgroundColor=[UIColor clearColor];
        baseView=[[UIView alloc] initWithFrame:cell.frame];
        
        baseView.backgroundColor=[UIColor clearColor];
        icon=[[UIImageView alloc] initWithFrame:CGRectMake(267, 10, 40, 40)];
       // icon.layer.cornerRadius=10;
        icon.clipsToBounds=YES;
        
        qHeader=[[UILabel alloc] initWithFrame:CGRectMake(5, 2, 270, 20)];
        qHeader.numberOfLines=1;
        qHeader.font=[UIFont systemFontOfSize:16];
        qHeader.backgroundColor=[UIColor clearColor];
        
        
        question=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 270, 60)];
        question.numberOfLines=3;
        question.font=[UIFont systemFontOfSize:13];
        question.backgroundColor=[UIColor clearColor];
        
 

        followBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        followBtn.frame=CGRectMake(200, 60, 100, 30);
        
        [followBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn"] forState:UIControlStateNormal];
        
               
        [followBtn addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
       
        
        UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, 75, 320, 2)];
        line.image=[UIImage imageNamed:@"seprater"];
        
        [baseView addSubview:qHeader];
        [baseView addSubview:question];
       // [baseView addSubview:followBtn];
        [baseView addSubview:icon];
        [baseView addSubview:line];
        [cell addSubview:baseView];
    }
        
        
        
        
                   qHeader.text=[NSString stringWithFormat:@"%@",[[questionArray objectAtIndex:indexPath.row] valueForKey:@"question"]];
        
            question.text=[NSString stringWithFormat:@"%@",[[questionArray objectAtIndex:indexPath.row] valueForKey:@"description"]];
                   
            [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[[questionArray objectAtIndex:indexPath.row] valueForKey:@"user_deatils"]objectAtIndex:0]valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
            followBtn.tag=[[NSString stringWithFormat:@"%@",[[questionArray objectAtIndex:indexPath.row] valueForKey:@"question_id"]]integerValue];
        
            if([[[questionArray objectAtIndex:indexPath.row] valueForKey:@"question_follow"] boolValue])
                [followBtn setTitle:@"Unfollow" forState:UIControlStateNormal];
            else [followBtn setTitle:@"Follow" forState:UIControlStateNormal];
    
        
      
           }
    else
    {
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:  identifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textAlignment=UITextAlignmentCenter;
        
        if(type==Questions)
            cell.textLabel.text=@"You are not following any Questions.";
        else
            cell.textLabel.text=@"You are not following any friends.";
        
    }

       
    }
    if(type==friends)
    {
        if(friendsarray.count>0){
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                
                
                
                cell.backgroundColor=[UIColor clearColor];
                baseView=[[UIView alloc] initWithFrame:cell.frame];
                
                baseView.backgroundColor=[UIColor clearColor];
                icon=[[UIImageView alloc] initWithFrame:CGRectMake(267, 10, 40, 40)];
                // icon.layer.cornerRadius=10;
                icon.clipsToBounds=YES;
                
                qHeader=[[UILabel alloc] initWithFrame:CGRectMake(5, 2, 270, 20)];
                qHeader.numberOfLines=1;
                qHeader.font=[UIFont systemFontOfSize:16];
                qHeader.backgroundColor=[UIColor clearColor];
                
                
                question=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 270, 60)];
                question.numberOfLines=3;
                question.font=[UIFont systemFontOfSize:13];
                question.backgroundColor=[UIColor clearColor];
                
                
                
                followBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                followBtn.frame=CGRectMake(200, 60, 100, 30);
                
                [followBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn"] forState:UIControlStateNormal];
                
                
                [followBtn addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
                
                
                UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, 75, 320, 2)];
                line.image=[UIImage imageNamed:@"seprater"];
                
                [baseView addSubview:qHeader];
                [baseView addSubview:question];
                // [baseView addSubview:followBtn];
                [baseView addSubview:icon];
                [baseView addSubview:line];
                [cell addSubview:baseView];

                
        qHeader.text=[NSString stringWithFormat:@"%@",[[friendsarray objectAtIndex:indexPath.row] valueForKey:@"username"]];
        
        NSString *fname=[NSString stringWithFormat:@"%@",[[friendsarray objectAtIndex:indexPath.row] valueForKey:@"firstname"]];
        
        if(![fname isEqualToString:@"<null>"])
        {
            question.text=[NSString stringWithFormat:@"%@",[[friendsarray objectAtIndex:indexPath.row] valueForKey:@"firstname"]];
        }
        
        [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[friendsarray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        
    }
        }
        else
        {
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:  identifier];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            cell.textLabel.textAlignment=UITextAlignmentCenter;
            
            if(type==Questions)
                cell.textLabel.text=@"You are not following any Questions.";
            else
                cell.textLabel.text=@"You are not following any friends.";
            
        }
    }


   // cell.selectionStyle=UITableViewCellSelectionStyleNone;


return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(type==Questions)
    {
        if(questionArray.count>0){
            AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
            question.questionId=[NSString stringWithFormat:@"%@",[[questionArray objectAtIndex:indexPath.row] valueForKey:@"question_id"]];
               
            [self.navigationController pushViewController:question animated:YES];
        
        }
    }else if(type==friends)
    {
        AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
        profile.userId=[[friendsarray objectAtIndex:indexPath.row] valueForKey:@"user_id"] ;
        
        if([[[friendsarray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
            profile.follow=1;
        
        [self.navigationController pushViewController:profile animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
         //if(type==Question)
        return 80;
}

@end
