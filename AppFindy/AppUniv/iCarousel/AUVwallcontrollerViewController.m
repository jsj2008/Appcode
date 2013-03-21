//
//  AUVwallcontrollerViewController.m
//  AppUniv
//
//  Created by sathish kumar on 2/21/13.
//
//

#import "AUVwallcontrollerViewController.h"
#import "AUVDealsViewController.h"
#import "AUVSnatchView.h"
#import "AUVCustomTabbar.h"
#import "AUVSearchViewController.h"
#import "ASRegisterViewController.h"
#import "ASSignViewController.h"
#import "AUVScrollTabBar.h"
#import "JSON.h"
#import "AUVwebservice.h"
#import "AUVSnatchshow.h"
#import "AUVConstants.h"
#import "UIImageView+AFNetworking.h"
#import "StrikeLabel.h"
#import "AUVRegisterPanel.h"
#import "AUVAPPSnatchView.h"
#import "AUVHelpViewController.h"

@interface AUVwallcontrollerViewController ()<UAModalPanelDelegate>{
    
    AUVSnatchView *signView;
    UILabel       *timeLabel;
    NSTimer       *theTimer;
    NSDate        *targetDate;
    NSCalendar    *cal;
    UIStepper     *stepper;
    NSDateComponents *components;
    UIScrollView   *scroll;
    AUVSnatchshow  *snatchShowView;
    AUVAppDelegate *appDel;
    UILabel      *appname;
    UILabel      *oldprice;
    UILabel     *dealprice;
    AUVAPPSnatchView *appSnatchview;
    UIProgressView *progressView;
   
}

@property (nonatomic, retain) NSMutableArray *items;
@end

@implementation AUVwallcontrollerViewController
@synthesize carousel;
@synthesize items;
NSString *str;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       
                // Custom initialization
        self.items = [NSMutableArray array];
        appDel = AUV_DELEGATE;
        [appDel startSpinner];
        [self performSelector:@selector(snatchWebservices) withObject:nil afterDelay:0.1];
    }
    

    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
      [super viewWillAppear:animated];
}
-(void)icarouse
{
    
    NSLog(@"item array count is %d",[items count]);
   
    carousel=[[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    carousel.backgroundColor =[UIColor clearColor];
    carousel.delegate=self;
    carousel.dataSource=self;
    carousel.type = iCarouselTypeCoverFlow2;
    [self.view addSubview:carousel];
    
//    str = @"24:00";
//    cal = [NSCalendar currentCalendar];
//    components = [[NSDateComponents alloc] init];
//    [self buttonPressed];
    
    
    AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 400, 320, 104)];
    [custombar.button1 setImage:[UIImage imageNamed:@"tab_home.png"] forState:UIControlStateNormal];
    custombar.delegate= self;
    [carousel addSubview:custombar];

    
    
}

