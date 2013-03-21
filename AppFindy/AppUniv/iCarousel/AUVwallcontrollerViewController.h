//
//  AUVwallcontrollerViewController.h
//  AppUniv
//
//  Created by sathish kumar on 2/21/13.
//
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "AUVAppDelegate.h"

@interface AUVwallcontrollerViewController : UIViewController<iCarouselDataSource,iCarouselDelegate,UITextFieldDelegate>{
  
}
@property (nonatomic, retain) IBOutlet iCarousel *carousel;

-(UILabel*)customlabel:(NSString*)str initframe:(CGRect)frame totallines:(int)lines;
-(UILabel*)customdefinedlabel:(NSString*)str initframe:(CGRect)frame totallines:(int)lines;
-(NSString*) timeIntervalSinceDate:(NSString*)fromDate toTime:(NSString*)toDate;
-(NSString *)TimeRemainingUntilDate:(NSDate *)date;
@end
