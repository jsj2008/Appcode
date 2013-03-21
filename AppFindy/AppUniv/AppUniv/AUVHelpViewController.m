//
//  AUVHelpViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 03/12/12.
//
//

#import "AUVHelpViewController.h"
#import "AUVFAQViewController.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"
#import "AUVImageHelpViewController.h"
#import "AUVScrollTabBar.h"
#import "ASSignViewController.h"
@interface AUVHelpViewController ()

@end

@implementation AUVHelpViewController

@synthesize helppagepositionpagevalue;

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
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"Help";
    
    helptableview.layer.cornerRadius=10.0f;
    helptableview.layer.borderWidth=1.0f;
    helptableview.layer.borderColor=[[UIColor grayColor]CGColor];
    
    
    baseView.layer.cornerRadius=10.0f;
    baseView.layer.borderWidth=1.0f;
    baseView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationController.navigationBarHidden=NO;
//    if([helppagepositionpagevalue isEqualToString:@"menu"])
//    {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
//    }
    
    AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 375, 320, 44)];
    [custombar.button3 setImage:[UIImage imageNamed:@"deals1.png"] forState:UIControlStateNormal];
    custombar.delegate= self;
    [self.view addSubview:custombar];

    // Do any additional setup after loading the view from its nib.
}

-(void)btnTap:(UIButton*)buttonId

{
    
    int buttonselect = buttonId.tag;
    if (buttonselect == 1) {
        
        AUVwallcontrollerViewController *notification = [[AUVwallcontrollerViewController alloc]initWithNibName:@"AUVwallcontrollerViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 2){
        
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
        
        [self.navigationController pushViewController:deal animated:YES];

        
    }else if (buttonselect == 4){
        ASSignViewController *signIn =[[ASSignViewController alloc] initWithNibName:@"ASSignViewController" bundle:nil];
        [self.navigationController pushViewController:signIn animated:YES];
        
    }else if (buttonselect == 5){
//        AUVHelpViewController *helpView =[[AUVHelpViewController alloc] initWithNibName:@"AUVHelpViewController" bundle:nil];
//        [self.navigationController pushViewController:helpView animated:YES];
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

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell  *cell=nil;
    
    static NSString *identifier = @"defaultcell";
    cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.textLabel.font=[UIFont systemFontOfSize:15];
    }
    
    
    if(indexPath.row==0)
    {
        cell.textLabel.text=@"Appfindee.com";
       
    }
    
    
    if(indexPath.row==1)
    {
        cell.textLabel.text=@"AppFindee Blog";
    }
    
    
    if(indexPath.row==2)
    {
        cell.textLabel.text=@"Terms of service";
    }
    
    if(indexPath.row==3)
    {
        cell.textLabel.text=@"Privacy policy";
        
    }
    if(indexPath.row==4)
    {
        cell.textLabel.text=@"Tour Appfindee";
        
    }
    if(indexPath.row!=5){
        UIImageView *arrow=[[UIImageView alloc] initWithFrame:CGRectMake(268, 10, 20, 18)];
        arrow.image=[UIImage imageNamed:@"bluearrow.png"];
        
        [cell addSubview:arrow];
    }
    if(indexPath.row==5)
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 280, 22)];
        label.text=@"Like us on Facebook";
        label.font=[UIFont boldSystemFontOfSize:12];
        label.textColor=[UIColor blueColor];
        [cell.contentView addSubview:label];
        
        UIWebView *web=[[UIWebView alloc] initWithFrame:CGRectMake(80, 16, 200, 66)];
        
        [web scrollView].scrollEnabled=NO;
        web.dataDetectorTypes = UIDataDetectorTypeNone;
        
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.facebook.com/plugins/likebox.php?href=http%3A%2F%2Fwww.facebook.com%2Fappfindee&width=300&height=62&show_faces=false&colorscheme=light&stream=false&border_color&header=false&appId=257769047669205"]]];
        web.delegate=self;
        [cell.contentView addSubview:web];
        
    }
    
    
    return cell;
    
}
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row!=5)
        return 40;
    else return 88;
    
}


-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell  *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.row==0)
    {
        NSURL *url = [NSURL URLWithString:@"http://appfindee.com/"];
        [[UIApplication sharedApplication] openURL:url];
        
    }else if(indexPath.row==1)
    {
        NSURL *url = [NSURL URLWithString:@"http://appfindee.com/blog"];
        [[UIApplication sharedApplication] openURL:url];
        
    }
    else if(indexPath.row==2)
    {
        AUVFAQViewController *faq=[[AUVFAQViewController alloc]initWithNibName:@"AUVFAQViewController" bundle:nil];
        faq.pagevalue=@"termsofservice";
        faq.title=cell.textLabel.text;
        [self.navigationController pushViewController:faq animated:YES];
        
    }else if(indexPath.row==3)
    {
        AUVFAQViewController *faq=[[AUVFAQViewController alloc]initWithNibName:@"AUVFAQViewController" bundle:nil];
        faq.title=cell.textLabel.text;
        
        faq.pagevalue=@"privacypolicy";
        [self.navigationController pushViewController:faq animated:YES];
    }else if(indexPath.row==4)
    {
        AUVImageHelpViewController *image=[[AUVImageHelpViewController alloc]initWithNibName:@"AUVImageHelpViewController" bundle:nil];
        image.title=cell.textLabel.text;
        
        [self.navigationController pushViewController:image animated:YES];
    }
}

-(IBAction)supportpageEvent:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:@"http://appfindee.com/support"];
    [[UIApplication sharedApplication] openURL:url];
    
}

-(IBAction)FAQpageEvent:(id)sender
{
    AUVFAQViewController *faq=[[AUVFAQViewController alloc]initWithNibName:@"AUVFAQViewController" bundle:nil];
    faq.pagevalue=@"faq";
    faq.title=@"FAQ";
    [self.navigationController pushViewController:faq animated:YES];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType==UIWebViewNavigationTypeLinkClicked)
    {
        return NO;
    }
    return YES;
}
@end
