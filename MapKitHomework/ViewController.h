//
//  ViewController.h
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 07.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView  *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStudents5;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStudents10;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStudents15;

- (IBAction)actionAdd:(UIBarButtonItem *)sender;
- (IBAction)actionShowAllStudents:(UIBarButtonItem *)sender;
- (IBAction)actionAddMeeting:(UIBarButtonItem *)sender;
- (IBAction)actionShowInfo:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)actionDirection:(UIBarButtonItem *)sender;


@end

