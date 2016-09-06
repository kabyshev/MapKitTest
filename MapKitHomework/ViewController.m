//
//  ViewController.m
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 07.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "MKMapAnnotation.h"
#import "AddressViewController.h"
#import "UIView+MKAnnotationView.h"
#import "MKMeetingAnnotation.h"

typedef enum {
    Female = 0,
    Male = 1
} Gender;

typedef enum {
    Distance5 = 1,
    Distance10 = 2,
    Distance15 = 3
} StudentDistance;

@interface ViewController () <MKMapViewDelegate>

@property (nonatomic, strong) NSMutableArray *studentsArray;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) CLGeocoder *geoCoder;
@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
@property (nonatomic, assign) CLLocationCoordinate2D meetingCoordinate;
@property (strong, nonatomic) MKDirections* directions;

@property (nonatomic, assign) BOOL infoButtonPressed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
    
    self.studentsArray = [NSMutableArray array];
    self.annotations = [NSMutableArray array];
    self.geoCoder = [[CLGeocoder alloc] init];
    self.infoButtonPressed = NO;
    
#ifdef TARGET_OS_SIMULATOR
    self.userLocation = CLLocationCoordinate2DMake(54.192566, 45.174334);
#else
    self.userLocation = self.mapView.userLocation.coordinate;
#endif
    
    for (NSInteger i = 0; i < 10 + arc4random() % 21; i++) {
        Student *student = [Student generateStudent];
        
        student.coordinate = CLLocationCoordinate2DMake(
        self.userLocation.latitude - (CGFloat)(arc4random() % 200) / 1000 + (CGFloat)(arc4random() % 220) / 1000,
        self.userLocation.longitude - (CGFloat)(arc4random() % 200) / 1000 + (CGFloat)(arc4random() % 220) / 1000); // generating student coordinate
        
        [self.studentsArray addObject:student];
        
        /* creating annotation and adding it in array of annotations */
        
        MKMapAnnotation* annotation = [[MKMapAnnotation alloc] init];
        annotation.title = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        annotation.subtitle = [NSString stringWithFormat:@"%ld", (long)student.year];
        annotation.coordinate = student.coordinate;
        [self.annotations addObject:annotation];
    }
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    // When the drag state changes to MKAnnotationViewDragStateStarting, set the state to MKAnnotationViewDragStateDragging. If you perform an animation to indicate the beginning of a drag, and the animated parameter is YES, perform that animation before changing the state.
    
    // When the state changes to either MKAnnotationViewDragStateCanceling or MKAnnotationViewDragStateEnding, set the state to MKAnnotationViewDragStateNone. If you perform an animation at the end of a drag, and the animated parameter is YES, you should perform that animation before changing the state.
    
    if (newState == MKAnnotationViewDragStateStarting) {
        view.dragState = MKAnnotationViewDragStateDragging;
    }
    else if (newState == MKAnnotationViewDragStateEnding || newState == MKAnnotationViewDragStateCanceling) {
        view.dragState = MKAnnotationViewDragStateNone;
        self.meetingCoordinate = view.annotation.coordinate; // change meetingCoordinate
        [self createCircleOverlays]; // create new circle overlays
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* studentIdentifier = @"StudentAnnotation";
    static NSString* meetingIdentifier = @"MeetingAnnotation";
    
    MKAnnotationView* annotationView;
    
    if ([annotation isKindOfClass:[MKMapAnnotation class]]) {
        
        annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:studentIdentifier];
        
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:studentIdentifier];
            annotationView.canShowCallout = YES;
            annotationView.draggable = NO;
            UIImage *image = [ViewController imageWithImage:[UIImage imageNamed:@"man.png"] scaledToSize:CGSizeMake(100.f, 100.f)];
            annotationView.image = image;
            
            UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [infoButton addTarget:self action:@selector(actionInfo:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = infoButton;
            
        } else {
            annotationView.annotation = annotation;
        }
    }
    else {
        annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:meetingIdentifier];
        
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:meetingIdentifier];
            annotationView.canShowCallout = YES;
            annotationView.draggable = YES;
            annotationView.image = [UIImage imageNamed:@"meetingLogo.png"];
        } else {
            annotationView.annotation = annotation;
        }
        
        [self createCircleOverlays];
    }
    
    return annotationView;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {

    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [self randomColor];
        return renderer;
    }
    
    if ([overlay isKindOfClass:[MKCircle class]]) {
        
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.fillColor = [UIColor colorWithRed:0.f green:0.f blue:0.8f alpha:0.07f];
        renderer.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.3f];
        
        return renderer;
    }
    return nil;
}

