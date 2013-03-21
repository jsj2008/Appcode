//
//  AUVAnswerViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/09/12.
//
//

#import <UIKit/UIKit.h>
#import "UATitledModalPanel.h"
#import "AUVCommentsViewController.h"
#import "AUVwebservice.h"
#import "AUVLogin.h"
#import "AUVQuestionViewController.h"
typedef enum {
    TypeANS=0,
    TypeQn,
    TypeCmt,
    TypeCatQn
}ansType;
@interface AUVAnswerViewController : UATitledModalPanel<UIScrollViewDelegate>
{
    IBOutlet UITextView *textView;
    IBOutlet UITextView *textViewtitle;
    IBOutlet UIView *view;
    IBOutlet UIButton *actionBtn;
    id parent;
    AUVQuestionViewController *questionView;
    NSString *questionId;
    
    IBOutlet UIScrollView *baseScroll;
    
  
}
@property(nonatomic,strong)id parent;
@property(nonatomic,strong)NSString *questionId;
@property(nonatomic,strong) AUVQuestionViewController *questionView;

-(id)initWithFrame:(CGRect)frame withType:(ansType)type;
@end
