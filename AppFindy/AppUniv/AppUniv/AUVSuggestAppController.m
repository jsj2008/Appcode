//
//  AUVSuggestAppController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 16/10/12.
//
//

#import "AUVSuggestAppController.h"
#import "UIImageView+AFNetworking.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "RNBlurModalView.h"
#import "AUVConstants.h"
@interface AUVSuggestAppController ()

@end

@implementation AUVSuggestAppController


@synthesize  appid,type;
NSInteger position;

-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
       // self.margin = UIEdgeInsetsMake( 10.0f,  10.0f, 10.0f,10.0f);
         self.margin = UIEdgeInsetsMake( 18.0f,  18.0f, 18.0f,18.0f);
        // Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
        self.padding = UIEdgeInsetsMake(2.0f,  2.0f, 2.0f,2.0f);
        
        // Border color of the panel. Default = [UIColor whiteColor]
        //self.borderColor = [UIColor whiteColor];
        self.headerLabel.text=@"Suggest to friends";
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
        
        tableArray=[[NSMutableArray alloc] init];
        dataArray=[[NSMutableArray alloc] init];
        NSString *nibName=@"AUVSuggestAppController";
        
       
       // table.frame=CGRectMake(0, 80, 280, 240);
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        
        
        if(IS_IPHONE_5)
        {
            view.frame=CGRectMake(0, 0, 280, 423);
            table.frame=CGRectMake(table.frame.origin.x, table.frame.origin.y,table.frame.size.width, view.frame.size.height);
        }
        
        self.contentView.backgroundColor=[UIColor lightGrayColor];
        self.contentView.layer.cornerRadius=10.0f;
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
    
    [followBtn setTitle:@"Suggest" forState:UIControlStateNormal];
    [followBtn addTarget:self action:@selector(appSuggesttofriends:) forControlEvents:UIControlEventTouchUpInside];
    //followBtn.tag=[[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"] integerValue];
    
    followBtn.tag=indexPath.row;
    
   /* if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
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
    }*/
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
    
    
  /*  if([parent isKindOfClass:[AUVDevsViewController class]])
    {
        [(AUVDevsViewController*)parent setUserId:[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"]];
        [(AUVDevsViewController*)parent setType:AUVTYPEPROFILE];
        
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
    }*/
}


- (void)showFromPoint:(CGPoint)point {
    
    [super showFromPoint:point];
    [self userFollowersList];
   
}
    
-(void)appSuggesttofriends:(id)sender
{
    //NSLog(@"id : %d",[sender tag]);
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    position=[sender tag];
    //NSLog(@"%@",appid);
    
    [service suggest:self action:@selector(appSuggesttofriendsHandler:) user_id:[AUVLogin valueforKey:@"user_id"] ref_user_id:[[tableArray objectAtIndex:[sender tag]] valueForKey:@"user_id"] a_id:appid type:type];

}


-(void)appSuggesttofriendsHandler:(id )value
{
  
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    else{
    
    AUVArray *arr=(AUVArray*)value;
    NSLog(@"Array : %@",arr);
    [SVProgressHUD dismiss];
    NSString *res=nil;
    if(arr.count>0){
        res=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];

    }
        
   // NSLog(res);
      
    if ([res boolValue]) {
     NSLog(@"True");
        [tableArray removeObjectAtIndex:position];
        [table reloadData];


    }else
    {
//        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController: title:@"" message:@"You have exceeded the day limit suggestion of 40 friends."];
//        [modal show];
        
        //[SVProgressHUD showErrorWithStatus:<#(NSString *)#>]
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"You have exceeded the day limit suggestion of 40 friends." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    }
    
    
}
    


-(void) userFollowersList
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
   
        [service following_list:self action:@selector(userFollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:@"0" offset:@"10"];
}


-(void)userFollowersListHandler:(id )value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    else{
    
    AUVArray *arr=(AUVArray*)value;
    //NSLog(@"%@",arr);
    
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    // //NSLog(@"REsult : %@",result);
    
    //NSLog(@"%@",[result JSONValue]);
    id jsResult=[[result JSONValue] valueForKey:@"user_details"];
    if([jsResult isKindOfClass:[NSArray class]])
    {
        [dataArray removeAllObjects];
        [dataArray addObjectsFromArray:jsResult];
        [tableArray removeAllObjects];
        [tableArray addObjectsFromArray:jsResult];
    }
    
    [table reloadData];
    }
}

/*
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
    SoapArray *arr=(SoapArray*)value;
    
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    // //NSLog(@"REsult : %@",result);
    
    //NSLog(@"%@",[result JSONValue]);
    
    if([[[result JSONValue] valueForKey:@"message"] boolValue] || [[[result JSONValue] valueForKey:@"message"] isEqualToString:@"success"])
    {
        [self userFollowersList];
    }
    else{
        [SVProgressHUD dismiss];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:[[result JSONValue] valueForKey:@"message"]  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}





-(void) followersList
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    if(self.type==AUVCatagoryFollowers)
        // [service user_followers_list:self action:@selector(userFollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"]];
        [service category_followers_list:self action:@selector(followersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] category_id:catId];
    if(self.type==AUVDevFollowers)
        [service developer_followers_list:self action:@selector(followersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] developer_id:devId];
}






-(void)followersListHandler:(id )value
{
    
    AUVArray *arr=(AUVArray*)value;
    //NSLog(@"%@",arr);
    
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    // //NSLog(@"REsult : %@",result);
    
    //NSLog(@"%@",[result JSONValue]);
    id jsResult=[[result JSONValue] valueForKey:@"user_details"];
    if([jsResult isKindOfClass:[NSArray class]])
    {
        [tableArray removeAllObjects];
        [tableArray addObjectsFromArray:jsResult];
    }
    
    [table reloadData];
    
}
*/
-(void)hide
{
    [SVProgressHUD dismiss];
    [super hide];
}

#pragma mark - UISearchBarDelegate Methods

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    
    
    
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    //dataArray
    
    return YES;
}


-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString *)searchText
{
    
    [tableArray removeAllObjects];
    ////NSLog(@"test: %@",text);
    
    if(searchText.length==0){
        [tableArray addObjectsFromArray:dataArray];
    }
    else{
        
        NSPredicate *predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
            ////NSLog(@" : %@",obj);
            NSString *string=[NSString stringWithFormat:@"%@ %@ %@",[(NSDictionary*)obj  valueForKey:@"username"],[(NSDictionary*)obj  valueForKey:@"firstname"],[(NSDictionary*)obj  valueForKey:@"lastname"]];
            // //NSLog(@"%@  %@",string,searchBar.text);
            NSRange range=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            
            if(range.location!=NSNotFound)
            {
                // //NSLog(@"succ : %d",range.location);
                return YES;
            }
            else
            {
                return NO;
                
            }
            
            //return <#expression#>
            //[string compare:text options:NSCaseInsensitiveSearch range:<#(NSRange)#>]
            // return  [[[(NSDictionary*)obj  valueForKey:@"firstname"] capitalizedString] isEqualToString:[self.title capitalizedString]] ||[[[(NSDictionary*)obj  valueForKey:@"lastname"] capitalizedString] isEqualToString:[self.title capitalizedString]]  ;
        }];
        
        
        
        [tableArray addObjectsFromArray:[dataArray filteredArrayUsingPredicate:predicate]];
        
        //  //NSLog(@"tab : %@",tableArray);
    }
    [table reloadData];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // Existing code
    
    // Removing the disableViewOverlay
    [searchBar resignFirstResponder];
}


@end
