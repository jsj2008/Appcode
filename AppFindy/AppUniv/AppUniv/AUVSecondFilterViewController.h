//
//  AUVSecondFilterViewController.h
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 02/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUVSecondFilterViewController : UIViewController
@property(strong,nonatomic)NSArray *tableArray;
@property(strong,nonatomic) NSString *categoryName;
@property(assign)NSMutableDictionary *dict;
@property(assign)id parent;
@end
