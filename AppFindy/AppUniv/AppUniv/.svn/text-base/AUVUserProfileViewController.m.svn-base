//
//  AUVUserProfileViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 26/08/12.
//
//

#import "AUVUserProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AUVProfileEditViewController.h"
#import "AUVwebservice.h"
#import "AUVProfileCell.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "BJImageCropper.h"
#import "AUVImageEditViewController.h"
#import "AUVFriendsCell.h"
#import "SVProgressHUD.h"
#import "AUVConstants.h"
#import "SSPhotoCropperViewController.h"
#import "CropTestViewController.h"

#import "AUVCustomTabbar.h"
#import "AUVAppWallController.h"
#import "AUVNotificationViewController.h"
#import "AUVQuestionChoiceViewController.h"
#import "AUVSearchViewController.h"
#import "AUVDealsViewController.h"


@interface AUVUserProfileViewController ()

@end

@implementation AUVUserProfileViewController

@synthesize type;
NSString *name=@"Connect with Facebook";
NSString *iconURL;

Facebook *fb;
NSString *status;

Boolean linkedaccountstatus;

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
    tableDictionary=[[NSMutableDictionary alloc] init];
   
    fb=[AUV_DELEGATE facebook];
    
    
    [super viewDidLoad];
    
    self.title=@"Settings";
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view from its nib.
    AUVCustomTabbar *custombar  =[[AUVCustomTabbar alloc]init];
    custombar.delegate= self;
    
//    UIBarButtonItem *rbtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(fbRequestDeactivate)];
//    
//    self.navigationItem.rightBarButtonItem=rbtn;
    [self.view addSubview:custombar];
    // Do any additional setup after loading the view from its nib.
}

-(void)btnTap:(UIButton*)buttonId

{
    
    int buttonselect = buttonId.tag;
    
    if (buttonselect == 1) {
        
        AUVAppWallController *notification = [[AUVAppWallController alloc]initWithNibName:@"AUVAppWallController_iPhone" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 2){
        
        AUVNotificationViewController *notification = [[AUVNotificationViewController alloc]initWithNibName:@"AUVNotificationViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 3){
        
        AUVQuestionChoiceViewController *notification = [[AUVQuestionChoiceViewController alloc]initWithNibName:@"AUVQuestionChoiceViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 4){
        
        AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
        
        [self.navigationController pushViewController:notification animated:YES];
        
    }else if (buttonselect == 5){
        
        AUVDealsViewController *deal=[[AUVDealsViewController alloc]initWithNibName:@"AUVDealsViewController" bundle:nil];
        
        [self.navigationController pushViewController:deal animated:YES];
    }
    else{
        
        //NSLog(@"nothing");
        
    }
    
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

-(void)viewDidAppear:(BOOL)animated
{
    
 
        
    if(self.type==UserProfile)
    {
        [self loadProfile];
    }
    else if(self.type==LinkedAccounts)
    {
        
        [self likedAccountStatus];
        
       /* fb=  [AUV_DELEGATE facebook];
        [SVProgressHUD dismiss];
        if(fb.isSessionValid)
        {
             [self fbRequest];            
        }*/
    }
    
    [super viewDidAppear:animated];


   }


-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if(self.type==LinkedAccounts) return 1;
    if(tableDictionary.count>0)
    return 9;
    else 
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.type==UserProfile)
    {
    if(indexPath.row==0)
    {
    UITableViewCell  *cell=nil;
    //UIView *baseCell=nil;
    UILabel *fieldName=nil;
    UILabel *content=nil;
    static NSString *identifier = @"defaultcell";
    cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (cell == nil)
    {
        // CGRect rect =[cell bounds];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
       
       // baseCell=[[UIView alloc] initWithFrame:rect];
        
         fieldName=[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
        fieldName.tag=101;
        fieldName.font=[UIFont systemFontOfSize:14];
        fieldName.backgroundColor=[UIColor clearColor];
        
         content=[[UILabel alloc] initWithFrame:CGRectMake(115, 10, 180, 30)];
        content.backgroundColor=[UIColor clearColor];
        content.tag=102;
        content.font=[UIFont systemFontOfSize:14];
        [cell addSubview:fieldName];
        [cell addSubview:content];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        //[cell addSubview:baseCell];
        

    }
        UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(115, 10, 80, 80)];
        [imageV setImage:[UIImage imageNamed:@"placeholder"]];
        [imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
//        NSURL *bgImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"picture"]]];
//        NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
//        UIImage *img = [UIImage imageWithData:bgImageData];
//        [imageV setImage:img];
//        
        imageV.layer.cornerRadius=10;
        imageV.layer.borderWidth=1.0;
        imageV.clipsToBounds=YES;
        
        // cell.textLabel.text=@"Contacts";
        // cell.title2.text=@"Add friends from your contact list";
        [cell addSubview:imageV];
        // cell.accessoryType=UITableViewCellAccessoryNone;
        
        fieldName.frame=CGRectMake(15, 40, 100, 30);
        fieldName.text=@"Photo";
        
        return cell;
    }
   
    else{
        
        
        
        AUVProfileCell *cell=nil;
        
        
 
        static NSString *identifier = @"profilecell";
        cell =(AUVProfileCell*) [profileTable dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            NSString *nibName;
            
            
            nibName=@"AUVProfileCell";
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
            
            cell=(AUVProfileCell*)[topLevelObjects objectAtIndex:0];
            
             cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            
        }
        cell.fieldName.font=[UIFont systemFontOfSize:14];
        cell.content.font=[UIFont systemFontOfSize:14];

    if(indexPath.row==1)
    {
       cell.fieldName.text=@"User name";
        cell.content.text=[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"username"]];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    if(indexPath.row==2)
    {
        cell.fieldName.text=@"First name";
        cell.content.text=[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"firstname"]];
        
    }
    if(indexPath.row==3)
        {
            cell.fieldName.text=@"Last name";
            cell.content.text=[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"lastname"]];
            
        }
    
    if(indexPath.row==4)
    {
        cell.fieldName.text=@"Email";
        cell.content.text=[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"email_id"]];
        
    }
    
    if(indexPath.row==5)
    {
        cell.fieldName.text=@"Bio";
        cell.content.text=[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"bio"]];
    }
    
    if(indexPath.row==6)
    {
        cell.fieldName.text=@"Mobile No";
        cell.content.text=[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"mobile_number"]];
        
    }
    
    if(indexPath.row==7)
    {
        cell.fieldName.text=@"Web";
        cell.content.text=[NSString stringWithFormat:@"%@",[tableDictionary valueForKey:@"website"]];
        
    }
    if(indexPath.row==8)
    {
        cell.fieldName.text=@"Location";
        cell.content.text=@"India";
        
    }


    cell.backgroundColor=[UIColor whiteColor];
    return cell;
    
    }
    }
    else
    {
        
        AUVFriendsCell *cell=nil;
        
        static NSString *identifier = @"defaultcell";
        cell =(AUVFriendsCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        
        if (cell == nil)
        {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            NSString *nibName;
            
            
            nibName=@"AUVFriendsCell";
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
            
            cell=(AUVFriendsCell*)[topLevelObjects objectAtIndex:0];
            
            
        }
        
        
            
            cell.title1.text =@"Facebook";
            cell.title2.text=name;
            
            [cell.icon setImage:[UIImage imageNamed:@"f_facebook"]];
    
                
        return cell;

    }

    
}
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [NSString stringWithFormat:@"Section %d", section];
 }
 */

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.type==LinkedAccounts) return 69;
    if(indexPath.row==0) return 100;
    else return 50;
    
}


