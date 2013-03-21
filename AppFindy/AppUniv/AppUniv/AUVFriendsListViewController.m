//
//  AUVFriendsListViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 15/08/12.
//
//

#import "AUVFriendsListViewController.h"
#import <AddressBook/AddressBook.h>
#import "UIImageView+AFNetworking.h"
#import "AUVDevsViewController.h"
#import "AUVAppDelegate.h"
#import "AUVConstants.h"
#import "AUVwebService.h"
#import "JSON.h"
#import <MessageUI/MessageUI.h>
#import "SVProgressHUD.h"
@interface AUVFriendsListViewController ()

@end

@implementation AUVFriendsListViewController


UIView *baseCell;
UIImageView *imageV;
UILabel *userName;
UILabel *fullName;
UIButton *btn;
Facebook *fb;
NSMutableArray *auvFriends,*fbFriends;
int page;
@synthesize dataArray,type,searchTerm,tableArray,parent;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(AUVFriendListType)friendListype
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.type=friendListype;
    }
    return self;
}
- (void)viewDidLoad
{
    tableArray=[[NSMutableArray alloc] init];
    fbFriends=[[NSMutableArray alloc] init];
    auvFriends=[[NSMutableArray alloc] init];
    if(!dataArray) {dataArray=[[NSMutableArray alloc] init];
        
    }
    else
    {
        [tableArray addObjectsFromArray:dataArray];
    }
    self.navigationController.navigationBarHidden=NO;
    //self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];

    [super viewDidLoad];
    
    if(self.type==AUVSuggestionList)
    {
        __unsafe_unretained AUVFriendsListViewController *rec = self;
        [friendsTable addInfiniteScrollingWithActionHandler:^{
            
            
            [self performSelectorOnMainThread:@selector(whoToFollow:) withObject:nil waitUntilDone:NO];
            
            [friendsTable.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:10];
        }];

    }
    
    [tableSearch setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"]];
    
    
       
    //ABAddressBook *address=[ABAddressBook sharedAddressBook];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadData:nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
   
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableArray.count==0)
    {
        return 1;
    }else
    {
        return tableArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell  *cell=nil;
    if(tableArray.count!=0)
    {
    static NSString *identifier = @"defaultcell";
    cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell=nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
         CGRect rect =[cell bounds];
        baseCell=[[UIView alloc] initWithFrame:rect];
        
        imageV=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 64, 64)];
        imageV.layer.cornerRadius=10;
        imageV.layer.borderWidth=1.0;
        imageV.clipsToBounds=YES;
        userName=[[UILabel alloc] initWithFrame:CGRectMake(80, 7, 200, 30)];
        userName.backgroundColor=[UIColor clearColor];
        userName.textColor=[UIColor blackColor];
        userName.font=[UIFont systemFontOfSize:15];
        fullName=[[UILabel alloc] initWithFrame:CGRectMake(80, 55, 180, 30)];
        fullName.backgroundColor=[UIColor clearColor];
        
       
        fullName.textColor=[UIColor grayColor];
        fullName.font=[UIFont systemFontOfSize:15];
        
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, 80, 26);
    
      //  btn.backgroundColor=[UIColor colorWithPatternImage:[[UIImage imageNamed:@"blue_btn"]stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0]];
        
        
        
        
        [btn setBackgroundImage:[[UIImage imageNamed:@"blue_btn"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        
        // btn.titleLabel.textColor=[UIColor whiteColor];
         
                
        [baseCell addSubview:imageV];
        [baseCell addSubview:userName];
        [baseCell addSubview:fullName];
        
        [cell addSubview:baseCell];

        //[baseCell addSubview:btn];
    }
    NSString *usericon;
    
    if(self.type==AUVFBFriendList||self.type==AUVInviteFBFriends) usericon= @"usericon";
    else
        usericon=@"picture";
    
    NSString *urlString=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:usericon]];
   
    
    if([urlString length]==0)
    {
        urlString = @"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/41736_771863010_2112689660_t.jpg";
    }
    
    [imageV setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
   
    // cell.textLabel.text=@"Contacts";
    // cell.title2.text=@"Add friends from your contact list";
    
    
    userName.text=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"username"];//[NSString stringWithFormat:@"sathish89",indexPath.row];
       
    btn.tag=indexPath.row;

        NSString *fn=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]valueForKey:@"firstname"]];
        NSString *ln=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]valueForKey:@"lastname"]];
        NSString *full=[[NSString stringWithFormat:@"%@ %@",fn,ln] stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        
        
        
  //  if(!([[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]valueForKey:@"firstname"]] isEqualToString:@"(null)"])&&[[[tableArray objectAtIndex:indexPath.row] valueForKey:@"username"] length]!=0 )
        if(self.type==AUVInviteContacts)
            userName.text=full;
        else
    fullName.text=[NSString stringWithFormat:@"%@",full];
       // else
       //     userName.text=[NSString stringWithFormat:@"%@",full];

   
    if(self.type==AUVContactsList|| self.type==AUVSearchFriendList || self.type==AUVFBFriendList || self.type == AUVSuggestionList ||self.type==AUVTopUserList)
    {
        if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
        {
        [btn setTitle:@"Unfollow" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(unfollowActionUser:) forControlEvents:UIControlEventTouchDown];

            
        }
        else
        {
            [btn setTitle:@" + Follow " forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(followActionUser:) forControlEvents:UIControlEventTouchDown];
        }
    }
    else if(self.type==AUVInviteContacts||self.type==AUVInviteFBFriends)
    {
        [btn setTitle:@" + Invite " forState:UIControlStateNormal];
        if(self.type==AUVInviteContacts)
        [btn addTarget:self action:@selector(InviteUser:) forControlEvents:UIControlEventTouchDown];
        else
            [btn addTarget:self action:@selector(InviteFbFriends:) forControlEvents:UIControlEventTouchDown];

    }
    
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    
    cell.accessoryView=btn;

    return cell;
    }
    else
    {

        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        }
        
        // Set up the cell...
        //NSString *cellValue = [listOfItems objectAtIndex:indexPath.row];
        //cell.text = cellValue;
        
        //return cell;
      
       // static NSString *identifier = @"defaultcell";
        //cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.textLabel.text=@"No Results";
        return  cell;
    }
}
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableArray.count!=0)
        return 90;
    else
        return 40;
    
    
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(tableArray.count!=0)
    {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   // //NSLog(@"Clciked Row : %d ",indexPath.row);
    
    if(self.type !=AUVInviteContacts && self.type != AUVInviteFBFriends &&self.type!=AUVFBFriendList){
    AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
    profile.userId=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"];
    if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
        profile.follow=1;
    [self.navigationController pushViewController:profile animated:YES];
    }
    if(self.type ==AUVFBFriendList){
        AUVDevsViewController *profile=[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE];
        profile.userId=[[tableArray objectAtIndex:indexPath.row] valueForKey:@"user_id"];
        if([[[tableArray objectAtIndex:indexPath.row] valueForKey:@"follow"] boolValue])
            profile.follow=1;
        [self.navigationController pushViewController:profile animated:YES];
    }
    }
}



