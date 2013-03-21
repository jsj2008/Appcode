//
//  AUVAPPSnatchView.m
//  AppUniv
//
//  Created by Innoppl Technologies on 27/02/13.
//
//

#import "AUVAPPSnatchView.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "SVProgressHUD.h"


@implementation AUVAPPSnatchView
@synthesize butTagValuefun;
@synthesize delegate;
UIButton *sharebtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"value of tag %d",butTagValuefun);
        [self.layer setCornerRadius:10.0f];
        [self.layer setBorderColor:[[UIColor blackColor] CGColor]];
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame =CGRectMake(10, 20, 100, 40);
        [button setTitle:@"Snatch" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(snatchbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UIButton *closeWebViewButton=[UIButton buttonWithType:UIButtonTypeCustom];
        closeWebViewButton.frame=CGRectMake(-5,-7,28, 28);
        [closeWebViewButton setImage:[UIImage imageNamed:@"close@2x.png"] forState:UIControlStateNormal];
        [closeWebViewButton addTarget:self action:@selector(WebviewCloseFunction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeWebViewButton];
        
        sharebtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        sharebtn.frame =CGRectMake(100, 80, 100, 40);
        [sharebtn setTitle:@"Share" forState:UIControlStateNormal];
        [sharebtn setTag:50];
        sharebtn.enabled = NO;
        [sharebtn addTarget:self action:@selector(shareFun:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sharebtn];


    }
    return self;
}
-(IBAction)snatchbtn:(id)sender{
    NSLog(@"snatch it %d",butTagValuefun);
    NSString *str =[NSString  stringWithFormat:@"%d",butTagValuefun];
    NSUserDefaults *defaultstd =[NSUserDefaults standardUserDefaults];
    [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=YES;
    
    [service snatchView:self action:@selector(snatchBtnWebServices:) id:str user_id:[defaultstd objectForKey:@"user_id"]];

}

-(void)snatchBtnWebServices:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
        NSLog(@"Sorry, the request was unsuccessful");
	}
    
    
    else{
        
        // Do something with the Array* result
        SoapArray* arr = (SoapArray*)value;
        NSLog(@"arr %@",arr);
          [SVProgressHUD dismiss];
        NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        NSDictionary *dict=[result JSONValue];
        NSLog(@"%@",dict);
        if ([[dict objectForKey:@"snatch"] isEqualToString:@"true"] ) {
            
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Snatch Alert" message:@"Now share the URL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            NSLog(@"first snatch");
        }else{
            NSLog(@"already snatched");
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Snatch Alert" message:[dict objectForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

     sharebtn.enabled = YES;
    }
}
-(void)shareFun:(UIButton*)sender{
    [[self delegate] ShareBtnValue:sender];
}
-(void)WebviewCloseFunction{
    [self removeFromSuperview];
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
