//
//  TXAlertViewWithField.h
//  taxi
//
//  Created by Jagadeesh Deivasigamani on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TXForgotPass 0
#define TXChangePass 1
@interface TXAlertViewWithField : UIAlertView <UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *textField;
    
    UITextField *opField;
    UITextField *npField;
    UITextField *vpField;
    UITableView *tableView;
}
@property(strong,nonatomic) UITextField *textField;
@property(strong,nonatomic) UITextField *opField;
@property(strong,nonatomic) UITextField *npField;
@property(strong,nonatomic) UITextField *vpField;
@property(strong,nonatomic) UITableView *tableView;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles type:(NSInteger) type;

@end
