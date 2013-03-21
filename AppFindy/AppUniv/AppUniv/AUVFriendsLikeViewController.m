//
//  AUVFriendsLikeViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 17/11/12.
//
//

#import "AUVFriendsLikeViewController.h"
#import "AUVDevsViewController.h"

@interface AUVFriendsLikeViewController ()

@end

@implementation AUVFriendsLikeViewController

@synthesize friendslikelist;

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
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [super viewDidLoad];
    
    //NSLog(@"%@",friendslikelist);
    
    //NSLog(@"%d",friendslikelist.count);
    
    self.title=@"Friends";
    
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

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return friendslikelist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    UILabel *name;
    UIView *baseView;
    UIImageView *icon;
    
	if(cell !=nil){
		cell=nil;
	}
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        
        cell.backgroundColor=[UIColor clearColor];
        baseView=[[UIView alloc] initWithFrame:cell.frame];
        
        baseView.backgroundColor=[UIColor clearColor];
               
        name =[[UILabel alloc] initWithFrame:CGRectMake(58, 11, 258, 45)];
        name.numberOfLines=2;
        name.font=[UIFont systemFontOfSize:14];
        name.textColor=[UIColor blueColor];
        name.backgroundColor=[UIColor clearColor];
        
        icon=[[UIImageView alloc] initWithFrame:CGRectMake(4, 2, 48, 54)];
        icon.layer.cornerRadius=10;
        icon.clipsToBounds=YES;
        
        UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, 57, 320, 2)];
        line.image=[UIImage imageNamed:@"seprater"];
        
        [baseView addSubview:icon];
        [baseView addSubview:name];
       // [baseView addSubview:line];
        [cell addSubview:baseView];
    }

    [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[friendslikelist objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    name.text=[NSString stringWithFormat:@"%@",[[friendslikelist objectAtIndex:indexPath.row] valueForKey:@"firstname"]];

       
 
    
    
    return cell;
    
}




/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       NSString *uid=[[friendslikelist objectAtIndex:indexPath.row] valueForKey:@"user_id"];
    AUVDevsViewController *devsView = [[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
    devsView.detailController=self;
    devsView.follow=1;
    devsView.userId=[NSString stringWithFormat:@"%@",uid];
    [self.navigationController pushViewController:devsView animated:YES];
}


-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
