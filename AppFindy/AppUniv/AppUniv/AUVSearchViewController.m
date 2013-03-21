//
//  AUVSearchViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVSearchViewController.h"
#import "AUVSearchCellCell.h"
#import "JSON.h"
#import "DYRateView.h"
#import "AUVConstants.h"
#import "Facebook.h"
#import "AUVDetailViewController.h"
#import "AUVAppWallController.h"
#import "AUVAppDelegate.h"
#import "UIViewController+Transitions.h"
#import "AUVFilterViewController.h"
#import "NSString+ParamHandling.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPRequestOperation.h"
#import "SVProgressHUD.h"
#import "AUVQuestionViewController.h"
#import "AUVCustomTabbar.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVDealsViewController.h"
#import "AUVHelpViewController.h"
#import "AUVScrollTabBar.h"
#import "ASSignViewController.h"


@interface AUVSearchViewController ()

@end

@implementation AUVSearchViewController
@synthesize resultView,searching,leftSelectedIndexPath,filterDic,filterContent,type,searchController;
NSArray *scope;
NSInteger scopeOption;
NSInteger start;
NSInteger end;
NSInteger count;
NSMutableArray *questionArray;
NSInteger segType;


int searchvalueloadingflag=0;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        UIBarButtonItem *settingsBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(Settingspage)];
//        settingsBtn.style= UIBarButtonItemStyleBordered;
//        self.navigationItem.rightBarButtonItem = settingsBtn;

        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setButtonsState:YES];
   
    self.navigationItem.hidesBackButton = YES;
   
    //[self.navigationController.view addSubview:pullDownView];


    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.backBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:@"Back"
//                                     style:UIBarButtonItemStyleBordered
//                                    target:nil
//                                    action:nil];
    
    dataArray=[[NSMutableArray alloc] init];
    questionArray=[[NSMutableArray alloc] init];
    filterDic=[[NSMutableDictionary alloc] init];
    filters=[[NSMutableDictionary alloc] init];
    filterContent=[[NSMutableDictionary alloc] init];
    scope=[[NSArray alloc] initWithObjects:@"iPhone",@"iPad",@"Questions", nil];
    sugArray=[[NSMutableArray alloc] init];
    self.navigationController.navigationBarHidden=NO;
    self.resultView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    //self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    progress.hidden=YES;
    
    
    
    
    
    searchBar =[[UISearchBar alloc] initWithFrame:CGRectMake(76, 0, 197, 44)];
    
    searchBar.tintColor=[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0];
    
    
    [searchBar setScopeButtonTitles:scope];
    searchBar.delegate=self;
    [searchBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"]];
    
    [self.navigationController.navigationBar addSubview:searchBar];
    
    
    
    
    
    
    
    
   
    //resultView.separatorStyle=UITableViewCellSeparatorStyleNone;
    // livelyTableView.backgroundColor=[UIColor greenColor];
    
    __unsafe_unretained AUVSearchViewController *svc=self;
    
    [self.resultView addInfiniteScrollingWithActionHandler:^{
        
        
        [svc performSelectorOnMainThread:@selector(loadMoreData) withObject:nil waitUntilDone:YES];
        
        [resultView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];
    
    if(self.type==NotLoggedIn)
    {
        //searchBar.text=searching;
        [searchBar becomeFirstResponder];
        // [self performSelectorInBackground:@selector(searchforText:) withObject:searching];
    }
    if(self.type==Menu)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
        
    }
    
    if(self.type==LoggedIn) {
       // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    }
    
    //[self.view addSubview:tableView];
    
    [resultView.pullToRefreshView triggerRefresh];
    //resultView.pullToRefreshView.lastUpdatedDate = [NSDate date];
    
    
    
    
    CGFloat xOffset = 0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        xOffset = 224;
    }
    
    
    UISearchDisplayController *searchCon = [[UISearchDisplayController alloc]
                                            initWithSearchBar:searchBar
                                            contentsController:self ];
    self.searchController = searchCon;
    
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    
    
//    if([AUVLogin isAccessAllowed])
//    {
//        AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
//        [custombar.button4 setImage:[UIImage imageNamed:@"tap_search1.png"] forState:UIControlStateNormal];
//        
//        custombar.delegate= self;
//        
//        [self.view addSubview:custombar];
    AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 360, 320, 104)];
    [custombar.button2 setImage:[UIImage imageNamed:@"tab_search.png"] forState:UIControlStateNormal];
    custombar.delegate= self;
    [self.view addSubview:custombar];
    
    
  //  }
    
    segType=0;
}
-(void)Settingspage{
    
    AUVHelpViewController *help=[[AUVHelpViewController alloc]initWithNibName:@"AUVHelpViewController" bundle:nil];
    [self.navigationController pushViewController:help animated:YES];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    scopeOption=0;
    
    
    [self.navigationController.navigationBar addSubview:searchBar];
    [super viewDidAppear:animated];
    
    }

