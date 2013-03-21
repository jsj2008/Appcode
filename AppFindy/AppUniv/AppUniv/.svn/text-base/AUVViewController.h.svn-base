//
//  AUVViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUVConstants.h"
#import "AUVSearchViewController.h"
//#import "DMOAuthTwitter.h"
//#import "DMTwitterCore.h"
#import "TXAlertViewWithField.h"
#import "AUVRegisterPanel.h"
#import "AUVLoginPanel.h"


@interface AUVViewController : UIViewController<UAModalPanelDelegate,UITextFieldDelegate,UISearchBarDelegate,FBRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    Facebook *facebook;
    IBOutlet UITextField *searchField;
    IBOutlet UISearchBar *searchBar;
    NSMutableArray *sugArray;
    NSString *fbUserName;
    
}

@property (strong,nonatomic) UITextField *searchField;
@property(strong,nonatomic) UISearchBar *searchBar;

@property(strong,nonatomic) UISearchDisplayController *searchController;
-(IBAction)connectWithFacebook:(id)sender;
-(IBAction)loginWithTwiter:(id)sender;
-(IBAction)goToWall:(id)sender;
//+ (NSString *) readableCurrentLoginStatus:(DMOTwitterLoginStatus) cstatus ;
@end
