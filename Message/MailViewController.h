//
//  MailViewController.h
//  Message
//
//  Created by RAJESH BLAZE on Jan,31.
//
//

#import <UIKit/UIKit.h>

@interface MailViewController : UIViewController
{
    IBOutlet UITableView *tableView;
}
@property (strong,nonatomic) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *mainArray;
@end
