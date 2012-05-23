//
//  ViewController.h
//  WhereAmI
//
//  Created by Li Emck on 12-05-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "MyAnnotation.h"

@interface ViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate> {
    IBOutlet MKMapView *myMapView;
    
    IBOutlet UILabel *myAccuracyLable;
    IBOutlet UILabel *myLatitudeLable;
    IBOutlet UILabel *myLongitudeLable;
    
    CLLocationManager *myLocalManager;
    
    MyAnnotation *myAnnotation;
    
    CLGeocoder *geocoder;
}

@property (nonatomic, retain) MKMapView *myMapView;
@property (nonatomic, retain) CLLocationManager *myLocalManager;
@property (nonatomic, retain) UILabel *myAccuracyLable;
@property (nonatomic, retain) UILabel *myLatitudeLable;
@property (nonatomic, retain) UILabel *myLongitudeLable;
@property (nonatomic, retain) CLGeocoder *geocoder;

@end
