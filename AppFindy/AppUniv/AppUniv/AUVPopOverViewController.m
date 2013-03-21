//
//  AUVPopOverViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 04/10/12.
//
//

#import "AUVPopOverViewController.h"
#import "Three20/Three20.h"
#import "UIImageView+AFNetworking.h"
#import "AUVDevsViewController.h"
#import "AUVQuestionViewController.h"
#import "SVPullToRefresh.h"
#import "AUVNotificationViewController.h"
@interface AUVPopOverViewController ()

@end

@implementation AUVPopOverViewController
@synthesize notifications,type,parent;
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

    self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    notifications=[[NSMutableArray alloc] init];
    [(UITableView*)self.tableView addPullToRefreshWithActionHandler:^(void){
        [self performSelector:@selector(loadNotifications) withObject:nil afterDelay:2];
    }];
    
    [self.tableView.pullToRefreshView triggerRefresh];
    self.tableView.pullToRefreshView.lastUpdatedDate = [NSDate date];

    //[self loadNotifications];
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return notifications.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIImageView *icon;
  //  UILabel *name;
    //UILabel *message;
    TTStyledTextLabel *date;
   // UIWebView *webView;
    //TTStyledText *text;
    TTStyledTextLabel *message;
    
    if(cell!=nil)
    {
        cell=nil;
    }
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        icon=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 48, 54)];
        icon.layer.cornerRadius=10.0f;
        icon.clipsToBounds=YES;
        //name=[[UILabel alloc] initWithFrame:CGRectMake(52, 2, 228, 22)];
        //webView=[[UIWebView alloc] initWithFrame:cell.frame];
        message=[[TTStyledTextLabel alloc] initWithFrame:CGRectMake(58, 2, 222, 40)];
        message.font=[UIFont fontWithName:AUVBoldFont size:13];
        
        message.backgroundColor=[UIColor clearColor];
        //message.text=[NSString stringWithFormat:@"<b></b> is Calling"];
        
        date=[[TTStyledTextLabel alloc] initWithFrame:CGRectMake(58, 40, 220, 22)];
        date.textAlignment=UITextAlignmentRight;
        date.font=[UIFont fontWithName:AUVBoldFont size:11];
        date.textColor=[UIColor grayColor];
        date.backgroundColor=[UIColor clearColor];
        [cell addSubview:message];
        [cell addSubview:date];
        [cell addSubview:icon];
        
    }
    
    if(indexPath.row==notifications.count && notifications.count!=0){
        //NSLog(@"test");
       /* UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(5, 5, 120, 40);
        [btn setBackgroundImage:[UIImage imageNamed:@"new_btn.png"] forState:UIControlStateNormal];
        btn.titleLabel.textColor=[UIColor whiteColor];
        [btn setTitle:@"View all notifications" forState:UIControlStateNormal];
        
        [cell addSubview:btn];*/
        
        cell.textLabel.text=@"View more...";
        cell.textLabel.textAlignment=UITextAlignmentCenter;
        
        return cell;
    }
    
    // Configure the cell...
    
   // cell.text=[NSString stringWithFormat:@"%d",indexPath.row];
    // [webView loadHTMLString:[self composeMessageWithUser:[[notifications objectAtIndex:indexPath.row] valueForKey:@"firstname"] andType:[[[notifications objectAtIndex:indexPath.row] valueForKey:@"type"] integerValue]] baseURL:nil];
    else if(notifications.count!=0){
    [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[notifications objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] ];
    message.text=[TTStyledText textFromXHTML:[self composeMessageWithUser:[[notifications objectAtIndex:indexPath.row] valueForKey:@"firstname"] andType:[[[notifications objectAtIndex:indexPath.row] valueForKey:@"type"] integerValue] andUserName:[[notifications objectAtIndex:indexPath.row] valueForKey:@"username"]]];
    date.text=[TTStyledText textFromXHTML:[NSString stringWithFormat:@" <span style='alignment:right;'>%@</span>",[[notifications objectAtIndex:indexPath.row] valueForKey:@"date"]]];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 70;
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
    ////NSLog(@"selected : %d",indexPath.row);
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if(indexPath.row==notifications.count && notifications.count!=0){
        AUVNotificationViewController *notify=[[AUVNotificationViewController alloc] initWithNibName:@"AUVNotificationViewController" bundle:nil];
        notify.parent=self.parent;
        [[(UIViewController*)self.parent navigationController] pushViewController:notify animated:YES];
        [[parent popoverController] dismissPopoverAnimated:YES];

        
    }
    else if(notifications.count!=0){
[self tableSelectLoad:[[[notifications objectAtIndex:indexPath.row] valueForKey:@"type"] integerValue] andId:[[notifications objectAtIndex:indexPath.row] valueForKey:@"value"]];
[[parent popoverController] dismissPopoverAnimated:YES];
    }
}


-(void)loadNotifications
{
    AUVwebservice *service=[AUVwebservice service];
    
    [service notification:self action:@selector(notificationHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:@"0" offset:@"10"];
}

-(void)notificationHandler:(id)value
{
    
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{

    SoapArray *arr=(SoapArray*)value;
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    [notifications removeAllObjects];
    
    [notifications addObjectsFromArray:[[result JSONValue] valueForKey:@"notification"]];
    [self.tableView reloadData];
    
    [(UITableView*)self.tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }
   // //NSLog(@"%@",[result JSONValue]);
}




-(NSString*)composeMessageWithUser:(NSString*)user andType:(NSInteger)ntype andUserName:(NSString*)userName
{
    NSString *str;
    if(user==[NSNull null] )
    {
        user=userName;
    }
    if(ntype==USER_FOLLW)
    {
        str=[NSString stringWithFormat:@"<b>%@</b> is following you.",user];
    }
   else if(ntype==QUESTION_FOLLOW)
    {
        str=[NSString stringWithFormat:@"<b>%@</b> is following your question.",user];
    }
   else if(ntype==QUESTION_COMMENT)
    {
        str=[NSString stringWithFormat:@"<b>%@</b> is commented on your question.",user];
    }
    
    return str;
    
}


-(void)tableSelectLoad:(NSInteger)ntype andId:(NSString*)mId
{
    if(ntype==USER_FOLLW)
    {
        AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
        profile.userId=mId;
       
        [[(UIViewController*)self.parent navigationController] pushViewController:profile animated:YES];
        
    }
    else if(ntype==QUESTION_FOLLOW)
    {
        AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
        question.questionId=[NSString stringWithFormat:@"%@",mId];
       // question.info=[[NSMutableDictionary alloc] initWithDictionary:[tableArray objectAtIndex:indexPath.row]];
        
        
        [[(UIViewController*)self.parent navigationController] pushViewController:question animated:YES];

        
    }
    else if(ntype==QUESTION_COMMENT)
    {
        AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
        question.questionId=[NSString stringWithFormat:@"%@",mId];
        // question.info=[[NSMutableDictionary alloc] initWithDictionary:[tableArray objectAtIndex:indexPath.row]];
        
        
        [[(UIViewController*)self.parent navigationController] pushViewController:question animated:YES];
    }
    
    

}
@end
