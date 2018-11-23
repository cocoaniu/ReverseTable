//
//  TestTableViewCell.m
//  ReverseTable
//
//  Created by cocoa_niu on 2018/11/22.
//  Copyright © 2018年 com.cocoa_niu. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self p_setupView];
    }
    return self;
}


- (void)p_setupView
{
    self.bgLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 5, self.bounds.size.width / 2 - 10, self.bounds.size.height - 10)];
    self.bgLabel.backgroundColor = [UIColor lightGrayColor];
    self.bgLabel.layer.masksToBounds = YES;
    self.bgLabel.layer.cornerRadius = 5;
    self.bgLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.bgLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
