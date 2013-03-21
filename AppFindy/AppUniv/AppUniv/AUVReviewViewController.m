//
//  AUVReviewViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 28/11/12.
//
//

#import "AUVReviewViewController.h"
#import "AUVSearchViewController.h"
#import "AUVSearchCellCell.h"
#import "JSON.h"
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
#import "SVProgressHUD.h"
#import "AUVQuestionViewController.h"
#import "AUVDetailViewController.h"


#import "AUVLogin.h"
#import "SVProgressHUD.h"

@interface AUVReviewViewController ()

@end

@implementation AUVReviewViewController
@synthesize  reviewid,urltag,name;

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
    

    self.title=name;
    [self loadData];

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

-(void) loadData

{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
 
    AUVwebservice *service=[AUVwebservice service];
    [service get_review_data:self action:@selector(reviewDataHandler:) review_id:reviewid];
}
    
    -(void)reviewDataHandler:(id)value
    {
        if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
            
            [SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
        }
    
        else{
        
        // Do something with the Array* result
        SoapArray* arr = (SoapArray*)value;
        
        NSString *result=[NSString stringWithFormat:@"%@",arr];
        
        
        //NSLog(@"Response : %@",result);
       [SVProgressHUD dismiss];
      [webview loadHTMLString:[self convertEntities:result] baseURL:nil];
        }
    }
- (NSString*)convertEntities:(NSString*)string
{
    NSString    *returnStr = nil;
    if( string )
    {
        returnStr = [ string stringByReplacingOccurrencesOfString:@"(" withString: @""];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"\"" withString: @""];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@")" withString: @""];
        
        returnStr = [ returnStr stringByReplacingOccurrencesOfString:@"&amp;" withString: @"&"  ];
        
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
