//
//  AUVProfileEditViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/08/12.
//
//

#import <UIKit/UIKit.h>
#define AUVPicture @"picture"
#define AUVLocation @"Location"
#define AUVBio @"bio"
#define AUVWeb @"website"
#define AUVMob @"mobile_number"
#define AUVFName @"firstname"
#define AUVLName @"lastname"
#define AUVEmail @"email_id"

@interface AUVProfileEditViewController : UIViewController
{
    NSString *labelName;
    NSString *fieldValue;
    UILabel *label;
    UITextField *textField;
    NSString *type;
}
@property(nonatomic,strong)NSString *labelName;
@property(nonatomic,strong)NSString *fieldValue;
@property(nonatomic,strong) NSString *type;
@end
