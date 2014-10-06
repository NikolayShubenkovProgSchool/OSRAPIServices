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
    return nil;
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
            
        });
        
    });
}

@end
