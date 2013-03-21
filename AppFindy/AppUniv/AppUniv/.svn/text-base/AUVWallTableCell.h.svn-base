//
//  AUVWallTableCell.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUVTextView.h"
#import "AUVLabel.h"

typedef enum {
    AppFollow=1,
    AppComment,
    AppLiked,
    RaiseQuestion,
    QuestionFollow,
    QuestionComment,
    QuestionLike,
    AppShare=10,
    QuestionShare=11
    
    
    
}CellType;

@interface AUVWallTableCell : UITableViewCell
{
    IBOutlet UIImageView *sharedUserIcon;
    IBOutlet UILabel *sharedUser;
    IBOutlet UILabel *sharedTime;
    IBOutlet UIImageView *appImage;
    IBOutlet UILabel *noOfLikes;
    IBOutlet UIButton *likeBtn;
    IBOutlet UILabel *noOfComments;
    IBOutlet UIButton *commentBtn;
    IBOutlet UILabel *appName;
    IBOutlet UIImageView *appIcon;
    IBOutlet UILabel *message;
    IBOutlet UIView *appContainer;
    IBOutlet UIView *questionContainer;
    IBOutlet AUVLabel *QuestionView;
    IBOutlet UIButton *suggest;
    IBOutlet UIButton *suggest1;
   
    
    IBOutlet UIButton *questionansimg;
    IBOutlet UILabel *questionanscount;
    IBOutlet UIButton *questionlikeimg;
    IBOutlet UILabel *questionlikecount;
    IBOutlet UIImageView *questionappimg;
    IBOutlet UILabel *questionappname;
    
    
    IBOutlet UILabel *appfollowercount;
    IBOutlet UILabel *questionfollowercount;
    
    IBOutlet UIButton *appfollowerbutton;
    IBOutlet UIButton *questionfollowerbutton;
    
    IBOutlet UIButton *profileview;
    
    IBOutlet UIView *questionroundedview;
      IBOutlet UIView *lineview;
    
    
    
    
    
    CellType type;
}

@property (strong,nonatomic) UIImageView *questionappimg;
@property (strong,nonatomic) UILabel *questionanscount;
@property (strong,nonatomic) UILabel *questionlikecount;
@property (strong,nonatomic) UILabel *questionappname;
@property (strong,nonatomic) UIButton *questionansimg;
@property (strong,nonatomic) UIButton *questionlikeimg;
@property (strong,nonatomic) UIButton *profileview;

@property (strong,nonatomic) UIImageView *sharedUserIcon;
@property (strong,nonatomic) UILabel *sharedUser;
@property (strong,nonatomic) UILabel *sharedTime;
@property(strong,nonatomic) UIImageView *appImage;
@property (strong,nonatomic) UILabel *noOfLikes;
@property (strong,nonatomic) UIButton *likeBtn;
@property (strong,nonatomic) UILabel *noOfComments;
@property (strong,nonatomic) UIButton *commentBtn;
@property (strong,nonatomic) UILabel *appName;
@property (assign,nonatomic) CellType type;
@property (strong,nonatomic) UIImageView *appIcon;
@property(strong,nonatomic) UILabel *message;
@property(strong,nonatomic)  UIView *appContainer;
@property(strong,nonatomic)  UIView *questionContainer;
@property(strong,nonatomic)  UIView *questionroundedview;
@property(strong,nonatomic)  UIView *lineview;
@property (strong,nonatomic) AUVLabel *QuestionView;
@property(strong,nonatomic) UIButton *suggest;
@property(strong,nonatomic) UIButton *suggest1;

@property(strong,nonatomic) UIButton *appfollowerbutton;
@property(strong,nonatomic) UIButton *questionfollowerbutton;
@property(strong,nonatomic) UILabel *appfollowercount;
@property(strong,nonatomic) UILabel *questionfollowercount;
@property(strong,nonatomic) IBOutlet UIView *baseView;


+ (AUVWallTableCell *)cellFromNibNamed:(NSString *)nibName;

@end
