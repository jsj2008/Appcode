//
//  AUVScrollTabBar.m
//  AppUniv
//
//  Created by Innoppl Technologies on 21/02/13.
//
//

#import "AUVScrollTabBar.h"
#import "AUVConstants.h"

@implementation AUVScrollTabBar
@synthesize  button1,button2,button3,button4,button5,label1,label2,label3,label4,label5;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    
//    if (IS_IPHONE_5)
//        self = [super initWithFrame:CGRectMake(0, 464, 320, 44)];
//    else
//        self = [super initWithFrame:CGRectMake(0, 419, 320, 44)];
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bg.png"]];
        
        [self setContentSize:CGSizeMake(440, 104)];
       
        
        button1 =[UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame =CGRectMake(10, 7, 40, 40);
        [button1 setImage:[UIImage imageNamed:@"tab_home.png"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag =1;
        [self addSubview:button1];
        
//        label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, 51, 10)];
//        label1.text=@"Home";
//        label1.backgroundColor=[UIColor clearColor];
//        label1.textColor=[UIColor whiteColor];
//        label1.font=[UIFont systemFontOfSize:11];
//        [self addSubview:label1];
        
        button2 =[UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame =CGRectMake(70, 7, 40, 40);
        [button2 setImage:[UIImage imageNamed:@"tab_search.png"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag = 2;
        [self addSubview:button2];
        
//        label2=[[UILabel alloc]initWithFrame:CGRectMake(100, 30, 70, 10)];
//        label2.text=@"Search";
//        label2.backgroundColor=[UIColor clearColor];
//        label2.textColor=[UIColor whiteColor];
//        label2.font=[UIFont systemFontOfSize:11];
//        [self addSubview:label2];
        
        button3 =[UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame =CGRectMake(130, 7, 40, 40);
        [button3 setImage:[UIImage imageNamed:@"tab_deals.png"] forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button3.tag=3;
        [self addSubview:button3];
        
//        
//        label3=[[UILabel alloc]initWithFrame:CGRectMake(180, 30, 67, 10)];
//        label3.text=@"Deals";
//        label3.backgroundColor=[UIColor clearColor];
//        label3.textColor=[UIColor whiteColor];
//        label3.font=[UIFont systemFontOfSize:11];
//        [self addSubview:label3];
        
        button4 =[UIButton buttonWithType:UIButtonTypeCustom];
        button4.frame =CGRectMake(190,7, 40, 40);
        [button4 setImage:[UIImage imageNamed:@"tab_feat.png"] forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button4.tag = 4;
        [self addSubview:button4];
        
//        label4=[[UILabel alloc]initWithFrame:CGRectMake(260, 30, 50, 10)];
//        label4.text=@"Featured";
//        label4.backgroundColor=[UIColor clearColor];
//        label4.textColor=[UIColor whiteColor];
//        label4.font=[UIFont systemFontOfSize:11];
//        [self addSubview:label4];
        
        button5 =[UIButton buttonWithType:UIButtonTypeCustom];
        button5.frame =CGRectMake(250,7, 40, 40);
        [button5 setImage:[UIImage imageNamed:@"tab_feat.png"] forState:UIControlStateNormal];
        [button5 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        button5.tag = 5;
        [self addSubview:button5];


        
    }
    return self;
}

-(void)btnTap:(UIButton*)sender
{
    
    [[self delegate] btnTap:sender];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
