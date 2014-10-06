//
//  PSROfficesMapViewController.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 03/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "PSROfficesMapViewController.h"
#import "PSROffice.h"

@import MapKit;

#import "PSROfficesParser.h"

#import "PSRPochtaManager.h"

@interface PSROfficesMapViewController () <MKMapViewDelegate>
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *offises;
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
    //if it is not our office model class annotation just return nil
    //to show annotaion of default presentation style
    if (![annotation isKindOfClass:[PSROffice class]]){
        return nil;
    }
    NSString *identifier = @"PSRMapANnotationIdentifier";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView){
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation
                                                     reuseIdentifier:identifier];
    }
    annotationView.image = [UIImage imageNamed:@"map"];
    annotationView.canShowCallout = YES;

    return annotationView;
}

#pragma mark - Private

- (void)p_parseOffices:(NSArray *)offices
{
    //get queue to perform long time calculations
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    //perform long task in background queue
    
    dispatch_async(backgroundQueue, ^{
    
        //parsing
    NSArray *parsedOffices = [[PSROfficesParser new] officesFromInfoes:offices];

        //get queue of UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        
        //perform UI updates on Main thread
        dispatch_async(mainQueue, ^{
            
            [self p_addOfficesOnMapView:parsedOffices];
        });
        
    });
}

- (void)p_addOfficesOnMapView:(NSArray *)offices
{
    //remove old offices from map at first
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    self.offises = offices;
    [self.mapView addAnnotations:self.offises];
}

@end
