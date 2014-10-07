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

- (IBAction)cleanAllData:(id)sender
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [Office MR_truncateAllInContext:localContext];
    }];
}

- (IBAction)loadOffices:(id)sender
{
    [[PSRPochtaManager new] getOfficesOfCount:500 complition:^(NSArray *data, BOOL success) {
        [self p_parseOffices:[data objectEnumerator]];
    }];
}

- (void)p_parseOffices:(NSEnumerator *)officesEnumerator
{
    __block BOOL parseFinished = NO;
    int parseOfficesChankCount = 10;
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        int k = parseOfficesChankCount;
        NSDictionary *anOfficeInfo = [officesEnumerator nextObject];
        while (k-- > 0 && anOfficeInfo) {
            [Office officeWithInfo:anOfficeInfo
                        inContenxt:localContext];
        }
        if (!anOfficeInfo){
            parseFinished = YES;
        }
        [NSThread sleepForTimeInterval:0.5];
    } completion:^(BOOL success, NSError *error) {
        if (parseFinished){
            return ;
        }
        else {
[self p_parseOffices:officesEnumerator];
        }
    }];
}


#pragma mark - Super

- (NSString *)cellReuseIdentifier
{
    return @"officeCell";
}

- (NSFetchRequest *)dataRequest
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Office class])];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(title))
                                                              ascending:YES]];
    return request;
}

- (void) configureCell:(UITableViewCell *)aCell withItem:(Office *)office
{
    aCell.textLabel.text       = office.title;
    aCell.detailTextLabel.text = office.opened ? @"Открыто" : @"Закрыто";
}

@end
