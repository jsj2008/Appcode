//
//  AUVInterestViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 11/10/12.
//
//

#import <UIKit/UIKit.h>
#import "SDSegmentedControl.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"

typedef enum {
    Categories=0,
    Apps=1,
    Questions=2,
    friends=3
    
}ContentType;

@interface AUVInterestViewController : UIViewController
{
   IBOutlet SDSegmentedControl *segmentedControl;
    
    IBOutlet UIView *container;
     UITableView *tableview;
    NSMutableArray *categoriesArray;
    GMGridView *gmGridView;
    ContentType type;
    IBOutlet UILabel *message;
}

@property(nonatomic,strong) GMGridView *gmGridView;
@property (strong,nonatomic) UITableView *tableview;
@property(nonatomic)ContentType type;
@end
