//
//  SUBRearViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 11/10/12.
//
//

#import "SUBRearViewController.h"
#import "RevealController.h"
#import "AUVUserInterstViewController.h"
@interface SUBRearViewController ()

@end

@implementation SUBRearViewController
@synthesize parent;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    tableView=self.tableView;
    tableView.backgroundColor=[UIColor blackColor];
    UIImageView *shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarshadow"]];
    [shadow setFrame:CGRectMake(250.0-33.5, 0, 43.5, 480)];
    [self.view addSubview:shadow];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIImageView *sbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarbg"]];
    [sbg setFrame:CGRectMake(0, 0, 161.5, 480)];
    [self.tableView setBackgroundView:sbg];
    self.view.backgroundColor = [UIColor clearColor];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont fontWithName:AUVBoldFont size:18];
	
	if (indexPath.row == 0)
	{
		cell.textLabel.text = @"iPhone";
        
	}
	else if (indexPath.row == 1)
	{
		cell.textLabel.text = @"Android";
        
	}
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarcell"]];
    [bg setFrame:CGRectMake(0, 0, 161.5, 42.5)];
    // Configure the cell...
    cell.backgroundView = bg;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    RevealController *revealController = [self.navigationController.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.navigationController.parentViewController : nil;
    
    if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVUserInterstViewController class]])
    {
        // AUVDevsViewController *dev=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil];
        //[self.navigationController pushViewController:dev animated:YES];
        
        
        AUVUserInterstViewController *usrInterest = [[AUVUserInterstViewController alloc] initWithNibName:@"AUVUserInterstViewController" bundle:nil];
        usrInterest.type=indexPath.row;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:usrInterest];
        [revealController setFrontViewController:navigationController animated:NO];
    }
    // Seems the user attempts to 'switch' to exactly the same controller he came from!
    else
    {
        if([((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVUserInterstViewController class]])
        {
            if(indexPath.row!=[(AUVUserInterstViewController*)((UINavigationController *)revealController.frontViewController).topViewController type]){
                [(AUVUserInterstViewController*)((UINavigationController *)revealController.frontViewController).topViewController setType:indexPath.row];
            [(AUVUserInterstViewController*)((UINavigationController *)revealController.frontViewController).topViewController reload];
            }
        }
        
        [revealController revealToggle:self];
        
    }

}

@end
