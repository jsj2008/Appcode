//
//  AUVAddQuestionViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 25/10/12.
//
//

#import "AUVAddQuestionViewController.h"
#import "AUVSearchTopicViewController.h"
#import "SVProgressHUD.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "AUVLogin.h"

#import "SCNavigationBar.h"

#import "DYRateView.h"
#import "AUVConstants.h"

#import "AUVDetailViewController.h"
#import "AUVAppWallController.h"
#import "AUVAppDelegate.h"
#import "UIViewController+Transitions.h"
#import "AUVFilterViewController.h"
#import "NSString+ParamHandling.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPRequestOperation.h"

#import "AUVQuestionViewController.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"

@interface AUVAddQuestionViewController ()

@end

@implementation AUVAddQuestionViewController
@synthesize questiontype,searchController,appid,apptitle;

UITextView *activeField;

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
    
    questionTextView.layer.cornerRadius=10.0f;
    questionTextView.layer.borderWidth=1.0f;
    
    titleTextFields.layer.cornerRadius=10.0f;
    titleTextFields.layer.borderWidth=1.0f;
    
    sugArray=[[NSMutableArray alloc] init];
    apptitle=[[NSString alloc]init];
    
   
    
   // sugtableview=[[UITableView alloc]init];
       
    if(questiontype==@"category")
    {
        [titleTextFields setText:@"Category Title"];
        appTextFields.text=@"Choose category name";
    }
    else
    {
        [titleTextFields setText:@"App Title"];
        appTextFields.text=@"Choose app name";
        
    }
    
    [questionTextView setText:@"Question"];
    [questionTextView setTextColor:[UIColor lightGrayColor]];
    [titleTextFields setTextColor:[UIColor lightGrayColor]];


    
   UIBarButtonItem *addquestion =[[UIBarButtonItem alloc] initWithTitle:@"Add Discussion" style:UIBarButtonItemStylePlain target:self action:@selector(addquestion:)];
    
    
    UIBarButtonItem *back =[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackPage:)];
   
    self.navigationItem.leftBarButtonItem=back;
    self.navigationItem.rightBarButtonItem = addquestion;

    AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
    custombar.delegate= self;
    
    [self.view addSubview:custombar];
    
    scrollview.contentSize=CGSizeMake(0, 460);
    scrollview.delegate=self;
    // Do any additional setup after loading the view from its nib.
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [activeField resignFirstResponder];
}

-(void)btnTap:(UIButton*)buttonId

