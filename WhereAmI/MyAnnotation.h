//
//  MyAnnotation.h
//  WhereAmI
//
//  Created by Li Emck on 12-05-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define REUSABLE_PIN_RED @"Red"
#define REUSABLE_PIN_GREEN @"Green"
#define REUSABLE_PIN_PURPLE @"Purple"


@interface MyAnnotation : NSObject <MKAnnotation> {
@private
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    MKPinAnnotationColor pinColor;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) MKPinAnnotationColor pinColor;


-(id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString *) t subtitle:(NSString *) st;
-(void)moveAnnotation:(CLLocationCoordinate2D) newCoordinate;
+(NSString *) reusableIdentifierforPinColor:(MKPinAnnotationColor )paramColor;

@end
