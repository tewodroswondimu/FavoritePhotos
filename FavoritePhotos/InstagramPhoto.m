//
//  InstagramPhoto.m
//  FavoritePhotos
//
//  Created by Tewodros Wondimu on 1/22/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "InstagramPhoto.h"

@implementation InstagramPhoto

- (instancetype)initInstagramPhotoWithFilter:(NSString *)filter type:(NSString *)type link:(NSString *)link images:(NSDictionary *)images captions:(NSDictionary *)captions location:(NSDictionary *)location user:(NSDictionary *)user comments:(NSDictionary *)comments likes:(NSDictionary *)likes
{
    self = [super init];
    if (self) {
        self.filter = filter;
        self.type = type;

        self.link = [NSURL URLWithString:link];

        self.images = images;
        self.caption = captions;
        self.location = location;
        self.user = user;
        self.comments = comments;
        self.likes = likes;

        self.standardImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:images[@"standard_resolution"][@"url"]]]];
        self.lowResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:images[@"low_resolution"][@"url"]]]];
        self.lowResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:images[@"thumbnail"][@"url"]]]];
    }
    return self;
}

@end
