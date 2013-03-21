//
//  AUVAnswerViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 30/09/12.
//
//

#import "AUVAnswerViewController.h"
#import "JSON.h"
#import "SVProgressHUD.h"
@interface AUVAnswerViewController ()

@end

@implementation AUVAnswerViewController
@synthesize parent,questionId,questionView;

int validate=0;
UITextView *activeField;
-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        self.margin = UIEdgeInsetsMake( 10.0f,  10.0f, 10.0f,10.0f);
        
        // Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
        self.padding = UIEdgeInsetsMake(10.0f,  10.0f, 10.0f,10.0f);
        
        // Border color of the panel. Default = [UIColor whiteColor]
        //self.borderColor = [UIColor whiteColor];
        self.headerLabel.text=@"Answer";
        self.headerLabel.font=[UIFont boldSystemFontOfSize:18];
        // Border width of the panel. Default = 1.5f;
        self.borderWidth = 2.0f;
        
        // Corner radius of the panel. Default = 4.0f
        self.cornerRadius = 10;
        
        //self.backgroundColor=[UIColor whiteColor];
        // Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
        //self.contentColor = [UIColor colorWithRed:(arc4random() % 2) green:(arc4random() % 2) blue:(arc4random() % 2) alpha:1.0];
        
        // Shows the bounce animation. Default = YES
        self.shouldBounce = YES;
        
        // Shows the actionButton. Default title is nil, thus the button is hidden by default
        //[self.actionButton setTitle:@"Login" forState:UIControlStateNormal];
        //self.actionButton.userInteractionEnabled=NO;
        
      

                       
                
        NSString *nibName=@"AUVAnswerViewController";
                     
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        
        textViewtitle.layer.cornerRadius=10.0f;
        textViewtitle.layer.borderWidth=1.0f;
        
        textViewtitle.hidden=YES;

        
        textView.layer.cornerRadius=10.0f;
        textView.layer.borderWidth=1.0f;

          [actionBtn setTitle:@"Add Answer" forState:UIControlStateNormal];
        [self.contentView addSubview:view ];
        
        baseScroll.contentSize=CGSizeMake(0, 400);
        baseScroll.delegate=self;
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame withType:(ansType)type
{
    if(self=[super initWithFrame:frame]){
        
        self.margin = UIEdgeInsetsMake( 10.0f,  10.0f, 10.0f,10.0f);
        
        // Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
        self.padding = UIEdgeInsetsMake(10.0f,  10.0f, 10.0f,10.0f);
        
        // Border color of the panel. Default = [UIColor whiteColor]
        //self.borderColor = [UIColor whiteColor];
        self.headerLabel.text=@"Answer";
        // Border width of the panel. Default = 1.5f;
        self.borderWidth = 2.0f;
        
        // Corner radius of the panel. Default = 4.0f
        self.cornerRadius = 10;
        
        //self.backgroundColor=[UIColor whiteColor];
        // Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
        //self.contentColor = [UIColor colorWithRed:(arc4random() % 2) green:(arc4random() % 2) blue:(arc4random() % 2) alpha:1.0];
        
        // Shows the bounce animation. Default = YES
        self.shouldBounce = YES;
        
        // Shows the actionButton. Default title is nil, thus the button is hidden by default
        //[self.actionButton setTitle:@"Login" forState:UIControlStateNormal];
        //self.actionButton.userInteractionEnabled=NO;
    
        NSString *nibName=@"AUVAnswerViewController";
        
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        
        
        
        textViewtitle.layer.cornerRadius=10.0f;
        textViewtitle.layer.borderWidth=1.0f;
        
        textView.layer.cornerRadius=10.0f;
        textView.layer.borderWidth=1.0f;
        
        if(type==TypeCmt)
        {
            validate=1;
            textViewtitle.hidden=YES;
            
            [textView setText:@"Comment"];
            [textView setTextColor:[UIColor lightGrayColor]];
            
            [actionBtn setTitle:@"Add Comment" forState:UIControlStateNormal];
            self.headerLabel.text=@"Add Comment";
        }
        else if(type==TypeQn)
        {
            validate=2;
            textViewtitle.hidden=NO;
            [textViewtitle setText:@"Write your title here"];
            [textViewtitle setTextColor:[UIColor lightGrayColor]];
            
            [textView setText:@"Tell us the detail here"];
            [textView setTextColor:[UIColor lightGrayColor]];
            
            [actionBtn setTitle:@"Add Question" forState:UIControlStateNormal];
            self.headerLabel.text=@"Add Question";
        }else if(type==TypeCatQn)
        {
            validate=2;
            textViewtitle.hidden=NO;
            [textViewtitle setText:@"Write your title here"];
            [textViewtitle setTextColor:[UIColor lightGrayColor]];
            
            [textView setText:@"Tell us the detail here"];
            [textView setTextColor:[UIColor lightGrayColor]];
            
            [actionBtn setTitle:@"Add Question" forState:UIControlStateNormal];
            self.headerLabel.text=@"Add Question";

        }
        else
        {
            textViewtitle.hidden=YES;
            
            [textView setText:@"Answer"];
            [textView setTextColor:[UIColor lightGrayColor]];
            
        }

        [self.contentView addSubview:view ];
        
        baseScroll.contentSize=CGSizeMake(0, 400);
        baseScroll.delegate=self;
    }
    
   self.headerLabel.font=[UIFont boldSystemFontOfSize:18];
    
    return self;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [activeField resignFirstResponder];
}


