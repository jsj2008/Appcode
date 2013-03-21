//
//  AUVDetailViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVDetailViewController.h"
#import "AUVQuestionViewController.h"
#import "AUVCustomTabbar.h"
#import "AUVNotificationViewController.h"
#import "AUVAppWallController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVSuggestAppController.h"
#import "AUVFriendsLikeViewController.h"
#import "AUVAddQuestionViewController.h"
#import "AUVAnswerViewController.h"
#import "AUVReviewViewController.h"
#import "AUVSignInViewController.h"
#import "AUVDealsViewController.h"
#import "AUVPhotoViewerViewController.h"
#import "RNBlurModalView.h"
#import "AUVScrollTabBar.h"
#import "AUVwallcontrollerViewController.h"
#import "ASSignViewController.h"
#import "AUVHelpViewController.h"
#import "ASSignViewController.h"



@interface AUVDetailViewController ()

@end

@implementation AUVDetailViewController
@synthesize appId,leftSelectedIndexPath,categoryId;
NSMutableArray *imgArray;
int ratecount=0;
int Pagepositon=0;
UIImageView *imgview;
NSMutableArray * reviewurlarray;


Facebook *fb;
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
    
    
    NSUserDefaults *standarddeflt =[NSUserDefaults standardUserDefaults];
    NSLog(@"default value %@",[standarddeflt objectForKey:@"user_id"]);
    
    [super viewDidLoad];
    [scrollView setScrollEnabled:YES];
     [scrollView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 650.0, 0.0)];
    self.navigationController.navigationBarHidden=NO;

    appDic=[[NSMutableDictionary alloc] init];
   
    self.title=@"App";
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
   
    [webView loadHTMLString:@"<body> <p>load Data </p> Hello user   <a href ='http://google.com'>Google </a>  </body>" baseURL:nil];
    
    imgArray = [[NSMutableArray alloc] init];
    appIcon.layer.cornerRadius=10;
    appIcon.clipsToBounds=YES;
    pageflow.delegate = self;
    pageflow.dataSource = self;
    pageflow.pageControl = pageControl;
    pageflow.minimumPageAlpha = 0.3;
    pageflow.minimumPageScale = 0.9;
    
    table.backgroundColor = [UIColor lightGrayColor];
    
    rateView=[[DYRateView alloc] initWithFrame:rateIt.frame fullStar:[UIImage imageNamed:@"star_full"] emptyStar:[UIImage imageNamed:@"star_empty"]];
    
    rateView.rate=0.0f;
    rateView.editable=YES;
    rateView.delegate=self;
    rateView.size=RateViewBig;
    
    [rateContainer setBackgroundColor:[UIColor clearColor]];
    [rateContainer addSubview:rateView];
   // [friends setBackgroundColor:[UIColor clearColor]];
    
    
    
         [segmentedControl addTarget:self
                         action:@selector(action:)
               forControlEvents:UIControlEventValueChanged];
    
        
    
    priceButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
    priceButton.layer.cornerRadius=5.0f;
    
[self GridViewSetUp];
    
//    if([AUVLogin isAccessAllowed])
//    {
//        AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
//        custombar.delegate= self;
//        
//        [self.view addSubview:custombar];
 //   }
    
    AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 360, 320, 104)];
    [custombar.button3 setImage:[UIImage imageNamed:@"tab_deals.png"] forState:UIControlStateNormal];
    custombar.delegate= self;
    [self.view addSubview:custombar];

    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];

    
    [self detailAction];



}
-(void)btnTap:(UIButton*)buttonId

{
    
    //NSLog(@"bbb %d",buttonId.tag);
    
//    if(![AUVLogin isAccessAllowed])
//    {
//        [self loginAndRegister];
//         [self GoaToSignInPage];
//        
//        return;
//    }
    
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
        
        ASSignViewController *notification = [[ASSignViewController alloc]initWithNibName:@"ASSignViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
                
    }else if (buttonselect == 5){
        
        AUVHelpViewController *helpView =[[AUVHelpViewController alloc] initWithNibName:@"AUVHelpViewController" bundle:nil];
        [self.navigationController pushViewController:helpView animated:YES];

      
    }
    else{
        
        //NSLog(@"nothing");
        
    }
    
}

-(void)GridViewSetUp
{
    if(!webView)
    {
        pagescroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0,116,320, 250)];
        [pagescroll setBackgroundColor:[UIColor whiteColor]];
        pagescroll.pagingEnabled=YES;
        [container addSubview:pagescroll];
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,90)];
        webView.delegate = self;
        
        [(UIScrollView*)[webView.subviews objectAtIndex:0] setShowsHorizontalScrollIndicator:NO];
        [(UIScrollView*)[webView.subviews objectAtIndex:0] setShowsVerticalScrollIndicator:NO];
        [(UIScrollView*)[webView.subviews objectAtIndex:0] setBounces:NO];
        [(UIScrollView*)[webView.subviews objectAtIndex:0] setScrollEnabled:NO];
        
        morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        morebutton.frame=CGRectMake(280, 90, 40, 25);
        morebutton.tag=2;
       
        [morebutton setTitle:@"More" forState:UIControlStateNormal];
         morebutton.font=[UIFont systemFontOfSize:13];
        [morebutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [morebutton addTarget:self action:@selector(photoViewerPage:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:morebutton];
        [self.view addSubview:webView];
        
        //GMGridViewLayoutHorizontalPagedTTB
        //[container addSubview:gmGridView];
        // self.gridView.centerGrid = control.on;
        // [self.gridView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
    }
    
    if(!tableviewquestion){
        
        tableviewquestion=[[UITableView alloc] initWithFrame:container.bounds style:UITableViewStylePlain];
        tableviewquestion.delegate=self;

        tableviewquestion.dataSource=self;
        tableviewquestion.separatorStyle=UITableViewCellSeparatorStyleNone;
        
    }
    if(!tableviewreview){
        
        tableviewreview=[[UITableView alloc] initWithFrame:container.bounds style:UITableViewStylePlain];
        tableviewreview.delegate=self;
        tableviewreview.dataSource=self;
        tableviewreview.separatorStyle=UITableViewCellSeparatorStyleNone;
        
    }
  
    
    if(type!= review && type!=discussion)
    {
        if(tableviewquestion&&tableviewreview)
        {
           [tableviewquestion removeFromSuperview];
            [tableviewreview removeFromSuperview];
        }
        [container addSubview:morebutton];
        [container addSubview:webView];
        
    }
    else if(type!=review && type!=description)
    {
       if(webView&&tableviewreview)
       {
           [morebutton removeFromSuperview];
           [webView removeFromSuperview];
           pagescroll.hidden=YES;
           [tableviewreview removeFromSuperview];
       }
        
        [container addSubview:tableviewquestion];
    }else if(type!=description && type!=discussion)
    {
        if (webView&&tableviewquestion) {
            [morebutton removeFromSuperview];
            [webView removeFromSuperview];
            pagescroll.hidden=YES;
            [tableviewquestion removeFromSuperview];
        }
        [container addSubview:tableviewreview];
    }
    
    
    friendsscroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320, 60)];
    [friendsscroll setBackgroundColor:[UIColor clearColor]];
    friendsscroll.pagingEnabled=YES;
    
    [friends setBackgroundColor:[UIColor clearColor]];
    [friends addSubview:friendsscroll];
    
    [self loadContentViews:type];
    
}


