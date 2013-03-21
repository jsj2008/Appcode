//
//  AUVAddQuestionViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 25/10/12.
//
//

#import <UIKit/UIKit.h>

@interface AUVAddQuestionViewController : UIViewController
{
    IBOutlet UITextView *titleTextFields;
    IBOutlet UITextField *appTextFields;
    IBOutlet UITextView *questionTextView;
    IBOutlet UIButton *submitButton;
    IBOutlet UIButton *choosetopicButton;
    IBOutlet UIScrollView *scrollview;
    
    UITableView *sugtableview;
    
    NSString *questiontype;
    NSMutableArray *sugArray;
    
    NSString *appid;
    
    UISearchDisplayController *searchController;
    UISearchBar *searchBar;
    
    NSString *apptitle;
    
    

}
@property(nonatomic,strong) NSString *questiontype;
@property(nonatomic,strong) NSString *appid;
@property(nonatomic,strong) NSString *apptitle;
@property(nonatomic,retain) UISearchDisplayController *searchController;

@end
