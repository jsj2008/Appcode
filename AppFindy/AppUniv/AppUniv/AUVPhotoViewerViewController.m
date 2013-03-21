//
//  AUVPhotoViewerViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 10/12/12.
//
//

#import "AUVPhotoViewerViewController.h"
#import "UIImageView+AFNetworking.h"

@interface AUVPhotoViewerViewController ()

@end

@implementation AUVPhotoViewerViewController

@synthesize imgarray,pageview,disc;

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
    if([pageview isEqualToString:@"imageview"])
    {
        self.title=@"Screen Shot";
        
        pagescroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320, 460)];
        if (IS_IPHONE_5) {
            pagescroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320,504)];

        }
        [pagescroll setBackgroundColor:[UIColor whiteColor]];
        pagescroll.pagingEnabled=YES;
        
        [self.view addSubview:pagescroll];
    }
    else
    {
        self.title=@"Description";
      
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,self.view.bounds.size.height)];
        webView.delegate = self;
        [webView loadHTMLString:[self convertEntities:disc] baseURL:nil];
       [self.view addSubview:webView];

    }
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closePage:)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if(imgarray.count>0)
    {
        int y=0;
        for (int i=0; i<imgarray.count; i++) {
            
            NSString *strapplogo=  [NSString stringWithFormat:@"%@",[imgarray objectAtIndex:i]];
            
            strapplogo = [strapplogo stringByReplacingOccurrencesOfString:@"vol/iphone_final/./"
                                                               withString:@""];
            UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0+y,0,320,pagescroll.bounds.size.height)];
            [imgview setImageWithURL:[NSURL URLWithString:strapplogo] placeholderImage:[UIImage imageNamed:@"loading"]];
            
            [pagescroll addSubview:imgview];
            
            y=320+y;
        }
        
        [pagescroll setContentSize:CGSizeMake(imgarray.count*320, 150)];
    }

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


-(IBAction)closePage:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
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
