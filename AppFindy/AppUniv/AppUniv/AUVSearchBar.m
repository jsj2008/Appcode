//
//  AUVSearchBar.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 25/09/12.
//
//

#import "AUVSearchBar.h"

@implementation AUVSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
   
    
    
 [super drawRect:rect];
}

//
//- (void)layoutSubviews
//{
//    UITextField *searchField;
//    
//    for(int i = 0; i < [self.subviews count]; i++)
//    {
//        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]])
//        {
//            searchField = [self.subviews objectAtIndex:i];
//        }
//    }
//    [super layoutSubviews];
//    if(!(searchField == nil))
//    {
//        searchField.frame = CGRectMake(50, 6, 220, 31);
//    }
//    
//    
//}
//


-(void)layoutSubviews
{
    [super layoutSubviews];
    UITextView * textField = [self.subviews objectAtIndex:1];
    textField.frame = CGRectMake(5, 6, (310 - 25), 31);
    
    
}
@end
