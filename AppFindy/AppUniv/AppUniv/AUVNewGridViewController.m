//
//  AUVNewGridViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 11/10/12.
//
//

#import "AUVNewGridViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AUVDetailViewController.h"
#import "UINavigationController+POP.h"
#import "SVPullToRefresh.h"

@interface AUVNewGridViewController ()

@end

@implementation AUVNewGridViewController
@synthesize parentController,contents,gmGridView,type;
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
    
    [self gridSetup];
    // Do any additional setup after loading the view from its nib.
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


-(void)gridSetup
{
    //gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (IS_IPHONE_5) {
        gmGridView.frame=CGRectMake(gmGridView.bounds.origin.x,gmGridView.bounds.origin.y,gmGridView.bounds.size.width,gmGridView.bounds.size.height+16);
    }
    gmGridView.style = GMGridViewStylePush;
    gmGridView.itemSpacing = 5;
    gmGridView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.2];
    //gmGridView.frame=container.frame;
    gmGridView.pagingEnabled=YES;
    //gmGridView.clipsToBounds=YES;
   //gmGridView.minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
   // gmGridView.centerGrid = YES;
    
    
    
    gmGridView.delegate=self;
    gmGridView.dataSource=self;
    gmGridView.actionDelegate=self;
   gmGridView.transformDelegate=self;
    
    gmGridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontalPagedLTR];

   /* [gmGridView.scrollView addInfiniteScrollingWithActionHandler:^(void){
        
        //NSLog(@"Loding");
    }];*/
    gmGridView.scrollView.delegate=self;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.x + scrollView.frame.size.width;
    if (bottomEdge == scrollView.contentSize.width) {
        // we are at the end
        //NSLog(@"loading");
        
        
        
        if([parentController isKindOfClass:[AUVDevsViewController class]]){
            
            AUVDevsViewController *devs=(AUVDevsViewController*)parentController;
            
            devs.start=devs.start+12;
            
            [devs reload];
        }
        
    }
}


