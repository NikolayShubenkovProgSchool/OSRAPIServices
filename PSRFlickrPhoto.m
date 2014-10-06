//
//  PSRFlickrPhoto.m
//  PhotosViewer
//
//  Created by n.shubenkov on 29/08/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSRFlickrPhoto.h"

@interface PSRFlickrPhoto()

@property (nonatomic,readwrite, strong) NSDictionary *info;

@end

@implementation PSRFlickrPhoto

+ (NSArray *)photosWithInfoes:(NSArray *)infoes
{
    NSMutableArray *parsedPhotos = [NSMutableArray arrayWithCapacity:infoes.count];
    
    for (int i = 0; i <infoes.count; i++) {
        NSDictionary *info = infoes[i];
    }
    [infoes enumerateObjectsUsingBlock:^(NSDictionary *anInfo, NSUInteger idx, BOOL *stop) {
        PSRFlickrPhoto *aPhoto = [self photoWithInfo:anInfo];
        [parsedPhotos addObject:aPhoto];
    }];
    //imitate long parsing process
    [NSThread sleepForTimeInterval:2];
    return parsedPhotos;
}

+ (instancetype)photoWithInfo:(NSDictionary *)info
{
    return [[self alloc]initWithInfo:info];
}

- (instancetype)initWithInfo:(NSDictionary *)info
{
    if (self = [super init]){
       _info = info;
    }
    return self;
}

- (NSURL *)highQualityURL
{
    return [self urlForQualityTag:@"b"];
}

- (NSURL *)lowQualityURL
{
    return [self urlForQualityTag:@"s"];
}

- (NSString *)title
{
    return self.info[@"title"];
}


- (NSURL *)urlForQualityTag:(NSString *)qualityTag
{
    NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_%@.jpg", [self.info objectForKey:@"farm"], [self.info objectForKey:@"server"], [self.info objectForKey:@"id"], [self.info objectForKey:@"secret"], qualityTag];
    return [NSURL URLWithString:photoURLString];
}

@end
