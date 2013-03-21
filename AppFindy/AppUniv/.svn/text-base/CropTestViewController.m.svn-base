//
//  CropTestViewController.m
//  CropTest
//
//  Created by Barrett Jacobsen on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// preview slows down frame rate (it's generating a new UIImage very frequently)
#define SHOW_PREVIEW NO
#define AUVPicture @"picture"
#import "CropTestViewController.h"
#import "SVProgressHUD.h"
#import "AUVwebservice.h"
#import "AUVConstants.h"
#import "NSData+Base64.h"
#import "JSON.h"
#import <QuartzCore/QuartzCore.h>

#ifndef CGWidth
#define CGWidth(rect)                   rect.size.width
#endif

#ifndef CGHeight
#define CGHeight(rect)                  rect.size.height
#endif

#ifndef CGOriginX
#define CGOriginX(rect)                 rect.origin.x
#endif

#ifndef CGOriginY
#define CGOriginY(rect)                 rect.origin.y
#endif


@implementation CropTestViewController
@synthesize boundsText;
@synthesize imageCropper;
@synthesize preview;
@synthesize fullImage;
UIImage *img;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)updateDisplay {
    self.boundsText.text = [NSString stringWithFormat:@"(%f, %f) (%f, %f)", CGOriginX(self.imageCropper.crop), CGOriginY(self.imageCropper.crop), CGWidth(self.imageCropper.crop), CGHeight(self.imageCropper.crop)];

    self.preview.image=NULL;
     self.preview.layer.borderWidth = 0.0;
    
    if (SHOW_PREVIEW) {
        self.preview.image = [self.imageCropper getCroppedImage];
        self.preview.frame = CGRectMake(10,10,self.imageCropper.crop.size.width * 0.1, self.imageCropper.crop.size.height * 0.1);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isEqual:self.imageCropper] && [keyPath isEqualToString:@"crop"]) {
        [self updateDisplay];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tactile_noise.png"]];
    
   // UIBarButtonItem *crop=[[UIBarButtonItem alloc] initWithTitle:@"Crop" style:UIBarButtonItemStyleBordered target:self action:@selector(getCrop:)];
    
    UIBarButtonItem *done=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:done, nil];
    self.imageCropper = [[BJImageCropper alloc] initWithImage:fullImage andMaxSize:CGSizeMake(320, 410)];//[[BJImageCropper alloc] initWithImage:[UIImage imageNamed:@"gavandme.jpg"] andMaxSize:CGSizeMake(1024, 600)];
    [self.view addSubview:self.imageCropper];
    self.imageCropper.center = self.view.center;
    self.imageCropper.imageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.imageCropper.imageView.layer.shadowRadius = 3.0f;
    self.imageCropper.imageView.layer.shadowOpacity = 0.8f;
    self.imageCropper.imageView.layer.shadowOffset = CGSizeMake(1, 1);
    
    [self.imageCropper addObserver:self forKeyPath:@"crop" options:NSKeyValueObservingOptionNew context:nil];
    
    //if (SHOW_PREVIEW) {
        self.preview = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,120,120)];
     //   self.preview.image = [self.imageCropper getCroppedImage];
        self.preview.clipsToBounds = YES;
        self.preview.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.preview.layer.borderWidth = 2.0;
        [self.view addSubview:self.preview];
  //  }
}


- (void)viewDidUnload
{
    [self setImageCropper:nil];
    [self setBoundsText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateDisplay];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(IBAction)getCrop:(id)sender
{
    img=[imageCropper getCroppedImage];
    self.preview.layer.borderWidth = 2.0;
    self.preview.image=img;
    
    //NSLog(@"%@",img.description);

}

-(IBAction)doneAction:(id)sender
{
 
   // [self.navigationController popViewControllerAnimated:YES];
    
    img=[imageCropper getCroppedImage];
   // self.preview.layer.borderWidth = 2.0;
    //self.preview.image=img;
    
    //NSLog(@"%@",img.description);
    

    if(img)
    [self performSelectorOnMainThread:@selector(update:) withObject:img waitUntilDone:YES];
    else
        [self.navigationController popViewControllerAnimated:YES];
}

-(void)update:(UIImage*)image
{
    [SVProgressHUD showWithStatus:@"Uploading the Image" maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    NSData *data= UIImageJPEGRepresentation(image, 0.3f);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    ////NSLog(@"Updating :");
    
    [service update_profile:self action:@selector(updateHandler:) user_id:[defaults valueForKey:@"user_id"] param_name:AUVPicture param_value:data.base64EncodedString];
    /*
     AUVImageEditViewController *viewController=[[AUVImageEditViewController alloc] init];
     viewController.image=[UIImage imageNamed:@"placeholder"];
     // BJImageCropper *imageCrop=[[BJImageCropper alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
     //viewController.view=imageCrop;
     [self presentModalViewController:viewController animated:YES];*/
}
-(void)updateHandler:(id)value
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{

    SoapArray *arr=(SoapArray*) value;
    
   // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //NSLog(@"Result : %@",[value description]);
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    if([[[result JSONValue] valueForKey:@"status"] boolValue])
    {
      //  [tableDictionary  setValue:[[result JSONValue] valueForKey:@"profile_image"]  forKey:@"picture"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    }
    //[profileTable reloadData];
    //[self.navigationController popViewControllerAnimated:YES];
}



@end