-(void) loadData:(id)sender
{
    switch (self.type) {
        case AUVContactsList:
        {
            self.title=@"Contact Friends";
            [SVProgressHUD showWithStatus:@"Please wait..."];
            [self performSelectorInBackground:@selector(test) withObject:nil];
        }
            break;
        case AUVFBFriendList:
        {
            self.title=@"Facebook Friends";
            //[SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
            [self performSelectorOnMainThread:@selector(loadFB) withObject:nil waitUntilDone:YES];

        }
            break;
        case AUVTwitterList:
        {
            
        }
            break;
        case AUVSearchFriendList:
        {
            self.title=@"Friends";
            //[self searchUser:nil];
            [self performSelectorOnMainThread:@selector(searchUser:) withObject:nil waitUntilDone:YES];

        }
            break;
        case AUVSuggestionList:
        {
            self.title=@"Suggest Friends";
           // [self whoToFollow:nil];
            [self performSelectorOnMainThread:@selector(whoToFollow:) withObject:nil waitUntilDone:YES];

        }
            break;
        case AUVTopUserList:
        {
            self.title=@"Top Contributors";
            [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
           // [self topUser:nil];
            [self performSelectorOnMainThread:@selector(topUser:) withObject:nil waitUntilDone:YES];

        }
            break;
        case AUVInviteContacts:
        {
            self.title=@"Contacts";
            [SVProgressHUD showWithStatus:@"Please wait..."];

            [self performSelectorInBackground:@selector(test) withObject:nil];
        }
            break;
            
        case AUVInviteFBFriends:
        {
             self.title=@"Facebook Friends";
            [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
            [self performSelectorOnMainThread:@selector(loadFB) withObject:nil waitUntilDone:YES];

        }
            break;
        default:
            break;
    }
    
}



-(void)loadFB
{
    fb=  [AUV_DELEGATE facebook];
    //fbFriends=[[NSMutableArray alloc] init];
    //auvFriends=[[NSMutableArray alloc] init];
    [SVProgressHUD dismiss];
    if(!fb.isSessionValid)
    {
        fb=[[Facebook alloc] initWithAppId:AUVFB_APPID andDelegate:self];
        [fb authorize:[AUV_DELEGATE fbPermission]];
        
        [AUV_DELEGATE setFacebook:fb];
    }
    else
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
        [self loadFBFriends];
    

}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[fb accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[fb expirationDate] forKey:@"FBExpirationDateKey"];
    
    // NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small,is_app_user FROM user WHERE  uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(is_app_user,first_name,last_name) asc"];
    
    /*  NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small FROM user WHERE is_app_user = 1 AND uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(first_name,last_name) asc"];
     */
    [defaults synchronize];
    
        if(self.type==AUVInviteFBFriends)
        {            [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];

            [self InviteFBFriends];
        }
        else
        {            [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];

            [self loadFBFriends];
        }
}


-(void)loadFBFriends
{
   // NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small,is_app_user FROM user WHERE  uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(is_app_user,first_name,last_name) asc"];
    
    // NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small FROM user WHERE is_app_user = 1 AND uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(first_name,last_name) asc"];
     
     NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small,is_app_user FROM user WHERE  uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(is_app_user,first_name,last_name) asc"];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:fql ,@"query", [fb accessToken], @"access_token", nil];
    
    [fb requestWithMethodName:@"fql.query" andParams:params andHttpMethod:@"GET" andDelegate:self];
}



-(void)InviteFBFriends
{
    // NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small,is_app_user FROM user WHERE  uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(is_app_user,first_name,last_name) asc"];
    
   // NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small FROM user WHERE is_app_user = 1 AND uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(first_name,last_name) asc"];
     NSString *fql = [NSString stringWithFormat:@"SELECT name,uid, pic_small,is_app_user FROM user WHERE  uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) order by concat(is_app_user,first_name,last_name) asc"];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:fql ,@"query", [fb accessToken], @"access_token", nil];
    
    [fb requestWithMethodName:@"fql.query" andParams:params andHttpMethod:@"GET" andDelegate:self];
}