-(void)loadContentViews:(ContentTypeAppview)type
{
    if(type==description)
    {
     // [webView loadHTMLString:@"<body> <p>load Data </p> Hello user   <a href ='http://google.com'>Google </a>  </body>" baseURL:nil];
        
        NSString *str=[NSString stringWithFormat:@"%@", [appDic valueForKey:@"descriptionExact"]];
        [webView loadHTMLString:[self convertEntities:str] baseURL:nil];
        pagescroll.hidden=NO;
    }
    else if(type==discussion)
    {
     [tableviewquestion reloadData];
        
    }
    
    else if(type==review)
    {
        [tableviewreview reloadData];
    }
}
-(void)action:(id)sender {
    
    
    if(segmentedControl.selectedSegmentIndex==0){
        
        [scrollView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 650.0, 0.0)];
        type=description;
    }
    else if(segmentedControl.selectedSegmentIndex==1)
    {
          [scrollView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 700.0, 0.0)];
        type=discussion;
    }
    
    else if(segmentedControl.selectedSegmentIndex==2)
    {
        [scrollView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 700.0, 0.0)];
        type=review;
    }
    
    [self GridViewSetUp];
    
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


-(void)detailAction
{
   //NSLog(@"tetetee");
    [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    [self detailActionWithAppId:appId];
}



-(void)detailActionWithAppId:(NSString*)sappId;
{
    NSUserDefaults *standarddeflt =[NSUserDefaults standardUserDefaults];
    NSLog(@"default value %@",[standarddeflt objectForKey:@"user_id"]);

    //NSLog(@"saasda");
    AUVwebservice *service=[AUVwebservice service];
    service.logging=YES;
    appId=sappId;
    
   //[service get_appdetails:self action:@selector(detailHandler:) appid:sappId];
    [service get_appdetails:self action:@selector(detailHandler:) appid:sappId user_id:[standarddeflt objectForKey:@"user_id"]];
}


-(void)detailHandler:(id)value
{
    
    ////NSLog(@"sdasdadasd");
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		//NSLog(@"%@", value);
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
		return;
	}				
    
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    
    if([[result JSONValue] count]!=0){
   [appDic addEntriesFromDictionary:[result JSONValue]];
         NSLog(@"%@",appDic);
        [self performSelectorOnMainThread:@selector(updateDetails) withObject:nil waitUntilDone:NO];
   }
    
   
   }

-(IBAction)suggestFriends
{
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }
    
           AUVSuggestAppController *suggest=[[AUVSuggestAppController alloc] initWithFrame:self.view.bounds];
        
        
        suggest.delegate=self;
        suggest.appid=[NSString stringWithFormat:@"%@",appId];
        [self.view addSubview:suggest];
        [suggest showFromPoint:[self.view center]];
        
    

}


