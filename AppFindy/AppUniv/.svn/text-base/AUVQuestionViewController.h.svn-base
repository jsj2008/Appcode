//
//  AUVQuestionViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/09/12.
//
//

#import <UIKit/UIKit.h>
#import "FaceBook.h"
#import "AUVAppDelegate.h"



@interface AUVQuestionViewController : UIViewController<FBSessionDelegate,FBRequestDelegate,FBDialogDelegate>

{
    IBOutlet UILabel *qn;
    IBOutlet UIImageView *icon;
    IBOutlet UILabel *username;
    IBOutlet UILabel *questiontitle;
    IBOutlet UILabel *ans;
    IBOutlet UILabel *followed;
    NSString *questionId;
    NSMutableDictionary *info;
    IBOutlet UITableView *answerTable;
    BOOL follow;
    UIBarButtonItem *followBtn;
    
    IBOutlet UIImageView *ansicon;
    IBOutlet UIImageView *followedicon;
    IBOutlet UIButton *addans;
    IBOutlet UIButton *suggestbutton;
    
    IBOutlet UIView *infoview;
    
    
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *homeButton;
    
    IBOutlet UILabel *appname;
    
    IBOutlet UIButton *followuserbutton;
    IBOutlet UILabel *followcount;
    IBOutlet UIView *questionView;
    
    IBOutlet UIView *bottomview;
}
@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSMutableDictionary *info;
@property(nonatomic,strong)NSMutableArray *tableArray;
@property(nonatomic,retain)UITableView *answerTable;
@property(nonatomic,assign)BOOL newlyadded;
@property(nonatomic)BOOL follow;
@end
