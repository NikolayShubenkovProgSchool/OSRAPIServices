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
@property (nonatomic, strong) NSArray *offices;
@end

@implementation PSROfficesCoreDataViewController


#pragma mark - View Lifcecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}
- (IBAction)cleanAllData:(id)sender
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [Office MR_truncateAllInContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        NSLog(@"all offices removed");
        [self update];
    }];
}

- (IBAction)loadOffices:(id)sender
{
    [[PSRPochtaManager new] getOfficesOfCount:500 complition:^(NSArray *data, BOOL success) {
        [self p_parseOffices:[data objectEnumerator]];
    }];
}

- (void)update
{
    self.offices = [Office MR_findAllSortedBy:@"title"
                                    ascending:YES];
    [self.tableView reloadData];
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
            [self update];
[self p_parseOffices:officesEnumerator];
        }
    }];
}


#pragma mark - UITableViewDataSourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.offices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"officeCell"];
    [self p_configureCell:aCell
              atIndexPath:indexPath
                 withItem:[self p_itemAtIndexPath:indexPath]];
    return aCell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (id)p_itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.offices[indexPath.row];
}

- (void)p_configureCell:(UITableViewCell *)aCell atIndexPath:(NSIndexPath *)indexPath withItem:(Office *)office
{
    aCell.textLabel.text       = office.title;
    aCell.detailTextLabel.text = office.opened ? @"Открыто" : @"Закрыто";
}


@end
