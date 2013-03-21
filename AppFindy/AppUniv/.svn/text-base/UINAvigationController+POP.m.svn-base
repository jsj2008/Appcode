//
//  UINAvigationController+POP.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 07/08/12.
//
//

#import "UINavigationController+POP.h"


@implementation UINavigationController (Extensions)



-(BOOL) popToViewControllerObject:(AUVDetailViewController*)obj{
    
   // UINavigationController *nav=self;
    for(UIViewController *vc in self.viewControllers)
    {
        if([vc isKindOfClass:[obj class]])
        {
            //NSLog(@"YES %@",[vc class]);
            [self popToViewController:vc animated:YES];
        }
        else
        {
            //NSLog(@"NO : %@  : %@",[vc class],self);
            //[self pushViewController:vc animated:YES];
        }
        
    }
    

return YES;
}

@end
