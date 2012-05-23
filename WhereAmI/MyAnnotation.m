//
//  MyAnnotation.m
//  WhereAmI
//
//  Created by Li Emck on 12-05-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize pinColor;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t subtitle:(NSString *)st {
    coordinate = c;
    self.title = t;
    self.subtitle = st;
    pinColor = MKPinAnnotationColorGreen;
    
    return self;
}

-(void)moveAnnotation:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

+(NSString *) reusableIdentifierforPinColor:(MKPinAnnotationColor )paramColor {
    NSString *result = nil;
    switch (paramColor) {
        case MKPinAnnotationColorRed:
            result = REUSABLE_PIN_RED;
            break;
        case MKPinAnnotationColorGreen:
            result = REUSABLE_PIN_GREEN;
            break;
        case MKPinAnnotationColorPurple:
            result = REUSABLE_PIN_PURPLE;
            break;
    }
    return result;
}

@end
