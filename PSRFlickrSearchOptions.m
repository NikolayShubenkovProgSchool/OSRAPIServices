//
//  FlickrSearchOptions.m
//  PhotosViewer
//
//  Created by n.shubenkov on 29/08/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSRFlickrSearchOptions.h"

@implementation PSRFlickrSearchOptions

- (void)setTags:(NSArray *)tags
{
    _tags = tags;
}

- (instancetype)initWithTags:(NSArray *)tags
{
//    NSParameterAssert(tags.count > 0);
    if (self  = [super init]){
        _tags = tags;
    }
    return self;
}

- (NSString *)defaultString
{
    return [NSString stringWithFormat:@"&format=json&nojsoncallback=1"];
}

- (NSString *)requestString
{
    NSMutableString *searchString = [[NSString stringWithFormat:@"&tags=%@",[self.tags componentsJoinedByString:@","]] mutableCopy];
    [searchString appendString:[self defaultString]];
    if (self.contentType){
        [searchString appendFormat:@"&contentType=%d",self.contentType];
    }
    if (self.coordinate.latitude != 0 && self.coordinate.longitude != 0){
        [searchString appendFormat:@"&lat=%.4f&lon=%.4f",self.coordinate.latitude, self.coordinate.longitude];
    }
    if (self.radiousKilometers > 0.01){
        [searchString appendFormat:@"&radious=%.2f",self.radiousKilometers];
    }
    if (self.extra){
        [searchString appendFormat:@"&extra=%@",[self.extra componentsJoinedByString:@","]];
    }
    if (self.page > 0){
        [searchString appendFormat:@"&page=%d",self.page];
    }
    if (self.itemsLimit > 0){
        [searchString appendFormat:@"&per_page=%d",self.itemsLimit];
    }
    return [searchString copy];
}

- (NSDictionary *)parameters
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setValue:[NSString stringWithFormat:@"&tags=%@",[self.tags componentsJoinedByString:@","]]
                                              forKey:@"tags"];
    [dictionary setValue:@(self.contentType)
                  forKey:@"contentType"];
    [dictionary setValue:CLLocationCoordinate2DIsValid(self.coordinate) ? @(self.coordinate.latitude) : nil
                  forKey:@"lat"];
    [dictionary setValue:CLLocationCoordinate2DIsValid(self.coordinate) ? @(self.coordinate.longitude) : nil
                  forKey:@"lon"];
    [dictionary setValue:self.radiousKilometers > 0 ? @(self.radiousKilometers) : nil
                  forKey:@"radious"];
    [dictionary setValue:@(self.page)
                  forKey:@"page"];
    [dictionary setValue:self.itemsLimit > 0 ? @(self.itemsLimit) : nil
                  forKey:@"per_page"];
    [dictionary setValue:@"82022260ce75b85778f8efc33e4bdf04"
                  forKey:@"api_key"];
    return dictionary;
}

@end
