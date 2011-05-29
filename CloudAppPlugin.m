//
//  CloudAppPlugin.m
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright Linebreak 2011. All rights reserved.
//

#import "CloudAppPlugin.h"
#import "CloudAppCredentialsViewController.h"
#import "CloudAppConstants.h"

@implementation CloudAppPlugin

- (RMUploadPresetConfigurationViewController *)credentialsConfigurationViewControllerForCredentials:(RMUploadCredentials *)credentials {
	CloudAppCredentialsViewController *viewController = [[CloudAppCredentialsViewController alloc] init];
	return [viewController autorelease];
}


- (RMUploadPresetConfigurationViewController *)presetConfigurationViewControllerForPreset:(RMUploadPreset *)preset {
	return nil;
}

@end
