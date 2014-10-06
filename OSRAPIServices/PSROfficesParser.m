//
//  PSROfficesParser.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSROfficesParser.h"

#import "PSROffice.h"

@import MapKit;

@implementation PSROfficesParser

- (NSArray *)officesFromInfoes:(NSArray *)infoes
{
    
    NSMutableArray *array    = [NSMutableArray new];
    for (NSDictionary *anInfo in infoes){
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude  = [anInfo[@"latitude"] doubleValue];
        coordinate.longitude = [anInfo[@"longitude"] doubleValue];
        PSROffice *office = [[PSROffice alloc]initWithCoordinate:coordinate address:anInfo[@"addressSource"]];
        [array addObject:office];
    }
    return array;
}


@end
