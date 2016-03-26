//
//  MainViewController.h
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *acronymsSearchBar;
@property (strong, nonatomic) IBOutlet UIView *acronymsTableViewContainer;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;


@end
