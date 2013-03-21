//
//  AUVSearchViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "StyledPullableView.h"
#import "AUVSearchBar.h"
#import "SDSegmentedControl.h"
typedef enum
{
    LoggedIn,
    NotLoggedIn,
    Menu
    
}SearchType;
@interface AUVSearchViewController : UIViewController<PullableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *resultView;
    UISearchBar *searchBar;
    NSMutableArray *dataArray;
    NSString *searching;
    NSString *page;
    StyledPullableView *pullDownView;
    NSMutableDictionary *filterDic;
    NSMutableDictionary *filterContent;
    UISearchDisplayController *searchController;
    NSMutableArray *sugArray;
    
    IBOutlet SDSegmentedControl *segmentedControl;
    NSMutableDictionary *filters;
    BOOL loadMore;
    
    IBOutlet UIActivityIndicatorView *progress;

}

@property (strong,nonatomic) UITableView *resultView;
@property(strong,nonatomic) NSString *searching;
@property(assign,nonatomic) NSInteger type;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;
@property(nonatomic,strong) NSMutableDictionary *filterDic;
@property(nonatomic,retain) NSMutableDictionary *filterContent;
@property(nonatomic,retain) UISearchDisplayController *searchController;


@end
