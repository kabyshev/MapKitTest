//
//  AddressViewController.h
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 09.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface AddressViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UILabel *genderLabel;
@property (nonatomic, weak) IBOutlet UILabel *countryLabel;
@property (nonatomic, weak) IBOutlet UILabel *cityLabel;
@property (nonatomic, weak) IBOutlet UILabel *thoroughfareLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorCountry;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorCity;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorAddress;

@property (nonatomic, strong) Student *student;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *birthYear;
@property (nonatomic, assign) BOOL gender;

@end
