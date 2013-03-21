//
//  AUVLinkedAccountsViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 24/09/12.
//
//
#import "AUVFriendsCell.h"
#import "AUVLinkedAccountsViewController.h"
#import "AUVFriendsListViewController.h"
#import "UIDevice+test.h"
@interface AUVLinkedAccountsViewController ()

@end

@implementation AUVLinkedAccountsViewController

@synthesize tableView;
NSMutableArray *applist;
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
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    applist=[[NSMutableArray alloc] init];
    [self performSelectorInBackground:@selector(installedApps) withObject:nil];
    // Do any additional setup after loading the view from its nib.
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
    
    
    //return 3;
    
    return  applist.count;
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
    
    
    /*   if(indexPath.row==0)
    {
        cell.title1.text=@"Facebook";
        cell.title2.text=@"connect Facebook";
    }
    
   else if(indexPath.row==1)
    {
        cell.title1.text=@"Twitter";
        cell.title2.text=@"Invite friends from twitter";
        
        
    }*/
    
    cell.title1.text=[[applist objectAtIndex:indexPath.row]objectForKey:@"ProcessName"];
    
    
    
    
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
    
    
//    if(indexPath.row==0){
//        AUVFriendsListViewController *friendsList=[[AUVFriendsListViewController alloc] initWithNibName:@"AUVFriendsListViewController" bundle:nil];
//        friendsList.type=AUVInviteContacts;
//        [self.navigationController pushViewController:friendsList animated:YES];
//        
//    }
//    else
//        if(indexPath.row==1){
//            AUVFriendsListViewController *friendsList=[[AUVFriendsListViewController alloc] initWithNibName:@"AUVFriendsListViewController" bundle:nil];
//            friendsList.type=AUVInviteFBFriends;
//            [self.navigationController pushViewController:friendsList animated:YES];
//            
//        }
    
    
    
    
}



- (void)installedApps {
    
    //NSLog(@"test");
    
    // Example usage.
     NSArray * processes = [[UIDevice currentDevice] runningProcesses];
     
     // //NSLog(@"%@", [processes description]);
     for (NSDictionary * dict in processes){
     
     
     //NSLog(@"%@ - %@", [dict objectForKey:@"ProcessID"], [dict objectForKey:@"ProcessName"]);
     }
     
    
    [ applist addObjectsFromArray:processes];
    
    [tableView reloadData];
    //return nil;
    
}



@end
