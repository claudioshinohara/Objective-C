//
//  ViewControllerExterna.m
//  AppMonitorExterno
//
//  Created by Claudio Shinohara on 17/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "ViewControllerExterna.h"

@interface ViewControllerExterna ()

@property (nonatomic, strong) MPMoviePlayerController *player;

@end

@implementation ViewControllerExterna

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
    
    //Adicionando no NSNotificatioCenter para esperar as notificações
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playClicado) name:@"play" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseClicado) name:@"pause" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopClicado) name:@"stop" object:nil];
}

-(void) playClicado {
    [self.player play];
}

-(void) pauseClicado {
    [self.player pause];
}

-(void) stopClicado {
    [self.player stop];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meuFilme" ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.player.view.frame = self.view.frame;
    [self.view addSubview:self.player.view];
    [self.player play];
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
