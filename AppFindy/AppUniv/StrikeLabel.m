//
//  StrikeLabel.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 01/12/12.
//
//

#import "StrikeLabel.h"

@implementation StrikeLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    const CGFloat* colors = CGColorGetComponents(self.textColor.CGColor);
    
    CGContextSetRGBStrokeColor(ctx, colors[1], colors[0], colors[0], 1.0); // RGBA
    
    CGContextSetLineWidth(ctx, 1.0f);
    
    CGSize tmpSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(200, 9999)];
    
    CGContextMoveToPoint(ctx, 0, self.bounds.size.height/2);
    CGContextAddLineToPoint(ctx, tmpSize.width, self.bounds.size.height/2);
    
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];  
}


@end
