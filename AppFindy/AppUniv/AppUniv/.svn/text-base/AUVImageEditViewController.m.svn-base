//
//  AUVImageEditViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 04/09/12.
//
//

#import "AUVImageEditViewController.h"
#import "BJImageCropper.h"
@interface AUVImageEditViewController ()

@end

@implementation AUVImageEditViewController

@synthesize image,finalImage;
BJImageCropper *imageCropper;
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
    
    imageCropper=[[BJImageCropper alloc] initWithImage:image];
    
    [self.view addSubview:imageCropper];
    
    self.finalImage=imageCropper.getCroppedImage;
    
   // UITabBar *tool=[[UIToolbar alloc] init];
    
    UIBarButtonItem *crop=[[UIBarButtonItem alloc] initWithTitle:@"Crop" style:UIBarButtonSystemItemAction target:self action:@selector(cropImage)];
    self.toolbarItems=[NSArray arrayWithObject:crop];
    
}

-(void)cropImage
{
    
    
    
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