#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    //NSLog(@"contents reload %d",contents.count);
    return contents.count;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(170, 135);
        }
        else
        {
            if (IS_IPHONE_5) {
                return CGSizeMake(150, 120);

            }else{
            return CGSizeMake(150, 130);
            }
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(285, 205);
        }
        else
        {
            return CGSizeMake(230, 175);
        }
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    ////NSLog(@"Creating view indx %d", index);
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    UIImageView *iconImage;
    UIView *textLabelBackgroundView ;
    UILabel* textLabel;
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    if(cell) cell=nil;
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        //cell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
        // cell.deleteButtonOffset = CGPointMake(-15, -15);
       // cell.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        //view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 1;
        
        
        view.backgroundColor = [UIColor whiteColor];
        //[view addSubview:self.backgroundView];
        /*self.baseContainer=[[[UIView alloc] initWithFrame:CGRectNull] autorelease];
         self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
         [self addSubview:self.backgroundView];*/
        
       // iconImage=[[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 54, 54)];
    
         iconImage=[[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 80, 80)];
        //[iconImage.layer setBorderWidth:1.0f];
        iconImage.layer.cornerRadius=10.0f;
        [view  addSubview:iconImage];
        
      //  iconImage.layer.borderColor=[[UIColor redColor]CGColor];
        //iconImage.layer.borderWidth=2;
        //iconImage.layer.cornerRadius=10.0f;
        iconImage.clipsToBounds=YES;
        
        // Label
        textLabelBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, 140, 30)];
        //  self.textLabelBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        textLabelBackgroundView.backgroundColor=[UIColor clearColor];
        
        textLabel = [[UILabel alloc] initWithFrame:textLabelBackgroundView.frame];
        textLabel.textAlignment = UITextAlignmentCenter;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor blackColor];
        textLabel.font = [UIFont systemFontOfSize:13];
        textLabel.numberOfLines = 2;
        textLabel.lineBreakMode=UILineBreakModeWordWrap;
        
        [view addSubview:textLabel];
        [view addSubview:textLabelBackgroundView];
        cell.layer.borderWidth=1.0f;
        cell.layer.borderColor=[UIColor grayColor].CGColor;
        //cell.layer.cornerRadius=10.0f;
        cell.contentView = view;
    }
    
    //[[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    /* UIImageView *imageV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a_shopping"]];
     imageV.frame=CGRectMake(10,5, size.width-20, size.width-50);
     [cell.contentView addSubview:imageV];
     UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
     label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
     label.text = @"test";//(NSString *)[_currentData objectAtIndex:index];
     label.textAlignment = UITextAlignmentCenter;
     label.backgroundColor = [UIColor clearColor];
     label.textColor = [UIColor blackColor];
     label.highlightedTextColor = [UIColor whiteColor];
     label.font = [UIFont boldSystemFontOfSize:20];
     [cell.contentView addSubview:label];*/
    //[iconImage setImage:[UIImage imageNamed:@"a_shopping"]];
    if(type==Profile){
        
        textLabel.text = [[contents objectAtIndex:index] valueForKey:@"appname"];
        
        NSString *applogo=[NSString stringWithFormat:@"%@",[[contents objectAtIndex:index] valueForKey:@"applogo"]];
        
        applogo=[applogo stringByReplacingOccurrencesOfString:@"vol/iphone_final/./" withString:@"images/"];
        
       // //NSLog(@"image : %@",applogo);
        
        [iconImage setImageWithURL:[NSURL URLWithString:applogo]placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
       // [iconImage setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[contents objectAtIndex:index] valueForKey:@"applogo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }

    else{
        textLabel.text = [[contents objectAtIndex:index] valueForKey:@"trackCensoredName"];
        
        
        
        NSString *strapplogo=  [NSString stringWithFormat:@"%@",[[(NSString*)[[contents objectAtIndex:index] valueForKey:@"artworkUrl60"] componentsSeparatedByString:@"appfindy"] objectAtIndex:0]];
        
        strapplogo = [strapplogo stringByReplacingOccurrencesOfString:@"vol/iphone_final/./"
                                                           withString:@""];
        
       // //NSLog(@"%@",strapplogo);
        
        [iconImage  setImageWithURL:[NSURL URLWithString:strapplogo] placeholderImage:[UIImage imageNamed:@"bg"]];
        
       // customcell.appIcon.contentMode = UIViewContentModeScaleAspectFit;
        
        
        //[iconImage setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://appfindy.com/%@",[[(NSString*)[[contents objectAtIndex:index] valueForKey:@"appLogo"] componentsSeparatedByString:@"appfindy"] objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"bg"]];
    }
    

    
    return cell;
}

- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return NO; //index % 2 == 0;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
   // //NSLog(@"Did tap at index %d", position);
   /* AUVDevsViewController *devs=(AUVDevsViewController*) parentController;
    if(devs.detailController){
        AUVDetailViewController *detail=devs.detailController;//(AUVDetailViewController*)[(AUVDevsViewController*)parentController detailController];
        //detail.appId=@""; // #appId should be entered here
        //detail.appId=@"121212";
        //[parentController.navigationController popToViewController:detail animated:YES];
        [parentController.navigationController popToViewControllerObject:detail];
        if(type==Profile)
        {
            [detail performSelector:@selector(detailActionWithAppId:) withObject:[[contents objectAtIndex:position] valueForKey:@"appid"]];
        }
        else
            [detail performSelector:@selector(detailActionWithAppId:) withObject:[[contents objectAtIndex:position] valueForKey:@"trackId"]];
        
    }
    else{*/
        
        AUVDetailViewController *detail=[[AUVDetailViewController alloc] initWithNibName:@"AUVDetailViewController" bundle:nil];
        
        if (type==Profile) {
            detail.appId=[[contents objectAtIndex:position] valueForKey:@"appid"]; // #appId should be entered here
            //NSLog(@"id %@:",detail.appId);
        }else
        {
            detail.appId=[[contents objectAtIndex:position] valueForKey:@"trackId"]; // #appId should be entered here
            //NSLog(@"id %@:",detail.appId);
        }
        
        [parentController.navigationController pushViewController:detail animated:YES];
        if(type==Profile)
        {
            [detail performSelector:@selector(detailActionWithAppId:) withObject:[[contents objectAtIndex:position] valueForKey:@"appid"]];
        }
        else
            [detail performSelector:@selector(detailActionWithAppId:) withObject:[[contents objectAtIndex:position] valueForKey:@"trackId"]];
    }

//}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    //NSLog(@"Tap on empty space");
}



//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    //NSObject *object = [_currentData objectAtIndex:oldIndex];
    //[_currentData removeObject:object];
    //[_currentData insertObject:object atIndex:newIndex];
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    // [_currentData exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}


//////////////////////////////////////////////////////////////
#pragma mark DraggableGridViewTransformingDelegate
//////////////////////////////////////////////////////////////

- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index inInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(320, 210);
        }
        else
        {
            return CGSizeMake(300, 310);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(700, 530);
        }
        else
        {
            return CGSizeMake(600, 500);
        }
    }
}

- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIView *fullView = [[UIView alloc] init];
    fullView.backgroundColor = [UIColor yellowColor];
    fullView.layer.masksToBounds = NO;
    fullView.layer.cornerRadius = 8;
    
    CGSize size = [self GMGridView:gridView sizeInFullSizeForCell:cell atIndex:index inInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    fullView.bounds = CGRectMake(0, 0, size.width, size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:fullView.bounds];
    label.text = [NSString stringWithFormat:@"Fullscreen View for cell at index %d", index];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (INTERFACE_IS_PHONE)
    {
        label.font = [UIFont boldSystemFontOfSize:15];
    }
    else
    {
        label.font = [UIFont boldSystemFontOfSize:20];
    }
    
    [fullView addSubview:label];
    
    
    return fullView;
}

- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blueColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEnterFullSizeForCell:(UIView *)cell
{
    
    //NSLog(@"did enter full size");
    
}

@end