#pragma FBRequestDelegate Methods


- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{

}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
 
    [SVProgressHUD dismiss];

}

- (void)request:(FBRequest *)request didLoad:(id)result
{

    NSPredicate *predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
      
        
        return  [[(NSDictionary*)obj  valueForKey:@"is_app_user"] intValue]==1 ;
    }];
    
    NSPredicate *predicate2=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
       
        
        return  [[(NSDictionary*)obj  valueForKey:@"is_app_user"] intValue]==0 ;
    }];
    
    
    
    NSArray *usersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate];
    NSArray *nonusersofApp=[(NSArray*)result filteredArrayUsingPredicate:predicate2];
    
  
//    if([usersofApp isKindOfClass:[NSArray class]]){
//        [auvFriends addObjectsFromArray:usersofApp];
//    }
//    else [auvFriends addObject:usersofApp];
//    if([nonusersofApp isKindOfClass:[NSArray class]])
//        [fbFriends addObjectsFromArray:nonusersofApp];
//    else [fbFriends addObject:nonusersofApp];
    
NSLog(@"Users Of App  :  %@",nonusersofApp);
   // NSMutableArray *array=[NSMutableArray arrayWithArray:result];
    [dataArray removeAllObjects];
    [tableArray removeAllObjects];
    if(self.type==AUVInviteFBFriends) {
        for(NSDictionary *dict in nonusersofApp)
        {
            NSDictionary *dt=[NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"name"],@"username",[dict valueForKey:@"pic_small"],@"usericon",[dict valueForKey:@"uid"],@"uid",nil];
            
            [dataArray addObject:dt];
            
            
            
            
        }
        //[dataArray addObjectsFromArray:fbFriends];
        [tableArray addObjectsFromArray:dataArray];
       
        [friendsTable reloadData];
      [SVProgressHUD dismiss];

    }
    else{
        for(NSDictionary *dict in usersofApp)
        {
           // NSDictionary *dt=[NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"name"],@"username",[dict valueForKey:@"pic_small"],@"usericon",[dict valueForKey:@"uid"],@"uid",nil];
            
            [auvFriends addObject:[dict valueForKey:@"uid"]];
            
            
            
        }
        
        [self fbLoadAUVContacts];

    }
    //
    
       

       
   //
    
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data
{
    
}
-(IBAction)followActionUser:(id)sender
{
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    UIButton *btn=sender;
    btn.enabled=NO;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[tableArray objectAtIndex:btn.tag]);
    //[service appcomment:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] app_id:appId comment:comment];
    
   // [service follow_users:<#(id)#> action:<#(SEL)#> user_id:<#(NSString *)#> follow_user_id:<#(NSString *)#>]
    
   // if(self.type!=AUVFBFriendList)
