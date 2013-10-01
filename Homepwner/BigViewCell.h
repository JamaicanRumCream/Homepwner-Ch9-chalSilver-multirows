//
//  BigViewCell.h
//  Homepwner
//
//  Created by Chris Paveglio on 9/27/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigViewCell : UITableViewCell
{
    BOOL isSelected;
}

@property (weak, nonatomic) IBOutlet UILabel *bvcTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *bvcDetailTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *bvcInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *bvcButtonOne;

- (IBAction)bvcButtonPress:(id)sender;

@end
