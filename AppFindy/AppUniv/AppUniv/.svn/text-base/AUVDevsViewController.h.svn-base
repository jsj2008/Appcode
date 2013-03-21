//
//  AUVDevsViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHTabsViewController.h"
#import "AUVDetailViewController.h"

typedef enum {
    AUVTYPEDEVELOPER =1,
    AUVTYPECATEGORY,
    AUVTYPEPROFILE,
    AUVFBPROFILE
} AUVViewType;

@class AUVDetailViewController;
@interface AUVDevsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BHTabsViewControllerDelegate>

{
    
       
     BHTabsViewController *tabController;
     AUVViewType type;
   NSString *userId;
    NSString *categoryId;
    NSString *developerId;
    NSString *developer;
    NSString *category;
    NSString *uid;

    NSInteger follow;
    NSMutableArray *contents;
      NSMutableArray *contents1;
    
    UIButton *addyourquestion;
    UILabel *questionlabel;
    
    IBOutlet UILabel *name;
    IBOutlet UILabel *followers;
    IBOutlet UILabel *questions;
    
    IBOutlet UIButton *followingbutton;
    
    IBOutlet UILabel *following;
    IBOutlet UILabel *userName;
    IBOutlet UILabel *website;
    IBOutlet UIImageView *icon;
    UITableView *questionsTable;
    UIBarButtonItem *followBtn;
    NSInteger start;
    
    
    IBOutlet UIButton *adddiscussion;
   // IBOutlet
}
@property (strong,nonatomic) UITableView *questionsTable;
@property(nonatomic,assign)AUVViewType type;
@property(nonatomic,strong) NSString *userId;
@property (nonatomic,strong) AUVDetailViewController *detailController;
@property(nonatomic,strong)NSString *uid;
@property (nonatomic,strong) NSString *developer;
@property(nonatomic,strong) NSString *category;
@property (nonatomic,assign) NSInteger follow;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *followers;
@property (nonatomic,strong) UILabel *questions;
@property(nonatomic,strong)  UILabel *following;
@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,strong) UILabel *website;
@property (nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) NSString *developerId;
@property(nonatomic,strong) NSString *categoryId;
@property(nonatomic)NSInteger start;
-(void)reload;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(AUVViewType)vType;
@end
