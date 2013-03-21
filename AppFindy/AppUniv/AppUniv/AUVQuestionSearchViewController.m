//
//  AUVQuestionSearchViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 02/11/12.
//
//

#import "AUVQuestionSearchViewController.h"
#import "AUVSearchCellCell.h"
#import "JSON.h"
#import "DYRateView.h"
#import "AUVConstants.h"

#import "AUVDetailViewController.h"
#import "AUVAppWallController.h"
#import "AUVAppDelegate.h"
#import "UIViewController+Transitions.h"
#import "AUVFilterViewController.h"
#import "NSString+ParamHandling.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPRequestOperation.h"
#import "SVProgressHUD.h"
#import "AUVQuestionViewController.h"

@interface AUVQuestionSearchViewController ()

@end

@implementation AUVQuestionSearchViewController

NSInteger segType;
int tableviewplace=0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    questionArray=[[NSMutableArray alloc] init];
    sugArray=[[NSMutableArray alloc] init];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
}

- (void)viewDidUnload

{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)sBar
{
 
    searching=sBar.text;
    
    searchbar.text=searching;
    [self searchforText:searching];
    
    
    [sBar resignFirstResponder];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString*)processText:(NSString*)string
{
    NSArray *arr=[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(arr.count>1)
        
        return [arr  componentsJoinedByString:@"+"];
    else return string;
}

-(void)searchforText:(NSString*)str
{
  
  
    if (questionArray.count==0) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        start=0;
    }else{
        start+=10;
    }
    tableviewplace=1;
    
    NSURL *url;

        url=[NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/question/select?wt=json&sort=sort_date+desc&q=%@",[self processText:str]]];

    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
        AFHTTPRequestOperation *operation=  [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *dict=[operation.responseString JSONValue];
   
       
        [questionArray removeAllObjects];
        
        [questionArray addObjectsFromArray:[[dict valueForKey:@"response"] valueForKey:@"docs"] ];

  
        
        [SVProgressHUD dismiss];
        
       
        [resultView reloadData];
            
           
        return ;
        
       
        
       
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
                                          
        }
     ];
    
    [operation start];
    
    
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 

    if(tableviewplace==0)
    {
      return sugArray.count;  
    }else if(tableviewplace==1)
    {
        return questionArray.count;
    }else
        return 0;;
   }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell=nil;
    
    

            
            static NSString *identifier = @"defaultcell";
            cell = [resultView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.font=[UIFont systemFontOfSize:16];
        if(tableviewplace==1)
        {
            if(questionArray.count>0){
                cell.textLabel.textColor=[UIColor blackColor];
                
                cell.textLabel.numberOfLines=3;
                cell.textLabel.text=[[questionArray objectAtIndex:indexPath.row] valueForKey:@"question"];
               
            }
            
            else{
                
                cell.textLabel.text=@"No results found";
            }
            
            UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, cell.textLabel.frame.origin.y+cell.textLabel.frame.size.height+5, 320, 2)];
            line.image=[UIImage imageNamed:@"seprater"];
            //[cell addSubview:line];
            
        }else
        {
            if(sugArray.count>0){
                cell.textLabel.textColor=[UIColor blackColor];
                
                cell.textLabel.numberOfLines=3;
                cell.textLabel.text=[sugArray objectAtIndex:indexPath.row];
                
            }
            
            else{
                
                cell.textLabel.text=@"No results found";
            }
            

        }
    return cell;
        }


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if(tableviewplace==1)
    {
            AUVQuestionViewController *question=[[AUVQuestionViewController alloc] initWithNibName:@"AUVQuestionViewController" bundle:nil];
            question.questionId=[NSString stringWithFormat:@"%@",[[questionArray objectAtIndex:indexPath.row] valueForKey:@"question_id"]];
       
            
            [self.navigationController pushViewController:question animated:YES];
    }else
    {
        [searchbar resignFirstResponder];
        searchbar.text=[sugArray objectAtIndex:indexPath.row];
        tableviewplace=1;
        [self searchforText:[sugArray objectAtIndex:indexPath.row]];
    }
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    tableviewplace=0;
    
    NSString *s=[searchbar.text stringByAppendingFormat:@"%@",text];
    
    [self performSelectorInBackground:@selector(loadSuggestionList:) withObject:s];
    
    return  YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //MyUISearchBar *sBar = (MyUISearchBar *)searchBar;
    [searchbar setShowsCancelButton:YES];
    // [searchBar setCloseButtonTitle:@"Cancel" forState:UIControlStateNormal];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchbar resignFirstResponder];
    
    // shareItemName =newSearchBar.text;
    //[self dis]
    
  //  [self dismissModalViewControllerAnimated:YES];
    
    // AUVAddQuestionViewController *obj=[[AUVAddQuestionViewController alloc]initWithNibName:@"AUVAddQuestionViewController" bundle:nil];
    //[self.view addSubview:obj];
    
}


-(void)loadSuggestionList:(NSString*)str
{
    //if(str.length<3)return;
    [AFHTTPRequestOperation cancelPreviousPerformRequestsWithTarget:self];
    NSURL *url;
  
       url=[NSURL URLWithString:[NSString stringWithFormat:@"http://approot:Ate3A9e*@appfindee.com:9264/solr/question/suggest?wt=json&sort=sort_date+desc&q=%@",[[self processText:str]lowercaseString]]];
 
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation=  [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [sugArray removeAllObjects];
        
        NSDictionary *dict=[operation.responseString JSONValue];
        
        NSLog(@"%@",dict);
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        if([[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"]count]==2)
        for(int i=0;i<[[[[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"] objectAtIndex:1]valueForKey:@"suggestion"]count];i++)
        {
            ;
            
            [arr addObject:[[[[[dict valueForKey:@"spellcheck"]valueForKey:@"suggestions"] objectAtIndex:1]valueForKey:@"suggestion"]objectAtIndex:i]];
            
        }
        
        
        if(arr.count!=0)
            [sugArray addObjectsFromArray:arr];

        
        [resultView reloadData];
        
}
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          
                                          
    }
     ];
    
    [operation start];
    
    
}




/*
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 40;

}
*/



@end
