//
//  BeaconAdvertisingService.h
//  iBeacon
//
//  Created by Mike Perry on 4/5/14.
//  Copyright (c) 2014 Anthony Perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconAdvertisingService : NSObject


@property (nonatomic,readonly, getter = isAdvertising) BOOL advertising;

+ (BeaconAdvertisingService *)sharedInstance;

- (void)startAdvertisingUUID:(NSUUID *)uuid major:(CLBeaconMajorValue)major minor:(CLBeaconMinorValue)minor;
- (void)stopAdvertising;

@end
