//
//  MsgViewController.m
//  Message
//
//  Created by RAJESH BLAZE on Jan,31.
//
//

#import "MsgViewController.h"
#import "PTSMessagingCell.h"

@interface MsgViewController ()
{
    NSString *filepath;
    NSString *documentDirectory;
}

@end

@implementation MsgViewController
@synthesize messages,tableView,toolbar,textfield,send;

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
    [self plistCreation];
    [self plistData];
    
    //-- Load table view to show last chat item rows in footer
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0]
                          atScrollPosition: UITableViewScrollPositionBottom
                                  animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)plistData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    documentDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    filepath = [NSString stringWithFormat:@"%@/chat.plist",documentDirectory];
    NSLog(@"path = %@",filepath);
    
    messages = [NSArray arrayWithContentsOfFile:filepath];
    NSLog(@"%d", messages.count);
    
    for (int i=0; i<messages.count; i++)
    {
        NSString *data = [messages objectAtIndex:i];
        NSLog(@"\n Data = %@",data);
    }
}


-(void)plistCreation
{
    NSFileManager *filemanager = [[NSFileManager alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chat.plist" ofType:nil];
    NSError *error;
    if(![filemanager copyItemAtPath:filePath toPath:[NSString stringWithFormat:@"%@/Documents/chat.plist", NSHomeDirectory()] error:&error])
    {
        // handle the error
        NSLog(@"Error creating the database: %@", [error description]);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"messagingCell";
    
    PTSMessagingCell * cell = (PTSMessagingCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PTSMessagingCell alloc] initMessagingCellWithReuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
-(void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath {
    PTSMessagingCell* ccell = (PTSMessagingCell*)cell;
    //-- Use Profile picture if needed
    if (indexPath.row % 2 == 0) {
        ccell.sent = YES;
        ccell.avatarImageView.image = [UIImage imageNamed:@"person1"];
    } else {
        ccell.sent = NO;
        ccell.avatarImageView.image = [UIImage imageNamed:@"person2"];
    }
    
    ccell.messageLabel.text = [messages objectAtIndex:indexPath.row];
    ccell.timeLabel.text = @"2012-08-29";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize messageSize = [PTSMessagingCell messageSize:[messages objectAtIndex:indexPath.row]];
    return messageSize.height + 2*[PTSMessagingCell textMarginVertical] + 40.0f;
}



- (IBAction)back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)send:(id)sender
{
    //-- Send operations
    NSMutableArray * plistArray = [[NSMutableArray alloc]
                                   initWithContentsOfFile:filepath];

    [plistArray insertObject:textfield.text atIndex:[messages count]];
    [plistArray writeToFile:filepath atomically:YES];
    
    
    
    //--Reset view
    [self plistData];
    [tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0]
                          atScrollPosition: UITableViewScrollPositionBottom
                                  animated:YES];
    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    [self.view endEditing:YES];
    textfield.text = @"";
}

//-- Enable keyboard when press textfield
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0,-220,self.view.frame.size.width,self.view.frame.size.height);
}

//-- Disable keyboard when press enter
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//-- Textfield should return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self send:nil];
    return YES;
}


@end