-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.type==LinkedAccounts)
    {
        [self Connect:nil];
    }
    else{
    if(indexPath.row==0)
    {
        UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"From Gallery",nil];
        
        actionSheet.actionSheetStyle=UIActionSheetStyleAutomatic;
        
        [actionSheet showInView:self.view];
        //        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraCaptureModePhoto])
        //        {
        //            UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        //            picker.delegate=self;
        //            picker.showsCameraControls=YES;
        //            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        //            [self presentModalViewController:picker animated:YES];
        //        }
        //        else{
        //            //NSLog(@"No Device");
        //        }
        
        
    }

    else{
    
    AUVProfileCell *cell=(AUVProfileCell*)[tableView cellForRowAtIndexPath:indexPath];
    AUVProfileEditViewController *editView=[[AUVProfileEditViewController alloc] init];
    editView.fieldValue=cell.content.text;
    editView.labelName=cell.fieldName.text;

    
    if(indexPath.row==2){
        
        editView.type=AUVFName;
    [self.navigationController pushViewController:editView animated:YES];
    }
        if(indexPath.row==3){
            
            editView.type=AUVLName;
            [self.navigationController pushViewController:editView animated:YES];
        }
        if(indexPath.row==4){
            
            editView.type=AUVEmail;
            [self.navigationController pushViewController:editView animated:YES];
        }
        if(indexPath.row==5){
            
            editView.type=AUVBio;
            [self.navigationController pushViewController:editView animated:YES];
        }
        if(indexPath.row==6){
            
            editView.type=AUVMob;
            [self.navigationController pushViewController:editView animated:YES];
        }
        if(indexPath.row==7){
            
            editView.type=AUVWeb;
            [self.navigationController pushViewController:editView animated:YES];
        }
        if(indexPath.row==8){
            
            editView.type=AUVLocation;
            [self.navigationController pushViewController:editView animated:YES];
        }
        
        
    }

    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(self.type==LinkedAccounts)
    {
        if (buttonIndex == 0) {
            [self loadFB];
            
        }
    }
    else {
    if (buttonIndex == 0) {
    
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraCaptureModePhoto])
        {
            UIImagePickerController *picker=[[UIImagePickerController alloc] init];
            picker.delegate=self;
           picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.showsCameraControls=YES;

          
        [self presentModalViewController:picker animated:YES];
        }
        else{
            //NSLog(@"No Device");
        }
        
        //[self update:nil];
    } else if (buttonIndex == 1) {
        
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.delegate=self;
        
        
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentModalViewController:picker animated:YES];
        
    } else if (buttonIndex == 2) {
        
//        //NSLog(@"2 Button Clicked");
//        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
//        picker.delegate=self;
//        
//        
//        picker.sourceType = UIImagePickerControllerCameraCaptureModePhoto;
//        [self presentModalViewController:picker animated:YES];
    }
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
   // //NSLog(@"%@",info);//[info valueForKey:@"UIImagePickerControllerOriginalImage"]);
    [picker dismissModalViewControllerAnimated:YES];
    
    
  /*  SSPhotoCropperViewController *ss=[[SSPhotoCropperViewController alloc] initWithPhoto:[info valueForKey:@"UIImagePickerControllerOriginalImage"] delegate:self uiMode:SSPCUIModePushedOnToANavigationController showsInfoButton:YES];*/
    
    CropTestViewController *ss=[[CropTestViewController alloc] initWithNibName:@"CropTestViewController_iPhone" bundle:[NSBundle mainBundle]];
    ss.fullImage=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self.navigationController pushViewController:ss animated:YES];

   // [self update:[info valueForKey:@"UIImagePickerControllerOriginalImage"]];
   // [picker dismissMode]
}



