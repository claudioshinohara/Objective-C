//
//  ViewController.h
//  AppDocumentos
//
//  Created by Aluno on 8/21/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@import QuickLook;

@interface ViewController : UIViewController <UIDocumentInteractionControllerDelegate, QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@end
