//
//  CloudAppUploadTask.m
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright Linebreak 2011. All rights reserved.
//

#import "CloudAppUploadTask.h"
#import "CloudAppConstants.h"

@interface CloudAppUploadTask () <RMUploadURLConnectionDelegate>
@end

@implementation CloudAppUploadTask

- (id)initWithPreset:(RMUploadPreset *)destination uploadInfo:(id)uploadInfo
{	
    if ((self = [super initWithPreset:destination uploadInfo:uploadInfo])) {
        
    }
    return self;
}

- (void)upload
{
	@synchronized (self) {
		if ([self isCancelled]) return;
        
        
	}
}

- (void)cancel
{
	@synchronized (self) {
		[super cancel];
		
		// Note: cancel upload connection…
		
		[[NSNotificationCenter defaultCenter] postNotificationName:RMUploadTaskDidCompleteNotificationName object:self];
	}
}

@end
