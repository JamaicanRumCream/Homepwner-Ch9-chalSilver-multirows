//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Chris Paveglio on 9/18/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BigViewCell.h"

@implementation ItemsViewController

-(id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
        //create random items to populate the table
        for (int i = 0; i < 12; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
        
        //load a custom tableviewcell so we can measure the height and save it for later
        //see heightForRow method
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"BigViewCell" owner:nil options:nil];
        BigViewCell *cell = [views objectAtIndex:0];
        BigViewCellHeight = cell.contentView.frame.size.height;
        views = nil;
    }
    return self;
}

-(id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //in a more complex solution, sub arrays may be held in a master array

    return 2;
    //or count if any of the sections have 0 items
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)//section 0 is valueInDollars < 50
    {
        return [[[BNRItemStore sharedStore] itemsUnder50] count];
    } else {
        //return [[[BNRItemStore sharedStore] itemsOver50] count];
        
        //let's add a row with default text for the 2nd section, add 1 to count of items
        return [[[BNRItemStore sharedStore] itemsOver50] count] +1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell; //declare cell object
    //not ideal but easier to return multiple object types when they are the same object class
    
    BNRItem *b;
    if ([indexPath section] == 0) {
        //use generic tableviewcells for first section
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        
        b = [[[BNRItemStore sharedStore] itemsUnder50] objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[b description]];
        [[cell detailTextLabel] setText:@"good stuff cheap"];
    } else {
        //section for higher priced items (valueInDollars > 50)
        if ([indexPath row] >= [[[BNRItemStore sharedStore] itemsOver50] count])
        {
            //if the row is => number of items in array, then this is the "subtotal" cell, use basic cell style
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
            [[cell textLabel] setText:[NSString stringWithFormat:@"number of items: %d", [[[BNRItemStore sharedStore] itemsOver50] count]]];
        } else {
            
            //it's a real content row
            //create a cell using our custom cell class
            cell = [tableView dequeueReusableCellWithIdentifier:@"BigViewCell"];
            //if it's the first time we are calling for this cell type, load nib
            if (cell == nil) {
                //build a new cell if deque cell doesnt exist
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"BigViewCell" owner:nil options:nil];
                //load nib named returns array of views, you could put multiple views in a xib
                //iterate through views, or  use itemAtIndex 0 if we know there is only 1 item
                cell = [views objectAtIndex:0];
                }
            
            //set the cell values now we have a cell made
            b = [[[BNRItemStore sharedStore] itemsOver50] objectAtIndex:[indexPath row]];
            [[cell bvcTextLabel] setText:[b description]];
            [[cell bvcDetailTextLabel] setText:@"details, details"];
            //set the button image based on attrs of data source, not table cell object
            if ([b valueInDollars] < 75) {
                [[cell bvcButtonOne] setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
                [[cell contentView] setBackgroundColor:[UIColor yellowColor]];
            } else {
                [[cell bvcButtonOne] setImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
            }
        }
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    
    UILabel *header = [[UILabel alloc] init];
    //if we wanted to have a custom view for the header we would instantiate it here
    //similar to how rows are made
    //and then return it as the view, after we set any parameters or display settings
    
    if (section == 0) {
        [header setText:[NSString stringWithFormat:@"Less than $50, qty: %d", [[[BNRItemStore sharedStore] itemsUnder50] count]]];
    } else {
        [header setText:[NSString stringWithFormat:@"More than $50, qty: %d", [[[BNRItemStore sharedStore] itemsOver50] count]]];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //for default plain header cell
    return 44.0;
}


//required if doing cells other than base cells
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        return 44.0;
    } else {
        return BigViewCellHeight;
    }
    /* It is IMPOSSIBLE to try to get a cell height of a cell dynamically
     because the height is calc'd FIRST and THEN the method cellForRowAtIndexPath
     gets called. It is possible to get a list of different row heights, as shown here,
     somewhat statically by making a "dummy" cell in memory and then measuring that and
     returning the appropriate value. If a cell is to grow or shrink with text, then
     this method could calculate a height of text and then add it to a known base height
     of a cell.
     What can NOT be done in this method is to call a cell and measure it, like so:
     cell = [[UITableViewCell alloc] init]; (or [tableview cellforindexpath:indexpath])
     return cell.contentView.frame.size.height
     
     http://stackoverflow.com/questions/4823197/iphone-when-to-calculate-heightforrowatindexpath-for-a-tableview-when-each-cel
     http://stackoverflow.com/questions/7128215/ios-dynamic-height-with-a-custom-uitableviewcell/7130728#7130728
     */
} 



@end
