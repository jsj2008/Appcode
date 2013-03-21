//
//  TXAlertViewWithField.m
//  taxi
//
//  Created by Jagadeesh Deivasigamani on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TXAlertViewWithField.h"
#import <QuartzCore/QuartzCore.h>

@implementation TXAlertViewWithField
@synthesize textField,opField,npField,vpField,tableView;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles type:(NSInteger) type{
    
	if ((self = [super initWithTitle:title message:@"\n\n\n" delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil])) {
		// FIXME: This is a workaround. By uncomment below, UITextFields in tableview will show characters when typing (possible keyboard reponder issue).
        if(type==TXForgotPass){
    
        textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 60, 256, 30)];
        textField.borderStyle=UITextBorderStyleRoundedRect;
        textField.placeholder=@"Please enter the email ID";
		[self addSubview:self.textField];
        }
        else if(TXChangePass)
        {
            [self addSubview:self.opField];
            
            tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;		
            tableView.scrollEnabled = NO;
            tableView.opaque = NO;
            tableView.layer.cornerRadius = 3.0f;
            tableView.editing = YES;
            tableView.rowHeight = 28.0f;
            self.center = CGPointMake(160.0f, (460.0f - 216.0f)/2 + 12.0f);
			self.tableView.frame = CGRectMake(12.0f, 51.0f, 260.0f, 56.0f);	
            [self addSubview:tableView];
        }
		
        
		/*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];        
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];*/
	}
	return self;
}




#pragma mark Accessors

- (UITextField *)oldPasswordField {
    
	if (!opField) {
		opField = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 255.0f, 28.0f)];
		opField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		opField.clearButtonMode = UITextFieldViewModeWhileEditing;
        opField.secureTextEntry = YES;
		opField.placeholder = @"Old Password";
	}
	return opField;
}

- (UITextField *)newPassField {
	
	if (!npField) {
		npField = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 255.0f, 28.0f)];
		npField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		npField.secureTextEntry = YES;
		npField.clearButtonMode = UITextFieldViewModeWhileEditing;
		npField.placeholder = @"New Password";
	}
	return npField;
}

- (UITextField *)verifyPassField {
	
	if (!vpField) {
		vpField = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 255.0f, 28.0f)];
		vpField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		vpField.secureTextEntry = YES;
		vpField.clearButtonMode = UITextFieldViewModeWhileEditing;
		vpField.placeholder = @"Retype New Password";
	}
	return npField;
}


#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *AlertPromptCellIdentifier = @"TXAlertCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tView dequeueReusableCellWithIdentifier:AlertPromptCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AlertPromptCellIdentifier];
    }
	
	if (![cell.contentView.subviews count]) {
		if (indexPath.row==0) {
			[cell.contentView addSubview:[self oldPasswordField]];			
		} else if (indexPath.row==1)  {
			[cell.contentView addSubview:[self newPassField]];
		}	
        else if (indexPath.row==2)  {
			[cell.contentView addSubview:[self verifyPassField]];
		}	
	}
    return cell;	
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}


@end
