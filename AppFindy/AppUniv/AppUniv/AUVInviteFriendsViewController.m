//
//  AUVInviteFriendsViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 18/09/12.
//
//

#import "AUVInviteFriendsViewController.h"
#import "AUVFriendsCell.h"
#import "AUVFriendsListViewController.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"

@interface AUVInviteFriendsViewController ()

@end

@implementation AUVInviteFriendsViewController

@synthesize tableView;
@synthesize invitefriendspageposition;

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
    self.navigationController.navigationBarHidden=NO;
   // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    //tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    if([invitefriendspageposition isEqualToString:@"menu"])
    {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    }
   
    self.title=@"Invite Friends";
    
    // Do any additional setup after loading the view from its nib.
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







#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AUVFriendsCell *cell=nil;
    
    static NSString *identifier = @"defaultcell";
    cell =(AUVFriendsCell*) [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    
    if (cell == nil)
    {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSString *nibName;
        
        
        nibName=@"AUVFriendsCell";
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        
        cell=(AUVFriendsCell*)[topLevelObjects objectAtIndex:0];
        
        
    }
    
    cell.title1.font=[UIFont systemFontOfSize:15];
    cell.title2.font=[UIFont systemFontOfSize:13];
    
    if(indexPath.row==0)
    {
        cell.title1.text=@"Contacts";
        
            cell.title2.text=@"Invite friends from your contact list";
        [cell.icon setImage:[UIImage imageNamed:@"f_contact"]];
        
    }
    if(indexPath.row==1)
    {
        cell.title1.text=@"Facebook";
                   cell.title2.text=@"Invite friends from Facebook";
        [cell.icon setImage:[UIImage imageNamed:@"f_facebook"]];
    }
    
   /* if(indexPath.row==2)
    {
        cell.title1.text=@"Twitter";
        cell.title2.text=@"Invite friends from twitter";
        [cell.icon setImage:[UIImage imageNamed:@"f_twitter"]];
        
        
    }*/
    
       
    
    
    return cell;
    
}
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 69;
    
}

-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
       
        if(indexPath.row==0){
            AUVFriendsListViewController *friendsList=[[AUVFriendsListViewController alloc] initWithNibName:@"AUVFriendsListViewController" bundle:nil];
            friendsList.type=AUVInviteContacts;
            [self.navigationController pushViewController:friendsList animated:YES];
            
        }
        else
            if(indexPath.row==1){
                AUVFriendsListViewController *friendsList=[[AUVFriendsListViewController alloc] initWithNibName:@"AUVFriendsListViewController" bundle:nil];
                friendsList.type=AUVInviteFBFriends;
                [self.navigationController pushViewController:friendsList animated:YES];
                
            }
        
        
    
    
}


@end
