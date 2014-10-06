//
//  PSROffice.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSROffice.h"

@interface PSROffice ()

@property (nonatomic) CLLocationCoordinate2D internalCoordinate;

@end


@implementation PSROffice

- (NSString *)title
{
    return self.address;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.internalCoordinate;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate address:(NSString *)address
{
    self = [super init];
    if (self){
        _internalCoordinate = coordinate;
        _address = [address copy];
    }
    return self;
}

- (NSString *)description
{
    NSDictionary *descr = @{@"cooddinate" : @{@"long":@(self.coordinate.longitude),
                                              @"lat" :@(self.coordinate.latitude)},
                            @"address" : self.address};
    return [NSString stringWithFormat:@"%@\n%@",[super description],descr];
}

@end
