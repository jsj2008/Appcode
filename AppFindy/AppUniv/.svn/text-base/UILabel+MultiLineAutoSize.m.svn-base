//
//  UILabel+MultiLineAutoSize.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/09/12.
//
//

#import "UILabel+MultiLineAutoSize.h"

@implementation UILabel (MultiLineAutoSize)

- (void)adjustFontSizeToFit
{
    UIFont *font = self.font;
    CGSize size = self.frame.size;
    
    for (CGFloat maxSize = self.font.pointSize; maxSize >= self.minimumFontSize; maxSize -= 1.f)
    {
        font = [font fontWithSize:maxSize];
        CGSize constraintSize = CGSizeMake(size.width, MAXFLOAT);
        CGSize labelSize = [self.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        if(labelSize.height <= size.height)
        {
            self.font = font;
            [self setNeedsLayout];
            break;
        }
    }
    // set the font to the minimum size anyway
    self.font = font;
    [self setNeedsLayout];
}


-(void) adjustHeightToFit
{
    CGFloat constrainedWidth = 300.0f;//YOU CAN PUT YOUR DESIRED ONE,THE MAXIMUM WIDTH OF YOUR LABEL.
    //CALCULATE THE SPACE FOR THE TEXT SPECIFIED.
    CGSize sizeOfText=[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(constrainedWidth, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,constrainedWidth,sizeOfText.height);
   // messageLabel.text=yourText;
    self.numberOfLines=100;
}
@end