#pragma mark SSPhotoCropperViewController Delegate  methods

- (void) photoCropper:(SSPhotoCropperViewController *)photoCropper
         didCropPhoto:(UIImage *)photo
{
    //[self update:photo];
    
    [photoCropper.navigationController popViewControllerAnimated:YES];
    [self update:photo];
    
}
- (void) photoCropperDidCancel:(SSPhotoCropperViewController *)photoCropper
{
    [photoCropper.navigationController popViewControllerAnimated:YES];
    
}

-(void)likedAccountStatus
{
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [service fb_linked_account_status:self action:@selector(likedAccountStatusHandler:) user_id:[defaults valueForKey:@"user_id"]];
}

-(void)likedAccountStatusHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray *arr=(SoapArray*)value;
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    
    [SVProgressHUD dismiss];
    
    //NSLog(@"RESULT %@",[result JSONValue]);
    
    if([[[result JSONValue]valueForKey:@"linked"]boolValue])
    {
        name=[[result JSONValue]valueForKey:@"firstname"];
        linkedaccountstatus=true;
        [profileTable reloadData];
    }else{
        name=@"Connect with Facebook";
        linkedaccountstatus=false;
        [profileTable reloadData];
    }
    }
}

-(void)loadProfile
{
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [service get_user_profile:self action:@selector(loadProfileHandler:) user_id:[defaults valueForKey:@"user_id"]];
}

-(void)loadProfileHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray *arr=(SoapArray*)value;
    
   // //NSLog(@"%@",arr);
     [tableDictionary removeAllObjects];

    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    ////NSLog(@"Result  : %@",result);
    NSDictionary *dict=[result JSONValue];

    [self performSelectorOnMainThread:@selector(addDictionaryFromDictionary:) withObject:[[dict valueForKey:@"user_details" ] objectAtIndex:0] waitUntilDone:YES];
   // [tableDictionary addEntriesFromDictionary:[aray objectAtIndex:0]];
    }
}