- (void)viewDidLoad
{
    
   // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blue.png"]]];
    

    
    signView =[[AUVSnatchView alloc] initWithFrame:CGRectMake(25, 100, 260, 150)];
    signView.delegate = self;
    signView.backgroundColor =[UIColor blackColor];
    
    appSnatchview =[[AUVAPPSnatchView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
 //   appSnatchview.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"snatch_screen.png"]];
    UIImageView *bgImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
    bgImageView.image = [UIImage imageNamed:@"snatch_screen.png"];
    [appSnatchview addSubview:bgImageView];
    appSnatchview.delegate = self;
    
    
    //CUSTOM TABBAR
//    AUVScrollTabBar *custombar  =[[AUVScrollTabBar alloc]initWithFrame:CGRectMake(0, 419, 320, 44)];
//    [custombar.button1 setImage:[UIImage imageNamed:@"home1.png"] forState:UIControlStateNormal];
//    custombar.delegate= self;
//    [self.view addSubview:custombar];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)buttonClickHandler{
    
}

-(void)buttonPressed{
    if (theTimer != nil) {
        return;
    }
   
    NSArray *timeSplit = [str componentsSeparatedByString:@":"];
    NSUInteger hours =  [[timeSplit objectAtIndex:0] intValue];
    NSUInteger minutes =  [[timeSplit objectAtIndex:1] intValue];
    NSDate *now = [NSDate date];
    NSDateComponents *dateComponents = [cal components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:now];
    [dateComponents setHour:hours];
    [dateComponents setMinute:minutes];
    
    if (!targetDate) {
        targetDate = [cal dateFromComponents:dateComponents] ;
    }
    else {
        targetDate = nil;
        targetDate = [cal dateFromComponents:dateComponents] ;
    }
    
    if ([targetDate timeIntervalSinceNow] > 0) {
        theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    }
    else {
        targetDate = nil;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot countdown because time is before now" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}


-(void)btnTap:(UIButton*)btnSendValue

{
    int buttonselect = btnSendValue.tag;
    
    if (buttonselect == 1) {
        
    }else if (buttonselect == 2){
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
      
      }else if (buttonselect == 3){
          AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
          
          [self.navigationController pushViewController:deal animated:YES];

         
      }else if (buttonselect == 4){
          
          ASSignViewController *signInView =[[ASSignViewController alloc]initWithNibName:@"ASSignViewController" bundle:nil];
          signInView.delegate = self;
          [self.navigationController pushViewController:signInView animated:YES];
                   
      }else if (buttonselect == 5){
          
          AUVHelpViewController *helpView =[[AUVHelpViewController alloc] initWithNibName:@"AUVHelpViewController" bundle:nil];
          [self.navigationController pushViewController:helpView animated:YES];
         
      }
}

-(void)snatchWebservices{
    AUVwebservice *service=[AUVwebservice service];
    
    service.logging = YES;
    
    [service homescreen:self action:@selector(loadDealsHandler:)];

}
-(void)loadDealsHandler:(id)value
{
    [appDel stopSpinner];
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		//[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
         [appDel stopSpinner];
        NSLog(@"Sorry, the request was unsuccessful");
	}
    
    
    else{
        
        // Do something with the Array* result
        SoapArray* arr = (SoapArray*)value;
        NSLog(@"arr from webservcie  %@",arr);
        NSLog(@"array count %d",[arr count]);
        
        for (NSDictionary *dict in arr)
        {
            NSLog(@"dict %@",dict);
            [items addObject:dict];
        }
         [appDel stopSpinner];
        [self performSelector:@selector(icarouse) withObject:nil afterDelay:1.5];
    }
    
}
- (void)makeMyProgressBarMoving {
    
//    float actual = [progressView progress];
//    if (actual < 1) {
//        progressView.progress = actual + ((float)recievedData/(float)xpectedTotalSize);
//        [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(makeMyProgressBarMoving) userInfo:nil repeats:NO];
//    }
//    else{
//        
//        
//        
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)] ;
        ((UIImageView *)view).image = [UIImage imageNamed:@"deals_bg.png"];
        view.contentMode = UIViewContentModeScaleAspectFit;
        
        label = [[UILabel alloc] initWithFrame:view.bounds] ;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
        
        
        [view addSubview:[self customlabel:@"save" initframe:CGRectMake(10, 240, 150, 30) totallines:1]];
        [view addSubview:[self customlabel:@"Time left" initframe:CGRectMake(120, 240, 150, 30) totallines:1]];
        [view addSubview:[self customlabel:@"share" initframe:CGRectMake(247, 240, 225, 30) totallines:1]];
        [view addSubview:[self customdefinedlabel:@"What is snatch?" initframe:CGRectMake(190, 200, 225, 30) totallines:1]];
        [view addSubview:[self customdefinedlabel:@"Original price" initframe:CGRectMake(45, 125, 225, 30) totallines:1]];
        [view addSubview:[self customdefinedlabel:@"0" initframe:CGRectMake(30, 185, 50, 20) totallines:1]];
        [view addSubview:[self customdefinedlabel:[[items objectAtIndex:index] valueForKey:@"total_snatch"] initframe:CGRectMake(170, 185, 50, 20) totallines:1]];
        
        UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame=CGRectMake(260,265 , 25, 25);
        [shareBtn setImage:[UIImage imageNamed:@"share_btn.png"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:shareBtn];
        
        
        
        UITextView *description = [[UITextView alloc]initWithFrame:CGRectMake(100, 40, 180, 100)];
        description.text = [[items objectAtIndex:index] valueForKey:@"description"];
        description.backgroundColor =[UIColor clearColor];
        description.font =[UIFont fontWithName:@"Arial" size:13.0f];
        description.editable = NO;
        [view addSubview:description];
        
        UIButton *buyButton=[UIButton buttonWithType:UIButtonTypeCustom];
        buyButton.frame=CGRectMake(200,160 , 90, 40);
        [buyButton setImage:[UIImage imageNamed:@"snatchit.png"] forState:UIControlStateNormal];
        [buyButton setTag:[[[items objectAtIndex:index] valueForKey:@"snatch_id"] intValue]];
        [buyButton addTarget:self action:@selector(buyFunction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:buyButton];
        
        UIImageView *imageview=[[UIImageView alloc] init];
        imageview.frame=CGRectMake(10, 40, 80, 80);
        [imageview.layer setBorderWidth:1.0f];
        [imageview.layer  setCornerRadius:10.0f];
        imageview.clipsToBounds=YES;
        [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[items objectAtIndex:index] valueForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [view addSubview:imageview];
        
        progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.frame = CGRectMake(30, 180, 150, 75);
        progressView.progress =[[[items objectAtIndex:index] valueForKey:@"current_snatch"]floatValue]/100;
        [self performSelectorOnMainThread:@selector(makeMyProgressBarMoving) withObject:nil waitUntilDone:NO];
        [view addSubview:progressView];
        
        
        UIImageView *priceimage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"price_tag.png"]];
        priceimage.frame =CGRectMake(130, 115, 160, 40);
        [view addSubview:priceimage];
        
        
        appname =[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 220, 30)];
        appname.numberOfLines=2;
        appname.font=[UIFont systemFontOfSize:16];
        appname.backgroundColor=[UIColor clearColor];
        [view addSubview:appname];
        
        oldprice =[[StrikeLabel alloc] initWithFrame:CGRectMake(140, 125, 50, 20)];
        oldprice.numberOfLines=1;
        oldprice.font=[UIFont systemFontOfSize:16];
        oldprice.textColor=[UIColor blackColor];
        oldprice.backgroundColor=[UIColor clearColor];
        [view addSubview:oldprice];
        
        dealprice=[[UILabel alloc] initWithFrame:CGRectMake(220, 125, 50, 20)];
        dealprice.font=[UIFont systemFontOfSize:16];
        dealprice.backgroundColor=[UIColor clearColor];
        dealprice.textColor=[UIColor blackColor];
        [view addSubview:dealprice];
        
        timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 263, 150, 25)];
        timeLabel.font=[UIFont systemFontOfSize:15];
        timeLabel.backgroundColor=[UIColor clearColor];
        timeLabel.textColor=[UIColor whiteColor];
        [view addSubview:timeLabel];
        
        NSString *end = [[items objectAtIndex:index] valueForKey:@"offer_end_date"];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *endDate = [f dateFromString:end];
        NSString *ssss =[self TimeRemainingUntilDate:endDate];
        timeLabel.text = ssss;
        
        UILabel *savepercent=[[UILabel alloc] initWithFrame:CGRectMake(15, 263, 150, 25)];
        savepercent.font=[UIFont systemFontOfSize:15];
        savepercent.backgroundColor=[UIColor clearColor];
        savepercent.textColor=[UIColor whiteColor];
        savepercent.text = [[items objectAtIndex:index] valueForKey:@"offer_percentage"];
        [view addSubview:savepercent];
        
        appname.text=[[items objectAtIndex:index] valueForKey:@"title"];
        oldprice.text=[[items objectAtIndex:index] valueForKey:@"price"];
        dealprice.text=[[items objectAtIndex:index] valueForKey:@"offer_price"];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    
    return view;
}



- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1f;
    }
    return value;
}

-(void)shareBtn{
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if ([defaultstd objectForKey:@"user_id"]) {
    NSString *text = @"App Snatch";
    NSString *url = @"http://appfindee.com";
    NSArray *activityItems = [NSArray arrayWithObjects:text,url , nil];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems: activityItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
    }else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Please Login" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}
/**************Custom Label ****************/
-(UILabel*)customlabel:(NSString*)str initframe:(CGRect)frame totallines:(int)lines
{
    UILabel *customlabel =[[UILabel alloc]initWithFrame:frame];
    customlabel.text=str;
    customlabel.numberOfLines=lines;
    customlabel.backgroundColor=[UIColor clearColor];
    customlabel.font=[UIFont fontWithName:@"Arial" size:14.0f];
    customlabel.textColor=[UIColor whiteColor];
    return customlabel;
}


-(UILabel*)customdefinedlabel:(NSString*)str initframe:(CGRect)frame totallines:(int)lines
{
    UILabel *customlabel =[[UILabel alloc]initWithFrame:frame];
    customlabel.text=str;
    customlabel.numberOfLines=lines;
    customlabel.backgroundColor=[UIColor clearColor];
    customlabel.font=[UIFont fontWithName:@"Arial" size:14.0f];
    customlabel.textColor=[UIColor blackColor];
    return customlabel;
}


// snatch View screen display screen button function
-(IBAction)buyFunction:(UIButton*)sender
{
    appSnatchview.butTagValuefun = [sender tag];
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    if ([defaultstd objectForKey:@"user_id"]) {
        
        [self.view addSubview:appSnatchview];
    }else{
        [self.view addSubview:signView];
    }
}



// Home page after snatch view screen delegate

-(void)btnView:(UIButton*)buttonId{
    NSLog(@"view for signin or signup %@",buttonId);
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 100) {
        NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
        if ([defaultstd objectForKey:@"user_id"]) {
            [self callSnatchwebservices];
        }else{
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Sign In" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }else if (buttonselect == 101){
        ASSignViewController *signInView =[[ASSignViewController alloc]initWithNibName:@"ASSignViewController" bundle:nil];
        signInView.delegate = self;
//        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:signInView];
        [self.navigationController pushViewController:signInView animated:YES];
      
    }
}
-(void)RatingsViewalues:(NSString*)rating{
    
    NSLog(@"rating %@",rating);
     [self performSelector:@selector(appscreen)];
     
}
-(void)appscreen{
    [self.view addSubview:appSnatchview];
}
-(void)ShareBtnValue:(UIButton*)butTagVal{
    int buttonselect = butTagVal.tag;
    
    if (buttonselect == 50) {
        [self shareBtn];
    }
}
-(void)callSnatchwebservices{
    NSLog(@"snatchView");
}

-(NSString *)TimeRemainingUntilDate:(NSDate *)date {
    
    NSTimeInterval interval = [date timeIntervalSinceNow];
    NSString * timeRemaining = nil;
    
    if (interval > 0) {
        
        div_t d = div(interval, 86400);
        int day = d.quot;
        div_t h = div(d.rem, 3600);
        int hour = h.quot;
        div_t m = div(h.rem, 60);
        int min = m.quot;
        div_t s = div(m.rem, 60);
        int sec = s.quot;
        
        NSString * nbday = nil;
        if(day > 1)
            nbday = @"Days";
        else if(day == 1)
            nbday = @"d";
        else
            nbday = @"";
        NSString * nbhour = nil;
        if(hour > 1)
            nbhour = @"H";
        else if (hour == 1)
            nbhour = @"hour";
        else
            nbhour = @"";
        NSString * nbmin = nil;
        if(min > 1)
            nbmin = @"M";
        else
            nbmin = @"min";
        
        NSString * nbsec = nil;
        if(sec > 1)
            nbsec = @"Sec";
        else
            nbsec = @"sec";
        
        timeRemaining = [NSString stringWithFormat:@"%@%@ %@%@ %@%@",day ? [NSNumber numberWithInt:day] : @"",nbday,hour ? [NSNumber numberWithInt:hour] : @"",nbhour,min ? [NSNumber numberWithInt:min] : @"00",nbmin];
    }
    else
        timeRemaining = @"Over";
    
    return timeRemaining;
}


- (void)tick {
    if ([targetDate timeIntervalSinceNow] <= 0) {
        //Checks if the countdown completed
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Countdown Completed" message:@"YAY! The countdown has complete" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    components = [cal components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date] toDate:targetDate options:0];
    
    NSInteger hours   = [components hour];
    NSInteger minutes = [components minute];
    NSInteger seconds = [components second];
    
    NSString *output = [NSString stringWithFormat:@"%iH%iM%i Seconds", hours, minutes, seconds];
    //  NSLog(@"output %@",output);
    timeLabel.text = output;
    // NSLog(@"output text %@",timeLabel.text);
}



@end
