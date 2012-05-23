//
//  ViewController.m
//  WhereAmI
//
//  Created by Li Emck on 12-05-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize myLocalManager;
@synthesize myMapView;
@synthesize myAccuracyLable;
@synthesize myLatitudeLable;
@synthesize myLongitudeLable;
@synthesize geocoder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myMapView.delegate = self;
    
    self.myLocalManager = [[CLLocationManager alloc] init];
    myLocalManager.delegate = self;
    myLocalManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    myLocalManager.distanceFilter = kCLDistanceFilterNone;
    [myLocalManager startUpdatingLocation];
    
//    geocoder = [[CLGeocoder alloc] init];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {    
    if ([annotation isKindOfClass:[MyAnnotation class]] == NO)
        return nil;
    
    if ([mapView isEqual:self.myMapView] == NO)
        return nil;
    
    MyAnnotation *senderAnnotation = (MyAnnotation *)annotation;
    
    NSString* pinResuableIdentifier = [MyAnnotation reusableIdentifierforPinColor:senderAnnotation.pinColor];
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinResuableIdentifier];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinResuableIdentifier];
        annotationView.canShowCallout = YES;                    // enable show pin title and subtitle
    }
    
    annotationView.pinColor = senderAnnotation.pinColor;        // set pin color
    
    UIImage *pinIMage = [UIImage imageNamed:@"Location.png"];
    if (pinIMage != nil)
        annotationView.image = pinIMage;                        // set pin image

    return annotationView;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    myLatitudeLable.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
    myLongitudeLable.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
    myAccuracyLable.text = [[NSString alloc] initWithFormat:@"%f", newLocation.horizontalAccuracy];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    MKCoordinateRegion region;
    region.center = newLocation.coordinate;
    region.span = span;
    [myMapView setRegion:region animated:TRUE];
    
    if(myAnnotation) {
        [myAnnotation moveAnnotation:newLocation.coordinate];
    }
    else {
        self.geocoder = [[CLGeocoder alloc] init];
        [self.geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] >0) {
                CLPlacemark *placemark = (CLPlacemark *)[placemarks objectAtIndex:0];
                myAnnotation = [[MyAnnotation alloc] initWithCoordinate:newLocation.coordinate title:NSLocalizedString(@"PinTitle",nil) subtitle:ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO)];
                [myMapView addAnnotation:myAnnotation];
            }
        }];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end