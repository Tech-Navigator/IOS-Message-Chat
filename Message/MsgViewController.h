//
//  MsgViewController.h
//  Message
//
//  Created by RAJESH BLAZE on Jan,31.
//
//

#import <UIKit/UIKit.h>

@interface MsgViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{}
@property (nonatomic) NSMutableArray * messages;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) IBOutlet UIButton *send;

- (IBAction)back:(id)sender;
- (IBAction)send:(id)sender;

@end
