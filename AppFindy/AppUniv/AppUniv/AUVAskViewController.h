//
//  AUVAskViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 13/12/12.
//
//

#import <UIKit/UIKit.h>

#import "SDSegmentedControl.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"


typedef enum {
    ask=0,
    suggest=1,
}AskType;

@interface AUVAskViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet SDSegmentedControl *segmentedControl;
    
    IBOutlet UIView *container;
    UITableView *tableview;
    NSMutableArray *askarray;
    NSMutableArray *suggestarray;
    AskType type;
    
    NSString *questionid;
}

@property (strong,nonatomic) UITableView *tableview;
@property(nonatomic)AskType type;
@property(nonatomic,retain)NSString *questionid;

@end
