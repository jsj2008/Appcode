//
//  AUVUserProfileViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 26/08/12.
//
//

#import <UIKit/UIKit.h>
#import "AUVAppDelegate.h"

typedef enum {UserProfile =0,
    LinkedAccounts}AUVType;
@interface AUVUserProfileViewController : UIViewController

{
    NSMutableDictionary *tableDictionary;
    IBOutlet UITableView *profileTable;
    Facebook *facebook;
    
}
@property(nonatomic,assign) AUVType type;
@end
