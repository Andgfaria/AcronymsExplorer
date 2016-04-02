//
//  AcronymsTableViewController.m
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import "AcronymsTableViewController.h"
#import "Acronym.h"

@interface AcronymsTableViewController ()

@end

@implementation AcronymsTableViewController

@synthesize acronyms = _acronyms;

// Acronyms array getter
-(NSArray *)acronyms{
    return _acronyms;
}

// Acronyms array setter
-(void)setAcronyms:(NSArray *)acronyms {
    _acronyms = acronyms;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Configure the table view so the cell heights are dinamically calculated
    self.tableView.estimatedRowHeight = 56;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Hide the empty rows
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

// Adjust the content insets according to the device resoltuion and orientation
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    self.tableView.contentInset = (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular && self.view.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) ? UIEdgeInsetsMake(24, 0, 12, 0) : UIEdgeInsetsZero;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _acronyms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acronymCell" forIndexPath:indexPath];
    cell.textLabel.text = [[(Acronym *) _acronyms[indexPath.row] longForm] capitalizedString];
    NSInteger acronymFrequency = [(Acronym *) _acronyms[indexPath.row] frequency];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long) acronymFrequency, acronymFrequency != 1 ? @"ocurrences" : @"ocurrence"];
    return cell;
}

@end
