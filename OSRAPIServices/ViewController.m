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
#import "FlickrClient.h"
#import "PSRPhotoCollectionViewCell.h"
#import "PSRFlickrPhoto.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *photos;
@end

@implementation ViewController

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSParameterAssert(self.collectionView);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

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

#pragma mark - UI Events

- (IBAction)requestRSS:(id)sender
{
    PSRRSSClient *client = [PSRRSSClient new];
    [self showIsCalculatingSomething:YES];
    [client getRSSFromURL:@"http://izvestia.ru/xml/rss/politics.xml"
           withComplition:^(id data, BOOL success) {
               
               [self showIsCalculatingSomething:NO];
           }];
}

- (IBAction)requestPhotos:(id)sender {
    FlickrClient *client = [FlickrClient new];
    [client getPhotosWithTag:@"Moscow"
                  complition:^(id data, BOOL success) {
                      if (success){
                          [self p_parseFlickrData:data];
                      }
                      else {
                          //show error to user or handle errror
                          NSLog(@"Something bad happend during request to flickr:\n%@",data);
                      }
                  }];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PSRPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell"
                                                                                 forIndexPath:indexPath];
    PSRFlickrPhoto *photo = [self p_photoForIndexPath:indexPath];
    [self p_configureCell:cell
                withPhoto:photo];
    return cell;
}

#pragma mark - Private
- (void)p_configureCell:(PSRPhotoCollectionViewCell *)aCell withPhoto:(PSRFlickrPhoto *)photo
{
    aCell.title.text = [photo title];
    NSData *imageData = [NSData dataWithContentsOfURL:[photo lowQualityURL]];
    UIImage *image = [UIImage imageWithData:imageData];
    aCell.image.image = image;
}

- (PSRFlickrPhoto *)p_photoForIndexPath:(NSIndexPath *)indexPath
{
    return self.photos[indexPath.row];
}

- (void)p_parseFlickrData:(id)data
{
    NSParameterAssert(data);
    NSArray *photos = [PSRFlickrPhoto photosWithInfoes:data[@"photos"][@"photo"]];
    self.photos = photos;
    [self.collectionView reloadData];
}

@end