-(void)viewDidDisappear:(BOOL)animated
{
   [searchBar removeFromSuperview];
   //[SVProgressHUD dismiss];
   [super viewDidDisappear:animated];
    
}
- (void)viewDidUnload
{
    
    [AFHTTPRequestOperation cancelPreviousPerformRequestsWithTarget:self];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)btnTap:(UIButton*)buttonId

{
    
    //NSLog(@"bbb %d",buttonId.tag);
    
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 1) {
        
        AUVwallcontrollerViewController *notification = [[AUVwallcontrollerViewController alloc]initWithNibName:@"AUVwallcontrollerViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 2){
        
//        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
//        
//        [self.navigationController pushViewController:notification animated:YES];
//        
        
    }else if (buttonselect == 3){
        
        AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
        
        [self.navigationController pushViewController:deal animated:YES];
        
    }else if (buttonselect == 4){
        ASSignViewController *signIn =[[ASSignViewController alloc] initWithNibName:@"ASSignViewController" bundle:nil];
        [self.navigationController pushViewController:signIn animated:YES];
               
    }else if (buttonselect == 5){
        AUVHelpViewController *helpView =[[AUVHelpViewController alloc] initWithNibName:@"AUVHelpViewController" bundle:nil];
        [self.navigationController pushViewController:helpView animated:YES];
        
    }
    else{
        
        //NSLog(@"nothing");
        
    }
    
}



