//
//  InstagramPhoto.h
//  FavoritePhotos
//
//  Created by Tewodros Wondimu on 1/22/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InstagramPhoto : NSObject

@property id instagramPhotoId; 

@property NSString *filter;
@property NSString *type;

@property long *created_time;

@property NSURL *link;

@property NSDictionary *images;
@property NSDictionary *caption;
@property NSDictionary *location;
@property NSDictionary *user;
@property NSDictionary *comments;
@property NSDictionary *likes;

@property UIImage *standardImage;
@property UIImage *thumbnailImage;
@property UIImage *lowResolutionImage; 

- (instancetype)initInstagramPhotoWithFilter:(NSString *)filter type:(NSString *)type link:(NSString *)link images:(NSDictionary *)images captions:(NSDictionary *)captions location:(NSDictionary *)location user:(NSDictionary *)user comments:(NSDictionary *)comments likes:(NSDictionary *)likes;

@end
