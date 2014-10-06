//
//  PSROfficesMapViewController.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 03/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSROfficesMapViewController.h"

@import MapKit;

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
                                       
                                   }];
}

#pragma mark - MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    return nil;
}

@end
