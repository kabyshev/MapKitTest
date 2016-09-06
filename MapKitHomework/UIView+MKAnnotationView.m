//
//  UIView+MKAnnotationView.m
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 10.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MapKit.h>

@implementation UIView (MKAnnotationView)

- (MKAnnotationView *)superAnnotationView {
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView *)self;
    }
    if (!self.superview) {
        return nil;
    }
    return [self.superview superAnnotationView];
}

@end