#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    
    if(tableView==self.searchController.searchResultsTableView) return sugArray.count;
    
    else if(scopeOption==2){
        if(questionArray.count>0) return questionArray.count;
        else return 0;
    }
    else{
    if(dataArray.count!=0)
    {
        
        return dataArray.count;//2*(dataArray.count)-1;
    }
    else {
        
        return 1;
    }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell=nil;
    
    
    if(tableView==self.searchController.searchResultsTableView)
    {
        static NSString *identifier = @"ResultViewCell";
         cell = [self.resultView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];


        }
        cell.textLabel.text=[sugArray objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        if(scopeOption==2)
        {
           
                static NSString *identifier = @"defaultcell";
                cell = [self.resultView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    //cell.selectionStyle=UITableViewCellSelectionStyleNone;
                     
                }
             cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            if(questionArray.count>0){
                cell.textLabel.textColor=[UIColor blackColor];
          
                cell.textLabel.numberOfLines=3;
                cell.textLabel.text=[[questionArray objectAtIndex:indexPath.row] valueForKey:@"question"];
            
            }
            else{
                
                cell.textLabel.text=@"No results found";
            }
            UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, cell.textLabel.frame.origin.y+cell.textLabel.frame.size.height+5, 310, 2)];
            line.image=[UIImage imageNamed:@"seprater"];
            [cell addSubview:line];
                return cell;
        }

    
    if( dataArray.count>0){
        static NSString *identifier = @"AUVSearchCellCell";
        cell = [self.resultView dequeueReusableCellWithIdentifier:identifier];
        DYRateView *rateView;

        if (cell == nil)
        {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            NSString *nibName;
                        
            if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
                //nibName=@"AUVSearchCell_iPhone";
                 nibName=@"SearchView";
               // rateView=[[DYRateView alloc] initWithFrame:CGRectMake(178, 51, 116, 21)];
                //rateView.size=RateViewBig;
            }
            else {
                nibName=@"AUVSearchCell_iPad";
                //rateView=[[DYRateView alloc] initWithFrame:CGRectMake(363, 106, 367, 34)];
                //rateView.size=RateViewBig;
            }
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            cell=(AUVSearchCellCell*)[topLevelObjects objectAtIndex:0];
            
            
            // cell=[[AUVWallTableCell alloc] in]
            
        }
        //
      
                
        CALayer *layer = [CALayer new];
        layer.frame=CGRectMake(cell.bounds.origin.x, 5, cell.bounds.size.width, cell.bounds.size.height-5);
        layer.borderColor = [[UIColor grayColor] CGColor];
        layer.borderWidth = 2.0f;
        layer.backgroundColor=[[UIColor clearColor] CGColor];
        layer.cornerRadius = 10.0f;
       // [cell.layer addSublayer:layer];
        cell.layer.cornerRadius=10;
                
        AUVSearchCellCell* customcell=(AUVSearchCellCell*)cell;
        
        
        int r=[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"averageUserRating"] intValue];
        if(r==1)
        {
            [customcell.star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            
        }else if(r==2)
        {
            [customcell.star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star2 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];


            
        }else if(r==3)
        {
            [customcell.star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star2 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star3 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            

            
        }else if(r==4)
        {
            [customcell.star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star2 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star3 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star4 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            
        }else if(r==5)
        {
            [customcell.star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star2 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star3 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star4 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            [customcell.star5 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
            

        }
        
        [customcell.appIcon.layer setBorderWidth:1.0f];
        customcell.appIcon.layer.cornerRadius=10.0f;
        
        customcell.noOfShares.text=@"1000";
        customcell.noOfLikes.text=@"100";
        customcell.noOfComments.text=@"1313";
        
        customcell.appName.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"trackNameExact"];
        
        customcell.appName.font=[UIFont systemFontOfSize:14];
        
        
        NSString *apppricestr=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"formattedPrice"];
        if([apppricestr isEqualToString:@"0"])
        {
         customcell.price.text=@"Free";
        }else
        {
        customcell.price.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"formattedPrice"];
        }
        
        //customcell.rating.
        customcell.price.font=[UIFont systemFontOfSize:12];
        customcell.rating.text=[NSString stringWithFormat:@"%@ RATINGS",[[dataArray objectAtIndex:indexPath.row]valueForKey:@"userRatingCount"]];
        customcell.rating.font=[UIFont systemFontOfSize:12];
        [customcell.details setTag:indexPath.row];
        
        [customcell.details addTarget:self action:@selector(viewAppDetailViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        [customcell addSubview:rateView];
        // NSUSer
        
        /***************
         For Android Apps for  iPhone datas
         *****************/
     
        NSString *strapplogo=  [NSString stringWithFormat:@"%@",[[(NSString*)[[dataArray objectAtIndex:indexPath.row] valueForKey:@"artworkUrl60"] componentsSeparatedByString:@"appfindy"] objectAtIndex:0]];
        
        strapplogo = [strapplogo stringByReplacingOccurrencesOfString:@"vol/iphone_final/./"
                                             withString:@""];
        
       
        
        [customcell.appIcon  setImageWithURL:[NSURL URLWithString:strapplogo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        customcell.appIcon.contentMode = UIViewContentModeScaleAspectFit;

     
        
        NSString *strappscreen=[NSString stringWithFormat:@"http://appfindee.com/images/%@",[[(NSString*)[[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"screenshot"]componentsSeparatedByString:@"|"] objectAtIndex:0]componentsSeparatedByString:@"appfindy"] objectAtIndex:0]];
        
        strappscreen = [strappscreen stringByReplacingOccurrencesOfString:@"vol/iphone_final/./"
                                                           withString:@""];

        
        
        [customcell.appImg setImageWithURL:[NSURL URLWithString:strappscreen]];
        
        customcell.appImg.contentMode = UIViewContentModeScaleAspectFill;
             
        customcell.downloadBtn.tag=indexPath.row;
        [customcell.downloadBtn addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
        
        
        customcell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return customcell;
    }
    else {
        static NSString *identifier = @"defaultcell";
        cell = [self.resultView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
                
        return cell;
    }
    
    }
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // AUVDetailViewController *detail=[[AUVDetailViewController alloc] initWithNibName:<#(NSString *)#> bundle:<#(NSBundle *)#>]
    
    
    
    if(tableView==self.searchController.searchResultsTableView)
    {
        start=0;
        loadMore=NO;
        searching=[sugArray objectAtIndex:indexPath.row];
        [searchController setActive:NO];
        searchBar.text=searching;

        [dataArray removeAllObjects];
        [self.resultView reloadData];
        
        
        [self performSelectorInBackground:@selector(searchforText:) withObject:[sugArray objectAtIndex:indexPath.row]];
    }
    else{
        
        if(scopeOption==2){
            AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
            question.questionId=[NSString stringWithFormat:@"%@",[[questionArray objectAtIndex:indexPath.row] valueForKey:@"question_id"]];
            [self.navigationController pushViewController:question animated:YES];
        }else
        {
            
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Like us on facebook" message:@"" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"like", nil];
//            [alert show];
            
            NSString *nibName;
            if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
                nibName=@"AUVDetailViewController";
            }
            else {
                nibName=@"AUVDetailViewController_iPad";
            }
            AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:nibName bundle:nil];
            detailView.appId=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"trackId"];
            [self.navigationController pushViewController:detailView animated:YES];
        }
     //if(indexPath.row%2==0)
   // [self viewAppDetailView:[[dataArray objectAtIndex:indexPath.row] valueForKey:@"appId"] ];
    }
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.searchController.searchResultsTableView)
    {
        return 40;
    }
    else{
   /* if(indexPath.row%2==0){
        
        
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            return 364;
        }
        else {
            return 800;
        }
        
        
    }
    else {
        return 40;
    }*/
        
        if(scopeOption==2) return 70;
        
        return 90;

    }
}



- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
   /* float cellHeight = 394;
    int index = floorf(scrollView.contentOffset.y / cellHeight);
//
    
    
    *targetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y = (index * cellHeight));
    */
    
    
    
}
//http://23.23.149.136:8081/select?use=apps_data&qt=search&q=photo&render=json

//http://appfindy.com:8081/select?use=iphone_data&login=appuniv&render=json&key=eaf0240551d8ec89df0d0713745c2d04&qt=search&start=0&rows=12&q=tamil

BOOL isWanted(unichar character)
{
    if(character>='a' && character<='z')
        return YES;
    if(character>='A' && character<='Z')
        return YES;
    if(character>='0' && character<='9')
        return YES;
    if(character=='+')
        return YES;
    return NO;
}



-(void)searchforText:(NSString*)str
{
 //%@:8081/select?use=apps_data&qt=search&q=%@&render=json&login=appuniv&key=eaf0240551d8ec89df0d0713745c2d04
    [filters removeAllObjects];
    [filterDic removeAllObjects];
    [filterContent removeAllObjects];
    if(!loadMore)
    {
        progress.hidden=NO;
        [progress startAnimating];
        start=0;
//[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }
    else{
        start=start+10;
        
    }
    
    NSURL *url;
    
    if(scopeOption!=2){
       
        NSData *data = [[self processText:str] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *inputString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        NSMutableString* dataString=[NSMutableString new];
        for(NSUInteger i=0; i<[inputString length];i++)
        {
            unichar character=[inputString characterAtIndex: i];
            if(isWanted(character))
                [dataString appendString: [NSString stringWithFormat: @"%c",character]];
        }
        
        if(segType==1)
        {

        
            /*
            url= [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/appfindee/select?wt=json&omitHeader=true&facet=true&facet.mincount=1&facet.field=primaryGenreId&facet.field=supportedDevices&facet.field=languageCodesISO2A&start=%d&row=10&fl=trackId,averageUserRating,trackNameExact,formattedPrice,userRatingCount,artworkUrl60&fq=supportedDevices:%@&fq=trackNameExact:%@&q=%@",start,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],dataString,dataString]];
             */
            
            url= [NSURL URLWithString:[NSString stringWithFormat:@"http://admin:hu5AsWud@appfindee.com/searchquery.php?index=name&query=%@&supportedDevices=%@&start=%d&rows=10",dataString,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],start]];
            
        }
        else if(segType==0)
        {
            url= [NSURL URLWithString:[NSString stringWithFormat:@"http://admin:hu5AsWud@appfindee.com/searchquery.php?index=relevance&query=%@&supportedDevices=%@&start=%d&rows=10",dataString,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],start]];
            
            /*
            url= [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/appfindee/select?wt=json&omitHeader=true&facet=true&facet.mincount=1&facet.field=primaryGenreId&facet.field=supportedDevices&facet.field=languageCodesISO2A&sort=scoring+desc&start=%d&row=10&fl=trackId,averageUserRating,trackNameExact,formattedPrice,userRatingCount,artworkUrl60&fq=supportedDevices:%@&q=%@",start,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],dataString]];
            */
            
        }
        else if(segType==2)
        {
            /*
            url= [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/appfindee/select?wt=json&omitHeader=true&facet=true&facet.mincount=1&facet.field=primaryGenreId&facet.field=supportedDevices&facet.field=languageCodesISO2A&sort=releaseDate+desc&start=%d&row=10&fl=trackId,averageUserRating,trackNameExact,formattedPrice,userRatingCount,artworkUrl60&fq=supportedDevices:%@&q=%@",start,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],dataString]];
        */
           url= [NSURL URLWithString:[NSString stringWithFormat:@"http://admin:hu5AsWud@appfindee.com/searchquery.php?index=latest&query=%@&supportedDevices=%@&start=%d&rows=10",dataString,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],start]];
            
             }
        
        //NSLog(@"url %@",url);
    }
    else{
        
        
     
        url=[NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/question/select?wt=json&sort=sort_date+desc&q=%@",[self processText:str]]];
    }
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];  
        
    AFHTTPRequestOperation *operation=  [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
     
        NSDictionary *dict=[operation.responseString JSONValue];
        
        searchvalueloadingflag=0;
       
        if(scopeOption==2) {
            [questionArray removeAllObjects];
            
              [questionArray addObjectsFromArray:[[dict valueForKey:@"response"] valueForKey:@"docs"] ];
            
            //NSLog(@"%@",questionArray);
            
            [progress stopAnimating];
            progress.hidden=YES;
            
            [self.resultView reloadData];
            
            self.navigationItem.rightBarButtonItem=nil;
       
             
            return ;
        }
        
        UIBarButtonItem *btn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"] style:UIBarButtonItemStylePlain target:self action:@selector(searchText)];
        //[btn setImage:[UIImage imageNamed:@"filter"]];
        
        self.navigationItem.rightBarButtonItem=btn;
        if(!loadMore){
            
            filterDic =[self parseFilterDictionary:dict];
            
            [dataArray addObjectsFromArray:[[dict valueForKey:@"response"]valueForKey:@"docs"]];
            
            
        }
        else{
            
            filterDic =[self parseFilterDictionary:dict];
            [dataArray addObjectsFromArray:[[dict valueForKey:@"response"]valueForKey:@"docs"]];
        }
        [progress stopAnimating];
        progress.hidden=YES;
        [self.resultView reloadData];
    }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                   
                                      }
     ];
    
    [operation start];


}




