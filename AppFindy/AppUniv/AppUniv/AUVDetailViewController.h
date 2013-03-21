//
//  AUVDetailViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagedFlowView.h"
#import "RSTapRateView.h"
#import "DYRateView.h"
#import "TXLabel.h"
#import "AUVwebservice.h"
#import "RSTapRateView.h"
#import "AUVAppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "AUVDevsViewController.h"
#import "JSON.h"
#import "InfinitePagingView.h"
#import "AUVCommentsViewController.h"
#import "AUVLogin.h"
#import "AUVFollowersList.h"
#import "AUVDescriptionViewController.h"
#import "AUVScreenShotsViewController.h"
#import "SDSegmentedControl.h"
#import "AUVQuestionViewController.h"
#import "FaceBook.h"

typedef enum {
    description=0,
    discussion=1,
    
    review=2
    
}ContentTypeAppview;

@interface AUVDetailViewController : UIViewController<PagedFlowViewDelegate,PagedFlowViewDataSource,DYRateViewDelegate,UAModalPanelDelegate,RSTapRateViewDelegate,FBSessionDelegate,FBRequestDelegate,FBDialogDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *table;
    NSString *_appId;
    NSString *categoryId;
    NSString *developerId;
    IBOutlet TXLabel *category;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *followers;
    IBOutlet UILabel *friendsLike;
    IBOutlet UILabel *appName;
    IBOutlet UIImageView *appIcon;
    IBOutlet UILabel *price;
    IBOutlet UILabel *like;
    IBOutlet UIWebView *descriptionView;
    NSMutableDictionary *appDic;
    IBOutlet UILabel *votes;
    IBOutlet UILabel *shares;
    IBOutlet TXLabel *developer;
    
    IBOutlet UILabel *categorylabel;
    
     IBOutlet PagedFlowView *pageflow;
     IBOutlet UIPageControl *pageControl;
    
    IBOutlet UIButton *btn;
    IBOutlet UIButton *likeBtn;
    IBOutlet UIView *rateContainer;
    IBOutlet UIButton *shareBtn;
    IBOutlet RSTapRateView *rateIt;
    IBOutlet UILabel *platform;
    IBOutlet UIButton *androidB;
    IBOutlet UIButton *iphoneB;
    
    IBOutlet UIButton *descriptionBtn;
    IBOutlet UIButton *screenshotBtn;
  
    DYRateView *rateView;
    DYRateView *currentRating;
    
    IBOutlet UIView *descriptionViewControll;
    
    
    IBOutlet UIView *friends;
     UITableView *likedFriends;
    IBOutlet UITableView *comments;
    IBOutlet UITableView *questions;
    BOOL followed;
    
    IBOutlet SDSegmentedControl *segmentedControl;
    
    IBOutlet UIView *container;
    ContentTypeAppview type;
    
    UIWebView *webView;
    UIButton *morebutton;
    UITableView *tableviewquestion;
    UITableView *tableviewreview;
    UIScrollView *pagescroll;
    
    UIScrollView *friendsscroll;
    
    NSDictionary *tabledict;
    
    IBOutlet UIButton *suggestButton;
    IBOutlet UIButton *friendslikeButton;
    
    NSString *apps_url148;
    NSString *theiphoneappreview_url;
    NSString *appadvice_url;
    NSString *iphoneappreview_url;
    NSString *appaddict_url;
    NSString *touchmyapps_url;
    NSString *toucharcade_url;
    
    IBOutlet UILabel *ratingcountlabel;
    
    IBOutlet UIButton *priceButton;
    IBOutlet UIButton *disLikeButton;
    
    IBOutlet UILabel *dislikeLabel;
    
   // userRatingCount
}
@property(nonatomic,strong) NSString *appId;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;
@end
