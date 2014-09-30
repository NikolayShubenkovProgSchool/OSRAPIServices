//
//  PSRRSSClient.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 30/09/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSRRSSClient.h"
#import <AFNetworking/AFNetworking.h>
#import <TBXML.h>

@implementation PSRRSSClient

#pragma mark - Public

- (void)getRSSFromURL:(NSString *)url withComplition:(PSRRSSCopmlition)copmlitionBlock
{
    NSParameterAssert(url);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:[self p_requestWithURL:url]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        TBXML *parsedXML = [[TBXML alloc]initWithXMLData:responseObject
                                                   error:nil];
        
        copmlitionBlock(parsedXML,YES);
    
        
    
    
    }
     
     
     
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         copmlitionBlock(error, NO);
        
    }];
    
    [operation start];    
}

#pragma mark - Private


- (NSURLRequest *)p_requestWithURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSParameterAssert(url);
    return [[NSURLRequest alloc]initWithURL:url];
}

@end
