//
//  AUVFriendsViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVFriendsViewController.h"
#import "AUVConstants.h"
#import "JSON.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "AUVAppWallController.h"
#import "SVProgressHUD.h"
#import "RearViewController.h"
#import "RevealController.h"
@interface AUVFriendsViewController ()

@end

@implementation AUVFriendsViewController

NSMutableArray *fbFriends;
NSMutableArray *auvFriends;
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
    fbFriends=[[NSMutableArray alloc] init];
    auvFriends=[[NSMutableArray alloc] init];
    facebook=[AUV_DELEGATE facebook];
    self.navigationController.navigationBarHidden=NO;
    [self createUI];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) createUI
{
    
    
   /* self.view.backgroundColor=[UIColor blackColor];
    UIView *baseView=[[UIView alloc] initWithFrame:AUVFRAME];
    
    
    UIImageView *bg=[[UIImageView alloc] initWithFrame:AUVFRAME];
    bg.image=[UIImage imageNamed:@"bg"];
    
    [baseView addSubview:bg];
    
    
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0,0,AUVFRAME.size.width,47)];
    headerView.backgroundColor=[UIColor colorWithRed:0.762f green:0.328f blue:0.117f alpha:1];
    UILabel *titleView=[[UILabel alloc] initWithFrame:headerView.frame];
    
    titleView.backgroundColor=[UIColor clearColor];
    titleView.textColor=[UIColor whiteColor];
    titleView.text=AUVAPPNAME;
    titleView.textAlignment=UITextAlignmentCenter;
    titleView.font=[UIFont boldSystemFontOfSize:18];
    
    [headerView addSubview:titleView];
    [baseView addSubview:headerView];
    
    

    
    UILabel *inviteall=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    UIButton *inviteallBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    inviteallBtn.frame=CGRectMake(10, 80, 140, 40);
    [inviteallBtn addSubview:inviteall];
    inviteall.backgroundColor=[UIColor colorWithRed:0.31f green:0.504f blue:0.738f alpha:1.0];
    inviteall.text=@"Invite All";
    inviteall.textAlignment=UITextAlignmentCenter;
    inviteall.textColor=[UIColor whiteColor];
    inviteall.layer.borderWidth=2.0f;
    [baseView addSubview:inviteallBtn];
    
    
    
    UILabel *search=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(170, 80, 140, 40);
    [searchBtn addTarget:self action:@selector(appWall) forControlEvents:UIControlEventTouchDown];
    [searchBtn addSubview:search];
    search.backgroundColor=[UIColor colorWithRed:0.31f green:0.504f blue:0.738f alpha:1.0];
    search.text=@"Search";
    search.textAlignment=UITextAlignmentCenter;
    search.textColor=[UIColor whiteColor];
    search.layer.borderWidth=2.0f;
    [baseView addSubview:searchBtn];
    
    
    */
    /*friendsTable=[[UITableView alloc] initWithFrame:CGRectMake(10, 160, 300, 200) style:UITableViewStyleGrouped];
    friendsTable.layer.cornerRadius=10;
    friendsTable.delegate=self;
    friendsTable.dataSource=self;
    friendsTable.backgroundColor=[UIColor clearColor];
    friendsTable.layer.borderWidth=1.0;
    [baseView addSubview:friendsTable];*/
    UIView *backView=[[UIView alloc] initWithFrame:friendsTable.bounds];
    backView.backgroundColor=[UIColor clearColor];
    friendsTable.backgroundView=backView;
    friendsTable.layer.borderWidth=1.0;
    friendsTable.layer.cornerRadius=10;
    [SVProgressHUD showWithStatus:@"Please Wait" maskType:SVProgressHUDMaskTypeBlack];
   // [facebook requestWithGraphPath:@"me/friends" andDelegate:self];
    NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small,is_app_user FROM user WHERE  uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(is_app_user,first_name,last_name) asc"];
    /*
     NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small FROM user WHERE is_app_user = 1 AND uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(first_name,last_name) asc"];
     */
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:fql ,@"query", [facebook accessToken], @"access_token", nil];
    
    [facebook requestWithMethodName:@"fql.query" andParams:params andHttpMethod:@"GET" andDelegate:self];
   // [self.view addSubview:baseView];
}



#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if(section==0)
        return auvFriends.count;
    else    
    return fbFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"TableCell"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell !=nil){
		cell=nil;
	}
	if (cell == nil) {
        
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.backgroundColor = [ UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGRect imgRect;
        CGRect lblRect;
        CGRect btnRect;
        CGRect btnLblRect;
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            imgRect=CGRectMake(15, 5, 52, 52);
            lblRect=CGRectMake(80, 6, 160, 50);
            
            btnRect=CGRectMake(160, 66, 100, 25);
            btnLblRect=CGRectMake(0, 0, 100, 25);
        }
        else {
            imgRect=CGRectMake(65, 10, 64, 64);
            lblRect=CGRectMake(145, 16, 260, 35);
            btnRect=CGRectMake(550, 16, 100, 35);
            btnLblRect=CGRectMake(0, 0, 100, 35);
        }
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:imgRect];
                
        [cell addSubview:imgView];
        imgView.layer.cornerRadius=10;
        imgView.layer.borderWidth=2.0;
        imgView.clipsToBounds=YES;

