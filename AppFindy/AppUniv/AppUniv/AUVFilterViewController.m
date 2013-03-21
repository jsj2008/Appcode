//
//  AUVFilterViewController.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AUVFilterViewController.h"
#import "UIViewController+Transitions.h"
#import "AUVSecondFilterViewController.h"
#import "AUVAppDelegate.h"
@interface AUVFilterViewController ()

@end

@implementation AUVFilterViewController
@synthesize filterdict,facets,parent,searchStr;

NSDictionary *langdict,*categorydict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle
                     :(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          }
    return self;
}

- (void)viewDidLoad
{
    
    if(filterdict.count==0)
    {
        filterdict=[NSDictionary new];
    }
    
    
    NSArray *price=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: @"Free",@"0",@"0.0",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil] ],
                    [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"$0-$0.99",@"0",@"[0.1 TO 0.99]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                    [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"$1-$2.99",@"0",@"[1.00 TO 2.99]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                    [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"$3-$5.99",@"0",@"[3.00 TO 5.99]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                    [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"$6-$9.99",@"0",@"[6.00 TO 9.99]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                    [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"$10-$20",@"0",@"[10.00 TO 20.00]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                    [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Above $20",@"0",@"[20.00 TO 3000.99]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]], nil];
    
    
    [filterdict setValue:price forKey:@"price"];
    
    NSArray *userRatingCount=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: @"0 - 10",@"0",@"[0 TO 10]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil] ],
                              [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"11 - 100",@"0",@"[11 TO 100]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                              [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"101 - 200",@"0",@"[101 TO 200]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                              [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"201 - 500",@"0",@"[201 TO 500]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                              [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"501 - 1000",@"0",@"[501 TO 1000]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                              [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Above 1000",@"0",@"[1000 TO 100000000000]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]], nil];
    
    
    [filterdict setValue:userRatingCount forKey:@"userRatingCount"];
    
    
    NSArray *averageUserRating=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: @"0 - 1",@"0",@"[0 TO 1]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil] ],
                                [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1 - 2",@"0",@"[1 TO 2]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                                [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"2 - 3",@"0",@"[2 TO 3]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                                [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"3 - 4",@"0",@"[3 TO 4]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                                [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"4 - 5",@"0",@"[4 TO 5]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],nil];
    
    [filterdict setValue:averageUserRating forKey:@"averageUserRating"];
    
    
    NSArray *fileSizeBytes=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: @"Below 1MB",@"0",@"[0 TO 1024]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil] ],
                            [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1MB - 5MB",@"0",@"[1025 TO 5000]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                            [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"5MB - 10MB",@"0",@"[50001 TO 10000]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],
                            [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Above 10MB",@"0",@"[100001 TO 10000000000]",nil] forKeys:[NSArray arrayWithObjects:@"name",@"value",@"realvalue",nil]],nil];
    
    
    [filterdict setValue:fileSizeBytes forKey:@"fileSizeBytes"];

    
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
  
    
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(test:)];
   
    //NSLog(@"filter dict: %@",filterdict);
    
  
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


-(IBAction)test:(id)sender
{
    //NSLog(@"facet : %@",facets);
   
    [self.parent performSelectorOnMainThread:@selector(searchforTextWithFilter:) withObject:facets waitUntilDone:YES];
   // else
       // [self.parent performSelectorOnMainThread:@selector(searchforText:) withObject:facets waitUntilDone:YES];
    [self dismissModalViewControllerWithPushDirection:kCATransitionFromTop]; 
}





#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
        {
        return facets.count;  
        }
            break;
        case 1:
        {
           
        return filterdict.count;
        }
            break;
        default:
            return 0;
            break;
    }
    
    
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
    
    switch (indexPath.section) {
        case 0:
            
        {
            
            
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            
            if(facets.count!=0)
            {
                if([[[facets allKeys] objectAtIndex:indexPath.row] isEqualToString:@"languageCodesISO2A"])
                {
                    //cell.textLabel.text= [NSString stringWithFormat:@"Language : %@ ",[[facets allValues] objectAtIndex:indexPath.row]];
                    cell.textLabel.text= [NSString stringWithFormat:@"Language : %@ ",[langdict valueForKey:[[facets allValues] objectAtIndex:indexPath.row]]];
                    
                }else if([[[facets allKeys] objectAtIndex:indexPath.row] isEqualToString:@"primaryGenreId"])
                {
                    cell.textLabel.text= [NSString stringWithFormat:@"Category : %@ ",[categorydict valueForKey:[[facets allValues] objectAtIndex:indexPath.row]]];
                }
                else if([[[facets allKeys] objectAtIndex:indexPath.row] isEqualToString:@"price"])
                {
                  for(int i=0;i<[[filterdict valueForKey:@"price"]count];i++)
                    {
                        if([[[[filterdict valueForKey:@"price"]valueForKey:@"realvalue"]objectAtIndex:i] isEqualToString:[[facets allValues]objectAtIndex:indexPath.row]])
                        {
                            cell.textLabel.text= [NSString stringWithFormat:@"Prices : %@ ",[[[filterdict valueForKey:@"price"]valueForKey:@"name"]objectAtIndex:i]];
                            
                        }
                    }
                    
                }
                else if([[[facets allKeys] objectAtIndex:indexPath.row] isEqualToString:@"userRatingCount"])
                {
                    for(int i=0;i<[[filterdict valueForKey:@"userRatingCount"]count];i++)
                    {
                        if([[[[filterdict valueForKey:@"userRatingCount"]valueForKey:@"realvalue"]objectAtIndex:i] isEqualToString:[[facets allValues]objectAtIndex:indexPath.row]])
                        {
                            cell.textLabel.text= [NSString stringWithFormat:@"User Rating Count : %@ ",[[[filterdict valueForKey:@"userRatingCount"]valueForKey:@"name"]objectAtIndex:i]];
                            
                        }
                    }
                    
                }
                else if([[[facets allKeys] objectAtIndex:indexPath.row] isEqualToString:@"averageUserRating"])
                {
                    for(int i=0;i<[[filterdict valueForKey:@"averageUserRating"]count];i++)
                    {
                        if([[[[filterdict valueForKey:@"averageUserRating"]valueForKey:@"realvalue"]objectAtIndex:i] isEqualToString:[[facets allValues]objectAtIndex:indexPath.row]])
                        {
                            cell.textLabel.text= [NSString stringWithFormat:@"Average User Rating : %@ ",[[[filterdict valueForKey:@"averageUserRating"]valueForKey:@"name"]objectAtIndex:i]];
                            
                        }
                    }
                    
                }
                else if([[[facets allKeys] objectAtIndex:indexPath.row] isEqualToString:@"fileSizeBytes"])
                {
                    for(int i=0;i<[[filterdict valueForKey:@"fileSizeBytes"]count];i++)
                    {
                        if([[[[filterdict valueForKey:@"fileSizeBytes"]valueForKey:@"realvalue"]objectAtIndex:i] isEqualToString:[[facets allValues]objectAtIndex:indexPath.row]])
                        {
                            cell.textLabel.text= [NSString stringWithFormat:@"File Size : %@ ",[[[filterdict valueForKey:@"fileSizeBytes"]valueForKey:@"name"]objectAtIndex:i]];
                            
                        }
                    }
                    
                }


                else
                {
                    cell.textLabel.text= [NSString stringWithFormat:@"Supported Devices : %@ ",[[facets allValues] objectAtIndex:indexPath.row]];
                }
            }
        }
        break;
            
        case 1:
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
            
            if(filterdict.count!=0)
            {
                if([[[filterdict allKeys] objectAtIndex:indexPath.row] isEqualToString:@"languageCodesISO2A"])
                    cell.textLabel.text=@"Language";
                else if([[[filterdict allKeys] objectAtIndex:indexPath.row] isEqualToString:@"primaryGenreId"])
                {
                    cell.textLabel.text=@"Category";

                }else if([[[filterdict allKeys] objectAtIndex:indexPath.row] isEqualToString:@"price"])
                {
                     cell.textLabel.text=@"Price";
                }
                else if([[[filterdict allKeys] objectAtIndex:indexPath.row] isEqualToString:@"userRatingCount"])
                {
                    cell.textLabel.text=@"User Rating Count";
                }
                else if([[[filterdict allKeys] objectAtIndex:indexPath.row] isEqualToString:@"averageUserRating"])
                {
                    cell.textLabel.text=@"Average User Rating";
                }
                else if([[[filterdict allKeys] objectAtIndex:indexPath.row] isEqualToString:@"fileSizeBytes"])
                {
                    cell.textLabel.text=@"File Size";
                }

                else
                {
                     cell.textLabel.text=@"Supported Devices";
                }
                
            }
                      
        }
            break;
        default:
            break;
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            [facets removeObjectForKey:[[facets allKeys] objectAtIndex:indexPath.row]];
            [tableView reloadData];
            
            [self test:nil];
        }
        
        break;
            
        case 1:
        {
           
            AUVSecondFilterViewController *sec=[[AUVSecondFilterViewController alloc] initWithNibName:@"AUVSecondFilterViewController" bundle:nil];
            
            //if(![[[filterdict allKeys] objectAtIndex:indexPath.row] isEqualToString:@"languageCodesISO2A"])
            sec.categoryName=[[filterdict allKeys] objectAtIndex:indexPath.row];
          //  else
           //     sec.categoryName=@"language";
            sec.dict=facets;
            sec.parent=self.parent;
            sec.tableArray=[[NSArray alloc ] initWithArray:[filterdict valueForKey:[NSString stringWithFormat:@"%@",[[filterdict allKeys] objectAtIndex:indexPath.row]]]];
            [self.navigationController pushViewController:sec animated:YES];
        }
            break;
        default:
        {
            
        }
            break;
    }
    

}
/*
- (id) init
{
    if (self = [super initWithNibName:@"SDNestedTableView" bundle:nil])
    {
        UIImageView *bg=[[UIImageView alloc] initWithFrame:self.view.frame];
        [bg setImage:[UIImage imageNamed:@"bg"]];
        self.tableView.backgroundView=bg;
  // do init stuff
    }
    return self;
}

#pragma mark - Nested Tables methods

- (NSInteger)mainTable:(UITableView *)mainTable numberOfItemsInSection:(NSInteger)section
{
    return [[filterdict allKeys] count];
}

- (NSInteger)mainTable:(UITableView *)mainTable numberOfSubItemsforItem:(SDGroupCell *)item atIndexPath:(NSIndexPath *)indexPath
{
    return [[filterdict valueForKey:[NSString stringWithFormat:@"%@",[[filterdict allKeys] objectAtIndex:item.cellIndexPath.row]]] count]; 
}

- (SDGroupCell *)mainTable:(UITableView *)mainTable setItem:(SDGroupCell *)item forRowAtIndexPath:(NSIndexPath *)indexPath
{
    item.itemText.text = [NSString stringWithFormat:@"%@", [[filterdict allKeys] objectAtIndex:indexPath.row]];
    [facets setValue:[NSMutableArray new] forKey:[NSString stringWithFormat:@"%@", [[filterdict allKeys] objectAtIndex:indexPath.row]]];
    return item;
}

- (SDSubCell *)item:(SDGroupCell *)item setSubItem:(SDSubCell *)subItem forRowAtIndexPath:(NSIndexPath *)indexPath
{
    subItem.itemText.text = [NSString stringWithFormat:@"%@ (%@)",[[[filterdict valueForKey:[NSString stringWithFormat:@"%@",[[filterdict allKeys] objectAtIndex:item.cellIndexPath.row]]]objectAtIndex:indexPath.row] valueForKey:@"name"],[[[filterdict valueForKey:[NSString stringWithFormat:@"%@",[[filterdict allKeys] objectAtIndex:item.cellIndexPath.row]]]objectAtIndex:indexPath.row] valueForKey:@"value"]];
    return subItem;
}

- (void) mainTable:(UITableView *)mainTable itemDidChange:(SDGroupCell *)item
{
    SelectableCellState state = item.selectableCellState;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:item];
    switch (state) {
        case Checked:
           // //NSLog(@"Changed Item at indexPath:%@ to state \"Checked\"", indexPath);
            break;
        case Unchecked:
            ////NSLog(@"Changed Item at indexPath:%@ to state \"Unchecked\"", indexPath);
            break;
        case Halfchecked:
            ////NSLog(@"Changed Item at indexPath:%@ to state \"Halfchecked\"", indexPath);
            break;
        default:
            break;
    }
}

- (void) item:(SDGroupCell *)item subItemDidChange:(SDSelectableCell *)subItem
{
    SelectableCellState state = subItem.selectableCellState;
    NSIndexPath *indexPath = [item.subTable indexPathForCell:subItem];
    switch (state) {
        case Checked:
            [[facets valueForKey:[NSString stringWithFormat:@"%@", [[filterdict allKeys] objectAtIndex:item.cellIndexPath.row]]] addObject:[[[filterdict valueForKey:[NSString stringWithFormat:@"%@",[[filterdict allKeys] objectAtIndex:item.cellIndexPath.row]]]objectAtIndex:indexPath.row] valueForKey:@"name"]]; 
           // //NSLog(@"Changed Sub Item at indexPath:%@ to state \"Checked\"", indexPath);
            break;
        case Unchecked:
            [[facets valueForKey:[NSString stringWithFormat:@"%@", [[filterdict allKeys] objectAtIndex:item.cellIndexPath.row]]] removeObject:[[[filterdict valueForKey:[NSString stringWithFormat:@"%@",[[filterdict allKeys] objectAtIndex:item.cellIndexPath.row]]]objectAtIndex:indexPath.row] valueForKey:@"name"]]; 
           // //NSLog(@"Changed Sub Item at indexPath:%@ to state \"Unchecked\"", indexPath);
            break;
        default:
            break;
    }
}

- (void)expandingItem:(SDGroupCell *)item withIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Expanded Item at indexPath: %@", indexPath);
}

- (void)collapsingItem:(SDGroupCell *)item withIndexPath:(NSIndexPath *)indexPath 
{
    //NSLog(@"Collapsed Item at indexPath: %@", indexPath);
}
*/

@end
