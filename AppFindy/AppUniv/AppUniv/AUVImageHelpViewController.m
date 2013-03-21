//
//  AUVImageHelpViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 20/12/12.
//
//

#import "AUVImageHelpViewController.h"
#import "AUVConstants.h"

@interface AUVImageHelpViewController ()

@end

@implementation AUVImageHelpViewController

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
    
    self.title=@"About Appfindee";
    self.navigationController.navigationBarHidden=NO;
    
    [pageControl setUserInteractionEnabled:NO];
    
    
    scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320, 400)];
   
    if (IS_IPHONE_5) {
        scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320,484)];
    }
    [scrollview setBackgroundColor:[UIColor whiteColor]];
    scrollview.delegate=self;
    scrollview.pagingEnabled=YES;
    scrollview.showsHorizontalScrollIndicator=NO;
    scrollview.showsVerticalScrollIndicator=NO;

    [self.view addSubview:scrollview];
    
    imagearray =[NSArray arrayWithObjects:@"welcome.png",@"connect.png" ,@"discussions.png",@"review.png",@"functional.png",@"alerts.png",nil];
    
    pageControl.numberOfPages=imagearray.count;
    
    
    if(imagearray.count>0)
    {
        int y=0;
        for (int i=0; i<imagearray.count; i++) {
            
            UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0+y,0,320,scrollview.bounds.size.height)];
            imgview.image=[UIImage imageNamed:[imagearray objectAtIndex:i]];
            
            [scrollview addSubview:imgview];
            
            y=320+y;
        }
        
        [scrollview setContentSize:CGSizeMake(imagearray.count*320, 150)];
    }
    pageControl.currentPage=0;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollview.frame.size.width;
    float fractionalPage = scrollview.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
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
@end
