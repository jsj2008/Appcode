//
//  AUVFollowersList.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 01/10/12.
//
//

#import <Foundation/Foundation.h>
#import "UATitledModalPanel.h"
#import "AUVDetailViewController.h"
#import "AUVDevsViewController.h"


typedef enum {
    AUVAppFollowers =1,
    AUVUserFollowers,
    AUVUserFollowing,
    AUVCatagoryFollowers,
    AUVDevFollowers,
    AUVQuestionFollowers
}AUVFollowType;
@interface AUVFollowersList : UATitledModalPanel

{
    IBOutlet UIView *view;
    IBOutlet UITableView *table;
    NSString *appId;
    NSMutableArray *tableArray;
    AUVFollowType type;
    NSString *catId;
    NSString *devId;
    NSString *userId;
    NSString *questionid;
    id parent;
}

@property (strong,nonatomic) UITableView *table;

@property(nonatomic,strong) NSString *appId;
@property(nonatomic,assign) AUVFollowType type;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *catId;
@property(nonatomic,strong) NSString *devId;
@property(nonatomic,strong)NSString *selectedUserId;
@property(nonatomic,strong)NSString *questionid;
@property(nonatomic,strong)id parent;
@end
