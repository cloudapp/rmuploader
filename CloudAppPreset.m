//
//  CloudAppPreset.m
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright Linebreak 2011. All rights reserved.
//

#import "CloudAppPreset.h"

#import "CloudAppUploadTask.h"
#import "CloudAppConstants.h"
#import "CloudAppCredentials.h"

static NSString *const CLCloudAppPresetPrivateUploadKey = @"privateUpload";

@implementation CloudAppPreset
@synthesize privateUpload = _privateUpload;

+ (NSString *)localisedName
{
	return @"CloudApp";
}

+ (Class)uploadTaskClass
{
	return [CloudAppUploadTask class];
}


+ (Class)credentialsClass
{
	return [CloudAppCredentials class];
}

- (id)initWithPropertyListRepresentation:(id)values
{
    if ((self = [super initWithPropertyListRepresentation:[values objectForKey:@"super"]])) {
        self.privateUpload = [[values valueForKey:CLCloudAppPresetPrivateUploadKey] boolValue];
	}
	return self;
}

- (id)propertyListRepresentation
{
	NSMutableDictionary *plist = [NSMutableDictionary dictionary];
	[plist setObject:[super propertyListRepresentation] forKey:@"super"];
	
	[plist setObject:[NSNumber numberWithBool:self.privateUpload] forKey:CLCloudAppPresetPrivateUploadKey];
	
	return plist;
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
    
    if ([key isEqualToString:RMUploadPresetDirtyKey]) {
        NSArray *otherKeyPaths = [NSArray arrayWithObject:CLCloudAppPresetPrivateUploadKey];
        [keyPaths addObjectsFromArray:otherKeyPaths];
    }
    
    return [keyPaths autorelease];
}

@end
