//
//  MKMeetingAnnotation.h
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 11.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMeetingAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
