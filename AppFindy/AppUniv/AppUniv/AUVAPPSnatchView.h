//
//  AUVAPPSnatchView.h
//  AppUniv
//
//  Created by Innoppl Technologies on 27/02/13.
//
//

#import <UIKit/UIKit.h>
@protocol SnatchidDelegate <NSObject>

@optional
-(void)snatchValues:(id)tagValue use:(NSString*)appuserid;
-(void)ShareBtnValue:(UIButton*)butTagVal;
@end

@interface AUVAPPSnatchView : UIView{
    int butTagValuefun;
    id<SnatchidDelegate> delegate;
}
@property(nonatomic,assign)int butTagValuefun;
@property(retain)id delegate;

@end
