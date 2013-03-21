//
//  AUVNotificationViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 10/10/12.
//
//

#import <UIKit/UIKit.h>
#import "AUVwebservice.h"
#import "AUVLogin.h"
#import "JSON.h"
typedef enum {
    
    NUSER_FOLLW =1,
    NQUESTION_FOLLOW=2,
    NQUESTION_COMMENT=3,
    NAPP_SUGGEST=4,
    NQUESTION_SUGGEST=5,
    NQUESTION_ASK=6
    
}NType;
@interface AUVNotificationViewController : UIViewController
{
     NSMutableArray *notifications;
     NType type;
    IBOutlet UITableView *tableView;
}

@property(nonatomic,strong)NSMutableArray *notifications;
@property(nonatomic) NType type;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)id parent;
@end