[service follow_users:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] follow_user_id:[[tableArray objectAtIndex:btn.tag] valueForKey:@"user_id"]];
//    else
//        [service facebook_follow_users:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] facebook_user_id:[[tableArray objectAtIndex:btn.tag] valueForKey:@"uid"]];
//
}




-(IBAction)unfollowActionUser:(id)sender
{
    AUVwebservice *service=[AUVwebservice service];
    service.logging=NO;
    UIButton *btn=sender;
    btn.enabled=NO;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //[service appcomment:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] app_id:appId comment:comment];
    
            
        
        [service unfollow_users:self action:@selector(followActionHandler:) user_id:[defaults valueForKey:@"user_id"] unfollow_user_id:[[tableArray objectAtIndex:btn.tag] valueForKey:@"user_id"]];
  
}





-(void)followActionHandler:(id)value
{
    
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
        
        NSLog(@"test: %@",arr);
    [self loadData:nil];
    }
    
}
/*

-(void)test
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool
                                                                granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted) {
        
        
        CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex npeople=ABAddressBookGetPersonCount(addressBook);
        self.tableData = [[NSMutableArray alloc]
                          initWithCapacity:CFArrayGetCount(people)];
        for (CFIndex i = 0; i < npeople; i++) {
            ABRecordRef person = CFArrayGetValueAtIndex(people, i);
            ABMultiValueRef emails = ABRecordCopyValue(person,
                                                       kABPersonEmailProperty);
            ABMultiValueRef phones=ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
            ABMultiValueRef fname=ABRecordCopyValue(person,
                                                    kABPersonFirstNameProperty);
            // ABMultiValueRef lname=ABRecordCopyValue(person,
            kABPersonLastNameProperty);
            // ABMultiValueRef userIcon=ABRecordCopyValue(person,
            kABPersonImageFormatThumbnail);
            
            //  CFDataRef imgData=ABPersonCopyImageData(person);
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
            
            [dict setValue:[NSString stringWithFormat:@"%@",(__bridge
                                                             NSString*) fname] forKey:@"firstname"];
            // [dict setValue:[NSString stringWithFormat:@"%@",(__bridge
            NSString*) lname] forKey:@"lastname"];
            // [dict setValue:(__bridge id)(imgData) forKey:@"imageData"];
            NSMutableArray *phonesArray=[[NSMutableArray alloc]
                                         initWithCapacity:ABMultiValueGetCount(phones)];
            ABRecordRef ref = CFArrayGetValueAtIndex(people, i);
            
            ABMultiValueRef contactnumber = ABRecordCopyValue(ref,
                                                              kABPersonPhoneProperty);
            NSMutableArray *allEmails=[[NSMutableArray alloc]
                                       initWithCapacity:ABMultiValueGetCount(emails)];
            
            for (CFIndex j=0; j < ABMultiValueGetCount(contactnumber); j++) {
                CFStringRef contactnumberRef =
                ABMultiValueCopyValueAtIndex(contactnumber, j);
                
                NSString *contactnumberstr = (__bridge NSString *)contactnumberRef;
                
                CFRelease(contactnumberRef);
                [dict setValue:contactnumberstr forKey:@"phonenumber"];
                
                
                
            }
            for (CFIndex j=0; j < ABMultiValueGetCount(emails); j++) {
                NSString* email = (__bridge
                                   NSString*)ABMultiValueCopyValueAtIndex(emails, j);
                // [allEmails addObject:email];
                [dict setValue:email forKey:@"allEmails"];
                
            }
            
            [self.tableData addObject:dict];
        }
    }
}*/
-(void)test
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    //ABAddressBookRef addressBook = ABAddressBookCreate();
    ABAddressBookRef addressBook = ABAddressBookCreate();
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool
                                                                granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }

    if(accessGranted){
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex npeople=ABAddressBookGetPersonCount(addressBook);
    NSMutableArray *allcontacts = [[NSMutableArray alloc] initWithCapacity:CFArrayGetCount(people)];
    NSMutableArray *allEmails=[[NSMutableArray alloc] init];
    for (CFIndex i = 0; i < npeople; i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        ABMultiValueRef phones=ABRecordCopyValue(person, kABPersonPhoneProperty);
        ABMultiValueRef fname=ABRecordCopyValue(person, kABPersonFirstNameProperty);
       // ABMultiValueRef lname=ABRecordCopyValue(person, kABPersonLastNameProperty);
       // ABMultiValueRef userIcon=ABRecordCopyValue(person, kABPersonImageFormatThumbnail);

      //  CFDataRef imgData=ABPersonCopyImageData(person);
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        
        [dict setValue:[NSString stringWithFormat:@"%@",(__bridge NSString*) fname] forKey:@"firstname"];
       // [dict setValue:[NSString stringWithFormat:@"%@",(__bridge NSString*) lname] forKey:@"lastname"];
       // [dict setValue:(__bridge id)(imgData) forKey:@"imageData"];
        NSMutableArray *phonesArray=[[NSMutableArray alloc] initWithCapacity:ABMultiValueGetCount(phones)];
        for (CFIndex j=0; j < ABMultiValueGetCount(phones); j++) {
            // NSString* email = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j);
            // [allEmails addObject:email];
          //  NSString *nameAndPhone=[NSString stringWithFormat:@"%@|%@",(__bridge NSString*)ABMultiValueCopyValueAtIndex(names, j),(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j)];
           
            NSString* phone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j);
            
          
            [phonesArray  addObject:phone];
        }
        [dict setValue:phonesArray forKey:@"phoneArray"];
          //NSMutableArray *allEmails=[[NSMutableArray alloc] initWithCapacity:ABMultiValueGetCount(emails)];
        for (CFIndex j=0; j < ABMultiValueGetCount(emails); j++) {
            NSString* email = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j);
            [allEmails addObject:email];
        }
        
        [dict setValue:allEmails forKey:@"allEmails"];
        [allcontacts addObject:dict];
        
   //    
        
    }
    // NSLog(@"test %@",allcontacts);
    
    if(self.type==AUVInviteContacts){
    
        [dataArray addObjectsFromArray:allcontacts];
   
        [tableArray addObjectsFromArray:dataArray];

        [friendsTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        
        [SVProgressHUD dismiss];

    }
    
    else
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
   
        AUVwebservice *service=[AUVwebservice service];
      //  service.logging=NO;
        [service contact:self action:@selector(searchHandler:) user_id:[AUVLogin valueforKey:@"user_id"] email:[allEmails componentsJoinedByString:@","]];
    }
     
    
    }
    
    
}


