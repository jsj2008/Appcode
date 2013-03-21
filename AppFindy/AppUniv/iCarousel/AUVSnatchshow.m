//
//  AUVSnatchshow.m
//  AppUniv
//
//  Created by Innoppl Technologies on 26/02/13.
//
//

#import "AUVSnatchshow.h"

@implementation AUVSnatchshow
UIImageView *image;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        image =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deals_bg.png"]];
        image.frame =CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:image];
        
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

@end
