//
//  Student.h
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 07.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Student : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) BOOL male;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

+ (Student *)generateStudent;

@end