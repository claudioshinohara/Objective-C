//
//  ViewController.m
//  AppMonitorExterno
//
//  Created by Claudio Shinohara on 17/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)stop:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"play" object:nil];
}

- (IBAction)pause:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pause" object:nil];
}

- (IBAction)stop:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
}
@end
