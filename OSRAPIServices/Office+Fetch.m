//
//  Office+Fetch.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "Office+Fetch.h"
#import <CoreData+MagicalRecord.h>


@implementation Office (Fetch)


+ (Office *)officeWithInfo:(NSDictionary *)info inContenxt:(NSManagedObjectContext *)context
{
    Office *office = [self officeWithID:info[@"postalCode"] context:context];
    if (!office){
        office = [self createOfficeWithID:info[@"postalCode"] context:context];
    }
    [self parseOffice:office withInfo:info];
    return office;
}

+ (void)parseOffice:(Office *)office withInfo:(NSDictionary *)info
{
    office.title  = info[@"addressSource"];
    office.opened = ![info[@"isClosed"] boolValue];
    
}

+ (Office *)createOfficeWithID:(NSString *)idValue context:(NSManagedObjectContext *)context
{
    NSParameterAssert([idValue integerValue] != 0);
    Office *office = [Office MR_createInContext:context];
    office.idValue = idValue;
    return office;
}

+ (Office *)officeWithID:(NSString *)idValue context:(NSManagedObjectContext *)context
{
    NSParameterAssert([idValue integerValue] != 0);
    //idValue = 823778
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",NSStringFromSelector(@selector(idValue)) ,idValue];
    
    NSArray *offices = [Office MR_findAllWithPredicate:predicate
                                             inContext:context];
    NSParameterAssert(offices.count <= 1);
    return [offices firstObject];
}

@end
