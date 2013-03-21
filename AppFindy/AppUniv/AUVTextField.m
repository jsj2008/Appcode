//
//  AUVTextField.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 08/10/12.
//
//

#import "AUVTextField.h"

@implementation AUVTextField

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
    self.font = [UIFont fontWithName:AUVRegularFont size:self.font.pointSize];
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
