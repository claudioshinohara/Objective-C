//
//  ViewController.h
//  AppAccelerometer
//
//  Created by Claudio Shinohara on 02/07/15.
//  Copyright (c) 2015 Shinohara. All rights reserved.
//

#import <UIKit/UIKit.h>

//Link do Framework é feito dinamicamente
@import CoreMotion;

@interface ViewController : UIViewController

//Objeto responsável por entregar as leituras do acelerômetro para essa VC
@property (nonatomic, strong) CMMotionManager *gerenciadorMovimento;

@end
