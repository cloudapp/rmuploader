//
//  CloudAppCredentialsViewController.m
//  CloudApp
//
//  Created by Sam Soffes on 8/29/10.
//  Copyright Sam Soffes 2010. All rights reserved.
//

#import "CloudAppCredentialsViewController.h"
#import "CloudAppCredentials.h"
#import "CloudAppConstants.h"
#import <Cloud/Cloud.h>

@interface CloudAppCredentialsViewController () <CLAPIEngineDelegate>
@property (nonatomic, readwrite, assign, getter=isAuthenticating) BOOL authenticating;
@end

@implementation CloudAppCredentialsViewController

@synthesize loginEmailField = _loginEmailField, loginPasswordField = _loginPasswordField, authenticating = _authenticating;

#pragma mark NSObject

- (id)init {
    if ((self = [super initWithNibName:@"CredentialsView" bundle:[NSBundle bundleWithIdentifier:CloudAppBundleIdentifier]])) {
        _engine = [[CLAPIEngine alloc] initWithDelegate:self];
    }
    return self;
}


- (void)dealloc {
	[_engine release];
    _engine = nil;
    
	[super dealloc];
}


#pragma mark Actions

- (IBAction)nextStage:(id)sender {
    NSLog(@"next stage");
	BOOL (^validateTextField)(NSTextField *) = ^ (NSTextField *field) {
		[field validateEditing];
		if ([field stringValue] != nil && [[field stringValue] length] > 0) return YES;
		
		[self highlightErrorInView:field];
		
		NSDictionary *validationNotificationInfo = [NSDictionary dictionaryWithObjectsAndKeys:
													[NSError errorWithDomain:RMUploadKitBundleIdentifier code:RMUploadPresetConfigurationViewControllerErrorValidation userInfo:nil], RMUploadPresetConfigurationViewControllerDidCompleteErrorKey,
													nil];
		[[NSNotificationCenter defaultCenter] postNotificationName:RMUploadPresetConfigurationViewControllerDidCompleteNotificationName object:self userInfo:validationNotificationInfo];
		
		return NO;
	};
    
	if (!validateTextField(self.loginEmailField)) 
        return;
    
	if (!validateTextField(self.loginPasswordField)) 
        return;
	
    _engine.email = [[self.loginEmailField stringValue] lowercaseString];
    _engine.password = [self.loginPasswordField stringValue];

    [_engine getAccountInformationWithUserInfo:nil];
    
    self.authenticating = YES;
}

- (void)requestDidFailWithError:(NSError *)error connectionIdentifier:(NSString *)connectionIdentifier userInfo:(id)userInfo
{
    NSDictionary *notificationInfo = [NSDictionary dictionaryWithObjectsAndKeys:
									  error, RMUploadPresetConfigurationViewControllerDidCompleteErrorKey,
									  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:RMUploadPresetConfigurationViewControllerDidCompleteNotificationName object:self userInfo:notificationInfo];
	
    self.authenticating = NO;
}

- (void)accountInformationRetrievalSucceeded:(CLAccount *)account connectionIdentifier:(NSString *)connectionIdentifier userInfo:(id)userInfo
{
    NSLog(@"Got account info");
    [(CloudAppCredentials *)self.representedObject setEmail:_engine.email];
    [(CloudAppCredentials *)self.representedObject setPassword:_engine.password];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RMUploadPresetConfigurationViewControllerDidCompleteNotificationName object:self];
    self.authenticating = NO;
}

@end
