//
//  AUVCustomTabbar.h
//  AppUniv
//
//  Created by Innoppl Technologies on 09/11/12.
//
//

#import <UIKit/UIKit.h>
#import "MKNumberBadgeView.h"
#import "AUVConstants.h"
@protocol ButtonActionDelegate

@required
-(void)btnTap:(UIButton*)buttonId;

@end


@interface AUVCustomTabbar : UIView<UINavigationControllerDelegate,UIScrollViewDelegate>{
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    UIButton *button5;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    MKNumberBadgeView *nb;
    UIToolbar *tools;
    UIScrollView *scrollView;
    id<ButtonActionDelegate> delegate;

}
@property(retain)id delegate;
@property(nonatomic,retain) UIButton *button1;
@property(nonatomic,retain) UIButton *button2;
@property(nonatomic,retain) UIButton *button3;
@property(nonatomic,retain) UIButton *button4;
@property(nonatomic,retain) UIButton *button5;
@property(nonatomic,retain) MKNumberBadgeView *nb;
@property(nonatomic,retain)UILabel *label1;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,retain)UILabel *label3;
@property(nonatomic,retain)UILabel *label4;
@property(nonatomic,retain)UILabel *label5;
@property(nonatomic,retain)UIScrollView *scrollView;



@end
