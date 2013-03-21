//
//  AUVAskViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 13/12/12.
//
//

#import "AUVAskViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AUVLogin.h"
#import "SVProgressHUD.h"
#import "AUVwebservice.h"
#import "JSON.h"
#import "AUVDevsViewController.h"

@interface AUVAskViewController ()

@end

@implementation AUVAskViewController

@synthesize tableview,type,questionid;

int position;

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
    // Do any additional setup after loading the view from its nib.
    
    
    askarray=[[NSMutableArray alloc]init];
    suggestarray=[[NSMutableArray alloc]init];
    if (IS_IPHONE_5) {
        
        container.frame=CGRectMake(container.frame.origin.x,container.frame.origin.y,container.frame.size.width, container.frame.size.height+45);
        
    }
    tableview=[[UITableView alloc] initWithFrame:container.bounds style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource=self;
    
    [container addSubview:tableview];
   // tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.title=@"Ask People";
    
    [segmentedControl addTarget:self
                         action:@selector(action:)
               forControlEvents:UIControlEventValueChanged];
    
    [self loadAskansSuggest];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)action:(id)sender {
    
    
    if(segmentedControl.selectedSegmentIndex==0){
        
        type=ask;
    }
    else if(segmentedControl.selectedSegmentIndex==1)
    {
        type=suggest;
    }
    
    [self loadAskansSuggest];
}

-(void)loadAskansSuggest
{
    if(type==ask)
    {
        if(askarray.count==0)
        {
            [self userFollowersList];
        }
        else
        {
            [self.tableview reloadData];
        }
    }else if(type==suggest)
    {
        if(suggestarray.count==0)
        {
         [self suggestList];
        }
        else
        {
            [self.tableview reloadData];
        }
    }
}

-(void) suggestList
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    [service ask_user_suggestion:self action:@selector(suggestListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] question_id:questionid];
}


-(void)suggestListHandler:(id )value
{
    
    AUVArray *arr=(AUVArray*)value;
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    
    //NSLog(@"%@",[result JSONValue]);
    id jsResult=[[result JSONValue] valueForKey:@"user_details"];
    if([jsResult isKindOfClass:[NSArray class]])
    {
        [suggestarray removeAllObjects];
        [suggestarray addObjectsFromArray:jsResult];
    }
    
    [self.tableview reloadData];
    
}




-(void) userFollowersList
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    
    [service following_list:self action:@selector(userFollowersListHandler:) user_id:[AUVLogin valueforKey:@"user_id"] limit:@"0" offset:@"10"];
}


