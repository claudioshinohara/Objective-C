//
//  ViewController.h
//  AppCompartilhamento
//
//  Created by Aluno on 8/20/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import <UIKit/UIKit.h>

//Framework para SMS/Email
@import MessageUI;

//Framework para Facebook/Twitter
@import Social;

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>


@end
