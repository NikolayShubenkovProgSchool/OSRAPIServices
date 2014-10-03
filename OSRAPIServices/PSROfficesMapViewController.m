//
//  PSROfficesMapViewController.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 03/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSROfficesMapViewController.h"
#import "PSRPochtaManager.h"

@interface PSROfficesMapViewController ()

@end

@implementation PSROfficesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showOfficesPressed:(id)sender {
    [[PSRPochtaManager new] getOfficesOfCount:300
                                   complition:^(id data, BOOL success) {
                                       
                                   }];
}
@end
