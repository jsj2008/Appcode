//
//  AUVCustomTabbar.m
//  AppUniv
//
//  Created by Innoppl Technologies on 09/11/12.
//
//

#import "AUVCustomTabbar.h"
#import "AUVNotificationViewController.h"
#import "AUVAppWallController.h"
#import "AUVSearchViewController.h"
#import "AUVQuestionChoiceViewController.h"

#import "AUVLogin.h"
#import "SVProgressHUD.h"

@implementation AUVCustomTabbar
@synthesize delegate;
@synthesize  button1,button2,button3,button4,button5,label1,label2,label3,label4,label5,nb;
@synthesize scrollView;

int count=0;

- (id)initWithFrame:(CGRect)frame
{
    if (IS_IPHONE_5)
        self = [super initWithFrame:CGRectMake(0, 464, 320, 40)];
    else
        self = [super initWithFrame:CGRectMake(0, 376, 320, 40)];
    if (self) {
        // Initialization code
                
        //[self setBackgroundColor:[UIColor blackColor]];
        
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar.png"]];
        
        
        button1 =[UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame =CGRectMake(3, 2, 100, 37);
        [button1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];

       // [button1 setTitle:@"Home" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag =1;
        [self addSubview:button1];
        
        label1=[[UILabel alloc]initWithFrame:CGRectMake(30, 30, 51, 10)];
        label1.text=@"Home";
        label1.backgroundColor=[UIColor clearColor];
        label1.textColor=[UIColor whiteColor];
        label1.font=[UIFont systemFontOfSize:11];
        [self addSubview:label1];
        
   /*     button2 =[UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame =CGRectMake(60, 2, 73, 37);
        
        if (count!=0) {
            nb=[[MKNumberBadgeView alloc] initWithFrame:CGRectMake(55, 5, 15, 18)];
            [button2 addSubview:nb];
            [nb setValue:count];
        }
        
                
        
        [button2 setImage:[UIImage imageNamed:@"notification.png"] forState:UIControlStateNormal];

        //[button2 setTitle:@"Home" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag = 2;
        [self addSubview:button2];
        
        label2=[[UILabel alloc]initWithFrame:CGRectMake(70, 30, 70, 10)];
        label2.text=@"Notification";
        label2.backgroundColor=[UIColor clearColor];
        label2.textColor=[UIColor whiteColor];
        label2.font=[UIFont systemFontOfSize:11];
        [self addSubview:label2];

        
        button3 =[UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame =CGRectMake(132, 2, 68, 37);
        //[button3 setTitle:@"Home" forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"tap_dplus2.png"] forState:UIControlStateNormal];

        [button3 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button3.tag=3;
        [self addSubview:button3];
        
        
        label3=[[UILabel alloc]initWithFrame:CGRectMake(139, 30, 67, 10)];
        label3.text=@"Discussion";
        label3.backgroundColor=[UIColor clearColor];
        label3.textColor=[UIColor whiteColor];
        label3.font=[UIFont systemFontOfSize:11];
        [self addSubview:label3];*/
        

        
        button4 =[UIButton buttonWithType:UIButtonTypeCustom];
        button4.frame =CGRectMake(105, 2, 100, 37);
        [button4 setImage:[UIImage imageNamed:@"tap_search.png"] forState:UIControlStateNormal];

        //[button4 setTitle:@"Home" forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button4.tag = 4;
        [self addSubview:button4];
        
        label4=[[UILabel alloc]initWithFrame:CGRectMake(140, 30, 50, 10)];
        label4.text=@"Search";
        label4.backgroundColor=[UIColor clearColor];
        label4.textColor=[UIColor whiteColor];
        label4.font=[UIFont systemFontOfSize:11];
        [self addSubview:label4];
        
        button5 =[UIButton buttonWithType:UIButtonTypeCustom];
        button5.frame =CGRectMake(210, 2, 100, 37);
        [button5 setImage:[UIImage imageNamed:@"deals.png"] forState:UIControlStateNormal];

        //[button5 setTitle:@"Home" forState:UIControlStateNormal];
        [button5 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button5.tag= 5;
        
        
        [self addSubview:button5];
        
        label5=[[UILabel alloc]initWithFrame:CGRectMake(240, 30, 50, 10)];
        label5.text=@"Deals";
        label5.backgroundColor=[UIColor clearColor];
        label5.textColor=[UIColor whiteColor];
        label5.font=[UIFont systemFontOfSize:12];
        [self addSubview:label5];
        
       
        
        
        
    }
    return self;
}

-(void)btnTap:(UIButton*)sender
{
   
    [[self delegate] btnTap:sender];
}
-(void)updateNotifications:(id)sender
{

    AUVwebservice *service=[AUVwebservice service];
    
    [service notification_count:self action:@selector(notificationCountHandler:) user_id:[AUVLogin valueforKey:@"user_id"]];

}

-(void)notificationCountHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    

    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
        [SVProgressHUD dismiss];

    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];

    
    [nb setValue:[[[result JSONValue]valueForKey:@"count"]intValue]];
    count=[[[result JSONValue]valueForKey:@"count"]intValue];
    
    
    }
}


@end