-(void) addDictionaryFromDictionary:(NSDictionary*)dictionary
{

    NSArray *keys=[dictionary allKeys];
    for(NSString *k in keys)
    {
        if([dictionary valueForKey:k]==[NSNull null])
        {
            [tableDictionary setValue:@"" forKey:k];
        }
        else
        {
            [tableDictionary setValue:[dictionary valueForKey:k] forKey:k];
        }
    }
    [SVProgressHUD dismiss];
    [profileTable reloadData];
}
-(void)update:(UIImage*)image
{
    [SVProgressHUD showWithStatus:@"Uploading the Image" maskType:SVProgressHUDMaskTypeBlack];
    AUVwebservice *service=[AUVwebservice service];
    //service.logging=NO;
    NSData *data= UIImageJPEGRepresentation(image, 50);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    ////NSLog(@"Updating :");
    
  [service update_profile:self action:@selector(updateHandler:) user_id:[defaults valueForKey:@"user_id"] param_name:AUVPicture param_value:data];
   
}
-(void)updateHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    SoapArray *arr=(SoapArray*) value;
    
     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    ////NSLog(@"Result : %@",arr);
    [SVProgressHUD dismiss];
    NSString *result=[[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    if([[[result JSONValue] valueForKey:@"status"] boolValue])
    {
        [tableDictionary  setValue:[[result JSONValue] valueForKey:@"profile_image"]  forKey:@"picture"];
    }
    [profileTable reloadData];
    //[self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)fbRequest
{
    NSLog(@"FB DELEGATE");
    if(!fb)
        fb=[AUV_DELEGATE facebook];
    fb.sessionDelegate=self;
    
    if([fb isSessionValid]){
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [fb requestWithGraphPath:@"/me" andDelegate:self];
    }
    else
    {
        [fb authorize:[AUV_DELEGATE fbPermission]];
        [AUV_DELEGATE setFacebook:fb];
    }
    
    
}


-(void)fbRequestDeactivate
{

    if(!fb)
     fb=[AUV_DELEGATE facebook];
    
    fb.sessionDelegate=self;
    
   
    if([fb isSessionValid])

    {
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeBlack];

        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:@"314252848686520" forKey:@"app_id"];
        [fb requestWithMethodName:@"Auth.revokeAuthorization" andParams:dict andHttpMethod:@"DELETE" andDelegate:self];
        
        }
    else{
        [fb authorize:[AUV_DELEGATE fbPermission]];
        [AUV_DELEGATE setFacebook:fb];
    }
    
}
#pragma FBRequestDelegate Methods
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"res");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"Err : %@",[error localizedDescription]);
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    
   NSLog(@"test  %@",[result description]);
    
   // NSDictionary *dict=[result JSONValue];
    if([result valueForKey:@"result"])
    {
        if(!fb)
        fb=[AUV_DELEGATE facebook];
        
        if([fb isSessionValid])
        {
            fb.accessToken = nil;
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies])
            {
                NSString* domainName = [cookie domain];
                NSRange domainRange = [domainName rangeOfString:@"facebook"];
                if(domainRange.length > 0)
                {
                    [storage deleteCookie:cookie];
                }
            }
            [fb logout];
            
           
        }

        AUVwebservice *service=[AUVwebservice service];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [service fb_unlink_account:self action:@selector(unlinkHandler:) user_id:[defaults valueForKey:@"user_id"]];
    }
    else{
    name=[NSString stringWithFormat:@"%@",[result valueForKey:@"name"]];
    
    AUVwebservice *service=[AUVwebservice service];
        service.logging=NO;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [service fb_linked_account:self action:@selector(fbLoginHandler:) user_id:[defaults valueForKey:@"user_id"] facebook_user_id:[result valueForKey:@"id"] access_key:[fb accessToken]];

    }
        
}



- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data
{
    
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[fb accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[fb expirationDate] forKey:@"FBExpirationDateKey"];
    
    [defaults synchronize];
    
    if(!linkedaccountstatus)
    [self fbRequest];
    else
        [self fbRequestDeactivate];
}

-(void)fbLoginHandler:(id)value
{
    
    
	// Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    
    NSString *result=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    
    //NSLog(@"Facebook link response :%@",[result JSONValue]);
    
    if([[[result JSONValue]valueForKey:@"linked"]boolValue])
    {
        [profileTable reloadData];
        
        [self.navigationController popViewControllerAnimated:YES];

        
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"This facebook account already linked with other account!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        [fb logout];
    }
    
    }
    
}

-(void)unlinkHandler:(id)value
{
    // Handle errors
    if([value isKindOfClass:[NSError class]] ||([value isKindOfClass:[SoapFault class]])) {
        
		[SVProgressHUD showErrorWithStatus:@"Sorry, the request was unsuccessful"];
	}
    
    else{
    
	// Do something with the Array* result
    SoapArray* arr = (SoapArray*)value;
    [SVProgressHUD dismiss];
    
    [self.navigationController popViewControllerAnimated:YES];
    }

    
}

-(IBAction)Connect:(id)sender
{
    
    //  //NSLog(@"Share");
    if(linkedaccountstatus) status=@"Unlink";
    else status=@"Connect";
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:status otherButtonTitles:nil,nil];
    
    actionSheet.actionSheetStyle=UIActionSheetStyleAutomatic;
    
    [actionSheet showInView:self.view];
    
    // [self loadFB];
    /* AUVwebservice *service=[AUVwebservice service];
     service.logging=NO;
     NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
     [service share_apps:self action:@selector(shareAppHandler:) user_id:[prefs valueForKey:@"user_id"] app_id:appId message:@""];*/
}
    
 


-(void)loadFB
{
    if([status isEqualToString:@"Connect"])
    {
        
            [self fbRequest];
            
            
    }
    else
    {
        NSLog(@"Deactivate");
        [self fbRequestDeactivate];
    }

}




@end
