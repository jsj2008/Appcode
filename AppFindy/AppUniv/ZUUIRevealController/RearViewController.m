/* 
 
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of Philip Kluz, 'zuui.org' nor the names of its contributors may 
 be used to endorse or promote products derived from this software 
 without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL PHILIP KLUZ BE LIABLE FOR ANY DIRECT, 
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import "RearViewController.h"
#import "AUVTredingAppsViewController.h"
#import "RevealController.h"
#import "AUVAppWallController.h"
#import "AUVSearchViewController.h"
#import "AUVDevsViewController.h"
#import "AUVFindFriendsViewController.h"
#import "AUVSettingsViewController.h"
#import "AUVInviteFriendsViewController.h"
#import "AUVDealsViewController.h"
#import "AUVAppDelegate.h"
#import "AUVLogin.h"
#import "AUVUserInterstViewController.h"
#import "SUBRearViewController.h"
#import "AUVInterestViewController.h"
#import "AUVCreditsViewController.h"
#import "SCNavigationBar.h"
#import "AUVAppsRecommendViewController.h"
#import "AUVMyAppSectionViewController.h"
#import "AUVHelpViewController.h"

@interface RearViewController()

// Private Properties:

// Private Methods:

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg"] forBarMetrics:UIBarMetricsDefault];
    if (IS_IPHONE_5) {
        self.view.frame=CGRectMake(0,0,320,544);
    }
   // UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 105, 28)];
   // imageview.image=[UIImage imageNamed:@"nav_logo.png"];
    //[self.navigationController.navigationBar.topItem setTitleView:imageView];
    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchbtn.frame=CGRectMake(10, 5, 220, 30);
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search_bg.png"]  forState:UIControlStateNormal];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search_bg.png"] forState:UIControlStateHighlighted];
    [searchbtn addTarget:self action:@selector(searchPageEvent) forControlEvents:UIControlEventTouchUpInside];
  

    [self.view addSubview:searchbtn];
    //[self.navigationController.navigationBar addSubview:searchbtn];
    
    _rearTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    NSLog(@"%f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    //self.navigationItem.titleView = searchbtn;
    
  }

-(void)searchPageEvent
{
   // NSLog(@"dss");
    
    RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    
        if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVSearchViewController class]])
		{
			AUVSearchViewController *frontViewController = [[[AUVSearchViewController alloc] initWithNibName:@"AUVSearchViewController" bundle:nil] autorelease];
            
            frontViewController.type=Menu;
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:frontViewController]];
            
			[revealController setFrontViewController:navigationController animated:NO];
			
		}
        else
		{
			[revealController revealToggle:self];
		}
	
   // AUVSearchViewController *notification = [[AUVSearchViewController alloc]initWithNibName:@"AUVSearchViewController" bundle:nil];
    
   // [self.navigationController pushViewController:notification animated:YES];
    //NSLog(@"Search Page");
}

#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	cell=nil;
    
	if (nil == cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
	}
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont systemFontOfSize:18];
	
	if (indexPath.row == 0)
	{
		cell.textLabel.text = @"Home";
         
	}
    else if (indexPath.row == 1)
	{
		cell.textLabel.text = @"Profile";
        
	}
    else if (indexPath.row == 2)
	{
		cell.textLabel.text = @"Categories";
	}
    else if (indexPath.row == 3)
	{
		cell.textLabel.text = @"Interest";
	}
    else if(indexPath.row==4)
    {
        cell.textLabel.text = @"Deals";
    }
    else if (indexPath.row == 5)
    {
        cell.textLabel.text = @"Trending";
    }

    else if(indexPath.row==6)
    {
        cell.textLabel.text = @"Recommendations";
    }
    else if(indexPath.row==7)
    {
        cell.textLabel.text=@"Share Your Apps";
    }
    
    else if(indexPath.row==8)
    {
        cell.textLabel.text = @"Credits";
    }
    else if(indexPath.row==9)
    {
    
        UILabel *bglabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,270, 30)];

        bglabel.text=@"  My Account";
        bglabel.font=[UIFont systemFontOfSize:15];
        bglabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg.png"]];
        bglabel.textColor=[UIColor whiteColor];
        [cell addSubview:bglabel];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    else if (indexPath.row == 10)
	{
		cell.textLabel.text = @"Settings";
	}
    else if (indexPath.row == 11)
	{
		cell.textLabel.text = @"Find Friends";
	}
    else if (indexPath.row == 12)
	{
		cell.textLabel.text = @"Invite Friends";
	}
    else if (indexPath.row == 13)
	{
		cell.textLabel.text = @"Help";
	}

        else if (indexPath.row == 14)
	{
		cell.textLabel.text = @"Logout";
	}
        
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarcell"]];
    [bg setFrame:CGRectMake(0, 0, 161.5, 42.5)];
    // Configure the cell...
    cell.backgroundView = bg;

	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
	RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;

	// Here you'd implement some of your own logic... I simply take for granted that the first row (=0) corresponds to the "FrontViewController".
	if (indexPath.row == 0)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
		if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVAppWallController class]])
		{
			AUVAppWallController *frontViewController = [[[AUVAppWallController alloc] initWithNibName:@"AUVAppWallController_iPhone" bundle:nil] autorelease];
			//UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:frontViewController] autorelease];
            
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:frontViewController]];
            
			[revealController setFrontViewController:navigationController animated:NO];
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
    else if (indexPath.row == 1)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
		if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVDevsViewController class]])
		{
            // AUVDevsViewController *dev=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil];
            //[self.navigationController pushViewController:dev animated:YES];
            
            
			AUVDevsViewController *devViewController = [[[AUVDevsViewController alloc] initWithNibName:@"AUVProfileViewController" bundle:nil type:AUVTYPEPROFILE] autorelease];
            
			//UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:devViewController] autorelease];
            
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:devViewController]];
            
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
    else if (indexPath.row == 2)
	{
        
        
        if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVUserInterstViewController class]])
		{
            AUVUserInterstViewController *usrInterest = [[AUVUserInterstViewController alloc] initWithNibName:@"AUVUserInterstViewController" bundle:nil];
            usrInterest.type=0;
			//UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:usrInterest] autorelease];
            
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:usrInterest]];
            
			[revealController setFrontViewController:navigationController animated:NO];
            
            
            
            
        }
		else
		{
			[revealController revealToggle:self];
            
        }
        
        /* SUBRearViewController *sub=[[SUBRearViewController alloc] initWithNibName:@"SUBRearViewController" bundle:nil];
         sub.parent=self;
         [self.navigationController pushViewController:sub animated:YES];*/
    }
    else if (indexPath.row == 3)
    {
        
        
        if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVInterestViewController class]])
		{
            // AUVDevsViewController *dev=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil];
            //[self.navigationController pushViewController:dev animated:YES];
            
            
			AUVInterestViewController *interestView = [[[AUVInterestViewController alloc] initWithNibName:@"AUVInterestViewController" bundle:nil] autorelease];
            
			//UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:interestView] autorelease];
            
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:interestView]];
            
            
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
        
        
    }
    else if(indexPath.row==4)
    {
        if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVDealsViewController class]])
		{
            
			AUVDealsViewController *deal = [[[AUVDealsViewController alloc] initWithNibName:@"AUVDealsViewController" bundle:nil] autorelease];
            
            deal.pageposition=@"menu";
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:deal]];
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
        
        
    }
    else if (indexPath.row == 5)
    {
        // Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVTredingAppsViewController class]])
        {
            AUVTredingAppsViewController *friendsViewController = [[[AUVTredingAppsViewController alloc] initWithNibName:@"AUVTredingViewController" bundle:nil] autorelease];
            friendsViewController.trendingpageposition=@"menu";
            
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:friendsViewController]];
            
            [revealController setFrontViewController:navigationController animated:NO];
        }
        else
        {
            [revealController revealToggle:self];
        }
    }
    else if(indexPath.row==6)
    {
        if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVAppsRecommendViewController class]])
		{
            
			AUVAppsRecommendViewController *interestView = [[[AUVAppsRecommendViewController alloc] initWithNibName:@"AUVAppsRecommendViewController" bundle:nil] autorelease];
            interestView.recommenedpageposition=@"menu";
            
            UINavigationController *navigationController=[self customizedNavigationController];
            
            [navigationController setViewControllers:[NSArray arrayWithObject:interestView]];
            
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
        
        //NSLog(@"%@",@"app recommends");
    }
    
    else if(indexPath.row==7)
    {
        
        if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVMyAppSectionViewController class]])
		{
            
			AUVMyAppSectionViewController *interestView = [[[AUVMyAppSectionViewController alloc] initWithNibName:@"AUVMyAppSectionViewController" bundle:nil] autorelease];
            
            interestView.myappspageposition=@"menu";
            
            UINavigationController *navigationController=[self customizedNavigationController];
            
            [navigationController setViewControllers:[NSArray arrayWithObject:interestView]];
            
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
    }
    
    else if(indexPath.row==8)
    {
        
        
        if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVCreditsViewController class]])
		{
            // AUVDevsViewController *dev=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil];
            //[self.navigationController pushViewController:dev animated:YES];
            
            
			AUVCreditsViewController *interestView = [[[AUVCreditsViewController alloc] initWithNibName:@"AUVCreditsViewController" bundle:nil] autorelease];
            
            //	UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:interestView] autorelease];
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:interestView]];
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
        
        //NSLog(@"%@",@"Credits");
    }


        
        



	// ... and the second row (=1) corresponds to the "MapViewController".
	    
    

        
	else if (indexPath.row == 10)
	{
		if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVSettingsViewController class]])
		{
        
        
        
           AUVSettingsViewController *sett=[[[AUVSettingsViewController alloc] initWithNibName:@"AUVSettingsViewController" bundle:nil] autorelease];
        //
        //    [self.navigationController pushViewController:sett animated:YES];
        
            //UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:sett] autorelease];
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:sett]];
            
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}

	}
    else if (indexPath.row == 11)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
		if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVFindFriendsViewController class]])
		{
            // AUVDevsViewController *dev=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil];
            //[self.navigationController pushViewController:dev animated:YES];
            
            
			AUVFindFriendsViewController *friendsViewController = [[[AUVFindFriendsViewController alloc] initWithNibName:@"AUVFindFriendsViewController" bundle:nil] autorelease];
            friendsViewController.findfriendspageposition=@"menu";
            friendsViewController.type=FindFriends;
			//UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:friendsViewController] autorelease];
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:friendsViewController]];
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
    else if (indexPath.row == 12)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
		if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVInviteFriendsViewController class]])
		{
            // AUVDevsViewController *dev=[[AUVDevsViewController alloc] initWithNibName:@"AUVDevsViewController" bundle:nil];
            //[self.navigationController pushViewController:dev animated:YES];
            
            
			AUVInviteFriendsViewController *friendsViewController = [[[AUVInviteFriendsViewController alloc] initWithNibName:@"AUVInviteFriendsViewController" bundle:nil] autorelease];
            friendsViewController.invitefriendspageposition=@"menu";
            
			//UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:friendsViewController] autorelease];
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:friendsViewController]];
            
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}

    else if (indexPath.row == 13)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
		if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[AUVHelpViewController class]])
		{
            AUVHelpViewController *friendsViewController = [[[AUVHelpViewController alloc] initWithNibName:@"AUVHelpViewController" bundle:nil] autorelease];
            friendsViewController.helppagepositionpagevalue=@"menu";
            UINavigationController *navigationController=[self customizedNavigationController];
            [navigationController setViewControllers:[NSArray arrayWithObject:friendsViewController]];
            
			[revealController setFrontViewController:navigationController animated:NO];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}

      else if (indexPath.row == 14)

    {
        
        
       // [self performSelectorOnMainThread:@selector(fbLogout:) withObject:nil waitUntilDone:YES];
        
        if([self fbLogout:nil])
        {
           // [AUVLogin Logout];

            [AUVLogin performSelectorOnMainThread:@selector(Logout) withObject:nil waitUntilDone:YES];
            [self dismissModalViewControllerAnimated:YES];

        }
            

    }
    

	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==9)
    {
        return 32;
    }else
    {
        return 40;
    }
}
- (UINavigationController *)customizedNavigationController
{
    UINavigationController *navController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    
    // Ensure the UINavigationBar is created so that it can be archived. If we do not access the
    // navigation bar then it will not be allocated, and thus, it will not be archived by the
    // NSKeyedArchvier.
    [navController navigationBar];
    
    // Archive the navigation controller.
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:navController forKey:@"root"];
    [archiver finishEncoding];
    // [archiver release];
    //[navController release];
    
    // Unarchive the navigation controller and ensure that our UINavigationBar subclass is used.
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [unarchiver setClass:[SCNavigationBar class] forClassName:@"UINavigationBar"];
    UINavigationController *customizedNavController = [unarchiver decodeObjectForKey:@"root"];
    [unarchiver finishDecoding];
    // [unarchiver release];
    
    // Modify the navigation bar to have a background image.
    SCNavigationBar *navBar = (SCNavigationBar *)[customizedNavController navigationBar];
    [navBar setTintColor:[UIColor colorWithRed:34.0f/255.0f green:61.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsLandscapePhone];
    
    return customizedNavController;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(BOOL)fbLogout:(id)sender
{
    Facebook *fb=[AUV_DELEGATE facebook];
    
    fb.sessionDelegate=AUV_DELEGATE;
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

    return YES;
}

@end