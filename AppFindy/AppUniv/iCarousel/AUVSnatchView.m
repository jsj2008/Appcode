//
//  AUVSnatchView.m
//  AppUniv
//
//  Created by Innoppl Technologies on 24/02/13.
//
//

#import "AUVSnatchView.h"
#import <QuartzCore/QuartzCore.h>


@implementation AUVSnatchView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.layer setCornerRadius:10.0f];
       //[self.layer setBorderWidth:1.0f];
        
        // Initialization code
        UIButton *closeWebViewButton=[UIButton buttonWithType:UIButtonTypeCustom];
        closeWebViewButton.frame=CGRectMake(-5,-7,28, 28);
        [closeWebViewButton setImage:[UIImage imageNamed:@"close@2x.png"] forState:UIControlStateNormal];
        [closeWebViewButton addTarget:self action:@selector(WebviewCloseFunction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeWebViewButton];

        // Initialization code
        [self addSubview:[self customlabel:@"App snatch" initframe:CGRectMake(70, 10, 150, 40) totallines:1]];
        
        [self addSubview:[self customlabel:@"Please Snatch the App" initframe:CGRectMake(20, 50, 250, 40) totallines:3]];
        
        signInBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        signInBtn.frame = CGRectMake(30, 110, 80, 30);
        signInBtn.tag = 100;
        [signInBtn setTitle:@"App Snatch" forState:UIControlStateNormal];
        [signInBtn addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:signInBtn];
        
        newUserBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        newUserBtn.frame = CGRectMake(150, 110, 100, 30);
        newUserBtn.tag = 101;
        [newUserBtn setTitle:@"Sign In" forState:UIControlStateNormal];
        [newUserBtn addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:newUserBtn];

    }
    return self;
}
-(void)WebviewCloseFunction{
    [self removeFromSuperview];
}


-(IBAction)buttonClickHandler:(id)sender
{
    NSLog(@"sender id %@",sender);
     [self removeFromSuperview];
    [[self delegate]btnView:sender];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
/**************Custom Label ****************/
-(UILabel*)customlabel:(NSString*)str initframe:(CGRect)frame totallines:(int)lines
{
    UILabel *customlabel =[[UILabel alloc]initWithFrame:frame];
    customlabel.text=str;
    customlabel.numberOfLines=lines;
    customlabel.backgroundColor=[UIColor clearColor];
    customlabel.font=[UIFont fontWithName:@"Arial" size:20.0f];
    customlabel.textColor=[UIColor whiteColor];
    return customlabel;
}

@end
