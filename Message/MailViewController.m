//
//  MailViewController.m
//  Message
//
//  Created by RAJESH BLAZE on Jan,31.
//
//

#import "MailViewController.h"
#import "MailCustomCell.h"
#import "MsgViewController.h"

@interface MailViewController ()
{
    NSArray *searchResults;
}
@end

@implementation MailViewController
@synthesize tableView,mainArray;

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
    self.navigationController.navigationBarHidden = YES;
    mainArray = [[NSMutableArray alloc]initWithObjects:@"Dhaya",@"Devan",@"Rajesh",@"Divya",@"Roopa", nil];
     [tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [mainArray count];
        
    }

  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    MailCustomCell *cell = (MailCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MailCustomCell1" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.P_name.text = [searchResults objectAtIndex:indexPath.row];
        cell.m_date.text = @"26/01/2014";
        cell.m_message.text = @"Ok see you tommorow";
    } else {
        cell.P_name.text = [mainArray objectAtIndex:indexPath.row];
        cell.m_date.text = @"26/01/2014";
        cell.m_message.text = @"Ok see you tommorow";
    }

  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We need to push on next controller
    MsgViewController *viewcont = [[MsgViewController alloc]initWithNibName:@"MsgViewController" bundle:nil];
    [self.navigationController pushViewController:viewcont animated:YES];
    
    //Reset Searchbar
    self.searchDisplayController.searchBar.text  = NULL;
    [self.searchDisplayController setActive:NO];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //searchResults = [[NSArray alloc]initWithArray:mainArray];
   // [mainArray removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    searchResults = [mainArray filteredArrayUsingPredicate:resultPredicate];
   //[mainArray addObjectsFromArray:[searchResults filteredArrayUsingPredicate:resultPredicate]];
}


@end
