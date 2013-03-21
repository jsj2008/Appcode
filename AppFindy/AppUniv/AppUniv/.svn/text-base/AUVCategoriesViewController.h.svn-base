//
//  AUVCategoriesViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 22/08/12.
//
//

#import <UIKit/UIKit.h>
#import "MMGridView.h"
#import "AUVTabViewController.h"
typedef enum {
    CategoriesSelect=0,
    UserInterest=1
}Type;
@interface AUVCategoriesViewController : UIViewController
{
    IBOutlet MMGridView *gridView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *categoryArray;
    id parentTab;
    NSMutableArray *selectedArray;
    Type type;
    
    IBOutlet UILabel *textlabel;
    
}
@property(nonatomic,strong) id parentTab;
@property(nonatomic,strong) NSMutableArray *selectedArray;
@property(nonatomic,assign)Type type;
@end
