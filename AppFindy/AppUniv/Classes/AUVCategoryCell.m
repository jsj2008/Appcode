//
//  AUVCategoryCell.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 22/08/12.
//
//

#import "AUVCategoryCell.h"

@implementation AUVCategoryCell

@synthesize textLabel;
@synthesize textLabelBackgroundView;
@synthesize backgroundView;
@synthesize baseContainer;
@synthesize iconImage;
@synthesize checked;
@synthesize image;
@synthesize categoryId;
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        // Background view
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectNull];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        /*self.baseContainer=[[[UIView alloc] initWithFrame:CGRectNull] autorelease];
         self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
         [self addSubview:self.backgroundView];*/
        
        self.iconImage=[[UIImageView alloc] initWithFrame:CGRectNull];
        [self.backgroundView addSubview:self.iconImage];
        
        self.backgroundColor=[UIColor whiteColor];
        // Label
        self.textLabelBackgroundView = [[UIView alloc] initWithFrame:CGRectNull];
        //  self.textLabelBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectNull];
        self.textLabel.textAlignment = UITextAlignmentCenter;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont fontWithName:AUVBoldFont size:13];
        self.textLabel.numberOfLines = 2;
        self.textLabel.lineBreakMode=UILineBreakModeWordWrap;
       
        [self.backgroundView addSubview:self.textLabel];
        [self addSubview:self.textLabelBackgroundView];
    }
     self.checked=NO;
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int labelHeight = 40;
    int inset = 5;
    
    // Background view
    self.backgroundView.frame = CGRectMake(3, 3, self.bounds.size.width-6, self.bounds.size.height-6);//self.bounds;
    self.backgroundView.layer.borderWidth=2.0f;
    self.backgroundView.layer.borderColor=[UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    self.iconImage.frame=CGRectMake(8, 8, 80, 60);
    
   // self.iconImage.center=self.center;
    // Layout label
    self.textLabelBackgroundView.frame = CGRectMake(0,
                                                    self.bounds.size.height - labelHeight - inset,
                                                    self.bounds.size.width,
                                                    labelHeight);
    self.textLabelBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Layout label background
    CGRect f = CGRectMake(0,
                          30,
                          self.textLabel.superview.bounds.size.width,
                          self.textLabel.superview.bounds.size.height);
    self.textLabel.frame = CGRectInset(f, inset, 0);
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
   // self.iconImage.center=CGPointMake(self.textLabel.center.x, self.textLabel.frame.origin.y+6);
    self.textLabel.font=[UIFont systemFontOfSize:13];
}



-(void)selectedCell
{
   
    //NSLog(@"checked ");
    
    if(self.checked)
    {
    //self.backgroundView.backgroundColor=[UIColor colorWithRed:128 green:0 blue:128 alpha:0.9];
       // self.backgroundView.backgroundColor=[UIColor colorWithRed:135 green:196 blue:250 alpha:0.9];//[UIColor colorWithRed:0 green:10 blue:215 alpha:0.9];
        
       self.backgroundView.backgroundColor=[UIColor colorWithRed:222.0f/255.0f green:223.0f/255.0f blue:227.0f/255.0f alpha:1.0f];
        self.checked=NO;
    }
    else if(!self.checked)
    {
        self.backgroundView.backgroundColor=[UIColor whiteColor];
        self.checked=YES;
    }
}

@end
