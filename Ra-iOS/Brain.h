//
//  Brain.h
//  Ra-iOS
//
//  Created by Joe Blau on 8/3/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Brain : NSObject

- (void)learn:(float)beaconZone proxmity:(float)proximity on:(BOOL)isOn r:(float)red g:(float)g b:(float)b;
- (void)train;
- (float)decide:(float)beaconZone proxmity:(float)proximity;

@end
