//
//  ViewController.m
//  VSMotionPanoramaViewExample
//
//  Created by Fernando Sproviero on 6/26/15.
//  Copyright (c) 2015 VS. All rights reserved.
//

#import "ViewController.h"
#import "VSMotionPanoramaView.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CLLocationCoordinate2D obeliscoCoordinate = CLLocationCoordinate2DMake(-34.603075, -58.381653);
    [self initializePanoViewWithCoordinate:obeliscoCoordinate];
}

- (void)initializePanoViewWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    GMSPanoramaView *panoView = [[VSMotionPanoramaView alloc] initWithFrame:CGRectZero];
    self.view = panoView;
    [panoView moveNearCoordinate:coordinate];
}

@end
