//
//  AUVSearchCellCell.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUVSearchCellCell : UITableViewCell

{
    IBOutlet UIImageView *appIcon;
    IBOutlet UILabel *appName;
    IBOutlet UILabel *price;
    IBOutlet UILabel *rating;
    IBOutlet UIImageView *appImg;
    IBOutlet UILabel *noOfComments;
    IBOutlet UILabel *noOfLikes;
    IBOutlet UILabel *noOfShares;
    IBOutlet UIButton *details;
    IBOutlet UIButton *downloadBtn;
    
    IBOutlet UIImageView *star1;
     IBOutlet UIImageView *star2;
    IBOutlet UIImageView *star3;
    IBOutlet UIImageView *star4;
     IBOutlet UIImageView *star5;
    
}

@property(nonatomic,strong)UIImageView *appIcon;
@property(nonatomic,strong) UILabel *appName;
@property(nonatomic,strong) UILabel *price;
@property(nonatomic,strong) UILabel *rating;
@property(nonatomic,strong) UIImageView *appImg;
@property(nonatomic,strong) UILabel *noOfComments;
@property(nonatomic,strong) UILabel *noOfLikes;
@property(nonatomic,strong) UILabel *noOfShares;
@property(nonatomic,strong) UIButton *downloadBtn;
@property(nonatomic,strong) UIButton *details;
@property(nonatomic,strong) UIImageView *star1;
@property(nonatomic,strong) UIImageView *star2;
@property(nonatomic,strong) UIImageView *star3;
@property(nonatomic,strong) UIImageView *star4;
@property(nonatomic,strong) UIImageView *star5;

@end
