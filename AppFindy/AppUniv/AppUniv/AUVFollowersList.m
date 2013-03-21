//
//  AUVFollowersList.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 01/10/12.
//
//

#import "AUVFollowersList.h"
#import "UIImageView+AFNetworking.h"
#import "AUVwebservice.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "JSON.h"

#import "SVPullToRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "StyledPullableView.h"

@implementation AUVFollowersList

@synthesize appId,type,catId,devId,userId,parent,selectedUserId,questionid,table;

int questionfollowerstart=0;
int appfollowerstart=0;
int categoryfollowerstart=0;

int userfollowerstart=0;
int userfollowingstart=0;


int questionfollowerflag=0;
int appfollowersflag=0;
int categoryfollowerflag=0;

int userfollowersflag=0;
int userfollowingflag=0;


-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        self.margin = UIEdgeInsetsMake( 10.0f,  10.0f, 10.0f,10.0f);
        
        // Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
        self.padding = UIEdgeInsetsMake(10.0f,  10.0f, 10.0f,10.0f);
        
        // Border color of the panel. Default = [UIColor whiteColor]
        //self.borderColor = [UIColor whiteColor];
        
        self.headerLabel.text=@"Users following";
        self.headerLabel.font=[UIFont boldSystemFontOfSize:18];
        // Border width of the panel. Default = 1.5f;
        self.borderWidth = 2.0f;
        
        // Corner radius of the panel. Default = 4.0f
        self.cornerRadius = 10;
        
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
        // Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
        //self.contentColor = [UIColor colorWithRed:(arc4random() % 2) green:(arc4random() % 2) blue:(arc4random() % 2) alpha:1.0];
        
        // Shows the bounce animation. Default = YES
        self.shouldBounce = YES;
        
        // Shows the actionButton. Default title is nil, thus the button is hidden by default
        //[self.actionButton setTitle:@"Login" forState:UIControlStateNormal];
        //self.actionButton.userInteractionEnabled=NO;
        
       
       
        NSString *nibName=@"AUVFollowersList";
        
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        
        if (IS_IPHONE_5) {
            view.frame=CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
        }else{
            view.frame=CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height-80);
        }
        
       
        
        [self.contentView addSubview:view ];
        
    }
    return self;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *identifier = @"TableCell";
    // UITableViewCell *cell=nil;
    UILabel *name;
    
    UIView *baseView;
    UILabel *fullName;
    UIImageView *icon;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	UIButton *followBtn;
	if(cell !=nil){
		cell=nil;
	}
    
    
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
                        // CGRectApplyAffineTransform(cell.bounds, rotateImage)
            baseView=[[UIView alloc] initWithFrame:cell.frame];
            
            baseView.backgroundColor=[UIColor clearColor];
            icon =[[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 48, 54)];
            
            icon.layer.cornerRadius=10.0;
            icon.clipsToBounds=YES;
            
            
            name=[[UILabel alloc] initWithFrame:CGRectMake(60, 2, 100, 22)];
            name.font=[UIFont systemFontOfSize:12];
            name.textColor=[UIColor blueColor];
            name.backgroundColor=[UIColor clearColor];
           // name.textAlignment=UITextAlignmentCenter;
            
            followBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            followBtn.titleLabel.textColor=[UIColor whiteColor];
            followBtn.titleLabel.font=[UIFont systemFontOfSize:11];
            followBtn.frame=CGRectMake(210, 2, 60, 30);
            [followBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn"] forState:UIControlStateNormal];
            
            fullName=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, 210, 22)];
            fullName.font=[UIFont systemFontOfSize:13];
            fullName.textColor=[UIColor grayColor];
            fullName.backgroundColor=[UIColor clearColor];
            //fullName.textAlignment=UITextAlignmentCenter;

            [baseView addSubview:icon];
            [baseView addSubview:name];
            [baseView addSubview:followBtn];
            [baseView addSubview:fullName];
            [cell addSubview:baseView];
            cell.backgroundColor=[UIColor clearColor];
        }
        
       // NSArray *friendsArray=[NSArray arrayWithArray:[appDic valueForKey:@"friends_app_like"]];
        [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
        {
            [followBtn setTitle:@"- Unfollow" forState:UIControlStateNormal];
            [followBtn addTarget:self action:@selector(unFollowUser:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
          [followBtn setTitle:@"+ Follow" forState:UIControlStateNormal];
            [followBtn addTarget:self action:@selector(followUser:) forControlEvents:UIControlEventTouchUpInside];

        }
    followBtn.tag=[[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"] integerValue];
    
    if([[AUVLogin valueforKey:@"user_id"] integerValue] ==[[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"] integerValue])
    {
        followBtn.hidden=YES;
    }
    if([[AUVLogin valueforKey:@"user_id"] integerValue]!=userId.intValue)
    {
        followBtn.hidden=YES;
    }
      //  [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash3/173132_100001693686032_1857987949_s.jpg"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    name.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"firstname"]];
    
    fullName.text=[NSString stringWithFormat:@"%@ %@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[tableArray objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //if(tableView==likedFriends)return <#expression#>
    
    return 60;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if([parent isKindOfClass:[AUVDevsViewController class]])
    {
       // [(AUVDevsViewController*)parent setUserId:[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"]];
        //[(AUVDevsViewController*)parent setType:AUVTYPEPROFILE];
        
        AUVDevsViewController *profile=(AUVDevsViewController*)parent;
        AUVDevsViewController *nextUser=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVFBPROFILE];
        nextUser.userId=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"];
        self.delegate=nextUser;
        [[profile navigationController] pushViewController:nextUser animated:YES];
        
        [self hide];
    }
    else
    {
        self.selectedUserId=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"];
        
        [self hide];
//        AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
//        profile.userId=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"];
//        if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
//            profile.follow=1;
//       // [self.navigationController pushViewController:profile animated:YES];
    }
}

-(void)loadQuestionFollowers
{
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    
    [service question_followers_list:self action:@selector(QuestionFollowerListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] question_id:questionid limit:[ NSString stringWithFormat:@"%d",userfollowerstart] offset:@"1"];

    
   // [service app_followers_list:self action:@selector(appfollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:appId];
    
}

-(void)QuestionFollowerListHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    [SVProgressHUD dismiss];
    AUVArray *arr=(AUVArray*)value;
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
   
 
    id jsResult=[result JSONValue];
    if([jsResult isKindOfClass:[NSArray class]])
    {
        //[tableArray removeAllObjects];
        [tableArray addObjectsFromArray:jsResult];
    }else
    {
        //[tableArray removeAllObjects];
        [tableArray addObjectsFromArray:[[result JSONValue]valueForKey:@"question_followers_list"]];
    }
   
    
    userfollowersflag=0;
    
    [self.table reloadData];
    }
    
}


-(void)loadAppFollowers
{
     AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
     [service app_followers_list:self action:@selector(appfollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:appId limit:[ NSString stringWithFormat:@"%d",userfollowerstart] offset:@"10"];

}



-(void)appfollowersListHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
    [SVProgressHUD dismiss];
    AUVArray *arr=(AUVArray*)value;
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];

    id jsResult=[result JSONValue];
    if([jsResult isKindOfClass:[NSArray class]])
    {
        //[tableArray removeAllObjects];
        [tableArray addObjectsFromArray:jsResult];
    }
    
    userfollowersflag=0;
    
    [self.table reloadData];
    }
    
}



- (void)showFromPoint:(CGPoint)point {

    [super showFromPoint:point];
    
     tableArray=[[NSMutableArray alloc] init];
    
   
    // livelyTableView.backgroundColor=[UIColor greenColor];
    __unsafe_unretained AUVFollowersList *list=self;
    [self.table addInfiniteScrollingWithActionHandler:^{
        
        
        [list performSelectorOnMainThread:@selector(loadAllFollowingandFollowers) withObject:nil waitUntilDone:YES];
        
        [table.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];

    
    [self loadAllFollowingandFollowers];
    
}

-(void)loadAllFollowingandFollowers
{
    if(userfollowersflag==0)
    {
        userfollowersflag=1;
            
        if(tableArray.count==0)
        {
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            userfollowerstart=0;
        }
        else
        {
            userfollowerstart=userfollowerstart+10;
        }
    
    if(self.type==AUVAppFollowers)
    {
        [self loadAppFollowers];
    }
    else if(self.type==AUVQuestionFollowers)
    {
        [self loadQuestionFollowers];
    }
    else
    {
        if(self.type==AUVUserFollowing)
        {
            self.headerLabel.text=@"Followed Users";
            [self userFollowersList];
        }
        if(self.type==AUVUserFollowers)
        {
            [self userFollowersList];
        }
        if(self.type==AUVCatagoryFollowers)
        {
            // [self userFollowersList];
            [self followersList];
        }
        if(self.type==AUVDevFollowers)
        {
            [self userFollowersList];
        }
    }
    }

}

-(void) userFollowersList
{

    AUVwebservice *service=[AUVwebservice service];

    
        if(self.type==AUVUserFollowers)
        {

            [service user_followers_list:self action:@selector(userFollowersListHandler:) user_id:userId limit:[ NSString stringWithFormat:@"%d",userfollowerstart] offset:@"10"];
        
        }
        if(self.type==AUVUserFollowing)
        {
            [service following_list:self action:@selector(userFollowersListHandler:) user_id:userId limit:[ NSString stringWithFormat:@"%d",userfollowerstart] offset:@"10"];
        }
        if(self.type==AUVCatagoryFollowers)
        {
            [service category_followers_list:self action:@selector(userFollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] category_id:catId limit:[ NSString stringWithFormat:@"%d",userfollowerstart] offset:@"10"];
        }
        if(self.type==AUVDevFollowers)
        {
            [service developer_followers_list:self action:@selector(userFollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] developer_id:devId];
        }
        if(self.type==AUVAppFollowers)
        {
            [self loadAppFollowers];
        }
        if(self.type==AUVQuestionFollowers)
        {
            [self loadQuestionFollowers];
        }
}
-(void)userFollowersListHandler:(id )value
{
    
    AUVArray *arr=(AUVArray*)value;
 
    
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
   // //NSLog(@"REsult : %@",result);
    id jsResult;
    if(self.type==AUVCatagoryFollowers)
     jsResult=[[result JSONValue] valueForKey:@"category_followers_list"];
    else
     jsResult=[[result JSONValue] valueForKey:@"user_details"];
    
    if([jsResult isKindOfClass:[NSArray class]])
    {
       // [tableArray removeAllObjects];
        [tableArray addObjectsFromArray:jsResult];
    }
    
    userfollowersflag=0;
   
    [self.table reloadData];
    
}

-(IBAction)followUser:(id)sender
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    [service follow_users:self action:@selector(followUnfollwHandler:) user_id:[AUVLogin valueforKey:@"user_id"] follow_user_id:[NSString stringWithFormat:@"%d",[sender tag]]];
    
}


-(IBAction)unFollowUser:(id)sender
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];

    [service unfollow_users:self action:@selector(followUnfollwHandler:)  user_id:[AUVLogin valueforKey:@"user_id"] unfollow_user_id:[NSString stringWithFormat:@"%d",[sender tag]]];
}


-(void)followUnfollwHandler:(id)value
{
    
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray *arr=(SoapArray*)value;
    
   
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
     [SVProgressHUD dismiss];
   
    
    if([[[result JSONValue] valueForKey:@"message"] boolValue] || [[[result JSONValue] valueForKey:@"message"] isEqualToString:@"success"])
    {
        [tableArray removeAllObjects];
         userfollowerstart=0;
        [self loadAllFollowingandFollowers];
    }
    else{
         [SVProgressHUD dismiss];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:[[result JSONValue] valueForKey:@"message"]  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    }

}





-(void) followersList
{
    
    AUVwebservice *service=[AUVwebservice service];
    
    if(self.type==AUVCatagoryFollowers)
       
        [service category_followers_list:self action:@selector(followersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] category_id:catId limit:[ NSString stringWithFormat:@"%d",userfollowerstart] offset:@"10"];
    if(self.type==AUVDevFollowers)
        [service developer_followers_list:self action:@selector(followersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] developer_id:devId];
}

-(void)followersListHandler:(id )value
{
    
    AUVArray *arr=(AUVArray*)value;
    
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
   
    id jsResult=[[result JSONValue] valueForKey:@"category_followers_list"];
    if([jsResult isKindOfClass:[NSArray class]])
    {
       // [tableArray removeAllObjects];
        [tableArray addObjectsFromArray:jsResult];
    }
    
    userfollowersflag=0;
    
    [self.table reloadData];
    
}

-(void)hide
{
   [SVProgressHUD dismiss];
    [super hide];
}



@end