-(void)contactHandler:(id)value
{
   // SoapArray *arr=(SoapArray*)value;
   
}
-(void)InviteUser:(id)sender
{
    
 //   //NSLog(@"Invite User : %@",[[dataArray objectAtIndex:[sender tag]] valueForKey:@"phoneArray"]);
    if(((NSArray*)[[tableArray objectAtIndex:[sender tag]] valueForKey:@"phoneArray"]).count!=0){
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    MFMessageComposeViewController *viewController = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
	{
        viewController.messageComposeDelegate=self;
        viewController.delegate = self;
        viewController.recipients=[[tableArray objectAtIndex:[sender tag]] valueForKey:@"phoneArray"];
        viewController.body = [NSString stringWithFormat:@"I'd like to invite you to AppFindee. http://www.appfindee.com"];
        [self presentModalViewController:viewController animated:YES];
        
    }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"No Phone number is there for the selected user."];
    }

}



-(void)InviteFbFriends:(id)sender
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];//[NSMutableDictionary dictionaryWithObjectsAndKeys:[fb accessToken], @"access_token",@"Hello",@"message",@"me",@"to",nil];
//    
//
   // NSString *str=[NSString stringWithFormat:@"I'd like to invite you to AppFindee. http://www.appfindee.com"];
    [params setObject:@"I'd like to invite you to have a look" forKey:@"message"];
    [params setObject:@"http://www.appfindee.com" forKey:@"link"];
    //[params setObject:@"257769047669205" forKey:@"appId"];
