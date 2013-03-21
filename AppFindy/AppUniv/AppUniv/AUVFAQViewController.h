//
//  AUVFAQViewController.h
//  AppUniv
//
//  Created by Innoppl technologies on 06/12/12.
//
//

#import <UIKit/UIKit.h>

@interface AUVFAQViewController : UIViewController

{
    IBOutlet UIWebView *faqwebview;
    
    NSString *pagevalue;
}

@property(nonatomic,retain)NSString *pagevalue;

@end
