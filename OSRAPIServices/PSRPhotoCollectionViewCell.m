//
//  PSRPhotoCollectionViewCell.m
//  OSRAPIServices
//
//  Created by n.shubenkov on 03/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//


#import "PSRPhotoCollectionViewCell.h"

@interface PSRPhotoCollectionViewCell ()

@property (nonatomic, copy) NSURL *currentURL;
@property (nonatomic, strong) UIImage *cachedImage;
@end

@implementation PSRPhotoCollectionViewCell

- (void)applyImageWithURL:(NSURL *)url
{
    if ([self.currentURL isEqual:url]){
        self.image.image = self.cachedImage;
        return;
    }
    self.currentURL = url;
    self.image.image = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
        self.cachedImage = image;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.currentURL isEqual:url]){
                self.image.image = image;
            }
        });
        
    });
    
}

@end
