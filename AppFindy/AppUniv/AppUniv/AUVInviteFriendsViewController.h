//
//  AUVInviteFriendsViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 18/09/12.
//
//

#import <UIKit/UIKit.h>

@interface AUVInviteFriendsViewController : UIViewController
{
    IBOutlet UITableView *tableView;
    NSString *invitefriendspageposition;

}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,retain)NSString *invitefriendspageposition;
@end
