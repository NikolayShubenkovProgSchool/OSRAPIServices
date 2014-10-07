//
//  PSRPhotosCoreDataViewController.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSROfficesCoreDataViewController.h"

#import <CoreData+MagicalRecord.h>

#import "Office+Fetch.h"

#import "PSRPochtaManager.h"



@interface PSROfficesCoreDataViewController ()

@end

@implementation PSROfficesCoreDataViewController


#pragma mark - View Lifcecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loadOffices:(id)sender
{
    [[PSRPochtaManager new] getOfficesOfCount:500 complition:^(id data, BOOL success) {
        [self p_parseOffices:data];
    }];
}

- (void)p_parseOffices:(NSArray *)offices
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        NSMutableArray *parsedOffices = [NSMutableArray new];
        
        for (NSDictionary *anOfficeInfo in offices){
            [Office officeWithInfo:anOfficeInfo
                        inContenxt:localContext];
        }
    } completion:^(BOOL success, NSError *error) {
        
    }];

}

@end
