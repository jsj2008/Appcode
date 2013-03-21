//
//  AUVSecondFilterViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 02/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVSecondFilterViewController.h"
#import "AUVAppDelegate.h"
@interface AUVSecondFilterViewController ()

@end

@implementation AUVSecondFilterViewController

@synthesize tableArray,categoryName,dict,parent;
NSDictionary *langdict,*categorydict;
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
    NSString* path = [[NSBundle mainBundle] pathForResource:@"lang"
                                                     ofType:@"txt"];
    NSString* content = [[NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:NULL] stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    NSArray *arr=[content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n:"]];
    
    NSIndexSet *co=  [arr indexesOfObjectsPassingTest:^BOOL(id obj,NSUInteger i,BOOL *stop){
        
        if(i%2==0) 
            
        {                      
            return YES;
        }
        else return NO;
    }];
    
    NSIndexSet *lang=  [arr indexesOfObjectsPassingTest:^BOOL(id obj,NSUInteger i,BOOL *stop){
        
        if(i%2==1) 
            
        {
            return YES;
        }
        else return NO;
    }];
    
    NSArray *code= [arr objectsAtIndexes:co];
    NSArray *language= [arr objectsAtIndexes:lang];
    langdict=[[NSDictionary alloc] initWithObjects:language forKeys:code];
    
    NSString* pathcategory = [[NSBundle mainBundle] pathForResource:@"category"
                                                     ofType:@"txt"];
    NSString* contentcategory = [[NSString stringWithContentsOfFile:pathcategory
                                                   encoding:NSUTF8StringEncoding
                                                      error:NULL] stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSArray *arrcategory=[contentcategory componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n:"]];
    
    NSIndexSet *cocategory=  [arrcategory indexesOfObjectsPassingTest:^BOOL(id obj,NSUInteger i,BOOL *stop){
        
        if(i%2==0)
            
        {
            return YES;
        }
        else return NO;
    }];
    
    NSIndexSet *langcategory=  [arrcategory indexesOfObjectsPassingTest:^BOOL(id obj,NSUInteger i,BOOL *stop){
        
        if(i%2==1)
            
        {
            return YES;
        }
        else return NO;
    }];
    
    
    NSArray *codecategory= [arrcategory objectsAtIndexes:cocategory];
    NSArray *languagecategory= [arrcategory objectsAtIndexes:langcategory];
    categorydict=[[NSDictionary alloc] initWithObjects:codecategory forKeys:languagecategory];
    
    //NSLog(@"Code %@",codecategory);
    //NSLog(@"Cateory %@",languagecategory);
    
    ////NSLog(@"Cat %@",categorydict);

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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




#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return tableArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=nil;
    static NSString *identifier = @"defaultcell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if([categoryName isEqualToString:@"languageCodesISO2A"])
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@ (%@)",[langdict valueForKey:[[tableArray objectAtIndex:indexPath.row] valueForKey:@"name"]],[[tableArray objectAtIndex:indexPath.row] valueForKey:@"value"]];
        
    else if([categoryName isEqualToString:@"primaryGenreId"])
    {
        cell.textLabel.text=[NSString stringWithFormat:@"%@ (%@)",[categorydict valueForKey:[[tableArray objectAtIndex:indexPath.row] valueForKey:@"name"]],[[tableArray objectAtIndex:indexPath.row] valueForKey:@"value"]];
    }
    else if(([categoryName isEqualToString:@"price"]))
    {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    }
    else if(([categoryName isEqualToString:@"userRatingCount"]))
    {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    }
    else if(([categoryName isEqualToString:@"averageUserRating"]))
    {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    }
    else if(([categoryName isEqualToString:@"fileSizeBytes"]))
    {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    }
    else
    {
     cell.textLabel.text=[NSString stringWithFormat:@"%@ (%@)",[[tableArray objectAtIndex:indexPath.row] valueForKey:@"name"],[[tableArray objectAtIndex:indexPath.row] valueForKey:@"value"]];
    }
    //[filterdict valueForKey:[NSString stringWithFormat:@"%@",[[filterdict allKeys] objectAtIndex:indexPath.row]]];
    
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[tableArray objectAtIndex:indexPath.row] count]==2)
    [dict setValue:[[tableArray objectAtIndex:indexPath.row] valueForKey:@"name"] forKey:categoryName];
    else
        [dict setValue:[[tableArray objectAtIndex:indexPath.row] valueForKey:@"realvalue"] forKey:categoryName];
    //NSLog(@"%@",dict);
    [self.parent performSelectorOnMainThread:@selector(searchforTextWithFilter:) withObject:dict waitUntilDone:YES];
    

    [self.navigationController dismissModalViewControllerAnimated:YES];
}


@end