//        [cell.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[fbFriends objectAtIndex:indexPath.row] valueForKey:@"pic_small"]]]];
       
		UILabel *lbl1 = [[UILabel alloc]initWithFrame:lblRect];
		
        lbl1.numberOfLines=2;
        lbl1.lineBreakMode=UILineBreakModeWordWrap;
        
		lbl1.font = [UIFont fontWithName:AUVBoldFont size:17];
		lbl1.textColor = [ UIColor blackColor];
		lbl1.backgroundColor = [UIColor clearColor];	
		[cell addSubview:lbl1];
        
        UILabel *invite=[[UILabel alloc] initWithFrame:btnLblRect];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=btnRect;
        invite.backgroundColor=[UIColor colorWithRed:0.31f green:0.504f blue:0.738f alpha:1.0];
        invite.textAlignment=UITextAlignmentCenter;
        invite.layer.cornerRadius=4;
        invite.textColor=[UIColor whiteColor];
        invite.layer.borderWidth=2.0f;
        [btn addSubview:invite];
        [cell addSubview:btn];

        if(indexPath.section==0){
        lbl1.text=[[auvFriends objectAtIndex:indexPath.row] valueForKey:@"name"];
        
            
            invite.text=@"Follow";
                  [imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[auvFriends objectAtIndex:indexPath.row] valueForKey:@"pic_small"]]]];
                    
    }
        else {
            lbl1.text=[[fbFriends objectAtIndex:indexPath.row] valueForKey:@"name"];
            invite.text=@"Invite";
            [imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[fbFriends objectAtIndex:indexPath.row] valueForKey:@"pic_small"]]]];
        }
		
	}
	return cell;
}


- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    if(section==0) return @"Follow Friends";
    else return @"Invite Friends";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    return 100;
        else return 84;
}
/*
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
	return UITableViewCellEditingStyleDelete;
}
 */
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[addedsubitems removeObjectAtIndex:indexPath.row];
		[tblMain reloadData];
	} 
}*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath
{
	
}




#pragma FBRequestDelegate Methods


- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"res");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    //NSLog(@"Err : %@",[error localizedDescription]);
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    
    ////NSLog(@"%@",result);

   // //NSLog(@"%@",[result valueForKey:@"data"]);
    
    //NSArray *arr=[NSArray arrayWithArray:[result valueForKey:@"data"]];
  //
    
       
    NSPredicate *predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
        ////NSLog(@" : %@",obj);
        
        return  [[(NSDictionary*)obj  valueForKey:@"is_app_user"] intValue]==1 ;
    }];
    
    NSPredicate *predicate2=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
       // //NSLog(@" : %@",obj);
        
        return  [[(NSDictionary*)obj  valueForKey:@"is_app_user"] intValue]==0 ;
    }];
    

    
    NSArray *usersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate];
    NSArray *nonusersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate2];
    
   // //NSLog(@"%@",usersofApp);
    if([usersofApp isKindOfClass:[NSArray class]]){
    [auvFriends addObjectsFromArray:usersofApp];
    }
    else [auvFriends addObject:usersofApp];
    if([nonusersofApp isKindOfClass:[NSArray class]])
    [fbFriends addObjectsFromArray:nonusersofApp];
    else [fbFriends addObject:nonusersofApp];
    [SVProgressHUD dismiss];
    [friendsTable reloadData];
    
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data
{
    
}


/*
-(IBAction)goToWall:(id)sender 
{
    
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVAppWallController_iPhone";
    }
    else {
        nibName=@"AUVAppWallController_iPad";
    }
   AUVAppWallController *wall=[[AUVAppWallController alloc] initWithNibName:nibName bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:wall];
   [navigationController.navigationBar setTintColor:[UIColor blackColor]];
   // navigationController.navigationBar.frame=CGRectMake(0, 0, navigationController.navigationBar.frame.size.width, 100);
   // AUVMenuViewController *sideMenuViewController = [[AUVMenuViewController alloc] init];
    
       
    [self presentModalViewController:navigationController animated:YES];
}

*/

-(IBAction)goToWall:(id)sender
{
    
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVAppWallController_iPhone";
    }
    else {
        nibName=@"AUVAppWallController_iPad";
    }
    AUVAppWallController *wall=[[AUVAppWallController alloc] initWithNibName:nibName bundle:nil];
    ///  [[(AUVAppDelegate*) [[UIApplication sharedApplication] delegate] viewControllers] addObject:wall];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:wall];
    
    // navigationController.navigationBar.frame=CGRectMake(0, 0, navigationController.navigationBar.frame.size.width, 100);
    // AUVMenuViewController *sideMenuViewController = [[AUVMenuViewController alloc] init];
    [navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
    
    /* AUVDevsViewController *dev=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil];
     [self.navigationController pushViewController:dev animated:YES];*/
    
    
	RearViewController *rearViewController = [[RearViewController alloc] initWithNibName:@"RearViewController" bundle:nil];
    
	RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigationController rearViewController:[[UINavigationController alloc] initWithRootViewController:rearViewController]];
	[self presentModalViewController:revealController animated:YES];
}




@end
