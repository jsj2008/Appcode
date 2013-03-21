//
//  AUVSnatchView.h
//  AppUniv
//
//  Created by Innoppl Technologies on 24/02/13.
//
//

#import <UIKit/UIKit.h>

@protocol ButtonClickDelegate
@required
-(void)btnView:(UIButton*)buttonId;

@end


@interface AUVSnatchView : UIView{
    UIButton *signInBtn;
    UIButton *newUserBtn;
    id<ButtonClickDelegate> delegate;
}
@property(retain)id delegate;

@end
