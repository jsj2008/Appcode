//
//  AUVFriendsListViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 15/08/12.
//
//

#import <UIKit/UIKit.h>
#import "FaceBook.h"
#import "AUVViewController.h"
typedef enum {
  AUVContactsList =1,
  AUVFBFriendList,
    AUVTwitterList,
    AUVSearchFriendList,
    AUVSuggestionList,
    AUVTopUserList,
    AUVInviteContacts,
    AUVInviteFBFriends
    
}AUVFriendListType;
@interface AUVFriendsListViewController : UIViewController<FBSessionDelegate,FBRequestDelegate>
{
     AUVFriendListType type;
    NSMutableArray *dataArray;
    NSMutableArray *tableArray;
    IBOutlet UITableView *friendsTable;
    NSString *searchTerm;
    IBOutlet UISearchBar *tableSearch;
    

}
@property(nonatomic,assign) AUVFriendListType type;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *tableArray;
@property (nonatomic,strong) NSString *searchTerm;
@property(nonatomic,assign)AUVViewController *parent;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(AUVFriendListType)friendListype;
@end
