//
//  AUVCommentsViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 10/08/12.
//
//

#import <UIKit/UIKit.h>



typedef enum
{
   Comment=2,
    question=1
    
}CommentTypeComment;

@interface AUVCommentsViewController : UIViewController

{
    IBOutlet UITableView *commentsTable;
    NSString *appId;
    NSMutableArray *tableArray;
    CommentTypeComment type;
    NSString *categoryId;
    IBOutlet UIButton *comment;
     UIBarButtonItem *adddiscusstionorcomment;
}
@property(nonatomic,strong) NSString *appId;
@property (nonatomic,assign) CommentTypeComment type;
@property (strong,nonatomic) UITableView *commentsTable;

@property (nonatomic,strong) NSString *categoryId;
-(void)commentsAction:(NSString*)comment withArg2:(NSString*)apptitle;
@end
