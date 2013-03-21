//
//  AUVWallTableCell.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVWallTableCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation AUVWallTableCell

@synthesize sharedUserIcon,sharedUser,sharedTime,appImage,noOfLikes,likeBtn,noOfComments,commentBtn,appName,appIcon,type,message,appContainer,questionContainer,QuestionView,suggest,suggest1,questionanscount,questionansimg,questionappimg,questionappname,questionlikecount,questionlikeimg,questionfollowercount,questionfollowerbutton,appfollowerbutton,appfollowercount,baseView,lineview,questionroundedview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         
    }
    return self;
}

+ (AUVWallTableCell *)cellFromNibNamed:(NSString *)nibName {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    AUVWallTableCell *customCell = nil;
    NSObject* nibItem = nil;
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[AUVWallTableCell class]]) {
        
            customCell = (AUVWallTableCell *)nibItem;
            
            break; // we have a winner
        }
    }
    return customCell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *) reuseIdentifier {
    return [super reuseIdentifier];
}


@end
