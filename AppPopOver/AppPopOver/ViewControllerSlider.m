//
//  ViewControllerSlider.m
//  AppPopOver
//
//  Created by Aluno on 9/2/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewControllerSlider.h"

@interface ViewControllerSlider ()



@property (weak, nonatomic) IBOutlet UISlider *sldRed;
@property (weak, nonatomic) IBOutlet UISlider *sldGreen;
@property (weak, nonatomic) IBOutlet UISlider *sldBlue;

- (IBAction)mexeuSlider:(id)sender;

@end

@implementation ViewControllerSlider

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)mexeuSlider:(id)sender {
    UIColor *novaCor = [UIColor colorWithRed:self.sldRed.value green:self.sldGreen.value blue:self.sldBlue.value alpha:1];
    [self.delegate acionaramSliderEACorMudouPara:novaCor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
