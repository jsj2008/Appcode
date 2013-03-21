//
//  AUVGridViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
#import "AUVGridViewController.h"
#import "MMGridViewDefaultCell.h"
#import "UINavigationController+POP.h"
#import "AUVDevsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AUVConstants.h"
#import "SVProgressHUD.h"
@interface AUVGridViewController ()
- (void)reload;
- (void)setupPageControl;
@end

@implementation AUVGridViewController
@synthesize parentController,contents,gridView,type;
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
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    //if(!contents) contents=[[NSArray alloc] init];
    [self setupPageControl];
    
    
    //[self reload];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    //NSLog(@"View Did Appear");
    [self.view layoutSubviews];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
  
    [SVProgressHUD dismiss];
    [super viewDidDisappear:animated];
}
- (void)reload
{
    //NSLog(@"Reloaded");
    [gridView setNeedsLayout];
}


- (void)setupPageControl
{
    pageControl.numberOfPages = gridView.numberOfPages;
    pageControl.currentPage = gridView.currentPageIndex;
}

// ----------------------------------------------------------------------------------


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma - MMGridViewDataSource

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    return contents.count;
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    MMGridViewDefaultCell *cell = [[[MMGridViewDefaultCell alloc] initWithFrame:CGRectNull] autorelease];
    cell.iconImage.layer.cornerRadius=10.0f;
    cell.iconImage.clipsToBounds=YES;
    if(type==Profile){
    
    cell.textLabel.text = [[contents objectAtIndex:index] valueForKey:@"appname"];
   
    [cell.iconImage setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[contents objectAtIndex:index] valueForKey:@"applogo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    else{
        cell.textLabel.text = [[contents objectAtIndex:index] valueForKey:@"appName"];
        
        [cell.iconImage setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://appfindy.com/%@",[[(NSString*)[[contents objectAtIndex:index] valueForKey:@"appLogo"] componentsSeparatedByString:@"appfindy"] objectAtIndex:1]]] placeholderImage:[UIImage imageNamed:@"bg"]];
    }
    
    [cell setNeedsLayout];
    return cell;
}

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDelegate

- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
   // //NSLog(@"Cell Selected : %d",index);
    AUVDevsViewController *devs=(AUVDevsViewController*) parentController;
    if(devs.detailController!=nil){
        AUVDetailViewController *detail=(AUVDetailViewController*)[(AUVDevsViewController*)parentController detailController];
        //detail.appId=@""; // #appId should be entered here
        //detail.appId=@"121212";
        //[parentController.navigationController popToViewController:detail animated:YES];
        [parentController.navigationController popToViewControllerObject:detail];
        if(type==Profile)
        {
            [detail performSelector:@selector(detailActionWithAppId:) withObject:[[contents objectAtIndex:index] valueForKey:@"appid"]];
        }
        else
        [detail performSelector:@selector(detailActionWithAppId:) withObject:[[contents objectAtIndex:index] valueForKey:@"appId"]];
        

    }
    else{
            //NSLog(@"else");
    AUVDetailViewController *detail=[[[AUVDetailViewController alloc] initWithNibName:@"AUVDetailViewController" bundle:nil] autorelease];
        
    detail.appId=[[contents objectAtIndex:index] valueForKey:@"appId"]; // #appId should be entered here
    [parentController.navigationController pushViewController:detail animated:YES];
        if(type==Profile)
        {
            [detail performSelector:@selector(detailActionWithAppId:) withObject:[[contents objectAtIndex:index] valueForKey:@"appid"]];
        }
        else
        [detail performSelector:@selector(detailActionWithAppId:) withObject:[[contents objectAtIndex:index] valueForKey:@"appId"]];
    }
}


- (void)gridView:(MMGridView *)gridView didDoubleTapCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"Cell at index %d was double tapped.", index]
                                                   delegate:nil 
                                          cancelButtonTitle:@"Cool!" 
                                          otherButtonTitles:nil] autorelease];
    [alert show];
    
}


- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    [self setupPageControl];
}






-(void)pageChanged:(UIPageControl*)thePageControl
{
    //[gridView reloadData];
}

@end*/