-(void)searchforTextWithFilter:(NSMutableDictionary*)dict
{

    [filters removeAllObjects];
       
    [filters addEntriesFromDictionary:dict];
    if(!loadMore){
        start=0;
        
        [dataArray removeAllObjects];
        [self.resultView reloadData];
    }
    else{
        start=start+10;
        
    }
        
    NSData *data = [[self processText:searchBar.text] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *inputString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSMutableString* dataString=[NSMutableString new];
    for(NSUInteger i=0; i<[inputString length];i++)
    {
        unichar character=[inputString characterAtIndex: i];
        if(isWanted(character))
            [dataString appendString: [NSString stringWithFormat: @"%c",character]];
    }

    /*
    NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/appfindee/select?wt=json&omitHeader=true&facet=true&facet.mincount=1&facet.field=primaryGenreId&facet.field=supportedDevices&facet.field=languageCodesISO2A&sort=scoring+desc&start=%d&row=10&fl=trackId,averageUserRating,trackNameExact,formattedPrice,userRatingCount,artworkUrl60&fq=supportedDevices:%@&q=%@%@",start,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],dataString,[self processDict:[dict mutableCopy]]]];
    */
    NSURL *url;
    if(segType==0)
    {
        url= [NSURL URLWithString:[NSString stringWithFormat:@"http://admin:hu5AsWud@appfindee.com/searchquery.php?index=relevance&query=%@&supportedDevices=%@&start=%d&rows=10%@",dataString,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],start,[self processDict:[dict mutableCopy]]]];
    }
    else if(segType==1)
    {
        url= [NSURL URLWithString:[NSString stringWithFormat:@"http://admin:hu5AsWud@appfindee.com/searchquery.php?index=name&query=%@&supportedDevices=%@&start=%d&rows=10%@",dataString,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],start,[self processDict:[dict mutableCopy]]]];
    }
    else if(segType==2)
    {
        url= [NSURL URLWithString:[NSString stringWithFormat:@"http://admin:hu5AsWud@appfindee.com/searchquery.php?index=latest&query=%@&supportedDevices=%@&start=%d&rows=10%@",dataString,[NSString stringWithFormat:@"%@",[scope objectAtIndex:scopeOption]],start,[self processDict:[dict mutableCopy]]]];
    }
    
    //NSLog(@"URL :%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     
    [request setHTTPMethod:@"POST"];
       
    AFHTTPRequestOperation *operation=  [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
   
        NSDictionary *dict=[operation.responseString JSONValue];
        
        searchvalueloadingflag=0;
        
        if(!loadMore){
            
            filterDic =[self parseFilterDictionary:dict];
            [dataArray addObjectsFromArray:[[dict valueForKey:@"response"]valueForKey:@"docs"]];
            
            
        }
        else{
            
            filterDic =[self parseFilterDictionary:dict];
            [dataArray addObjectsFromArray:[[dict valueForKey:@"response"]valueForKey:@"docs"]];
            
            loadMore=NO;
        }
        [progress stopAnimating];
        progress.hidden=YES;
        [self.resultView reloadData];
       // [SVProgressHUD dismiss];
    }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                   
                                      }
     ];
    
    [operation start];

    
    
}



