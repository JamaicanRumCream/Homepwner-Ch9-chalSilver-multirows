//
//  BigViewCell.m
//  Homepwner
//
//  Created by Chris Paveglio on 9/27/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import "BigViewCell.h"

@implementation BigViewCell

@synthesize bvcTextLabel, bvcDetailTextLabel;
@synthesize bvcInfoButton, bvcButtonOne;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        isSelected = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)bvcButtonPress:(id)sender {
    /* this doesn't "stick" when scrolling because the cell object
     is destroyed and reused when scrolled. the state of the object
     must be set inside the data source object as being selected, and then
     the attribute of this cell set whenever the cell is displayed.
     it's not hard, just outside scope of this part of code */
    
    if (isSelected) {
        isSelected = NO;
        [sender setTitle:@"OFF" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
    } else {
        isSelected = YES;
        [sender setTitle:@"ON" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
    }
    
}
@end
