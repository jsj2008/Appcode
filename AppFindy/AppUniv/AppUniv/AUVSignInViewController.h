//
//  AUVSignInViewController.h
//  AppUniv
//
//  Created by Innoppl technologies on 06/12/12.
//
//

#import <UIKit/UIKit.h>

@interface AUVSignInViewController : UIViewController
{
    IBOutlet UIScrollView *scroll;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIButton *login;
    IBOutlet UIButton *signup;
}
@property (nonatomic)BOOL loggedIn;

@end