-(void)searchText
{
    
    AUVFilterViewController *filter=[[AUVFilterViewController alloc] initWithNibName:@"AUVFilterViewController" bundle:nil];
     //filter.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    
    
    UINavigationController *filterNavigation=[[UINavigationController alloc] initWithRootViewController:filter];
    filterNavigation.navigationBar.tintColor=[UIColor blackColor];
    filterNavigation.navigationItem.title=@"Filter";

    filter.filterdict=filterDic;
    filter.parent=self;
    filter.searchStr=searchBar.text;
    filter.facets=filterContent;
    [self.navigationController presentModalViewController:filterNavigation withPushDirection:kCATransitionFromBottom];
   }

-(NSMutableDictionary*)parseFilterDictionary:(NSArray*)dict
{
    
    NSMutableDictionary *array=[[NSMutableDictionary alloc] init];
    
    /* for(NSDictionary *d in array)
     {
     
     [dict setValue:[d valueForKey:@"facet"] forKey:[d valueForKey:@"fieldName"]];
     }*/
    
    // //NSLog(@"facet : %@",dict);
    
    int count=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"languageCodesISO2A"]count];
    
    NSMutableArray *languagearray=[[NSMutableArray alloc]init];
    NSString *name;
    NSString *value;
    for(int i=0;i<count;i++)
    {
        
        
        if(i%2==0)
        {
            
            name=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"languageCodesISO2A"]objectAtIndex:i];
        }
        else{
            value=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"languageCodesISO2A"]objectAtIndex:i];
            
            [languagearray addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name,value, nil] forKeys:[NSArray arrayWithObjects:@"name",@"value", nil]]];
            
            
        }
        
        
    }
    
    
    [array setValue:languagearray forKey:@"languageCodesISO2A"];
    
    
    int category_count=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"primaryGenreId"]count];
    
    NSMutableArray *category_array=[[NSMutableArray alloc]init];
    NSString *name_category;
    NSString *value_category;
    for(int i=0;i<category_count;i++)
    {
        if(i%2==0)
        {
            
            name_category=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"primaryGenreId"]objectAtIndex:i];
        }
        else{
            value_category=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"primaryGenreId"]objectAtIndex:i];
            
            [category_array addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name_category,value_category, nil] forKeys:[NSArray arrayWithObjects:@"name",@"value", nil]]];
            
            
        }
        
        
    }
    
    
    [array setValue:category_array forKey:@"primaryGenreId"];
    
    int supportdevice_count=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"supportedDevices"]count];
    
    NSMutableArray *supportdevice_array=[[NSMutableArray alloc]init];
    NSString *name_supportdevice;
    NSString *value_supportdevice;
    for(int i=0;i<supportdevice_count;i++)
    {
        
        
        if(i%2==0)
        {
            
            name_supportdevice=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"supportedDevices"]objectAtIndex:i];
        }
        else{
            value_supportdevice=[[[[dict valueForKey:@"facet_counts"]valueForKey:@"facet_fields"] valueForKey:@"supportedDevices"]objectAtIndex:i];
            
            [supportdevice_array addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name_supportdevice,value_supportdevice, nil] forKeys:[NSArray arrayWithObjects:@"name",@"value", nil]]];
            
            
        }
        
        
    }
    
    
    [array setValue:supportdevice_array forKey:@"supportedDevices"];
    
    
    return array;
}

