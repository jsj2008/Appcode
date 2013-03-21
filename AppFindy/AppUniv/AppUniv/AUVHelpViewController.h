//
//  AUVHelpViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 03/12/12.
//
//

#import <UIKit/UIKit.h>

@interface AUVHelpViewController : UIViewController
{
    IBOutlet UITableView *helptableview;
    IBOutlet UIView *baseView;
    NSString *helppagepositionpagevalue;
    IBOutlet UIWebView *webView;
}

@property(nonatomic,retain)NSString *helppagepositionpagevalue;

@end
