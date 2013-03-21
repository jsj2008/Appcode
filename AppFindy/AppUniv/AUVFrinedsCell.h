//
//  AUVFrinedsCell.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 14/08/12.
//
//

#import <UIKit/UIKit.h>

@interface AUVFriendsCell : UITableViewCell
{
    IBOutlet UIImageView *icon;
    IBOutlet UILabel *title1;
    IBOutlet UILabel *title2;
}
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *title1;
@property(nonatomic,strong) UILabel *title2;
@end