-(void)updateDetails
{
 
   // NSLog(@"%@",appDic);
    
    if([[appDic valueForKey:@"redeem"] integerValue]==1)
    {
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Redeem code!" message:@"Get redeem code for this app by suggesting this app to 10 friends."];
        [modal show];

    }
    /*else if([[appDic valueForKey:@"redeem"] integerValue]==0)
    {
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"dasd" message:@"10 friends"];
        [modal show];
        
    }*/
    
    
    if([appDic valueForKey:@"trackCensoredName"]==[NSNull null]){
        [self.navigationController popViewControllerAnimated:YES];
        return;
       
    }
   
    reviewurlarray=[[NSMutableArray alloc]init];
    
    [reviewurlarray addObjectsFromArray:[appDic valueForKey:@"reviews"]];
    
    
 
    

    appName.font=[UIFont systemFontOfSize:13];
    
    appName.text=[self convertEntities:[appDic valueForKey:@"trackCensoredName"]];
    
    NSString *str=[NSString stringWithFormat:@"%@", [appDic valueForKey:@"descriptionExact"]];
    [webView loadHTMLString:[self convertEntities:str] baseURL:nil];
    
    NSArray *logoArray=[(NSString*)[appDic  valueForKey:@"artworkUrl60"] componentsSeparatedByString:@"appfindy"];
    
    if(logoArray.count==1)
    {
        NSString *strapplogo=  [NSString stringWithFormat:@"%@",[logoArray objectAtIndex:0]];
        
        strapplogo = [strapplogo stringByReplacingOccurrencesOfString:@"vol/iphone_final/./"
                                                           withString:@""];

        
    [appIcon setImageWithURL:[NSURL URLWithString:strapplogo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    rateView.rate=[[appDic valueForKey:@"averageUserRating"] floatValue];
    
    like.text=[NSString stringWithFormat:@"%@",[appDic valueForKey:@"like_count"]];
    
    dislikeLabel.text=[NSString stringWithFormat:@"%@",[appDic valueForKey:@"app_dislike_count"]];
        
    
    developer.font=[UIFont systemFontOfSize:12];
    developer.text=[self convertEntities:[appDic valueForKey:@"artistName"]];
    category.font=[UIFont systemFontOfSize:13];
    category.text=[self convertEntities:[appDic valueForKey:@"primaryGenreName"]];
    friendsLike.text=[NSString stringWithFormat:@"%@ Friends likes it",[appDic valueForKey:@"friends_app_like_count"]];
    friendsLike.font=[UIFont systemFontOfSize:12];
    price.font=[UIFont systemFontOfSize:12];
    price.text=[NSString stringWithFormat:@"%@",[appDic valueForKey:@"formattedPrice"]];
    //btn.titleLabel.text=[appDic valueForKey:@"price"];
    //[btn addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchDown];
   // [imgArray ]
    NSArray *pathArray=[NSArray arrayWithArray:[[appDic valueForKey:@"all_screenshotUrls"]componentsSeparatedByString:@","]];
    

    
 
   // NSArray *pathArray=[NSArray arrayWithArray:[[appDic valueForKey:@"screenshotUrls"]componentsSeparatedByString:@","]];

    
    categoryId=[appDic valueForKey:@"primaryGenreId"];
    developerId=[appDic valueForKey:@"artistId"];
    categorylabel.font=[UIFont systemFontOfSize:12];
    platform.font=[UIFont systemFontOfSize:12];
    platform.text=[appDic valueForKey:@"supportedDevices"];
    
    ratingcountlabel.text=[appDic valueForKey:@"supportedDevices"];
                           
    
    followers.text=[NSString stringWithFormat:@"%@",[appDic valueForKey:@"follow_count"]];
    [imgArray removeAllObjects];
    for(int i=0;i<pathArray.count;i++){
        NSArray *StrArray=[NSArray arrayWithArray:[(NSString*)[pathArray objectAtIndex:i]componentsSeparatedByString:@"appfindy"]];
        
       // if(StrArray.count==2)
    [imgArray addObject:[NSString stringWithFormat:@"%@",[StrArray objectAtIndex:0]]];
    }
        
    
    if(imgArray.count>0)
    {
       
                   
            NSString *strapplogo=  [NSString stringWithFormat:@"%@",[imgArray objectAtIndex:0]];
            
            strapplogo = [strapplogo stringByReplacingOccurrencesOfString:@"vol/iphone_final/./"
                                                               withString:@""];
    
        
//        if(imgview){
//            
//            [imgview removeFromSuperview];
//        }
           imgview=[[UIImageView alloc]initWithFrame:CGRectMake(60,0,200,250)];
            
            [imgview setImageWithURL:[NSURL URLWithString:strapplogo] placeholderImage:[UIImage imageNamed:@"loading"]];
            
            [pagescroll addSubview:imgview];
        
        
        UIButton *photoviewbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        photoviewbutton.frame=CGRectMake(0, 0, 320, 250);
        photoviewbutton.tag=1;
        [photoviewbutton addTarget:self action:@selector(photoViewerPage:) forControlEvents:UIControlEventTouchUpInside];
        

        [pagescroll addSubview:photoviewbutton];
        
           [pagescroll setContentSize:CGSizeMake(320, 150)];
    }
    
    
    
    if([[appDic valueForKey:@"friends_app_like"] count]>0)
    {
        int y=0;
        for (int i=0; i<[[appDic valueForKey:@"friends_app_like"]count]; i++) {
            
            
            
            UIView *baseView=[[UIView alloc] initWithFrame:CGRectMake(0+y, 2, 60, 60)];
            
            baseView.backgroundColor=[UIColor clearColor];
            
            UIImageView *icon =[[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 40, 30)];
            
            
            //icon.clipsToBounds=YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 60, 60);
            
            [button addTarget:self
                       action:@selector(goToFriendsProfile:)
             forControlEvents:(UIControlEvents)UIControlEventTouchDown];
            
            button.tag=i;
            
            
            
            UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(0, 35, 50, 22)];
            name.font=[UIFont systemFontOfSize:12];
            name.textColor=[UIColor blueColor];
            name.backgroundColor=[UIColor clearColor];
            name.textAlignment=UITextAlignmentLeft;
            [baseView addSubview:button];
            [baseView addSubview:icon];
            [baseView addSubview:name];
            
            NSArray *friendsArray=[NSArray arrayWithArray:[appDic valueForKey:@"friends_app_like"]];
            
            
            [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[friendsArray objectAtIndex:i] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
            name.text=[NSString stringWithFormat:@"%@",[[friendsArray objectAtIndex:i] valueForKey:@"firstname"]];
            
            y=70+y;
            [friendsscroll addSubview:baseView];
            
        }
        [friendsscroll setContentSize:CGSizeMake([[appDic valueForKey:@"friends_app_like"] count]*60, 60)];
    }
    
    [pageflow performSelectorInBackground:@selector(reloadData) withObject:nil];
    
    [tableviewreview reloadData];
    //[likedFriends reloadData];
    [tableviewquestion reloadData];
    //[self setupHorizontalScrollView];
    
//    UIBarButtonItem *followBtn=[[UIBarButtonItem alloc] initWithTitle:@"Follow" style:UIBarButtonItemStylePlain target:self action:@selector(followAction:)];
//    if([[appDic valueForKey:@"follow"] boolValue]){
//        
//        followBtn.title=@"Unfollow";
//        //followBtn.action=nil;
//        
//    }
//    followed=[[appDic valueForKey:@"follow"] boolValue];
//    
//    self.navigationItem.rightBarButtonItem=followBtn;

    
}

-(void)photoViewerPage:(id)sender
{
     AUVPhotoViewerViewController *photoviewer=[[AUVPhotoViewerViewController alloc]initWithNibName:@"AUVPhotoViewerViewController" bundle:nil];
    if([sender tag]==1)
    {
       
        photoviewer.imgarray=imgArray;
        photoviewer.pageview=@"imageview";
    }else if([sender tag]==2)
    {
        photoviewer.pageview=@"desc";
        photoviewer.disc=[appDic valueForKey:@"descriptionExact"];
    }
    UINavigationController *photonavigation=[[UINavigationController alloc] initWithRootViewController:photoviewer];
    
    photonavigation.navigationBar.tintColor=[UIColor blackColor];
    [self.navigationController presentModalViewController:photonavigation animated:YES];
}
                                                         
                                                         
-(IBAction)goToFriendsProfile:(id)sender
{
    
    
   NSArray *friendsArray=[NSArray arrayWithArray:[appDic valueForKey:@"friends_app_like"]];
//    
   [self userView:[[friendsArray objectAtIndex:[sender tag]] valueForKey:@"user_id"]];
  
}
/*

 
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    webView.userInteractionEnabled=NO;
}

*/

-(IBAction) openURL:(id)sender
{
    
    [NSURL URLWithString:@"itms://itunes.com/apps/appname"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[appDic valueForKey:@"trackViewUrl"]]]];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        //[[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


- (NSString*)convertEntities:(NSString*)string
{
    
    NSString    *returnStr = nil;
    
    if( string )
    {
        returnStr = [ string stringByReplacingOccurrencesOfString:@"&amp;" withString: @"&"  ];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""  ];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"  ];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"&#x39;" withString:@"'"  ];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"&#x92;" withString:@"'"  ];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"&#x96;" withString:@"'"  ];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"  ];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"  ];
        
        returnStr = [ [ NSString alloc ] initWithString:returnStr ];
    }
    
    return returnStr;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(200, 150);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(PagedFlowView *)flowView {
    //NSLog(@"Scrolled to page # %d", pageNumber);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return [imgArray count];
}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 6;
        imageView.layer.masksToBounds = YES;
    }
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imgArray objectAtIndex:index]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

- (IBAction)pageControlValueDidChange:(id)sender {
    UIPageControl *pgControl = sender;
    [pageflow scrollToPage:pgControl.currentPage];
    
}





-(IBAction)makeFavoriteforUser
{
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }
    AUVwebservice *service=[AUVwebservice service];
   [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //service.logging=NO;
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    
   // [service favorite_app:self action:@selector(favoriteHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:appId];
    [service applike:self action:@selector(favoriteHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:appId];
    
    
}

-(IBAction)addComment:(id)sender
{
    //NSLog(@"Comment");
}

-(IBAction)shareApp:(id)sender
{
 
  //  //NSLog(@"Share");
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
        
        [self GoaToSignInPage];
        
        return;
    }
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Wall",nil];
    
    actionSheet.actionSheetStyle=UIActionSheetStyleAutomatic;
    
    [actionSheet showInView:self.view];

   // [self loadFB];
   /* AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    [service share_apps:self action:@selector(shareAppHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:appId message:@""];*/
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self loadFB];
        
    } else if (buttonIndex == 1) {
        [self loadWall];
        
    } else if (buttonIndex == 2) {
        
    }
}


-(void)loadWall
{
 
    AUVwebservice *service=[AUVwebservice service];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    service.logging=NO;
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    
    [service appshare:self action:@selector(loadWallHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:appId];
    
}


-(void)loadWallHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    
        NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    
    NSLog(@"Res : %@",[result JSONValue]);

    
   /* NSDictionary * dict = [result JSONValue];
    // //NSLog( @"%@: %@",[dict valueForKey:@"key"],[dict valueForKey:@"value"]);
    //  [appDic setValue:[dict valueForKey:@"value"] forKey:[dict valueForKey:@"key"]];
    
    if([[dict valueForKey:@"status"] boolValue])
    {
        likeBtn.enabled=NO;
        [self detailAction];
        
    }*/
    
    }
    
}


-(IBAction)reportApp:(id)sender
{
    //NSLog(@"Report");
}
-(void)favoriteHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{

    SoapArray* arr = (SoapArray*)value;
  
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    //NSLog(@"result : %@",result);
    
    NSDictionary * dict = [result JSONValue];
    
    if([[dict valueForKey:@"status"] boolValue])
        {
              [SVProgressHUD dismiss];
            likeBtn.enabled=NO;
            [self detailAction];
            
        }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"You have already liked the app."];

    }

    
    }
}

