//
//  MailCustomCell.m
//  Message
//
//  Created by RAJESH BLAZE on Jan,31.
//
//

#import "MailCustomCell.h"

@implementation MailCustomCell
@synthesize P_name,m_date,m_message;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