- (void)textViewDidBeginEditing:(UITextView *)textview
{
    ////NSLog(@"test");
    
      activeField=textview;
    
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        
        baseScroll.contentOffset=CGPointMake(0,textview.frame.origin.y);
        
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    baseScroll.contentOffset=CGPointMake(0,0);
    
    
}




//- (BOOL)textFieldShouldReturn:(UITextView *)textField
/*- (BOOL)textViewShouldEndEditing:(UITextView *)textViews
{
    if (textViews==textViewtitle) {
        [textViews resignFirstResponder];
        [textView becomeFirstResponder];
    }
    else if (textViews==textView) {
        [textViews resignFirstResponder];
        
        // [self performSelectorInBackground:@selector(login:) withObject:nil];
    }
    [textViews resignFirstResponder];
    
    
    return YES;
}*/
- (BOOL)textView:(UITextView *)textview shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textview==textViewtitle)
    {
        if ([text isEqualToString:@"\n"])
        {
            [textViewtitle resignFirstResponder];
            [textView becomeFirstResponder];
            return NO;
        }
        else
        {
            return YES;
        }
    }
    if(textview==textView)
    {
        if ([text isEqualToString:@"\n"])
        {
            [textView resignFirstResponder];
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return YES;
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textview
{
    
    
    if(textview==textViewtitle)
    {
        if (textViewtitle.textColor == [UIColor lightGrayColor]) {
            textViewtitle.text = @"";
            textViewtitle.textColor = [UIColor blackColor];
        }
    }
    if(textview==textView)
    {
        if (textView.textColor == [UIColor lightGrayColor]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textview
{
    if(textview==textViewtitle)
    {
        if(textViewtitle.text.length == 0){
            textViewtitle.textColor = [UIColor lightGrayColor];
            textViewtitle.text = @"Write your title here";
            [textViewtitle resignFirstResponder];
        }
    }
    if(textview==textView)
    {
        if(textView.text.length == 0){
            if(validate==1)
            {
                textView.textColor = [UIColor lightGrayColor];
                textView.text = @"Comment";
                [textView resignFirstResponder];
            }
            else if(validate==2)
            {
               textView.textColor = [UIColor lightGrayColor];
               textView.text = @"Tell us the detail here";
               [textView resignFirstResponder];
        }
        }
    }
    
}
-(IBAction)answer:(id)sender
{
    if(parent){
        if(validate==1)
        {
            
           if(textView.text.length == 0||[textView.text isEqualToString:@"Comment"])
           {
               UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the comment." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alertView show];
           }else
           {
               [parent commentsAction:textView.text withArg2:textViewtitle.text];
               [self hide];
  
           }
        }
        else if(validate==2)
        {
            if(textView.text.length == 0||[textView.text isEqualToString:@"Tell us the detail here"])
            {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                
            }else if(textViewtitle.text.length == 0||[textViewtitle.text isEqualToString:@"Write your title here"])
            {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the title." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else
            {
                [parent commentsAction:textView.text withArg2:textViewtitle.text];
                [self hide];
            }
        }
       // [parent commentsAction:textView.text withArg2:textViewtitle.text];
        //[self hide];
    }
    else{
     //   AUVwebservice *service=[AUVwebservice service];
        if( textView.text.length == 0)
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the answer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
        }else
        {
            [self loadAnswers:sender];
        }
       // [service a]
    }
    
}



-(void)loadAnswers:(id)sender
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
   // service.logging=NO;
    [service answer:self action:@selector(loadAnswerHandler:) question_id:questionId user_id:[AUVLogin valueforKey:@"user_id"] comment:textView.text start:@"0" end:@"10"];
    
   // [service add_answer_point:self action:@selector(loadAnswerHandler:) user_id:<#(NSString *)#> answer_id:<#(NSString *)#> positive_negative:<#(NSString *)#>]
}


-(void)loadAnswerHandler:(id)value
{
    SoapArray *arr=(SoapArray*)value;
    ////NSLog(@"%@",arr);
    
    
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}

   // NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    ////NSLog(@"%@",[result JSONValue]);
    /*if(questionView)
    {
        [questionView.tableArray removeAllObjects];
        [questionView.tableArray addObjectsFromArray:[[result JSONValue] objectForKey:@"answer_details"]];
        
    }
    */
    else 
    [self hide];
    ////NSLog(@"%@",result);
    
    
}

-(void)hide
{
    [SVProgressHUD dismiss];
    [super hide];
    
}


@end
