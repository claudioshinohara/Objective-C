//
//  ViewController.m
//  AppPropaganda
//
//  Created by Claudio Shinohara on 16/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ADBannerView *anuncio;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.anuncio.delegate = self;
    self.anuncio.hidden = NO;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    banner.hidden = NO;
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    banner.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
