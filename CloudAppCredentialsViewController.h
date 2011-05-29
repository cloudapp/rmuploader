//
//  CloudAppCredentialsViewController.h
//  CloudApp
//
//  Created by Sam Soffes on 8/29/10.
//  Copyright Sam Soffes 2010. All rights reserved.
//

#import "RMUploadKit/RMUploadKit.h"

@class CloudAppCredentials, CLAPIEngine;
@interface CloudAppCredentialsViewController : RMUploadPresetConfigurationViewController {
    IBOutlet NSTextField *_loginEmailField;
    IBOutlet NSTextField *_loginPasswordField;
    
	CLAPIEngine *_engine;
}

@property (nonatomic, readonly) NSTextField *loginEmailField;
@property (nonatomic, readonly) NSTextField *loginPasswordField;

@property (nonatomic, readonly, getter=isAuthenticating) BOOL authenticating;

@end