//Android
-(NSMutableArray*)parseJsonToDictionary:(NSArray*)appArray
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
   
    for(NSDictionary *app in appArray){
                NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setValue:[app valueForKey:@"score"] forKey:@"score"];
        for (NSDictionary *value in [app valueForKey:@"field"]) {
           
           
            [dict setValue:[value valueForKey:@"value"] forKey:[value valueForKey:@"name"]];
            
        }
        for (NSDictionary *value in [app valueForKey:@"snippet"]) {
            
            NSString *nameString=[NSString stringWithFormat:@"%@",[[[value valueForKey:@"value"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""]stringByReplacingOccurrencesOfString:@"</b>" withString:@""]];
            
            [dict setValue:nameString forKey:[value valueForKey:@"name"]];
            
        }
        
        
        [arr addObject:dict];
    }

return arr;
}
-(NSString*)processText:(NSString*)string
{
    NSArray *arr=[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(arr.count>1)
    
        return [arr  componentsJoinedByString:@"+"];
    else return string;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)sBar
{
 
    [dataArray removeAllObjects];
    [self.resultView reloadData];
    loadMore=NO;
    start=0;
    searching=sBar.text;
    [searchController setActive:NO];
     searchBar.text=searching;
    [self searchforText:searching];
    
   
    [sBar resignFirstResponder];

}


-(void) viewAppDetailView:(NSString*)appId
{
   // AUVDetailViewController *detail=[[AUVDetailViewController alloc] initWithNibName:@"" bundle:<#(NSBundle *)#>]
    
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVDetailViewController";
    }
    else {
        nibName=@"AUVDetailViewController_iPad";
    }
    AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:nibName bundle:nil];
    detailView.appId=appId;
    [self.navigationController pushViewController:detailView animated:YES];
    
}



-(void) viewAppDetailViewBtn:(id)sender
{
    // AUVDetailViewController *detail=[[AUVDetailViewController alloc] initWithNibName:@"" bundle:<#(NSBundle *)#>]
    
    NSString *nibName;
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        nibName=@"AUVDetailViewController";
    }
    else {
        nibName=@"AUVDetailViewController_iPad";
    }
    AUVDetailViewController *detailView=[[AUVDetailViewController alloc] initWithNibName:nibName bundle:nil];
    detailView.appId=[[dataArray objectAtIndex:[sender tag]] valueForKey:@"appId"];
    [self.navigationController pushViewController:detailView animated:YES];
    
}


-(NSString*)filterString:(NSMutableDictionary*)filter
{
   
  NSArray *keys=  [filter allKeys];
    NSArray *values=[filter allValues];
    NSMutableString *str=[[NSMutableString alloc] init];
    for(int i=0;i<keys.count;i++)
    {
        if([values  count]>0){
            [str stringByAppendingFormat:@"?fq=%@:",[keys objectAtIndex:i]];
            for(NSString *val in keys)
            {
                [str stringByAppendingFormat:@"%@",[filter valueForKey:val]];
            }
        }
    }
   
    
    return str;
}


-(NSString*)processDict:(NSMutableDictionary*)dict{
     NSMutableString *filter=[[NSMutableString alloc] initWithString:@""];
    //NSString *filter;
     if([dict count]!=0)
     {
     
     for(int i=0;i<[dict count];i++)
     {
   
         /*
         [filter appendString:[NSString stringWithFormat:@"&fq=%@:%@",[[dict allKeys] objectAtIndex:i],[[[dict allValues] objectAtIndex:i] encodeParameter]]];
         */
         
         // Editer : Sathish Jr
         [filter appendString:[NSString stringWithFormat:@"&%@=%@",[[dict allKeys] objectAtIndex:i],[[[dict allValues] objectAtIndex:i] encodeParameter]]];                   
     
     }
     }
    
    return filter;//[filter stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
}


/*
- (void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened {
    if (opened) {
      //  pullUpLabel.text = @"Now I'm open!";
    } else {
       // pullUpLabel.text = @"Now I'm closed, pull me up again!";
    }
}

*/



#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //[self filterContentForSearchText:searchString scope:nil];

    if(!controller.isActive){
        controller.searchResultsTableView.hidden = YES;
        return NO;
    }
    controller.searchResultsTableView.hidden = NO;
   //[self loadSuggestionList:searchString];
    [self performSelectorInBackground:@selector(loadSuggestionList:) withObject:searchString ];
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self performSelectorInBackground:@selector(loadSuggestionList:) withObject:[self.searchController.searchBar text] ];
    scopeOption=searchOption;
    // [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:nil];
    return YES;
}
- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
     
   
   	[self.searchController.searchResultsTableView setDelegate:self];
   

  
   
    
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
   
    
}


- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView  {
    

    
}

#pragma mark - UISearchBarDelegate Methods



