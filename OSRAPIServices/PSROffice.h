//
//  PSROffice.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface PSROffice : NSObject <MKMapViewDelegate>


// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, copy) NSString *address;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate address:(NSString *)address;

- (NSString *)description;

@end
