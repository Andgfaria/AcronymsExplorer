//
//  MainViewController.m
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import "MainViewController.h"
#import "AcronymsTableViewController.h"
#import "SearchManager.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize acronymsSearchBar;
@synthesize acronymsTableViewContainer;
@synthesize infoLabel;

AcronymsTableViewController *acronymsTableViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self adjustSearchBarTextField];
}

-(void) adjustSearchBarTextField {
    UITextField *searchBarTextField = (UITextField *) [acronymsSearchBar valueForKey:@"_searchField"];
    searchBarTextField.textColor = [UIColor whiteColor];
}

-(void) viewWillAppear:(BOOL)animated {
    [acronymsSearchBar becomeFirstResponder];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if ([searchBar.text length] > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self fetchAcronymsWithString:searchBar.text];
    }
    else {
        infoLabel.hidden = acronymsTableViewContainer.hidden = YES;
    }
}


-(void) fetchAcronymsWithString:(NSString *)string {
    [[SearchManager sharedManager] getAcronymsWithString:string andCompletionHandler:^(SearchResult result, NSArray * acronyms) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result == Success) {
                infoLabel.hidden = YES;
                acronymsTableViewController.acronyms = acronyms;
                acronymsTableViewContainer.hidden = NO;
            }
            else if (result == NoResults) {
                acronymsTableViewContainer.hidden = YES;
                infoLabel.text = @"No Results";
                infoLabel.hidden = NO;
            }
            else {
                acronymsTableViewContainer.hidden = YES;
                infoLabel.text = result == ServerError ? @"Server Error" : @"JSON Error";
                infoLabel.hidden = NO;
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"acronymsTableViewEmbedSegue"]) {
        acronymsTableViewController = (AcronymsTableViewController *) segue.destinationViewController;
    }
}


@end
