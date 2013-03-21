//
//  AUVCategoriesViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 22/08/12.
//
//

#import "AUVCategoriesViewController.h"
#import "AUVCategoryCell.h"
#import "UIImageView+AFNetworking.h"
#import "AUVwebService.h"
#import "NSString+MKNetworkKitAdditions.h"
#import "JSON.h"
#import "UIImage+Grayscale.h"
#import "SVProgressHUD.h"
#import "AUVLogin.h"
#import "AUVConstants.h"
@interface AUVCategoriesViewController ()
- (void)reload;
- (void)setupPageControl;
@end

@implementation AUVCategoriesViewController

@synthesize parentTab,selectedArray,type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)setupPageControl
{
    pageControl.numberOfPages = gridView.numberOfPages;
    pageControl.currentPage = gridView.currentPageIndex;
    gridView.numberOfRows=3;
    gridView.numberOfColumns=3;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.navigationController.navigationBarHidden=NO;
   // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    self.navigationController.navigationBarHidden=NO;
    
    [self setupPageControl];
    categoryArray=[[NSMutableArray alloc] init];
    selectedArray=[[NSMutableArray alloc] init];
    
    textlabel.font=[UIFont systemFontOfSize:15];
    [self getCategories:nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view layoutSubviews];
}
- (void)reload
{
    [gridView reloadData];
    [gridView reloadInputViews];
    [self setupPageControl];
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




#pragma - MMGridViewDataSource

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    return categoryArray.count;
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    AUVCategoryCell *cell = [[AUVCategoryCell alloc] initWithFrame:CGRectNull];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[categoryArray objectAtIndex:index] valueForKey:@"category_name"]];
    // cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-image.png"]];
    
    [cell.iconImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[categoryArray objectAtIndex:index] valueForKey:@"image"]]]];
    cell.image=[NSString stringWithFormat:@"%@", [[categoryArray objectAtIndex:index] valueForKey:@"image"]];
   
    cell.categoryId=[NSString stringWithFormat:@"%@", [[categoryArray objectAtIndex:index] valueForKey:@"category_id"]];
    cell.checked=NO;
    if([selectedArray indexOfObject:[NSNumber numberWithInteger:index]]!=NSNotFound)
    {
        cell.backgroundView.backgroundColor=[UIColor colorWithRed:0.529f green:0.7686f blue:0.9804f alpha:0.9];
        cell.checked=YES;
    }
    
  
    return cell;
}

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDelegate

- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    // //NSLog(@"Cell Selected : %d",index);
    AUVCategoryCell *cat=(AUVCategoryCell*)cell;
    //cell.backgroundColor=[UIColor colorWithHue:12 saturation:23 brightness:12 alpha:0.2];
    
    //cat.backgroundView.backgroundColor=[UIColor colorWithHue:12 saturation:23 brightness:12 alpha:0.2];
    
       // [cat.iconImage setAlpha:0.2f];
        //[cat.iconImage setImage:[cat.iconImage.image invertImage]];
              //  cat.selected=NO;
    
       // [cat.iconImage setAlpha:1.0f];
       // [cat.iconImage setImage:[cat.iconImage.image invertImage]];

       // [cat selectedCell];
    
    if(cat.checked){
        cat.backgroundView.backgroundColor=[UIColor whiteColor];
        cat.checked=NO;
        [selectedArray removeObject:cat.categoryId];

    }
    else
    {
        
         cat.backgroundView.backgroundColor=[UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
      // cat.backgroundView.backgroundColor=[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
      //  cat.backgroundView.backgroundColor=[UIColor colorWithRed:0.529f green:0.7686f blue:0.9804f alpha:0.9];
        
       // cat.backgroundView.backgroundColor=[UIColor blueColor];
        cat.checked=YES;
        [selectedArray addObject:cat.categoryId];
    }

      //NSLog(@"%@",selectedArray);
        
   }


- (void)gridView:(MMGridView *)gridView didDoubleTapCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"Cell at index %d was double tapped.", index]
                                                   delegate:nil
                                          cancelButtonTitle:@"Cool!"
                                          otherButtonTitles:nil];
    [alert show];
    
}


- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    [self setupPageControl];
}







-(void)getCategories:(id)sender
{
    
    [AUVwebservice cancelPreviousPerformRequestsWithTarget:self];
    AUVwebservice *service=[AUVwebservice service];
                            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    if(type==CategoriesSelect)
    [service get_all_category:self action:@selector(getCategoriesHandler:)];
    else if(type==UserInterest)
        [service get_user_interest:self action:@selector(getCategoriesHandler:) user_id:[AUVLogin valueforKey:@"user_id"]];
    
    
}



-(void)getCategoriesHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    

    else{
    SoapArray *arr=(SoapArray*)value;
     NSString *result=[[[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\\" withString:@""] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    //NSLog(@"Result : %@",result);
    
    NSDictionary *dict=[result JSONValue];
    
   ////NSLog(@"%@",[dict valueForKey:@"category_list"]);
    [categoryArray removeAllObjects];
    
    NSPredicate *predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
        ////NSLog(@" : %@",obj);
        
        return  [[[(NSDictionary*)obj  valueForKey:@"apptype"] capitalizedString] isEqualToString:[self.title capitalizedString]] ;
        
        
        
    }];
    
  /*  NSPredicate *iphone=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
        ////NSLog(@" : %@",obj);
        
        return  [[(NSDictionary*)obj  valueForKey:@"apptype"] isEqualToString:@"iPhone"] ;
    }];

    
    if(self.title)*/
 //   NSArray *categories=[(NSArray*)[dict valueForKey:@"category_list"] filteredArrayUsingPredicate:predicate];
  //  NSArray *nonusersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate2];
    
    NSArray *categories=[NSArray arrayWithArray:[dict valueForKey:@"category_list"]] ;
    

    //NSLog(@"%@",categories);
    [categoryArray addObjectsFromArray:categories];
    [self reload];
        [SVProgressHUD dismiss];
    }
    
}

//
//
//-(IBAction)doneAction:(id)sender
//{
//    [(AUVTabViewController*)parentTab doneAction:nil];
//    
//}
//


-(void)doneAction:(id)sender
{
      
    
    
    
    
    AUVwebservice *service=[AUVwebservice service];
    
    [service user_interest:self action:@selector(userInterestHandler:) user_id:[NSString stringWithFormat:@"%@",[AUVLogin valueforKey:@"user_id"]] category_id:[NSString stringWithFormat:@"%@", [selectedArray componentsJoinedByString:@","]]];
    
   // [service user_interest:self action:@selector(userInterestHandler:) user_id:[NSString stringWithFormat:@"%@",[AUVLogin valueforKey:@"user_id"]] category_id:<#(NSString *)#>]
}




-(void)userInterestHandler:(id)value
{
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    

    else{
    SoapArray *arr=(SoapArray*)value;
    
    //NSLog(@"%@",arr);
    NSString *result=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"\\" withString:@""]];
    
    NSDictionary *dict=[result JSONValue];
    
    //NSLog(@"Insert %@",dict);
        [SVProgressHUD dismiss];
    if([[dict valueForKey:@"status"] boolValue])
    {
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"new_user"];
        [defaults synchronize];
        
        [[self  navigationController] popViewControllerAnimated:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:AUVCategoryNotification object:nil];
    }
    // //NSLog(@"%@",value);
    }
}

@end