-(void)defavoriteHandler:(id)value
{
    
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray* arr = (SoapArray*)value;
    
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    //NSLog(@"result : %@",result);
    
    NSDictionary * dict = [result JSONValue];
    
    if([[dict valueForKey:@"status"] boolValue])
    {
        [SVProgressHUD dismiss];
        likeBtn.enabled=NO;
        [self detailAction];
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"You have already disliked the app."];
        
    }
    }
    
    
}


-(void)shareAppHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    //NSLog(@"result : %@",result);
    
    NSDictionary * dict = [result JSONValue];
    // //NSLog( @"%@: %@",[dict valueForKey:@"key"],[dict valueForKey:@"value"]);
    //  [appDic setValue:[dict valueForKey:@"value"] forKey:[dict valueForKey:@"key"]];
    
    if([[dict valueForKey:@"status"] boolValue])
    shareBtn.enabled=NO;
    }
    
}


-(IBAction)friendslikePage
{
    
   // //NSLog(@"%@",[appDic  valueForKey:@"friends_app_like"]);
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {
//    if(![AUVLogin isAccessAllowed])
//    {
        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }
    
    NSArray *arr=[NSArray arrayWithArray:[appDic valueForKey:@"friends_app_like"]];
    
    if(arr.count!=0)
    {
    
        AUVFriendsLikeViewController *friendslikeview=[[AUVFriendsLikeViewController alloc] initWithNibName:@"AUVFriendsLikeViewController" bundle:nil];
        friendslikeview.friendslikelist=[NSArray arrayWithArray:[appDic valueForKey:@"friends_app_like"]];
        [self.navigationController pushViewController:friendslikeview
                                      animated:YES];
    }else
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Friends not found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}


-(IBAction)developerView
{
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {
        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }

    AUVDevsViewController *devsView=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil type:AUVTYPEDEVELOPER];
    devsView.detailController=self;
    
    //NSLog(@"dev %@",developerId);
    
    devsView.developerId=developerId;
    devsView.developer=developer.text;
    [self.navigationController pushViewController:devsView animated:YES];
}


-(IBAction)categoryView
{
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {
        
        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }

    AUVDevsViewController *devsView=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil type:AUVTYPECATEGORY];
    devsView.detailController=self;
    devsView.categoryId=categoryId;
    devsView.category=category.text;
    [self.navigationController pushViewController:devsView animated:YES];
}


-(IBAction)userView:(NSString*)uid
{
    //NSLog(@"test");
    /*
    AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil type:AUVTYPEPROFILE];
    profile.userId=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"user_id"];
    if([[[dataArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
        profile.follow=1;
    [self.navigationController pushViewController:profile animated:YES];
    */
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {
        
        [self loginAndRegister];
         [self GoaToSignInPage];
        
        return;
    }

    else{
    AUVDevsViewController *devsView = [[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
    devsView.detailController=self;
    devsView.follow=1;
    devsView.userId=[NSString stringWithFormat:@"%@",uid];
    [self.navigationController pushViewController:devsView animated:YES];
    }
}



-(void)rateTheApplication
{
//    if(![AUVLogin isAccessAllowed])
//{
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

    [self loginAndRegister];
     [self GoaToSignInPage];
    
    return;
}

    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
     NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    [service apprating:self action:@selector(rateHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:appId rating:[NSString stringWithFormat:@"%d",ratecount]];
}



-(void)rateHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    
	// Do something with the Array* result
    //SoapArray* arr = (SoapArray*)value;
    
    //NSLog(@"%@",arr);
}



-(IBAction) commentsView:(UIButton*)sender
{
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        
        return;
    }
    AUVAnswerViewController *panel;
    if([sender tag]==3)
    {
        /*AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc] initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
        obj.questiontype=@"app";
        
        [self.navigationController pushViewController:obj animated:YES];
        */
        
        
        Pagepositon=3;
        panel =[[AUVAnswerViewController alloc] initWithFrame:self.view.bounds withType:TypeQn];
        panel.delegate=self;
        panel.parent=self;
        
        [self.view addSubview:panel];
        [panel showFromPoint:[self.view center]];
        
    }else if([sender tag]==4)
    {
        Pagepositon=4;
        panel =[[AUVAnswerViewController alloc] initWithFrame:self.view.bounds withType:TypeCmt];        
       
        
        panel.delegate=self;
        panel.parent=self;
        
        [self.view addSubview:panel];
        [panel showFromPoint:[self.view center]];
    }
    else
    {
    //NSLog(@"sender : %d",sender.tag);
    AUVCommentsViewController *commentView=[[AUVCommentsViewController alloc] initWithNibName:@"AUVCommentsViewController" bundle:nil];
    commentView.appId=appId;
    if([sender tag]==1)
    commentView.type=Comment;
   else if([sender tag]==2)
        commentView.type=discussion;

    commentView.categoryId=categoryId;
    [self.navigationController pushViewController:commentView animated:YES];
    }
    
    
}

-(void)commentsAction:(NSString*)comment withArg2:(NSString*)apptitle
{
    AUVwebservice *service=[AUVwebservice service];
   
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    
    if(Pagepositon==4)
        [service appcomment:self action:@selector(commentActionHandler:) user_id:[defaults valueForKey:@"user_id"] app_id:appId comment:comment];
    else if(Pagepositon==3)
        [service question:self action:@selector(commentActionHandler:) category_id:categoryId app_id:appId user_id:[defaults valueForKey:@"user_id"] question:apptitle description:comment];
    
}

-(void)commentActionHandler:(id)value
{
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
       // SoapArray* arr = (SoapArray*)value;
		//NSLog(@"%@", arr);
        if(Pagepositon==4){
            Pagepositon=0;
            
            AUVCommentsViewController *commentView=[[AUVCommentsViewController alloc] initWithNibName:@"AUVCommentsViewController" bundle:nil];
            commentView.appId=appId;
            commentView.type=Comment;
            commentView.categoryId=categoryId;
            [self.navigationController pushViewController:commentView animated:YES];
        }

        [SVProgressHUD dismiss];
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		//NSLog(@"%@", value);
        if(Pagepositon==4){
            Pagepositon=0;
            
            AUVCommentsViewController *commentView=[[AUVCommentsViewController alloc] initWithNibName:@"AUVCommentsViewController" bundle:nil];
            commentView.appId=appId;
            commentView.type=Comment;
            commentView.categoryId=categoryId;
            [self.navigationController pushViewController:commentView animated:YES];
        }

        [SVProgressHUD dismiss];
		return;
	}
    
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    //[SVProgressHUD dismiss];
    //NSLog(@"arrrr : %@",arr);
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //NSLog(@"result : %@",[result JSONValue]);
   [SVProgressHUD dismiss];
    
    if(Pagepositon==4){
        Pagepositon=0;
        
        AUVCommentsViewController *commentView=[[AUVCommentsViewController alloc] initWithNibName:@"AUVCommentsViewController" bundle:nil];
        commentView.appId=appId;
        commentView.type=Comment;
        commentView.categoryId=categoryId;
        [self.navigationController pushViewController:commentView animated:YES];
    }
    else if(Pagepositon==3)
    {
        Pagepositon=0;
        NSDictionary *dict=[result JSONValue];
        
        AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
        question.questionId=[NSString stringWithFormat:@"%@",[dict valueForKey:@"question_id"]];
        question.info=[[NSMutableDictionary alloc] initWithDictionary:dict];
        
        [self.navigationController pushViewController:question animated:YES];
        
    }
}



