//
//  FlickrClient.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 30/09/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "FlickrClient.h"

@implementation FlickrClient

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:@"https://api.flickr.com/services/rest/"]];
    if (self){
        self.requestSerializer  = [AFHTTPRequestSerializer new];
        self.responseSerializer = [AFJSONResponseSerializer new];
    }
    return self;
}

- (void)getPhotosWithTag:(NSString *)tag complition:(PSRFlickrCopmlition)complitionBlock
{
    PSRFlickrCopmlition copiedComplitionBlock = [complitionBlock copy];
    NSDictionary *parameters = @{@"method" :@"flickr.photos.search",
                                 @"api_key":@"90f769c05a5f121ea4e592ea0147b916",
                                 @"tags"   :tag,
                                 @"lat":@(55),
                                 @"lon":@(37),
                                 @"radious":@(50),
                                 @"format":@"json",
                                 @"nojsoncallback":@"1"};
    [self GET:@""
   parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          copiedComplitionBlock(responseObject, YES);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          copiedComplitionBlock(error, NO);
      }];
}


- (void)getPhotosWithTagOld:(NSString *)tag complition:(PSRFlickrCopmlition)complitionBlock
{
    NSMutableURLRequest *request = [[[AFJSONRequestSerializer new] requestWithMethod:@"GET"
                                                                           URLString:@"https://api.flickr.com/services/rest/"
                                                                          parameters:@{@"method":@"flickr.photos.search",
                                                                                       @"api_key":@"5d6fa2867c7b25758c414f12192a9840",
                                                                                       @"tags":tag,
                                                                                       @"lat":@(55),
                                                                                       @"lon":@(37),
                                                                                       @"format":@"json",
                                                                                       @"nojsoncallback":@"1"}
                                                                               error:nil] mutableCopy];
    
    AFHTTPRequestOperation *tagOperation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer new];
    serializer.readingOptions = NSJSONReadingAllowFragments;
    tagOperation.responseSerializer = serializer;
    
    [tagOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [tagOperation start];
}



@end
