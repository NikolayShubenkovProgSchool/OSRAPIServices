//
//  ViewController.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 30/09/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showIsCalculatingSomething:YES];
    [self performSelector:@selector(showIsCalculatingSomething:)
               withObject:nil
               afterDelay:1];
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
@end
