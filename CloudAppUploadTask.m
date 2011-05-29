//
//  CloudAppUploadTask.m
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright Linebreak 2011. All rights reserved.
//

#import "CloudAppUploadTask.h"
#import "CloudAppConstants.h"
#import "CloudAppCredentials.h"
#import <Cloud/Cloud.h>

@interface CloudAppUploadTask () <CLAPIEngineDelegate>
@end

@implementation CloudAppUploadTask

- (id)initWithPreset:(RMUploadPreset *)destination uploadInfo:(id)uploadInfo
{	
    if ((self = [super initWithPreset:destination uploadInfo:uploadInfo])) {
        _engine = [[CLAPIEngine alloc] initWithDelegate:self];
        CloudAppCredentials *credentials = (CloudAppCredentials *)destination.authentication;
        _engine.email = credentials.email;
        _engine.password = credentials.password;
    }
    return self;
}

- (void)dealloc
{
    [_engine release];
    _engine = nil;
    
    [super dealloc];
}

#pragma - RMUploadTask

- (void)upload
{
	@synchronized (self) {
		if ([self isCancelled]) 
            return;
        
        NSURL *fileURL = [self.uploadInfo valueForKey:RMUploadFileURLKey];
        NSString *title = [self.uploadInfo valueForKey:RMUploadFileTitleKey];
        NSLog(@"Upload! %@, %@", fileURL, title);
        [_engine uploadFileWithName:title fileData:[NSData dataWithContentsOfMappedFile:[fileURL path]] userInfo:nil];
        
	}
}

- (void)cancel
{
	@synchronized (self) {
		[super cancel];
		
		[_engine cancelAllConnections];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:RMUploadTaskDidCompleteNotificationName object:self];
	}
}

#pragma - CLAPIEngineDelegate

- (void)requestDidFailWithError:(NSError *)error connectionIdentifier:(NSString *)connectionIdentifier userInfo:(id)userInfo
{
    NSDictionary *notificationInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
									  error, RMUploadTaskErrorKey,
									  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:RMUploadTaskDidFinishTransactionNotificationName object:self userInfo:notificationInfo];
}

- (void)fileUploadDidProgress:(CGFloat)percentageComplete connectionIdentifier:(NSString *)connectionIdentifier userInfo:(id)userInfo
{
    NSDictionary *notificationInfo = [NSDictionary dictionaryWithObjectsAndKeys:
									  [NSNumber numberWithDouble:percentageComplete], RMUploadTaskProgressCurrentKey,
									  [NSNumber numberWithDouble:1], RMUploadTaskProgressTotalKey,
									  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:RMUploadTaskDidReceiveProgressNotificationName object:self userInfo:notificationInfo];
}

- (void)fileUploadDidSucceedWithResultingItem:(CLWebItem *)item connectionIdentifier:(NSString *)connectionIdentifier userInfo:(id)userInfo
{
    NSDictionary *notificationInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
									  item.URL, RMUploadTaskResourceLocationKey,
									  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:RMUploadTaskDidFinishTransactionNotificationName object:self userInfo:notificationInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RMUploadTaskDidCompleteNotificationName object:self];
}

@end
