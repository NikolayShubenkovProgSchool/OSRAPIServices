//
//  PSRPochtaManager.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 03/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSRPochtaManager.h"
#import "AFNetworking.h"

//NSString *const kRPIAddress = @"http://95.128.178.180:5432";
//
//@implementation RPIAPIClient
//
//#pragma mark - public -
//
//+ (instancetype) shared
//{
//    static dispatch_once_t onceToken = 0;
//    static __strong RPIAPIClient *_sharedObject;
//    dispatch_once(&onceToken, ^{
//        _sharedObject = [[self alloc] initWithBaseURL:[NSURL URLWithString:kRPIAddress]];
//        _sharedObject.operationQueue.maxConcurrentOperationCount = 4;
//        [_sharedObject registerHTTPOperationClass:[AFJSONRequestOperation class]];
//        _sharedObject.parameterEncoding = AFFormURLParameterEncoding;
//        [_sharedObject setDefaultHeader:@"Accept"
//                                  value:@"application/json; charset=utf-8"];
//        
//        [_sharedObject setDefaultHeader:@"Accept-Charset" value:@"utf-8"];
//        
//        [_sharedObject setDefaultHeader:@"User-Agent"
//                                  value:@"RussianPost/2.1"];
//        
//        [_sharedObject setDefaultHeader:@"MobileApiAccessToken"
//                                  value:@"Yi5GaWMTY8x27uEPte0/l9vfrZw="];
//        
//    });
//    return _sharedObject;
//}
//
//- (NSMutableDictionary *)p_defaultParameters
//{
//    NSDateFormatter *formatter1 = [NSDateFormatter new];
//    formatter1.dateFormat = @"YYYY-MM-dd";
//    NSDateFormatter *formatter2 = [NSDateFormatter new];
//    formatter2.dateFormat = @"HH:mm:ss";
//    NSString *yearMonthday = [formatter1 stringFromDate:[NSDate date]];
//    NSString *hourMoniteSecond = [formatter2 stringFromDate:[NSDate date]];
//    
//    NSString *time = [NSString stringWithFormat:@"%@T%@",yearMonthday,hourMoniteSecond];
//    return [@{
//              @"currentDateTime"  :time,
//              } mutableCopy];
//    
//}
//
//- (void)getAllOfficesNearLongitude:(double)longitude latitude:(double)latitude withSuccess:(RPIApiSuccessBlock)success failure:(RPIApiFailureBlock)failure
//{
//    int top                = 500;//max offices count
//    int radius             = 5000;
//    NSString *type = @"ALL";
//    NSMutableDictionary *parameters = [self p_defaultParameters];
//    [parameters addEntriesFromDictionary:@{
//                                           @"top"              :@(top),
//                                           @"latitude"         :@(latitude),
//                                           @"longitude"        :@(longitude),
//                                           @"searchRadius"     :@(radius),
//                                           @"type"             :type
//                                           }];
//    
//    [self getPath:@"mobile-api/method/offices.find.nearby"
//       parameters:parameters
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              if (success){
//                  success(responseObject);
//              }
//          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              if (failure){
//                  failure(error);
//              }
//          }];
//}

//- (NSDictionary *)officesFromBundle
//{
//    NSURL *fileUrl = [[NSBundle mainBundle]  URLForResource:@"pochta_json" withExtension:@"txt"];
//    NSParameterAssert(fileUrl);
//    NSError *error = nil;
//    NSString *string = [[NSString alloc]initWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:&error];
//    NSParameterAssert(string && !error);
//    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
//                                                         options:0
//                                                           error:&error];
//    return data;
//}
//
//@end


@implementation PSRPochtaManager

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:@"http://95.128.178.180:5432"]];
    if (self){
        
        
        self.requestSerializer = [AFHTTPRequestSerializer new];
        self.responseSerializer = [AFJSONResponseSerializer new];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"application/json"] ];
    }
    return self;
}

- (void)getOfficesOfCount:(int)count complition:(PSRPochtaCopmlition)complitionBlock
{
    PSRPochtaCopmlition copiedComplitionBlock = [complitionBlock copy];
    NSMutableDictionary *parameters = [self p_defaultParameters];
    
    int top                = 500;//max offices count
    int radius             = 5000;
    NSString *type = @"ALL";
    [parameters addEntriesFromDictionary:@{
                                           @"top"              :@(top),
                                           @"latitude"         :@(37),
                                           @"longitude"        :@(57),
                                           @"searchRadius"     :@(radius),
                                           @"type"             :type
                                           }];
    
    [self GET:@"mobile-api/method/offices.find.nearby"
   parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          copiedComplitionBlock(responseObject, YES);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          copiedComplitionBlock(error, NO);
      }];
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    /*
     //        [_sharedObject registerHTTPOperationClass:[AFJSONRequestOperation class]];
     //        _sharedObject.parameterEncoding = AFFormURLParameterEncoding;
     //        [_sharedObject setDefaultHeader:@"Accept"
     //                                  value:@"application/json; charset=utf-8"];
     //
     //        [_sharedObject setDefaultHeader:@"Accept-Charset" value:@"utf-8"];
     //
     //        [_sharedObject setDefaultHeader:@"User-Agent"
     //                                  value:@"RussianPost/2.1"];
     //
     //        [_sharedObject setDefaultHeader:@"MobileApiAccessToken"
     //                                  value:@"Yi5GaWMTY8x27uEPte0/l9vfrZw="];*/
    
    [request setValue:@"Accept"
   forHTTPHeaderField:@"application/json; charset=utf-8"];
    
    [request setValue:@"RussianPost/2.1"
   forHTTPHeaderField:@"User-Agent"];

    //  как хорошо, когда апи почты говорит в чем проблема
    //{"code":"1005","desc":"Request is not authorized: Access token was either missing or invalid."}

    [request setValue:@"Yi5GaWMTY8x27uEPte0/l9vfrZw="
   forHTTPHeaderField:@"MobileApiAccessToken"];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (NSMutableDictionary *)p_defaultParameters
{
    NSDateFormatter *formatter1 = [NSDateFormatter new];
    formatter1.dateFormat = @"yyyy-MM-dd";
    NSDateFormatter *formatter2 = [NSDateFormatter new];
    formatter2.dateFormat = @"HH:mm:ss";
    NSString *yearMonthday = [formatter1 stringFromDate:[NSDate date]];
    NSString *hourMoniteSecond = [formatter2 stringFromDate:[NSDate date]];
    
    NSString *time = [NSString stringWithFormat:@"%@T%@",yearMonthday,hourMoniteSecond];
    return [@{
              @"currentDateTime"  :time,
              } mutableCopy];
    
}

@end
