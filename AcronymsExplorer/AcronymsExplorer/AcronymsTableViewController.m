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

-(NSArray *)acronyms{
    return _acronyms;
}

-(void)setAcronyms:(NSArray *)acronyms {
    _acronyms = acronyms;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 56;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu occurrences", (unsigned long)[(Acronym *) _acronyms[indexPath.row] frequency]];
    return cell;
}

@end
