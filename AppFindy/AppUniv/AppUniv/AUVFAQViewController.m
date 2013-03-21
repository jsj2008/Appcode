//
//  AUVFAQViewController.m
//  AppUniv
//
//  Created by Innoppl technologies on 06/12/12.
//
//

#import "AUVFAQViewController.h"
#import "DAKeyboardControl.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "UIImageView+AFNetworking.h"
#import "AUVQuestionViewController.h"
#import "AUVAnswerViewController.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "AUVDetailViewController.h"
#import "StrikeLabel.h"

@interface AUVFAQViewController ()

@end

@implementation AUVFAQViewController

@synthesize pagevalue;

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
    
    
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    if([pagevalue isEqualToString:@"faq"])
    {
     [service faq:self action:@selector(loadDataHandler:)];
    }
    else if([pagevalue isEqualToString:@"termsofservice"])
    {
        
        [service terms_of_service:self action:@selector(loadDataHandler:)];
    }
    else if([pagevalue isEqualToString:@"privacypolicy"])
    {
        [service privacy_policy:self action:@selector(loadDataHandler:)];
    }

}




-(void)loadDataHandler:(id)value
{
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    //NSLog(@"arr");
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSString *str=[NSString stringWithFormat:@"%@", [[result JSONValue] valueForKey:@"message"]];
    //NSLog(@"result : %@",str);

    [faqwebview loadHTMLString:[self convertEntities:str] baseURL:nil];
    }
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



@end