#pragma mark DYRateView Delegate
- (void)changedToNewRate:(NSNumber *)rate
{
    
   // [self rateTheApplication:[rate floatValue]];
}








#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView==tableviewreview)
    return [[appDic  valueForKey:@"get_app_comment"] count]+2+reviewurlarray.count;
    if(tableView==likedFriends)
        return [[appDic  valueForKey:@"friends_app_like"] count];
    if(tableView==tableviewquestion)
        return [[appDic  valueForKey:@"get_app_questions"] count]+1;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *identifier = @"TableCell";
    // UITableViewCell *cell=nil;
    UILabel *name;
    UILabel *comment;
    UILabel *time;
    UIView *baseView;
    UIImageView *icon;
    UIImageView *ansicon;
    UILabel *anscount;
    UIImageView *line;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(cell !=nil){
		cell=nil;
	}
    
     if(tableView==likedFriends)
     {
         if (cell == nil)
         {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
              CGAffineTransform rotateImage = CGAffineTransformMakeRotation(M_PI_2);
             cell.transform = rotateImage;
             cell.frame=CGRectMake(0, 0, 60, 50);
            // CGRectApplyAffineTransform(cell.bounds, rotateImage)
             baseView=[[UIView alloc] initWithFrame:cell.bounds];
             
             baseView.backgroundColor=[UIColor clearColor];
             icon =[[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 40, 30)];
             
             //icon.layer.cornerRadius=10.0;
             icon.clipsToBounds=YES;
            
             
             name=[[UILabel alloc] initWithFrame:CGRectMake(0, 35, 50, 22)];
             name.font=[UIFont systemFontOfSize:12];
             name.textColor=[UIColor blueColor];
             name.backgroundColor=[UIColor clearColor];
             name.textAlignment=UITextAlignmentCenter;
             [baseView addSubview:icon];
             [baseView addSubview:name];
             
             [cell addSubview:baseView];
             cell.backgroundColor=[UIColor clearColor];
         }
         
          NSArray *friendsArray=[NSArray arrayWithArray:[appDic valueForKey:@"friends_app_like"]];
          [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[friendsArray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
         
         //[icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash3/173132_100001693686032_1857987949_s.jpg"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
         name.text=[NSString stringWithFormat:@"%@",[[friendsArray objectAtIndex:indexPath.row] valueForKey:@"firstname"]];
        // cell.selectionStyle=UITableViewCellSelectionStyleNone;
         return cell;
     }
     else{
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        
        cell.backgroundColor=[UIColor clearColor];
        baseView=[[UIView alloc] initWithFrame:cell.frame];
        
        baseView.backgroundColor=[UIColor clearColor];
        
        name=[[UILabel alloc] initWithFrame:CGRectMake(60, 5, 250, 23)];
        name.textColor=[UIColor blueColor];
        name.font=[UIFont systemFontOfSize:15];
        name.backgroundColor=[UIColor clearColor];
        
        comment =[[UILabel alloc] initWithFrame:CGRectMake(60, 20, 250, 45)];
        comment.numberOfLines=2;
        comment.font=[UIFont systemFontOfSize:11];
        comment.backgroundColor=[UIColor clearColor];
        
        time=[[UILabel alloc] initWithFrame:CGRectMake(5, 60, 310, 25)];
        time.font=[UIFont systemFontOfSize:10];
        time.backgroundColor=[UIColor clearColor];
        time.textColor=[UIColor grayColor];
        time.textAlignment=UITextAlignmentRight;
        
        ansicon=[[UIImageView alloc] initWithFrame:CGRectMake(60, 60, 15, 13)];
        [ansicon setImage:[UIImage imageNamed:@"wall_com_icon.png"]];
        
        
        anscount =[[UILabel alloc] initWithFrame:CGRectMake(80,58, 25, 15)];
        anscount.numberOfLines=1;
        anscount.font=[UIFont systemFontOfSize:11];
        anscount.backgroundColor=[UIColor clearColor];

    
        line =[[UIImageView alloc] initWithFrame:CGRectMake(0,90, 320, 2)];
        [line setImage:[UIImage imageNamed:@"seprater"]];
        
        icon =[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 48, 48)];
        
        icon.layer.cornerRadius=10.0;
        icon.clipsToBounds=YES;
        
       // [baseView addSubview:line];
        [baseView addSubview:anscount];
        [baseView addSubview:ansicon];
        [baseView addSubview:icon];
        [baseView addSubview:name];
        [baseView addSubview:comment];
        [baseView addSubview:time];
        [cell     addSubview:baseView];
    }
    //
    //cell.backgroundColor=[UIColor redColor];
    //    CALayer *layer = cell.layer;
    //    layer.borderColor = [[UIColor blackColor] CGColor];
    //    layer.borderWidth = 1.0f;
    //    //layer.cornerRadius = 20.0f;
    //    cell.layer.cornerRadius=10;
    //    cell.layer.shadowRadius=10.0f;
    //
    
    if(tableView==tableviewreview){
        if(type==review)
        {
            if(reviewurlarray.count>0 && indexPath.row !=0 && indexPath.row < reviewurlarray.count+1)
            {
                cell.textLabel.text = [[reviewurlarray valueForKey:@"name"]objectAtIndex:indexPath.row-1];
                cell.textColor=[UIColor blueColor];
                cell.font=[UIFont systemFontOfSize:16];
                
                UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 27, 320, 2)];
                [lineimage setImage:[UIImage imageNamed:@"table_line.png"]];
                
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
               
                //NSLog(@"Array : %d",reviewurlarray.count);
                
                
                //NSLog(@" row : %d",indexPath.row);
                
                if(reviewurlarray.count!=indexPath.row)
                {
                    [cell addSubview:lineimage];
                }
            }
    
            anscount.hidden=YES;
            ansicon.hidden=YES;
        }
        if(indexPath.row!=0)
        {
            //NSLog(@"%d",indexPath.row);
            if(indexPath.row>reviewurlarray.count)
            {
                if(indexPath.row-reviewurlarray.count-1<[[appDic  valueForKey:@"get_app_comment"] count])
                {
               
                    if(indexPath.row==reviewurlarray.count+1){
                        UILabel  *commentlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 2, 330, 35)];
                        commentlabel.text=@"  User Comments";
                        commentlabel.font=[UIFont systemFontOfSize:15];
                        commentlabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
                        commentlabel.textColor=[UIColor whiteColor];
                        [baseView addSubview:commentlabel];
                    }
                    name=[[UILabel alloc] initWithFrame:CGRectMake(60, 40, 250, 23)];
                    name.textColor=[UIColor blueColor];
                    name.font=[UIFont systemFontOfSize:15];
                    name.backgroundColor=[UIColor clearColor];
                
                    comment =[[UILabel alloc] initWithFrame:CGRectMake(60, 55, 250, 45)];
                    comment.numberOfLines=2;
                    comment.font=[UIFont systemFontOfSize:11];
                    comment.backgroundColor=[UIColor clearColor];
                
                    time=[[UILabel alloc] initWithFrame:CGRectMake(5, 95, 310, 25)];
                    time.font=[UIFont systemFontOfSize:10];
                    time.backgroundColor=[UIColor clearColor];
                    time.textColor=[UIColor grayColor];
                    time.textAlignment=UITextAlignmentRight;
                
                    icon =[[UIImageView alloc] initWithFrame:CGRectMake(5, 40, 48, 48)];
                
                    icon.layer.cornerRadius=10.0;
                    icon.clipsToBounds=YES;
   
                    [baseView addSubview:name];
                    [baseView addSubview:comment];
                    [baseView addSubview:time];
                    [baseView addSubview:icon];
                
                    NSDictionary *tableDict=[[appDic valueForKey:@"get_app_comment"] objectAtIndex:indexPath.row-reviewurlarray.count-1];
                ////NSLog(@"Table dict : %@",tableDict);
                    name.text=[NSString stringWithFormat:@"%@",[tableDict valueForKey:@"firstname"]];
                    name.tag=[[tableDict valueForKey:@"user_id"] integerValue];
                    comment.text=[tableDict valueForKey:@"comment"];
                    time.text=[tableDict valueForKey:@"added_time"];
                    [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tableDict valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
                    anscount.hidden=YES;
                    ansicon.hidden=YES;
                }
                else{
                    
                    UIButton *addcomment=[UIButton buttonWithType:UIButtonTypeCustom];
                    addcomment.frame=CGRectMake(10, 20, 120, 40);
                   // [addcomment setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"]  forState:UIControlStateNormal];
                    
                    addcomment.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
                    
                    addcomment.layer.cornerRadius=5.0f;
                    
                    addcomment.tag=4;
                    [addcomment setTitle:@"Add Comment" forState:UIControlStateNormal];
                    addcomment.titleLabel.font=[UIFont systemFontOfSize:13];
                    [addcomment addTarget:self action:@selector(commentsView:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIButton *viewAll=[UIButton buttonWithType:UIButtonTypeCustom];
                    viewAll.frame=CGRectMake(160, 20, 150, 40);
                    //[viewAll setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forState:UIControlStateNormal];
                    viewAll.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
                    
                     viewAll.layer.cornerRadius=5.0f;
                  
                    viewAll.tag=1;
                    viewAll.titleLabel.font=[UIFont systemFontOfSize:13];
                    [viewAll setTitle:@"View All Comments" forState:UIControlStateNormal];
                    [viewAll addTarget:self action:@selector(commentsView:) forControlEvents:UIControlEventTouchUpInside];
                    ansicon.hidden=YES;
                    anscount.hidden=YES;
                    
                    [baseView addSubview:addcomment];
                    [baseView addSubview:viewAll];
                }

            }
        }else
        {
            UIButton *viewAll=[UIButton buttonWithType:UIButtonTypeCustom];
            viewAll.frame=CGRectMake(170, 10, 130, 30);
            //[viewAll setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"]forState:UIControlStateNormal];
            
            viewAll.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
             viewAll.layer.cornerRadius=5.0f;
            viewAll.tag=2;
            viewAll.titleLabel.font=[UIFont systemFontOfSize:13];
            [viewAll setTitle:@"Rate This app" forState:UIControlStateNormal];
            [viewAll addTarget:self action:@selector(RateThisApp:) forControlEvents:UIControlEventTouchUpInside];
            ansicon.hidden=YES;
            anscount.hidden=YES;
            
            //UIView *view=[[UIView alloc]initWithFrame:CGRectMake(20, 10, 100, 30)];
           // view.backgroundColor=[UIColor redColor];
            //[view addSubview:rateView];
            
          UILabel *reviewlabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 2, 320, 35)];
            reviewlabel.numberOfLines=1;
            reviewlabel.text=@"  Editor's Reviews";
            reviewlabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
            reviewlabel.textColor=[UIColor blueColor];
            reviewlabel.font=[UIFont systemFontOfSize:15];
            
            UILabel *rating =[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 110, 20)];
            rating.numberOfLines=1;
            rating.textAlignment=UITextAlignmentCenter;
           
            //NSLog(@"%@",[appDic  valueForKey:@"userRatingCount"]);
            
            
            NSString *str =[NSString stringWithFormat:@"%d",[[appDic  valueForKey:@"userRatingCount"]intValue ]];
                        
            rating.text=[str stringByAppendingFormat:@" Rating"];
            
            rating.font=[UIFont systemFontOfSize:13];
            
            
            UIImageView *star1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
            UIImageView *star2=[[UIImageView alloc]initWithFrame:CGRectMake(32, 10, 20, 20)];
            UIImageView *star3=[[UIImageView alloc]initWithFrame:CGRectMake(54, 10, 20, 20)];
            UIImageView *star4=[[UIImageView alloc]initWithFrame:CGRectMake(76, 10, 20, 20)];
            UIImageView *star5=[[UIImageView alloc]initWithFrame:CGRectMake(98, 10, 20, 20)];
            [star1 setImage:[UIImage imageNamed:@"StarEmpty@2x.png"]];
            [star2 setImage:[UIImage imageNamed:@"StarEmpty@2x.png"]];
            [star3 setImage:[UIImage imageNamed:@"StarEmpty@2x.png"]];
            [star4 setImage:[UIImage imageNamed:@"StarEmpty@2x.png"]];
            [star5 setImage:[UIImage imageNamed:@"StarEmpty@2x.png"]];
            
            /*DYRateView *rateViewbar;
            rateViewbar=[[DYRateView alloc] initWithFrame:CGRectMake(10, 10, 116, 21)];
            rateViewbar.size=RateViewBig;
            [rateViewbar sizeToFit];
            rateViewbar.editable=NO;
            [rateViewbar setBackgroundColor:[UIColor clearColor]];*/
            int r=[[appDic valueForKey:@"averageUserRating"] intValue];
            if(r==1)
            {
                [star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                
            }else if(r==2)
            {
                [star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star2 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                
                
                
            }else if(r==3)
            {
                [star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star2 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star3 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                
                
                
            }else if(r==4)
            {
                [star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star2 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star3 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star4 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                
            }else if(r==5)
            {
                [star1 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star2 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star3 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star4 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                [star5 setImage:[UIImage imageNamed:@"StarFull@2x.png"]];
                
                
            }

                       
           
            
            //[baseView addSubview:reviewlabel];
            [baseView addSubview:star1];
            [baseView addSubview:star2];
            [baseView addSubview:star3];
            [baseView addSubview:star4];
            [baseView addSubview:star5];

            [baseView addSubview:rating];
            [baseView addSubview:viewAll];
            
            
            
            if(reviewurlarray.count>0)
            {
               UILabel *revimg =[[UILabel alloc] initWithFrame:CGRectMake(0,50, 320, 35)];
               revimg.text=@"  Editor's Reviews";
               revimg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
                revimg.font=[UIFont systemFontOfSize:14];
                revimg.textColor=[UIColor whiteColor];

                [baseView addSubview:revimg];
            }
            
        }
    }
    
    else if(tableView==tableviewquestion)
    {
        if(indexPath.row<[[appDic  valueForKey:@"get_app_questions"] count]){
        NSDictionary *tableDict=[[appDic valueForKey:@"get_app_questions"] objectAtIndex:indexPath.row];
        ////NSLog(@"Table dict : %@",tableDict);
        name.text=[NSString stringWithFormat:@"%@",[tableDict valueForKey:@"firstname"]];
        name.tag=[[tableDict valueForKey:@"user_id"] integerValue];
        comment.text=[tableDict valueForKey:@"question"];
        time.text=[tableDict valueForKey:@"added_date"];
            
        //NSLog(@"answer_count : %@",[tableDict valueForKey:@"answer_count"]);
        anscount.text=[NSString stringWithFormat:@"%@",[tableDict valueForKey:@"answer_count"]];
        
        [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tableDict valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        
        else{
            
            UIButton *adddiscussion=[UIButton buttonWithType:UIButtonTypeCustom];
            adddiscussion.frame=CGRectMake(10, 10, 120, 40);
           // [adddiscussion setBackgroundImage:[[UIImage imageNamed:@"navigation_bg.png"] stretchableImageWithLeftCapWidth:13.0 topCapHeight:0.0] forState:UIControlStateNormal];
            
            adddiscussion.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
            
             adddiscussion.layer.cornerRadius=5.0f;
            adddiscussion.tag=3;
            [adddiscussion setTitle:@"Add Discussion" forState:UIControlStateNormal];
            adddiscussion.font=[UIFont systemFontOfSize:13];
            [adddiscussion addTarget:self action:@selector(commentsView:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton *viewAll=[UIButton buttonWithType:UIButtonTypeCustom];
            viewAll.frame=CGRectMake(160, 10, 150, 40);
           // [viewAll setBackgroundImage:[[UIImage imageNamed:@"navigation_bg.png"] stretchableImageWithLeftCapWidth:13.0 topCapHeight:0.0] forState:UIControlStateNormal];
            viewAll.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
            
            [[viewAll layer]setCornerRadius:5.0f];
          //  viewAll.layer.cornerRadius=5.0f;
            
            viewAll.tag=2;
            [viewAll setTitle:@"View All Questions" forState:UIControlStateNormal];
             viewAll.font=[UIFont systemFontOfSize:13];
            [viewAll addTarget:self action:@selector(commentsView:) forControlEvents:UIControlEventTouchUpInside];
            ansicon.hidden=YES;
            anscount.hidden=YES;
            
             [baseView addSubview:adddiscussion];
            [baseView addSubview:viewAll];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
     }
    return cell;
    
}




-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView==likedFriends)
    {
        return 50;
    }
    else if(tableView==tableviewreview)
        {
            
            
            if(indexPath.row==0)
            {
                if(reviewurlarray.count>0)
                {
                    return 85;
                }else
                {
                return 60;
                }
            }
            else if(reviewurlarray.count>0 && indexPath.row !=0 && indexPath.row < reviewurlarray.count+1)
            {
                return 30;
            }else
            {
                return 95;
            }
        }
    else
    {
        return 85;
    }

}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }

    
    if(tableView==likedFriends)
    {
        NSArray *friendsArray=[NSArray arrayWithArray:[appDic valueForKey:@"friends_app_like"]];
        
        [self userView:[[friendsArray objectAtIndex:indexPath.row] valueForKey:@"user_id"]];
    }else if(tableView==tableviewquestion)
    {
        NSDictionary *tableDict=[[appDic valueForKey:@"get_app_questions"] objectAtIndex:indexPath.row];
        
        AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
        
        question.questionId=[NSString stringWithFormat:@"%@",[tableDict valueForKey:@"question_id"]];
        
        question.info=[[NSMutableDictionary alloc] initWithDictionary:tableDict];
                      
        question.follow=false;
        
        [self.navigationController pushViewController:question animated:YES];
    }
    else if(tableView==tableviewreview)
    {
        if(reviewurlarray.count>0 && indexPath.row !=0 && indexPath.row < reviewurlarray.count+1)
        {
           // NSLog(@"%@",reviewurlarray);
            AUVReviewViewController *reviewpage=[[AUVReviewViewController alloc]initWithNibName:@"AUVReviewViewController" bundle:nil];
            
            reviewpage.reviewid=[[reviewurlarray valueForKey:@"id"]objectAtIndex:indexPath.row-1];

            reviewpage.name=[[reviewurlarray valueForKey:@"name"]objectAtIndex:indexPath.row-1];

            [self.navigationController pushViewController:reviewpage animated:YES];
        }
        
    }
}


-(IBAction)disLikeButtonEvent:(id)sender
{
   
//        if(![AUVLogin isAccessAllowed])
//        {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

            [self loginAndRegister];
            [self GoaToSignInPage];
            return;
        }
        AUVwebservice *service=[AUVwebservice service];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        service.logging=NO;
        NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
   
        [service appdislike:self action:@selector(defavoriteHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:appId];
        
        
    

}


-(IBAction)followAction:(id)sender
{
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        
        return;
    }

    
    AUVwebservice *service=[AUVwebservice service];
    
    [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];

    if(!followed)
    [service follow_app:self action:@selector(followActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:appId];
    else if(followed)
    {
        [service unfollow_app:self action:@selector(followActionHandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:appId];
    }
    
    
}


-(void)followActionHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{

   // AUVArray *arr=(AUVArray *)value;
    
   // NSString *result=[NSString stringWithFormat:@"%@",arr];
    
    
    //NSLog(@"%@",result);
    [SVProgressHUD dismiss];
    [self detailAction];
    }
}


- (void)setupHorizontalScrollView
{
    CGAffineTransform rotateTable = CGAffineTransformMakeRotation(-M_PI_2);
    likedFriends.transform = rotateTable;
    likedFriends.frame = CGRectMake(0, 167,likedFriends.frame.size.width,likedFriends.frame.size.height);
    
    [scrollView addSubview:likedFriends];
   // tableViewCell.contentArray = [arrays objectAtIndex:indexPath.section];
    //tableViewCell.horizontalTableView.allowsSelection = NO;

}

-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
  
    [super viewDidDisappear:animated];
}

-(IBAction)followersList:(id)sender
{
   /* AUVwebservice *service=[AUVwebservice service];
    
    [service app_followers_list:self action:@selector(followersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] app_id:appId];*/
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        
        return;
    }

    AUVFollowersList *panel=[[AUVFollowersList alloc] initWithFrame:self.view.bounds];
    panel.delegate=self;
    panel.type=AUVAppFollowers;
    panel.appId=appId;
    [self.view addSubview:panel];
    [panel showFromPoint:[self.view center]];
}
-(void) loginAndRegister
{
    //NSLog(@"Login Required");
}

-(IBAction)RateThisApp:(id)sender
{
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }

    
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Rate this app" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Rate",nil  ];
    
    /*rateView=[[DYRateView alloc] initWithFrame:rateIt.frame fullStar:[UIImage imageNamed:@"star_full"] emptyStar:[UIImage imageNamed:@"star_empty"]];
    
    rateView.rate=0.0f;
    rateView.editable=YES;
    rateView.delegate=self;
    rateView.size=RateViewBig;
    
    //[rateContainer setBackgroundColor:[UIColor clearColor]];
    //[rateContainer addSubview:rateView];

    [alertview addSubview:rateView];*/
    
   RSTapRateView *_tapRateView = [[RSTapRateView alloc] initWithFrame:CGRectMake(25, 65, 185, 30.f)];
    _tapRateView.delegate = self;
    _tapRateView.backgroundColor =[UIColor clearColor];
    [alertview addSubview:_tapRateView];
    
    [alertview show];
    
    //NSLog(@"Rate this app : %d",[sender tag]);
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        if([alertView tag]==10)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        if([alertView tag]==100)
        {
            //[self.navigationController popToRootViewControllerAnimated:YES];
            ASSignViewController *signInView =[[ASSignViewController alloc]initWithNibName:@"ASSignViewController" bundle:nil];
            signInView.delegate = self;
            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:signInView];
            
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
        
    }
    if(buttonIndex==1)
    {
        if([alertView tag]==100)
        {
            return;
        }else
        {
            [self rateTheApplication];
        }
    }
}

