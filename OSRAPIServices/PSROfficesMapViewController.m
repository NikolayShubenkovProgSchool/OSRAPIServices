//
//  PSROfficesMapViewController.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 03/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSROfficesMapViewController.h"

@import MapKit;

#import "PSROfficesParser.h"

#import "PSRPochtaManager.h"

@interface PSROfficesMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PSROfficesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    // Do any additional setup after loading the view.
}

- (IBAction)showOfficesPressed:(id)sender {
    [[PSRPochtaManager new] getOfficesOfCount:300
                                   complition:^(id data, BOOL success) {
                                       if (success){
                                           [self p_parseOffices:data];
                                       }
                                       else {
                                           NSLog(@"recieved error when tried to get offices:\n%@",data);
                                       }
                                   }];
}

#pragma mark - MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    return nil;
}

#pragma mark - Private

- (void)p_parseOffices:(NSArray *)offices
{
    NSArray *parsedOffices = [[PSROfficesParser new] officesFromInfoes:offices];
    NSLog(@"Parsed Offices:\n%@",parsedOffices);
}

@end
