//
//  AUVSearchTopicViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 02/11/12.
//
//

#import "AUVSearchTopicViewController.h"
#import "AUVAddQuestionViewController.h"
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

@interface AUVSearchTopicViewController ()

@end

@implementation AUVSearchTopicViewController

@synthesize pageview;

NSArray *appidarray;
NSArray *appnamearray;

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
    
   
 // [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    sugArray=[[NSMutableArray alloc] init];
    sugidArray=[[NSMutableArray alloc] init];
    if(pageview==@"category")
    {
        
        self.title=@"Category";
        searchtopic.hidden=YES;
        selectcategorylabel.hidden=NO;
        
        [self getCategories];
    }else
    {
        
        self.title=@"Choose your app";
        searchtopic.hidden=NO;
        selectcategorylabel.hidden=YES;
        [self getAppName];
    }
    
    // [searchtopic setBackgroundColor:[UIColor clearColor]];
    
    [searchtopic setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"]];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(test:)];
    
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0];

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


-(IBAction)test:(id)sender
{
       [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSString *s=[searchtopic.text stringByAppendingFormat:@"%@",text];
    
    [self performSelectorInBackground:@selector(loadSuggestionList:) withObject:s];

    return  YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //MyUISearchBar *sBar = (MyUISearchBar *)searchBar;
    [searchBar setShowsCancelButton:YES];
   // [searchBar setCloseButtonTitle:@"Cancel" forState:UIControlStateNormal];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
    
   // shareItemName =newSearchBar.text;
    //[self dis]
    
    [self dismissModalViewControllerAnimated:YES];
    
   // AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc]initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
    //[self.view addSubview:obj];
    
}
-(void)loadSuggestionList:(NSString*)str
{
  
    [AFHTTPRequestOperation cancelPreviousPerformRequestsWithTarget:self];
   
  
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://appfindee.com:8081/autocompletion?use=autocomplete&login=admin&key=20b565d8bc413ab92d0f65ff48b84f12&query=%@",str]];
    
    NSString *string=[[NSString alloc]init];
    for(int i=0;i<str.length;i++)
    {
        char s=[str characterAtIndex:i];
        if(s==' ')
        {
            string=[string stringByAppendingString:@"_"];
            
        }else
        {
            string=[string stringByAppendingFormat:@"%c",s];
        }
    }
    
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/new_appsuggest/suggest?&omitHeader=true&wt=json&q=%@",[string lowercaseString]]];
    
    [AFHTTPRequestOperation cancelPreviousPerformRequestsWithTarget:self];
    
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation=  [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      
        NSDictionary *dict=[operation.responseString JSONValue];
        
        //  //NSLog(@"%@",dict);
        
        // NSArray *arr=[[NSArray alloc]init];
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        if([[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"]count]==2)
        for(int i=0;i<[[[[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"] objectAtIndex:1]valueForKey:@"suggestion"]count];i++)
        {
            
            
            [arr addObject:[[[[[[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"] objectAtIndex:1]valueForKey:@"suggestion"]objectAtIndex:i]stringByReplacingOccurrencesOfString:@"_" withString:@" "]componentsSeparatedByString:@"@--@"]];
            
        }
        
        [sugArray removeAllObjects];
        [sugidArray removeAllObjects];
        for(int i=0;i<arr.count;i++)
        {
            
                [sugArray addObject:[[arr objectAtIndex:i]objectAtIndex:0]];
            
                [sugidArray addObject:[[arr objectAtIndex:i] objectAtIndex:1]];
            
        }
        [searchresult reloadData];
    }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          
                                          
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
    
    if(pageview==@"category")
    {
        cell.textLabel.font = [UIFont systemFontOfSize:20.0];
        cell.textLabel.text=[[sugArray objectAtIndex:indexPath.row] valueForKey:@"category_name"];

    }else
    {
   
    
    cell.textLabel.font = [UIFont systemFontOfSize:20.0];
        
        
        //[icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    

       cell.textLabel.text=[sugArray objectAtIndex:indexPath.row] ;
    }
    return cell;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(pageview==@"category")
    {
        AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc]initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
        obj.apptitle=[[sugArray objectAtIndex:indexPath.row] valueForKey:@"category_name"] ;
        obj.appid=[[sugArray objectAtIndex:indexPath.row] valueForKey:@"category_id"];
        
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        [standardUserDefaults setObject:[[sugArray objectAtIndex:indexPath.row] valueForKey:@"category_name"] forKey:@"apptitle"];
        
        [standardUserDefaults setObject:[[sugArray objectAtIndex:indexPath.row] valueForKey:@"category_id"] forKey:@"appid"];
        [standardUserDefaults synchronize];
        
    }else
    {
        AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc]initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
        obj.apptitle=[sugArray objectAtIndex:indexPath.row];
        obj.appid=[sugidArray objectAtIndex:indexPath.row];
    
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
   
        [standardUserDefaults setObject:[sugArray objectAtIndex:indexPath.row]forKey:@"apptitle"];

        [standardUserDefaults setObject:[sugidArray objectAtIndex:indexPath.row] forKey:@"appid"];
        [standardUserDefaults synchronize];
        
        
        //NSLog(@" id %@:",[sugidArray objectAtIndex:indexPath.row]);
    }
    [self dismissModalViewControllerAnimated:YES];
    
       
}



-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}


-(void)getCategories
{
    
    AUVwebservice *service=[AUVwebservice service];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
   
    [service get_all_category:self action:@selector(getCategoriesHandler:)];
}



-(void)getCategoriesHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray *arr=(SoapArray*)value;
    NSString *result=[[[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\\" withString:@""] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    NSDictionary *dict=[result JSONValue];

    [sugArray removeAllObjects];
    
    [sugArray addObjectsFromArray:[dict valueForKey:@"category_list"]];
    [SVProgressHUD dismiss];
    
   
    [searchresult reloadData];
    
    }
}

-(void)getAppName
{
    NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/appfindee/select?wt=json&omitHeader=true&sort=scoring+desc&start=0&row=10&fl=trackId,trackNameExact,artworkUrl60&q=*:*"]];
    
    //NSLog(@"url %@",url);
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation=  [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict=[operation.responseString JSONValue];
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        
        [array addObjectsFromArray:[[dict valueForKey:@"response"]valueForKey:@"docs"]];
        
        for(int i=0;i<array.count;i++)
        {
            [sugArray addObject:[[array objectAtIndex:i] valueForKey:@"trackNameExact"]];
            [sugidArray addObject:[[array objectAtIndex:i] valueForKey:@"trackId"]];

            
        }
        [searchresult reloadData];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          
        }
     ];
    
    [operation start];

}


@end
