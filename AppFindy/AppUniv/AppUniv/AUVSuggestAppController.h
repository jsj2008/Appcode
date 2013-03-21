//
//  AUVSuggestAppController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 16/10/12.
//
//

#import <UIKit/UIKit.h>
#import "UATitledModalPanel.h"
#import "UAModalPanel.h"
@interface AUVSuggestAppController : UATitledModalPanel
{
    NSMutableArray *tableArray;
    IBOutlet UITableView *table;
    IBOutlet UIView *view;
    NSMutableArray *dataArray;
    NSString *appid;
    NSString *type;

}
@property(nonatomic,strong) NSMutableArray *tableArray;
@property(nonatomic,strong) NSString *appid;
@property(nonatomic,strong) NSString *type;
@end
