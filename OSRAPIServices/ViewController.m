//
//  ViewController.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 30/09/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

#import "PSRRSSClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)showIsCalculatingSomething:(BOOL)calculating
{
    if (calculating){
        [MBProgressHUD showHUDAddedTo:self.view
                             animated:YES];
    }
    else {
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
    }
}
- (IBAction)requestRSS:(id)sender
{
    PSRRSSClient *client = [PSRRSSClient new];
    [self showIsCalculatingSomething:YES];
    [client getRSSFromURL:@"http://izvestia.ru/xml/rss/politics.xml"
           withComplition:^(id data, BOOL success) {
               
               [self showIsCalculatingSomething:NO];
           }];
}
@end
