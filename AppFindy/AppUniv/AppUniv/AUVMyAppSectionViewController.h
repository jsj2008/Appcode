//
//  AUVMyAppSectionViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/11/12.
//
//

#import <UIKit/UIKit.h>
#import "AUVConstants.h"
#import <iHasApp/iHasApp.h>
@interface AUVMyAppSectionViewController : UIViewController
{
    
    IBOutlet UILabel *processstext;
    IBOutlet UIActivityIndicatorView *progressview;
    
    iHasApp *appEngine;
    NSArray *detectedApps;
    
    IBOutlet UITableView *myappstableview;
    
    IBOutlet UILabel *myappscount;
    
    NSMutableArray *myappslist;
    NSString *myappspageposition;
}
@property(nonatomic,retain)NSString *myappspageposition;

@end