#pragma mark -
#pragma mark RSTapRateViewDelegate

- (void)tapDidRateView:(RSTapRateView*)view rating:(NSInteger)rating {
    //NSLog(@"Current rating: %i", rating);
    ratecount=rating;

}

-(IBAction)Description:(id)sender
{
    
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }
  
    
    AUVDescriptionViewController *desview=[[AUVDescriptionViewController alloc] initWithNibName:@"AUVDescriptionViewController" bundle:nil];
   // desview.detailController=self;
    //desview.developerId=developerId;
   // desview.developer=developer.text;
    desview.title=@"Description";
    [self.navigationController pushViewController:desview animated:YES];
    //NSLog(@"Description");
    
}

-(IBAction)ScreenShot:(id)sender
{
    
//    if(![AUVLogin isAccessAllowed])
//    {
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if (![defaultstd objectForKey:@"user_id"]) {

        [self loginAndRegister];
         [self GoaToSignInPage];
        return;
    }
    
    
    AUVScreenShotsViewController *screenshot=[[AUVScreenShotsViewController alloc] initWithNibName:@"AUVScreenShotsViewController" bundle:nil];
    // desview.detailController=self;
    //desview.developerId=developerId;
    // desview.developer=developer.text;
    screenshot.title=@"Screen Shot";
    [self.navigationController pushViewController:screenshot animated:YES];
    //NSLog(@"Screen Shot");
    
}
#pragma mark UAModalPanel

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
    
    if(Pagepositon!=3 && Pagepositon!=4)
    {
        if([modalPanel isKindOfClass:[AUVSuggestAppController class]])
            return;
        if( [[(AUVFollowersList*)modalPanel selectedUserId] integerValue]!=0)
        {
               AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
            profile.userId=[(AUVFollowersList*)modalPanel selectedUserId];
      
            [self.navigationController pushViewController:profile animated:YES];
        }
    }
   
}