-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)sBar
{
    [sBar removeFromSuperview];
    sBar.text=@"";
   // scopeOption=0;
    

    sBar.frame=CGRectMake(0, 0, 320, 44);
    [self.view addSubview:sBar];
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   

    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)sbar {
    //move the search bar down to the correct location eg
    [searchController setActive:NO animated:YES];
    searchBar.text=sbar.text;
    searchBar.frame= CGRectMake(76, 0, 197, 44);
    [self.navigationController.navigationBar addSubview:searchBar];
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {

 }
-(void)loadSuggestionList:(NSString*)str
{
    [AFHTTPRequestOperation cancelPreviousPerformRequestsWithTarget:self];
    NSURL *url;
    if(scopeOption!=2)
    {
        
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
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/new_appsuggest/suggest?wt=json&omitHeader=true&q=%@",[[self processText:string]lowercaseString]]];
        
    }else
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/question/suggest?wt=json&sort=sort_date+desc&q=%@",[[self processText:str] lowercaseString]]];
    }
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody:postData];
    
    AFHTTPRequestOperation *operation=  [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    [sugArray removeAllObjects];
        
    NSDictionary *dict=[operation.responseString JSONValue];
        
    //  //NSLog(@"%@",dict);
        
    // NSArray *arr=[[NSArray alloc]init];
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        if([[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"]count]==2)
        for(int i=0;i<[[[[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"] objectAtIndex:1]valueForKey:@"suggestion"]count];i++)
        {
            ;
            
            [arr addObject:[[[[[[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"] objectAtIndex:1]valueForKey:@"suggestion"]objectAtIndex:i] stringByReplacingOccurrencesOfString:@"_" withString:@" "] componentsSeparatedByString:@"@--@"]];
            
        }
        
        
        for(int i=0;i<arr.count;i++)
        {
            [sugArray addObject:[[arr objectAtIndex:i]objectAtIndex:0]];
        }
        
       // if(arr.count!=0)
        //[sugArray addObjectsFromArray:arr];

        
        [self.searchController.searchResultsTableView reloadData];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {}
   ];
    [operation start];
}
-(void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened
{
    
}
-(void)loadMoreData
{
    loadMore=YES;
    
    if(searchvalueloadingflag==0)
    {
        if(filters.count==0)
        {
        
            [self searchforText:searching];
            searchvalueloadingflag=1;
        
        }
        else
        {
       
            [self searchforTextWithFilter:[filters mutableCopy]];
            searchvalueloadingflag=1;
       
        
        }
    }

}
-(IBAction) openURL:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",(NSString*)[[dataArray objectAtIndex:[sender tag]] valueForKey:@"appurl"]]]];
 
}
-(void)valueChanged:(SDSegmentedControl*)seg
{
    if(seg.selectedSegmentIndex==0)
    {
        loadMore=NO;
        start=0;
        segType=0;
        [dataArray removeAllObjects];
        [self.resultView reloadData];
       
    }
    else if(seg.selectedSegmentIndex==1)
    {
        loadMore=NO;
        start=0;
        segType=1;
        [dataArray removeAllObjects];
        [self.resultView reloadData];
        
    }
    else if(seg.selectedSegmentIndex==2)
    {
        loadMore=NO;
        start=0;
        segType=2;
        [dataArray removeAllObjects];
        [self.resultView reloadData];
        
    }
    [self searchforText:searching];
}



-(void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        if(![[AUV_DELEGATE facebook] isSessionValid]){
    
                [[AUV_DELEGATE facebook] authorize:[AUV_DELEGATE fbPermission]];

      //   DLog(@"responseData: %@", content);
        }
               
        
        NSString *urlToLikeFor = @"http://facebook.com/appfindee";//facebookLike.titleLabel.text;
        
        NSString *theWholeUrl = [NSString stringWithFormat:@"https://graph.facebook.com/me/og.likes?object=%@&access_token=%@", urlToLikeFor, [[AUV_DELEGATE facebook] accessToken]];
        //  DLog(@"TheWholeUrl: %@", theWholeUrl);
        
        NSURL *facebookUrl = [NSURL URLWithString:theWholeUrl];
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:facebookUrl];
        [req setHTTPMethod:@"POST"];
        
        NSURLResponse *response;
        NSError *err;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&err];
        NSString *content = [NSString stringWithUTF8String:[responseData bytes]];

        NSLog(@"test :%@",content);
    }
}
@end