- (void)createCircleOverlays {
    
    [self.mapView removeOverlays:[self.mapView overlays]]; // deleting all old overlays
    
    MKCircle *circle5 = [MKCircle circleWithCenterCoordinate:self.meetingCoordinate radius:5000];
    MKCircle *circle10 = [MKCircle circleWithCenterCoordinate:self.meetingCoordinate radius:10000];
    MKCircle *circle15 = [MKCircle circleWithCenterCoordinate:self.meetingCoordinate radius:15000];
    [self.mapView addOverlays:@[circle5, circle10, circle15] level:MKOverlayLevelAboveRoads];
    
    [self countStudents];
}

#pragma mark - Actions

- (IBAction)actionAdd:(UIBarButtonItem *)sender {
    
    [self.mapView addAnnotations:self.annotations];
}

- (IBAction)actionShowAllStudents:(UIBarButtonItem *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        static double delta = 20000;
        CLLocationCoordinate2D location = annotation.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(100, 50, 50, 50)
                           animated:YES];
}

- (IBAction)actionAddMeeting:(UIBarButtonItem *)sender {
    
    MKMeetingAnnotation* annotation = [[MKMeetingAnnotation alloc] init];
    annotation.title = @"Student meeting!";
    annotation.subtitle = @"Party for everybody (not)";
    annotation.coordinate = self.meetingCoordinate = CLLocationCoordinate2DMake(
                               self.userLocation.latitude - 0.02 + (CGFloat)(arc4random() % 60) / 1000,
                               self.userLocation.longitude - 0.02 + (CGFloat)(arc4random() % 60) / 1000);
    
    [self.mapView addAnnotation:annotation];
}

/* shows number of students in every overlay */

- (IBAction)actionShowInfo:(UIButton *)sender forEvent:(UIEvent *)event {
    
    [UITableView animateWithDuration:0.5f
                          animations:^{
                              if (self.infoButtonPressed) {
                                  self.infoView.hidden = YES;
                                  self.infoButtonPressed = NO;
                              } else  {
                                  self.infoView.hidden = NO;
                                  self.infoButtonPressed = YES;
                              }
                          }
                          completion:nil];
}

- (IBAction)actionDirection:(UIBarButtonItem *)sender {
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.meetingCoordinate
                                                              addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark]; // destination - meeting place
    
    for (NSInteger i = 0; i < [self.annotations count]; i++) {
        
        MKMapAnnotation *annotationView = self.annotations[i];
        Student *student = self.studentsArray[i];
        
        CGFloat probabilityProcent;
        NSInteger distanceCoefficient = [self findStudentDistance:student];
        
        // with probability = distanceCoefficient we'll draw direction
        
        if (distanceCoefficient == Distance5)       probabilityProcent = 90;
        else if (distanceCoefficient == Distance10) probabilityProcent = 60;
        else if (distanceCoefficient == Distance15) probabilityProcent = 30;
        else                                        probabilityProcent = 10;
        
        BOOL drawDistance = (arc4random() % 101) <= probabilityProcent; // draw direction or not

        if (!drawDistance) {
            continue; // if drawDistance = NO, don't draw direction
        }
        
        MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:annotationView.coordinate
                                                             addressDictionary:nil];
        MKMapItem *source = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
        
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        request.source = source;
        request.destination = destination;
        request.transportType = MKDirectionsTransportTypeAny;
        request.requestsAlternateRoutes = YES;
        
        self.directions = [[MKDirections alloc] initWithRequest:request];
        
        [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Error: %@", [error localizedDescription]);
            } else if (response.routes == 0) {
                NSLog(@"Routes = 0");
            } else {
                
                NSMutableArray* array = [NSMutableArray array];
                
                for (MKRoute* route in response.routes) {
                    [array addObject:route.polyline];
                }
                
                [self.mapView addOverlays:array level:MKOverlayLevelAboveRoads];
            }
        }];
    }
}

- (void)actionInfo:(UIButton *)sender {
    
    AddressViewController *vc;
    
    [self setViewController:vc
            phoneIdentifier:@"AddressViewController"
              padIdentifier:@"AddressViewController"
                  andSender:sender];
}

#pragma mark - Popovers