//Facebook

-(void)sharebtn{
    //    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    //   NSString *strj= [defaultstd objectForKey:AUVFBACCESSTOKENKEY];
    //    //NSLog(@"string val %@",strj);
    /* NSString *str = https://graph.facebook.com/me/feed?access_token=AAAAAAITEghMBAIZBrGS5jmunXOoSZCR4P0tr0sSqIuZBp6P7x7V3xXnpP0lpFmCXMkTPvyWjHij3H45Q8Yc8WwA5TM5k2MAh7ers9CmLksGqPZCmF56u */
    
    
    NSArray *logoArray=[(NSString*)[appDic  valueForKey:@"artworkUrl60"] componentsSeparatedByString:@"appfindy"];
    
   // //NSLog(@"%@",appDic);
    NSString *appID=(NSString*)[appDic valueForKey:@"trackId"];
    
//    NSString *strapplogo;
//    if(logoArray.count==1)
//    {
//        NSString *strapplogo=  [NSString stringWithFormat:@"%@",[logoArray objectAtIndex:0]];
//        
//        strapplogo = [strapplogo stringByReplacingOccurrencesOfString:@"vol/iphone_final/./"
//                                                           withString:@""];
//        
//        
////        [appIcon setImageWithURL:[NSURL URLWithString:strapplogo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    }
//    
////    NSArray *logoArray=[(NSString*)[appDic  valueForKey:@"appLogo"] componentsSeparatedByString:@"appfindy"];
//    
//  //  NSString *strapplogo=  [NSString stringWithFormat:@"http://appfindy.com/images%@",[logoArray objectAtIndex:0]];
//    
//    //strapplogo = [strapplogo stringByReplacingOccurrencesOfString:@"vol/iphone_final/./"
//                                 //                      withString:@""];
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   appName.text, @"name",
                                   
                                   [NSString stringWithFormat:@"http://appfindee.com/en/index.php/search/app/index/%@",appID], @"link", [logoArray objectAtIndex:0], @"picture",
                                   nil];
    
    // Invoke the dialog
    [fb dialog:@"feed" andParams:params andDelegate:self];
   // //NSLog(@"params %@",params);
    
    
}
-(void)loadFB
{
    fb=  [AUV_DELEGATE facebook];
    [SVProgressHUD dismiss];
    if(!fb.isSessionValid)
    {
        fb=[[Facebook alloc] initWithAppId:AUVFB_APPID andDelegate:self];
        [fb authorize:[AUV_DELEGATE fbPermission]];
        
        [AUV_DELEGATE setFacebook:fb];
    }
    else
     [self sharebtn];
    
    
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[fb accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[fb expirationDate] forKey:@"FBExpirationDateKey"];
    
    [defaults synchronize];
    
    [self sharebtn];
    
}

