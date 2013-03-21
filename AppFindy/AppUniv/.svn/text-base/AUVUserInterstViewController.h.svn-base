//
//  AUVUserInterstViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 10/10/12.
//
//

#import <UIKit/UIKit.h>
typedef enum{
    iPhone=0,
    Android
}InterstType;

@interface AUVUserInterstViewController : UIViewController
{
    NSMutableArray *categoryArray;
    UITableView *tableview;
  
    
}
@property(nonatomic,strong) IBOutlet UITableView *tableview;
@property(nonatomic,strong) NSString *st;
@property(nonatomic,assign) InterstType type;

-(void)reload;
@end
