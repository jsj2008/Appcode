//
//  SUBRearViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 11/10/12.
//
//

#import <UIKit/UIKit.h>

@interface SUBRearViewController : UITableViewController
{
    UITableView *tableView;
    IBOutlet UISearchBar *searchBar;
}
@property(nonatomic,strong) id parent;
@end