-(void)userFollowersListHandler:(id )value
{
    
    AUVArray *arr=(AUVArray*)value;
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    
    //NSLog(@"%@",[result JSONValue]);
    id jsResult=[[result JSONValue] valueForKey:@"user_details"];
    if([jsResult isKindOfClass:[NSArray class]])
    {
        [askarray removeAllObjects];
        [askarray addObjectsFromArray:jsResult];
    }
    
    [self.tableview reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(type==ask)
    {
        return askarray.count;
    }else if(type==suggest)
    {
        return suggestarray.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *identifier = @"TableCell";
    // UITableViewCell *cell=nil;
    UILabel *name;
    
    UIView *baseView;
    UILabel *fullName;
    UIImageView *icon;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	UIButton *followBtn;
	if(cell !=nil){
		cell=nil;
	}
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        // CGRectApplyAffineTransform(cell.bounds, rotateImage)
        baseView=[[UIView alloc] initWithFrame:cell.frame];
        
        baseView.backgroundColor=[UIColor clearColor];
        icon =[[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 48, 54)];
        
        icon.layer.cornerRadius=5.0f;
        icon.clipsToBounds=YES;
        
        
        name=[[UILabel alloc] initWithFrame:CGRectMake(60, 2, 100, 22)];
        name.font=[UIFont systemFontOfSize:12];
        name.textColor=[UIColor blueColor];
        name.backgroundColor=[UIColor clearColor];
        // name.textAlignment=UITextAlignmentCenter;
        
        followBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        followBtn.titleLabel.textColor=[UIColor whiteColor];
        followBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        followBtn.frame=CGRectMake(250, 10, 60, 30);
        [followBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn"] forState:UIControlStateNormal];
        
        fullName=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, 210, 22)];
        fullName.font=[UIFont systemFontOfSize:13];
        fullName.textColor=[UIColor grayColor];
        fullName.backgroundColor=[UIColor clearColor];
        //fullName.textAlignment=UITextAlignmentCenter;
        
        [baseView addSubview:icon];
        [baseView addSubview:name];
        [baseView addSubview:followBtn];
        [baseView addSubview:fullName];
        [cell addSubview:baseView];
        cell.backgroundColor=[UIColor clearColor];
    }
    
   
    
    if(type==ask)
    {
      [followBtn setTitle:@"Ask" forState:UIControlStateNormal];
       name.text=[NSString stringWithFormat:@"%@",[[askarray objectAtIndex:indexPath.row] valueForKey:@"firstname"]];
       fullName.text=[NSString stringWithFormat:@"%@ %@",[[askarray objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[askarray objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
         [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[askarray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }else if(type==suggest)
    {
        [followBtn setTitle:@"Ask" forState:UIControlStateNormal];
        name.text=[NSString stringWithFormat:@"%@",[[suggestarray objectAtIndex:indexPath.row] valueForKey:@"firstname"]];
        fullName.text=[NSString stringWithFormat:@"%@ %@",[[suggestarray objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[suggestarray objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
         [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[suggestarray objectAtIndex:indexPath.row] valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    [followBtn addTarget:self action:@selector(askandsuggest:) forControlEvents:UIControlEventTouchUpInside];
    
    followBtn.tag=indexPath.row;

   
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(type==ask)
    {
    AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
    profile.userId=[[askarray objectAtIndex:indexPath.row] valueForKey:@"user_id"];
    
    //if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
    profile.follow=1;
    
    [self.navigationController pushViewController:profile animated:YES];
    }
    else if(type==suggest)
    {
            AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
            profile.userId=[[suggestarray objectAtIndex:indexPath.row] valueForKey:@"user_id"];
            
            //if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
            profile.follow=1;
            
            [self.navigationController pushViewController:profile animated:YES];
        
    }
}


-(void)askandsuggest:(id)sender
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    position=[sender tag];
    
     //[service ask:self action:@selector(questionSuggesttofriendsHandler:) user_id:[AUVLogin valueforKey:@"user_id"] ref_user_id:[[askarray objectAtIndex:[sender tag]]valueForKey:@"user_id"] question_id:questionid];

    if(type==ask)
    {
        [service ask:self action:@selector(questionSuggesttofriendsHandler:) user_id:[AUVLogin valueforKey:@"user_id"] ref_user_id:[[askarray objectAtIndex:[sender tag]]valueForKey:@"user_id"] question_id:questionid];
    }else if(type==suggest)
    {
        
        [service ask:self action:@selector(questionSuggesttofriendsHandler:) user_id:[AUVLogin valueforKey:@"user_id"] ref_user_id:[[suggestarray objectAtIndex:[sender tag]]valueForKey:@"user_id"] question_id:questionid];
      //[service suggest:self action:@selector(questionSuggesttofriendsHandler:) user_id:[AUVLogin valueforKey:@"user_id"] ref_user_id:[[suggestarray objectAtIndex:[sender tag]] valueForKey:@"user_id"] a_id:questionid type:@"1"];
    }
}
-(void)questionSuggesttofriendsHandler:(id )value
{
    
    AUVArray *arr=(AUVArray*)value;
    //NSLog(@"Array : %@",arr);
    [SVProgressHUD dismiss];
    
    NSString *res=[NSString stringWithFormat:@"%@",arr];
    
    
    if ([res isEqualToString:@"1"]) {
        //NSLog(@"True");
    }else
    {
        //NSLog(@"False");
    }
    if(type==ask)
    {
    [askarray removeObjectAtIndex:position];
    }else if(type==suggest)
    {
        [suggestarray removeObjectAtIndex:position];
        
    }
    [self.tableview reloadData];
}


@end