//    [params setObject:@"https://www.mysite.com/myImg.jpg" forKey:@"picture"];
    //[params setObject:@"to" forKey:@"me"];
    //[params setObject:@"771863010" forKey:@"to"];
    
    
    [params setObject:[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:[sender tag]] valueForKey:@"uid"]] forKey:@"to"];
    //[fb requestWithGraphPath:@"100001693686032/apprequests" andParams:params andHttpMethod:@"post" andDelegate:self];

  //  [fb requestWithGraphPath:@"me" andParams:params andHttpMethod:@"post" andDelegate:self];
    //[fb requestWithMethodName:@"apprequests" andParams:params andHttpMethod:@"post" andDelegate:self];
   //[fb requestWithGraphPath:@"me/feed" andParams:[NSMutableDictionary dictionaryWithObject:@"test wall post" forKey:@"message"] andHttpMethod:@"POST" andDelegate:self];
    
   // Bundle params = new Bundle();
  
    [fb dialog:@"apprequests" andParams:params andDelegate:self];
    
   // [fb enableFrictionlessRequests];
   // [fb requestWithGraphPath:@"100001693686032/apprequests" andParams:params andHttpMethod:@"post" andDelegate:self];
}





#pragma mark MessageComposeView delegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
        {
			
        }
			break;
		case MessageComposeResultFailed:
        {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Unknown Error"
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
			
        }
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}





-(IBAction)searchUser:(id)sender
{
 [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //service.logging=NO;
    [service search_user:self action:@selector(searchHandler:) user_id:[defaults valueForKey:@"user_id"] search_term:searchTerm];
    
    // [service search_user:self action:@selector(searchHandler:) search_term:searchField.text];
}


-(void)searchHandler:(id)value
{
  
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
   
    
    NSArray * dict = [result JSONValue];
    //  //NSLog( @"%@",[[dict class] description]);
    if(dict.count>0)
    {
        
        if([[dict valueForKey:@"user_details"] isKindOfClass:[NSArray class]])
            self.dataArray=[[NSMutableArray alloc] initWithArray:[dict valueForKey:@"user_details"]];
        [tableArray removeAllObjects];
        [tableArray addObjectsFromArray:dataArray];
        
    }
    

    [friendsTable reloadData];
    
    [SVProgressHUD dismiss];
    }
    //  [appDic setValue:[dict valueForKey:@"value"] forKey:[dict valueForKey:@"key"]];
    
    //if([[dict valueForKey:@"message"] isEqualToString:@"success"])
    //  likeBtn.enabled=NO;
}




-(IBAction)whoToFollow:(id)sender
{
    //[SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];

    
    if(tableArray.count==0)
    {
        page=0;
    }
    else{
        
        page+=10;
    }
    NSLog(@"apge=%d",page);
    AUVwebservice *service=[AUVwebservice service];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    service.logging=NO;
   // [service search_user:self action:@selector(whoToFollowHandler:) user_id:[defaults valueForKey:@"user_id"] search_term:searchTerm];
    [service suggest_friends:self action:@selector(whoToFollowHandler:) user_id:[defaults valueForKey:@"user_id"] limit:[NSString stringWithFormat:@"%d",page] offset:@"10"];
    // [service search_user:self action:@selector(searchHandler:) search_term:searchField.text];
}



