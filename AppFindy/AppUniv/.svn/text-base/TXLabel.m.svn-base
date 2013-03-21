//
//  TXLabel.m
//  taxi
//
//  Created by Jagadeesh Deivasigamani on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TXLabel.h"

@implementation TXLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:AUVBoldFont size:self.font.pointSize];
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

CGContextSetRGBStrokeColor(ctx, colors[0], colors[1], colors[2], 1.0); // RGBA

CGContextSetLineWidth(ctx, 1.0f);

CGSize tmpSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(200, 9999)];

CGContextMoveToPoint(ctx, 0, self.bounds.size.height - 3);
CGContextAddLineToPoint(ctx, tmpSize.width, self.bounds.size.height - 3);

CGContextStrokePath(ctx);

[super drawRect:rect];  
}

@end
