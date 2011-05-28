//
//  CloudAppCredentials.m
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright 2011 Linebreak. All rights reserved.
//

#import "CloudAppCredentials.h"

static NSString *const CLCloudAppPresetEmailKey = @"email";
static NSString *const CLCloudAppPresetPasswordKey = @"password";

@implementation CloudAppCredentials

- (NSString *)userIdentifier
{
    return self.email;
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
    
    if ([key isEqualToString:RMUploadCredentialsDirtyKey]) {
        NSArray *otherKeyPaths = [NSArray arrayWithObjects:CLCloudAppPresetEmailKey, CLCloudAppPresetPasswordKey, nil];
        [keyPaths addObjectsFromArray:otherKeyPaths];
    }
    
    if ([key isEqualToString:RMUploadCredentialsUserIdentifierKey])
        [keyPaths addObject:CLCloudAppPresetEmailKey];
    
    return [keyPaths autorelease];
}

- (id)initWithPropertyListRepresentation:(id)values
{
    if ((self = [super initWithPropertyListRepresentation:[values objectForKey:@"super"]])) {
        self.email = [values valueForKey:CLCloudAppPresetEmailKey];
        self.password = [values valueForKey:CLCloudAppPresetPasswordKey];
    }
	
	return self;
}

- (id)propertyListRepresentation
{
	NSMutableDictionary *plist = [NSMutableDictionary dictionary];
	[plist setObject:[super propertyListRepresentation] forKey:@"super"];
	
    if (self.email != nil)
        [plist setObject:self.email forKey:CLCloudAppPresetEmailKey];
    if (self.password != nil)
        [plist setObject:self.password forKey:CLCloudAppPresetPasswordKey];
	
	return plist;
}

@end
