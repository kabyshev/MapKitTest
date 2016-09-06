//
//  AddressViewController.m
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 09.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import "AddressViewController.h"
#import <MapKit/MapKit.h>

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstNameLabel.text = self.firstName;
    self.lastNameLabel.text = self.lastName;
    self.genderLabel.text = (self.gender) ? @"Male" : @"Female";
    self.yearLabel.text = self.birthYear;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [self.view setBackgroundColor:[UIColor clearColor]];
    } else {
        [cell setBackgroundColor:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.8f]];
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.6f]];
    }
    
}

@end
