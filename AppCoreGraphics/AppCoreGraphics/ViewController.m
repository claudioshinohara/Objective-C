//
//  ViewController.m
//  AppCoreGraphics
//
//  Created by Claudio Shinohara on 17/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "ViewController.h"
#import "Relogio.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    Relogio *rel = [[Relogio alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, 200, 200)];
    rel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
