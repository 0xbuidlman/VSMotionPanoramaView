//
//  AppDelegate.m
//  VSMotionPanoramaViewExample
//
//  Created by Fernando Sproviero on 6/29/15.
//  Copyright (c) 2015 VS. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>

static NSString *const GMSApiKey = @"YOUR_API_KEY";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [GMSServices provideAPIKey:GMSApiKey];
    return YES;
}

@end