#pragma FBRequestDelegate Methods


- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"res");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    //NSLog(@"Err : %@",[error localizedDescription]);
    [SVProgressHUD dismiss];
    
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    //NSLog(@"response : %@",result);
    
    
    NSPredicate *predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
        
        
        return  [[(NSDictionary*)obj  valueForKey:@"is_app_user"] intValue]==1 ;
    }];
    
    NSPredicate *predicate2=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
        
        
        return  [[(NSDictionary*)obj  valueForKey:@"is_app_user"] intValue]==0 ;
    }];
    
    
    
   // NSArray *usersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate];
   // NSArray *nonusersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate2];
    
    
    //    if([usersofApp isKindOfClass:[NSArray class]]){
    //        [auvFriends addObjectsFromArray:usersofApp];
    //    }
    //    else [auvFriends addObject:usersofApp];
    //    if([nonusersofApp isKindOfClass:[NSArray class]])
    //        [fbFriends addObjectsFromArray:nonusersofApp];
    //    else [fbFriends addObject:nonusersofApp];
    
    ////NSLog(@"Users Of App  :  %@",usersofApp);
    // NSMutableArray *array=[NSMutableArray arrayWithArray:result];
   /* [dataArray removeAllObjects];
    [tableArray removeAllObjects];
    if(self.type==AUVInviteFBFriends) {
        for(NSDictionary *dict in nonusersofApp)
        {
            NSDictionary *dt=[NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"name"],@"username",[dict valueForKey:@"pic_small"],@"usericon",[dict valueForKey:@"uid"],@"uid",nil];
            
            [dataArray addObject:dt];
            
            
            
            
        }
        //[dataArray addObjectsFromArray:fbFriends];
        [tableArray addObjectsFromArray:dataArray];
        [SVProgressHUD dismiss];
        [friendsTable reloadData];
        
    }
    else{
        for(NSDictionary *dict in usersofApp)
        {
            // NSDictionary *dt=[NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"name"],@"username",[dict valueForKey:@"pic_small"],@"usericon",[dict valueForKey:@"uid"],@"uid",nil];
            
            [auvFriends addObject:[dict valueForKey:@"uid"]];
            
            
            
        }
        
        [self fbLoadAUVContacts];
        
    }*/
    
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data
{
    
}

-(void)GoaToSignInPage
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please login" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    alert.tag=100;
    [alert show];
    
}


@end
