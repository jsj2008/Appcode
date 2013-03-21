//
//  AUVFBRegViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 27/09/12.
//
//

#import <UIKit/UIKit.h>

@interface AUVFBRegViewController : UIViewController
{
   IBOutlet UITextField *userName;
   IBOutlet  UITextField *password;
   IBOutlet UITextField *verifyPass;
    NSString *userNameString;
   IBOutlet UILabel *message;
    IBOutlet UIScrollView *scrollview;
}

@property(nonatomic,strong) NSString *userNameString;
@end
