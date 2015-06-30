//
//  VSMotionPanoramaView.h
//
//  Created by Fernando Sproviero on 6/25/15.
//  Copyright (c) 2015 VS. All rights reserved.
//

#import <GoogleMaps/GMSPanoramaView.h>

@interface VSMotionPanoramaView : GMSPanoramaView

/**
 * Controls whether orientation by device motion is enabled (default) or disabled. If
 * enabled, users may use device motion to change the orientation of the camera. 
 * orientationGestures will be disabled if orientationMotion is enabled.
 * orientationMotion will be disabled if orientationGestures are enabled.
 * This does not limit programmatic movement of the camera.
 */
@property (nonatomic, assign) BOOL orientationMotion;

@end
