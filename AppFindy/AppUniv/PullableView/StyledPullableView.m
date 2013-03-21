
#import "StyledPullableView.h"

/**
 @author Fabio Rodella fabio@crocodella.com.br
 */

@implementation StyledPullableView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
       UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
        imgView.frame = CGRectMake(300,frame.size.height-30,30, 60);
        imgView.clipsToBounds=YES;
        [self addSubview:imgView];
        
        [imgView release];
        self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}

@end
