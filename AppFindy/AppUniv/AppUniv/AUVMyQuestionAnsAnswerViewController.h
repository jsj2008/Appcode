//
//  AUVMyQuestionAnsAnswerViewController.h
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
    Question=0,
    Answer=1,
}MyQuestionansAnswerType;

@interface AUVMyQuestionAnsAnswerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet SDSegmentedControl *segmentedControl;
    
    IBOutlet UIView *container;
    UITableView *tableview;
    NSMutableArray *questionarray;
    NSMutableArray *answerarray;
    MyQuestionansAnswerType type;
    
    
}

@property (strong,nonatomic) UITableView *tableview;
@property(nonatomic)MyQuestionansAnswerType type;





@end
