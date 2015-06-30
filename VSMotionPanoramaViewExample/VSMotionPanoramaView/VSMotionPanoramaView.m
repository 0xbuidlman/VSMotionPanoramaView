//
//  VSMotionPanoramaView.m
//
//  Created by Fernando Sproviero on 6/25/15.
//  Copyright (c) 2015 VS. All rights reserved.
//

#import "VSMotionPanoramaView.h"
#import <GoogleMaps/GMSPanoramaCamera.h>
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIDevice.h>

@interface VSMotionPanoramaView()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locManager;
@property (assign, nonatomic) CLLocationDirection currentHeading;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) CMAttitude *referenceAttitude;
@property (assign, nonatomic) double currentPitch;

@end

@implementation VSMotionPanoramaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentHeading = 0;
        self.currentPitch = 0;
        self.orientationMotion = YES;
    }
    return self;
}

- (void)setOrientationGestures:(BOOL)orientationGestures
{
    [super setOrientationGestures:orientationGestures];
    if (YES == orientationGestures) {
        self.orientationMotion = NO;
    }
}

- (void)setOrientationMotion:(BOOL)orientationMotion
{
    _orientationMotion = orientationMotion;
    
    if (YES == _orientationMotion) {
        self.orientationGestures = NO;
        [self startHeadingEvents];
        [self startMotionEvents];
    } else {
        [self.locManager stopUpdatingHeading];
        [self.motionManager stopDeviceMotionUpdates];
    }
}

- (void)dealloc
{
    [self.locManager stopUpdatingHeading];
    [self.motionManager stopDeviceMotionUpdates];
}

- (void)startHeadingEvents
{
    if (!self.locManager) {
        self.locManager = [[CLLocationManager alloc] init];
        self.locManager.delegate = self;
    }
    
    if ([CLLocationManager headingAvailable]) {
        self.locManager.headingOrientation = CLDeviceOrientationFaceUp;
        self.locManager.headingFilter = kCLHeadingFilterNone;
        self.locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [self.locManager startUpdatingHeading];
    }
}

- (void)startMotionEvents
{
    if (!self.motionManager) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    
    if (self.motionManager.deviceMotionAvailable) {
        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical
                                                                toQueue:[NSOperationQueue currentQueue]
                                                            withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                                                [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
                                                            }];
    }
}

- (void)handleDeviceMotion:(CMDeviceMotion *)motion
{
    self.currentPitch = [self calculatePitchWithDeviceMotion:motion];
    
    [self updatePanoViewCamera];
}

- (double)calculatePitchWithDeviceMotion:(CMDeviceMotion *)motion
{
    CMAttitude *attitude = motion.attitude;
    
    if (!self.referenceAttitude) {
        self.referenceAttitude = attitude;
    }
    
    [attitude multiplyByInverseOfAttitude:self.referenceAttitude];
    
    double newPitch = 100;
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        newPitch = fabs(motion.attitude.roll * 180 / M_PI) - 90;
    } else if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
        if (motion.gravity.z < 0) {
            newPitch = motion.attitude.pitch * 180 / M_PI - 90;
        } else {
            newPitch = 90 - motion.attitude.pitch * 180 / M_PI;
        }
    }
    if (newPitch <= 90 && newPitch >= -90) {
        return newPitch;
    }
    return self.currentPitch;
}

- (void)updatePanoViewCamera
{
    self.camera = [GMSPanoramaCamera cameraWithHeading:self.currentHeading
                                                 pitch:self.currentPitch
                                                  zoom:self.camera.zoom];
}

#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    self.currentHeading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
    
    [self updatePanoViewCamera];
}


@end