{
    
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 1) {
        
        AUVAppWallController *notification = [[AUVAppWallController alloc]initWithNibName:@"AUVAppWallController_iPhone" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }/*else if (buttonselect == 2){
        
        AUVNotificationViewController *notification = [[AUVNotificationViewController alloc]initWithNibName:@"AUVNotificationViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        
        AUVQuestionChoiceViewController *notification = [[AUVQuestionChoiceViewController alloc]initWithNibName:@"AUVQuestionChoiceViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }*/else if (buttonselect == 4){
        
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


-(void)viewDidAppear:(BOOL)animated
{
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    apptitle = [standardUserDefaults stringForKey:@"apptitle"];
    appid = [standardUserDefaults stringForKey:@"appid"];
    
    if(apptitle.length!=0)
    {
        appTextFields.text=apptitle;
    }
    
    
    [standardUserDefaults setObject:@"" forKey:@"apptitle"];
    
    [standardUserDefaults setObject:@"" forKey:@"appid"];
    [standardUserDefaults synchronize];
    
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


-(void)goBackPage:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    ////NSLog(@"test");
    
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        
        scrollview.contentOffset=CGPointMake(0,textField.frame.origin.y);
        
    }
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField
{
    scrollview.contentOffset=CGPointMake(0,0);
    
}

- (void)textViewDidBeginEditing:(UITextView *)textview
{
    ////NSLog(@"test");
     activeField=textview;
    
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        
        scrollview.contentOffset=CGPointMake(0,textview.frame.origin.y);
        
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField==appTextFields)
    {
        
        NSString *s=[appTextFields.text stringByAppendingFormat:@"%@",string];
    
        [self performSelectorInBackground:@selector(loadSuggestionList:) withObject:s];
    
    }
    return  YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    scrollview.contentOffset=CGPointMake(0,0);
    
    
}


- (BOOL)textView:(UITextView *)textview shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    if(textview==questionTextView)
    {
        if ([text isEqualToString:@"\n"])
        {
            [questionTextView resignFirstResponder];
            
            return NO;
        }
        else
        {
            return YES;
        }
    }else  if(textview==titleTextFields)
    {
        if ([text isEqualToString:@"\n"])
        {
            [titleTextFields resignFirstResponder];
            [questionTextView becomeFirstResponder];
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    
    
    
        return YES;
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textview
{
    
    
    if(textview==questionTextView)
    {
        if (questionTextView.textColor == [UIColor lightGrayColor]) {
            questionTextView.text = @"";
            questionTextView.textColor = [UIColor blackColor];
        }
    }else  if(textview==titleTextFields)
    {
        if (titleTextFields.textColor == [UIColor lightGrayColor]) {
            titleTextFields.text = @"";
            titleTextFields.textColor = [UIColor blackColor];
        }
    }
        
    return YES;
}

-(void) textViewDidChange:(UITextView *)textview
{
    if(textview==questionTextView)
    {
        if(questionTextView.text.length == 0){
            questionTextView.textColor = [UIColor lightGrayColor];
            questionTextView.text = @"Question";
            [questionTextView resignFirstResponder];
        }
    }else if(textview==titleTextFields)
    {
        if(questiontype==@"category")
        {
            if(titleTextFields.text.length == 0){
                titleTextFields.textColor = [UIColor lightGrayColor];
                titleTextFields.text = @"Category Title";
                [titleTextFields resignFirstResponder];
            }
            
        }
        else
        {
            if(titleTextFields.text.length == 0){
                titleTextFields.textColor = [UIColor lightGrayColor];
                titleTextFields.text = @"App Title";
                [titleTextFields resignFirstResponder];
            }
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [searchBar removeFromSuperview];
    [SVProgressHUD dismiss];
    [super viewDidDisappear:animated];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==appTextFields) {
        [textField resignFirstResponder];
        [titleTextFields becomeFirstResponder];
    }
   
    [textField resignFirstResponder];
    
    
    return YES;
}

-(IBAction)chooseTopic:(id)sender{

    AUVSearchTopicViewController *filter=[[AUVSearchTopicViewController alloc]initWithNibName:@"AUVSearchTopicViewController" bundle:nil];
    
    
    if(questiontype==@"category")
    {
        filter.pageview=@"category";
    }
    else
    {
        filter.pageview=@"app";
    }
    
   // [self.navigationController presentModalViewController:obj animated:YES];
    
    //AUVFilterViewController *filter=[[AUVFilterViewController alloc] initWithNibName:@"AUVFilterViewController" bundle:nil];
    //filter.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    
    UINavigationController *navigationController=[self customizedNavigationController];
    
    [navigationController setViewControllers:[NSArray arrayWithObject:filter]];
    
    //UINavigationController *filterNavigation=[[UINavigationController alloc] initWithRootViewController:filter];
    
   //  [filterNavigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
    //filterNavigation.navigationBar.tintColor=[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
   // [filterNavigation.navigationBar setBackgroundImage:[] forBarMetrics:<#(UIBarMetrics)#>
    // filterNavigation.navigationItem.title=@"Filter";
    
    [self.navigationController presentModalViewController:navigationController withPushDirection:kCATransitionFromBottom];
    
}

- (IBAction)addquestion:(id)sender {
    
    if(appTextFields.text.length==0||[appTextFields.text isEqualToString:@"Choose category name"])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please choose a category." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else  if(appTextFields.text.length==0||[appTextFields.text isEqualToString:@"Choose app name"])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please choose an app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else if(titleTextFields.text.length==0||[titleTextFields.text isEqualToString:@"App Title"])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the title." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }else if(questionTextView.text.length==0||[questionTextView.text isEqualToString:@"Question"])
    {
        UIAlertView *alerView=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerView show];
    }
    else
    {

        AUVwebservice *service=[AUVwebservice service];
    
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
  
        if(questiontype==@"category")
        {
            [service question:self action:@selector(commentActionHandler:) category_id:appid app_id:@"0" user_id:    [defaults valueForKey:@"user_id"] question:titleTextFields.text description:questionTextView.text];
        
           
        }
        else if(questiontype==@"app")
        {
            [service question:self action:@selector(commentActionHandler:) category_id:@"0" app_id:appid user_id:    [defaults valueForKey:@"user_id"] question:titleTextFields.text description:questionTextView.text];
       
           
        }
    }
}

-(void)commentActionHandler:(id)value
{
    
    
   
	if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
	
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    

	else{
  
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
  
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
 
    //NSLog(@"Result : %@",result);
    
    NSDictionary *dict=[result JSONValue];
    
    AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
    question.questionId=[NSString stringWithFormat:@"%@",[dict valueForKey:@"question_id"]];
    question.info=[[NSMutableDictionary alloc] initWithDictionary:dict];
    question.newlyadded=[[dict valueForKey:@"new"] boolValue];
    [self.navigationController pushViewController:question animated:YES];
    }
   }

- (UINavigationController *)customizedNavigationController
{
    UINavigationController *navController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    
    // Ensure the UINavigationBar is created so that it can be archived. If we do not access the
    // navigation bar then it will not be allocated, and thus, it will not be archived by the
    // NSKeyedArchvier.
    [navController navigationBar];
    
    // Archive the navigation cooller.
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:navController forKey:@"root"];
    [archiver finishEncoding];
    // [archiver release];
    //[navController release];
    
    // Unarchive the navigation controller and ensure that our UINavigationBar subclass is used.
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [unarchiver setClass:[SCNavigationBar class] forClassName:@"UINavigationBar"];
    UINavigationController *customizedNavController = [unarchiver decodeObjectForKey:@"root"];
    [unarchiver finishDecoding];
    // [unarchiver release];
    
    // Modify the navigation bar to have a background image.
    SCNavigationBar *navBar = (SCNavigationBar *)[customizedNavController navigationBar];
    [navBar setTintColor:[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsLandscapePhone];
    
    return customizedNavController;
}


-(void)addQuestionHandler:(id)value
{
    
   // SoapArray *arr=(SoapArray*)value;
    ////NSLog(@"%@",arr);
    [SVProgressHUD dismiss];
    // NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    ////NSLog(@"%@",[result JSONValue]);
    /*if(questionView)
     {
     [questionView.tableArray removeAllObjects];
     [questionView.tableArray addObjectsFromArray:[[result JSONValue] objectForKey:@"answer_details"]];
     
     }
     */
  //  [self hide];
    ////NSLog(@"%@",result);
    
    
}



-(void)loadSuggestionList:(NSString*)str
{
    //if(str.length<3)return;
    [AFHTTPRequestOperation cancelPreviousPerformRequestsWithTarget:self];
   // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://appfindy.com:8081/autocompletion?use=iphone_data&query=%@&login=appuniv&key=eaf0240551d8ec89df0d0713745c2d04",str]];
    ////NSLog(@"%@",url);
    
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://23.21.189.26:8081/select?use=data&login=appuniv&key=eaf0240551d8ec89df0d0713745c2d04&qt=search_auto&q=%@&render=json",str]];
    
    [AFHTTPRequestOperation cancelPreviousPerformRequestsWithTarget:self];
   


    
    
     NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

    AFHTTPRequestOperation *operation=  [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // //NSLog(@"success: %@", operation.responseString);
        [sugArray removeAllObjects];
         NSDictionary *dict=[operation.responseString JSONValue];
        
        [sugArray addObjectsFromArray:[[[dict valueForKey:@"response"] valueForKey:@"result"] valueForKey:@"doc"]];
        
      
        
        if ([sugArray count]==0) {
           sugtableview.hidden=YES;
        }else
        {
        
        sugtableview.hidden=NO;
        [sugtableview reloadData];
        }
        
      //  NSArray *arr=[operation.responseString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
       // NSArray *myFilteredArray = [arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]]; //Non-destructive, myStrings is still intact
        
       // [sugArray addObjectsFromArray:myFilteredArray];
        
        
    }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          //NSLog(@"error: %@",  operation.responseString);
                                          
                                      }
     ];
    
    [operation start];

    
    
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
     return sugArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell=nil;
    
    
   
        static NSString *identifier = @"ResultViewCell";
      //  cell = [self.resultView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            
        }
        

    
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    
        cell.textLabel.text=[[[[sugArray objectAtIndex:indexPath.row] valueForKey:@"field"] objectAtIndex:1]  valueForKey:@"value"];
        return cell;
    }


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        appTextFields.text=[[[[sugArray objectAtIndex:indexPath.row] valueForKey:@"field"] objectAtIndex:1]  valueForKey:@"value"];
    
        appid=[NSString stringWithFormat:@"%@",[[[[sugArray objectAtIndex:indexPath.row] valueForKey:@"field"] objectAtIndex:0]  valueForKey:@"value"]];
    
        sugtableview.hidden=YES;
    
}



-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 20;
}

@end
