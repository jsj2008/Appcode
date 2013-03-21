//
//  AUVNewGridViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 11/10/12.
//
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "AUVDevsViewController.h"
typedef enum {
    Category =0,
    Developer =1,
    Profile=2
}Type;
@interface AUVNewGridViewController : UIViewController
{
    IBOutlet GMGridView *gmGridView;
    NSMutableArray *contents;
    Type type;
}
@property (nonatomic,assign) UIViewController *parentController;
@property (nonatomic,retain) NSMutableArray *contents;
@property (nonatomic,strong) GMGridView *gmGridView;
@property (nonatomic,assign) Type type;
- (void)reload;

@end