- (void)setViewController:(AddressViewController *)vc phoneIdentifier:(NSString *)identifierPhone padIdentifier:(NSString *)identifierPad andSender:(id)sender {

    UIPopoverPresentationController *popoverController;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        vc = [self.storyboard instantiateViewControllerWithIdentifier:identifierPhone];
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        vc.view.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.6f];
        popoverController = [vc popoverPresentationController];
        
    } else {
        
        vc = [self.storyboard instantiateViewControllerWithIdentifier:identifierPad];
        vc.modalPresentationStyle = UIModalPresentationPopover;
        
        popoverController = [vc popoverPresentationController];
        popoverController.sourceView = sender;
        popoverController.presentingViewController.view.alpha = 0.2;
    }
    
    popoverController.permittedArrowDirections = UIPopoverArrowDirectionAny;

    MKAnnotationView *annotationView = [sender superAnnotationView];
    MKMapAnnotation *annotation = annotationView.annotation;
    NSString *fullName = annotation.title;
    NSArray *nameComponents = [fullName componentsSeparatedByString:@" "];
    NSString *name = [nameComponents firstObject];
    NSString *surname = [nameComponents lastObject];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        vc.firstNameLabel.text = name;
        vc.lastNameLabel.text = surname;
        vc.genderLabel.text = @"Male";
        vc.yearLabel.text = [NSString stringWithFormat:@"%@", annotation.subtitle];
    }
    else {
        [vc setFirstName:name];
        [vc setLastName:surname];
        [vc setGender:Male];
        [vc setBirthYear:annotation.subtitle];
    }
    
    [self getLocationFromViewController:(AddressViewController *)vc andCoordinate:annotation.coordinate];
    
    [self presentViewController:vc animated:YES completion:^{
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }];
}

#pragma mark - Help Methods

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)getLocationFromViewController:(AddressViewController *)vc andCoordinate:(CLLocationCoordinate2D)coordinate {
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            
            MKPlacemark* placeMark = [placemarks firstObject];
            
            vc.countryLabel.text = placeMark.country;
            [vc.activityIndicatorCountry stopAnimating];
            vc.cityLabel.text = (placeMark.locality) ? placeMark.locality : @"Not found";
            [vc.activityIndicatorCity stopAnimating];
            
            NSString *thoroughfareAvailable = [NSString stringWithFormat:@"%@, %@", placeMark.thoroughfare, placeMark.subThoroughfare];
            NSString *thoroughfareUnavailable = @"Not found";
            
            vc.thoroughfareLabel.text = (placeMark.thoroughfare && placeMark.subThoroughfare) ? thoroughfareAvailable : thoroughfareUnavailable;
            [vc.activityIndicatorAddress stopAnimating];
        }
    }];
}

- (CLLocationDistance)findDistanceWithCoordinate:(CLLocationCoordinate2D)studentCoordinate {
    
    CLLocation *studentLocation = [[CLLocation alloc] initWithLatitude:studentCoordinate.latitude longitude:studentCoordinate.longitude];
    CLLocation *meetingLocation = [[CLLocation alloc] initWithLatitude:self.meetingCoordinate.latitude longitude:self.meetingCoordinate.longitude];
    
    CLLocationDistance distance = [studentLocation distanceFromLocation:meetingLocation];
    
    return distance;
}

- (void)countStudents {
    
    NSInteger counter5 = 0, counter10 = 0, counter15 = 0;
    
    for (NSInteger i = 0; i < [self.studentsArray count]; i++) {
        
        Student *student = [self.studentsArray objectAtIndex:i];
        
        CLLocationDistance distance = [self findDistanceWithCoordinate:student.coordinate];
        
        if (distance <= 5000)       counter5++;
        else if (distance <= 10000) counter10++;
        else if (distance <= 15000) counter15++;
    }
    
    self.numberOfStudents5.text  = [NSString stringWithFormat:@"%ld", (long)counter5];
    self.numberOfStudents10.text = [NSString stringWithFormat:@"%ld", (long)counter10];
    self.numberOfStudents15.text = [NSString stringWithFormat:@"%ld", (long)counter15];
}

- (NSInteger)findStudentDistance:(Student *)student {
    
    CLLocationDistance distance = [self findDistanceWithCoordinate:student.coordinate];
    
    if (distance <= 5000)       return Distance5;
    else if (distance <= 10000) return Distance10;
    else if (distance <= 15000) return Distance15;

    return -1;
}

- (UIColor *)randomColor {
    CGFloat red   = (CGFloat)(arc4random() % 256) / 255;
    CGFloat green = (CGFloat)(arc4random() % 256) / 255;
    CGFloat blue  = (CGFloat)(arc4random() % 256) / 255;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:0.9f];
}

#pragma mark - Deallocation

- (void)dealloc {
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
}

@end