-(void)whoToFollowHandler:(id)value
{
    
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSArray * dict = [result JSONValue];
  //  NSLog( @"%@",dict);
    if(dict.count>0)
    {
        
        if([[dict valueForKey:@"user_details"] isKindOfClass:[NSArray class]])
            self.dataArray=[[NSMutableArray alloc] initWithArray:[dict valueForKey:@"user_details"]];
        //[tableArray removeAllObjects];
        [tableArray addObjectsFromArray:dataArray];
    }
    
    
    [friendsTable reloadData];
        [SVProgressHUD dismiss];
    }
    //  [appDic setValue:[dict valueForKey:@"value"] forKey:[dict valueForKey:@"key"]];
    
    //if([[dict valueForKey:@"message"] isEqualToString:@"success"])
    //  likeBtn.enabled=NO;
}




-(IBAction)topUser:(id)sender
{
    //[SVProgressHUD show];
    AUVwebservice *service=[AUVwebservice service];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //service.logging=NO;
    // [service search_user:self action:@selector(whoToFollowHandler:) user_id:[defaults valueForKey:@"user_id"] search_term:searchTerm];
    //[service suggest_friends:self action:@selector(whoToFollowHandler:) user_id:[defaults valueForKey:@"user_id"]];
    [service popular_user:self action:@selector(topUserHandler:) user_id:[defaults valueForKey:@"user_id"] limit:@"0" offset:@"10"];
}


-(void)topUserHandler:(id)value
{
    AUVArray *arr=(AUVArray*)value;
    
    
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
  
    
    NSArray * dict = [result JSONValue];
    //  //NSLog( @"%@",[[dict class] description]);
    if(dict.count>0)
    {
        
        if([[dict valueForKey:@"user_details"] isKindOfClass:[NSArray class]])
            self.dataArray=[[NSMutableArray alloc] initWithArray:dict];
        [tableArray removeAllObjects];
        [tableArray addObjectsFromArray:dataArray];
    }
    
    
    [friendsTable reloadData];
        [SVProgressHUD dismiss];
    }

}





#pragma mark - UISearchBarDelegate Methods



-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{

   
    
    
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    //dataArray
    
        return YES;
}


-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString *)searchText
{
    
    [tableArray removeAllObjects];
    ////NSLog(@"test: %@",text);
    
    if(searchText.length==0){
        [tableArray addObjectsFromArray:dataArray];
    }
    else{
        
        NSPredicate *predicate=[NSPredicate predicateWithBlock:^BOOL(id obj,NSDictionary *bind){
            ////NSLog(@" : %@",obj);
            NSString *string=[NSString stringWithFormat:@"%@ %@ %@",[(NSDictionary*)obj  valueForKey:@"username"],[(NSDictionary*)obj  valueForKey:@"firstname"],[(NSDictionary*)obj  valueForKey:@"lastname"]];
            // //NSLog(@"%@  %@",string,searchBar.text);
            NSRange range=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            
            if(range.location!=NSNotFound)
            {
                // //NSLog(@"succ : %d",range.location);
                return YES;
            }
            else
            {
                return NO;
                
            }
            
            //return <#expression#>
            //[string compare:text options:NSCaseInsensitiveSearch range:<#(NSRange)#>]
            // return  [[[(NSDictionary*)obj  valueForKey:@"firstname"] capitalizedString] isEqualToString:[self.title capitalizedString]] ||[[[(NSDictionary*)obj  valueForKey:@"lastname"] capitalizedString] isEqualToString:[self.title capitalizedString]]  ;
        }];
        
        
        
        [tableArray addObjectsFromArray:[dataArray filteredArrayUsingPredicate:predicate]];
        
        //  //NSLog(@"tab : %@",tableArray);
    }
    [friendsTable reloadData];

    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // Existing code
    
    // Removing the disableViewOverlay
    [searchBar resignFirstResponder];
}


-(void)goToWall:(id)sender
{
    if(parent)
    {
        [self dismissViewControllerAnimated:YES completion:^(void){
            [parent goToWall:sender];
        }];
    }
}



-(void)fbLoadAUVContacts
{
    AUVwebservice *service=[AUVwebservice service];

    [SVProgressHUD showWithStatus:@"Please wait.."];
    [service facebook_find_friends:self action:@selector(searchHandler:) user_id:[AUVLogin valueforKey:@"user_id"] facebook_user_id:[auvFriends componentsJoinedByString:@","]];
    
    
   
    
    
}


@end
