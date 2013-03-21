//
//  AUVPopOverViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 04/10/12.
//
//

#import <UIKit/UIKit.h>
#import "AUVwebservice.h"
#import "AUVLogin.h"
#import "JSON.h"


typedef enum {
    
    USER_FOLLW =1,
    QUESTION_FOLLOW=2,
    QUESTION_COMMENT=3,
    
}NotificationType;
@interface AUVPopOverViewController : UITableViewController

{
    NSMutableArray *notifications;
    NotificationType type;
}

@property(nonatomic,strong)NSMutableArray *notifications;
@property(nonatomic) NotificationType type;
@property(nonatomic,assign)id parent;
@end
