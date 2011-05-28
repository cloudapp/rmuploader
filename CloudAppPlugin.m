//
//  CloudAppPlugin.m
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright Linebreak 2011. All rights reserved.
//

#import "CloudAppPlugin.h"

#import "CloudAppConstants.h"

@implementation CloudAppPlugin

- (RMUploadPresetConfigurationViewController *)presetConfigurationViewControllerForPreset:(RMUploadPreset *)preset
{
	// Note: this can be your own subclass of NSViewController if you wish
	RMUploadPresetConfigurationViewController *controller = [[RMUploadPresetConfigurationViewController alloc] initWithNibName:@"PresetConfigurationView" bundle:[NSBundle bundleWithIdentifier:CloudAppBundleIdentifier]];
	return controller;
}

@end
