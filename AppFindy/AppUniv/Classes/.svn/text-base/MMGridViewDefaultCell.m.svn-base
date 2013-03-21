//
// Copyright (c) 2010-2011 René Sprotte, Provideal GmbH
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "MMGridViewDefaultCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MMGridViewDefaultCell

@synthesize textLabel;
@synthesize textLabelBackgroundView;
@synthesize backgroundView;
@synthesize baseContainer;
@synthesize iconImage;
- (void)dealloc
{
    [textLabel release];
    [iconImage release];
    [textLabelBackgroundView release];
    [backgroundView release];
    [baseContainer release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) {
        // Background view
        self.backgroundView = [[[UIView alloc] initWithFrame:CGRectNull] autorelease];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        /*self.baseContainer=[[[UIView alloc] initWithFrame:CGRectNull] autorelease];
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
        [self addSubview:self.backgroundView];*/
        
        self.iconImage=[[[UIImageView alloc] initWithFrame:CGRectNull] autorelease];
        [self.backgroundView addSubview:self.iconImage];
        
        self.backgroundColor=[UIColor whiteColor];
        // Label
        self.textLabelBackgroundView = [[[UIView alloc] initWithFrame:CGRectNull] autorelease];
      //  self.textLabelBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        self.textLabel = [[[UILabel alloc] initWithFrame:CGRectNull] autorelease];
        self.textLabel.textAlignment = UITextAlignmentCenter;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont fontWithName:AUVBoldFont size:15];
        self.textLabel.numberOfLines = 2;
        self.textLabel.lineBreakMode=UILineBreakModeWordWrap;

        [self.backgroundView addSubview:self.textLabel];
        [self addSubview:self.textLabelBackgroundView];
    }
    
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
    
    
    self.iconImage.frame=CGRectMake(40, 10, 70, 70);
    
    // Layout label
    self.textLabelBackgroundView.frame = CGRectMake(0, 
                                                    self.bounds.size.height - labelHeight - inset, 
                                                    self.bounds.size.width, 
                                                    labelHeight);
    self.textLabelBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Layout label background
    CGRect f = CGRectMake(0, 
                          34,
                          self.textLabel.superview.bounds.size.width,
                          self.textLabel.superview.bounds.size.height);
    self.textLabel.frame = CGRectInset(f, inset, 0);
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    }

@end
