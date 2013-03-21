//
//  AUVLogin.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 29/09/12.
//
//

#import "AUVLogin.h"

@implementation AUVLogin


+(void)Help:(bool)helppage
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setBool:helppage forKey:@"help"];
    [defaults synchronize];
}

+(BOOL)HelpResponse
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    BOOL help;
    if([defaults objectForKey:@"help"]==nil)
        help=NO;
    else
        help=[[defaults objectForKey:@"help"] boolValue];
    return help;
}



+(void)Login:(NSDictionary*)dict
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    
    [defaults setBool:TRUE forKey:@"Access"];
    if([dict count]>0){
        
        [defaults setValue:[dict valueForKey:@"user_id"] forKey:@"user_id"];
        [defaults setValue:[dict valueForKey:@"username"] forKey:@"username"];
        [defaults setBool:[[dict valueForKey:@"new_user"] boolValue] forKey:@"new_user"];
    }
    [defaults synchronize];
}
+(void)Logout
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:@"" forKey:@"user_id"];
    [defaults setValue:@"" forKey:@"username"];
    [defaults setBool:NO forKey:@"Access"];

    [defaults synchronize];

}

+(void)Register:(NSDictionary*)dict
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    
    [defaults setBool:TRUE forKey:@"Access"];
    if([dict count]>0)
    {
        [defaults setValue:[dict valueForKey:@"user_id"] forKey:@"user_id"];
        [defaults setValue:[dict valueForKey:@"username"] forKey:@"username"];
        
        [defaults setBool:[[dict valueForKey:@"new_user"] boolValue] forKey:@"new_user"];


        
    }
    [defaults synchronize];
    
}

+(BOOL)isAccessAllowed
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
 
    BOOL access;
    if([defaults objectForKey:@"Access"]==nil)
        access=NO;
    else access=[[defaults objectForKey:@"Access"] boolValue];
    return access;
}


+(BOOL)isNewUSer
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    BOOL newUser;
    if([defaults objectForKey:@"new_user"]==nil)
        newUser=NO;
    else newUser=[[defaults objectForKey:@"new_user"] boolValue];
    return newUser;
}

+(void)categorySelected
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"new_user"];
}


+(id)valueforKey:(NSString*)key
{
     NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    return [defaults valueForKey:key];
}

@end
