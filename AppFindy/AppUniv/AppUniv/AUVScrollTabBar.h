//
//  AUVScrollTabBar.h
//  AppUniv
//
//  Created by Innoppl Technologies on 21/02/13.
//
//

#import <UIKit/UIKit.h>
@protocol ButClickerDelegate

@required
-(void)btnTap:(UIButton*)btnSendValue;

@end


@interface AUVScrollTabBar : UIScrollView<UIScrollViewDelegate>{
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
    id<ButClickerDelegate> delegate;

}
@property(nonatomic,retain) UIButton *button1;
@property(nonatomic,retain) UIButton *button2;
@property(nonatomic,retain) UIButton *button3;
@property(nonatomic,retain) UIButton *button4;
@property(nonatomic,retain) UIButton *button5;
@property(nonatomic,retain) UILabel *label1;
@property(nonatomic,retain) UILabel *label2;
@property(nonatomic,retain) UILabel *label3;
@property(nonatomic,retain) UILabel *label4;
@property(nonatomic,retain) UILabel *label5;
@property(retain)id delegate;

@end
