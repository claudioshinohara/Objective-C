//
//  ViewControllerSalaChat.h
//  AppChat
//
//  Created by Aluno on 9/11/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MultipeerConnectivity;

@interface ViewControllerSalaChat : UIViewController <UITableViewDelegate, UITableViewDataSource, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate>

@property (nonatomic, strong) NSString *strApelido;

@end
