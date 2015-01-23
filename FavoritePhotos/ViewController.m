//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Tewodros Wondimu on 1/22/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "InstagramCollectionViewCell.h"
#import "InstagramPhoto.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *instagramPhotosCollectionView;
@property NSMutableArray *instagramPhotos;
@property NSMutableArray *instagramImages;

@property NSString *clientID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.clientID = @"db760878ce144d559ea6193a13d23d93";
    self.instagramPhotos = [NSMutableArray new];
    self.instagramImages = [NSMutableArray new];
    self.instagramPhotosCollectionView.delegate = self;

    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=%@", self.clientID];
    [self getInstagramPhotoFromJSONURLString:url];
}

- (void)getInstagramPhotoFromJSONURLString:(NSString *)url
{
    [self.instagramPhotos removeAllObjects];

    // Create a url from the string
    NSURL *jsonURL = [NSURL URLWithString:url];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:jsonURL];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        // Create a dictionary of the results
        NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        NSArray *resultsInstagramPhotosArray = resultsDictionary[@"data"];

        // Loops through the results array of instagram photos
        for (NSDictionary *resultInstagramPhotoDictionary in resultsInstagramPhotosArray) {


            NSString *filter = resultInstagramPhotoDictionary[@"filter"];
            NSString *type = resultInstagramPhotoDictionary[@"type"];

            NSString *link = resultInstagramPhotoDictionary[@"link"];

            NSDictionary *user = resultInstagramPhotoDictionary[@"user"];
            NSDictionary *location = resultInstagramPhotoDictionary[@"location"];
            NSDictionary *comments = resultInstagramPhotoDictionary[@"comments"];
            NSDictionary *likes = resultInstagramPhotoDictionary[@"likes"];
            NSDictionary *images = resultInstagramPhotoDictionary[@"images"];
            NSDictionary *caption = resultInstagramPhotoDictionary[@"caption"];


            InstagramPhoto *instagramPhoto = [[InstagramPhoto alloc] initInstagramPhotoWithFilter:filter type:type link:link images:images captions:caption location:location user:user comments:comments likes:likes];

            // Add the instagram photo to the instagram photo array
            [self.instagramPhotos addObject:instagramPhoto];
            [self.instagramImages addObject:instagramPhoto.standardImage];
            NSLog(@"%lu", self.instagramImages.count);
            [self.instagramPhotosCollectionView reloadData];
        }

        // Make an annotation for every bus stop
//        for (InstagramPhoto *instagramPhoto in self.instagramPhotos) {
//            BusStopAnnotation *annotation = [BusStopAnnotation new];
//            annotation.coordinate = busStop.coordinate;
//            annotation.title = busStop.busStopName;
//            annotation.subtitle = busStop.routes;
//            annotation.busStop = busStop;
//
//            [self.mapView addAnnotation:annotation];
//            [self.tableView reloadData];
//        }
    }];
}

#pragma mark COLLECTION VIEW

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InstagramCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InstagramPhotoCell" forIndexPath:indexPath];;
    cell.imageView.image = [self.instagramImages objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.instagramPhotos.count;
}

@end
