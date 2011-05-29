//
//  CloudAppCredentials.m
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright 2011 Linebreak. All rights reserved.
//

#import "CloudAppCredentials.h"

static NSString *const CLCloudAppCredentialsEmailKey = @"email";
static NSString *const CLCloudAppCredentialsPasswordKey = @"password";

@implementation CloudAppCredentials
@synthesize email = _email, password = _password;

- (NSString *)userIdentifier
{
    return self.email;
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
    
    if ([key isEqualToString:RMUploadCredentialsDirtyKey]) {
        NSArray *otherKeyPaths = [NSArray arrayWithObjects:CLCloudAppCredentialsEmailKey, CLCloudAppCredentialsPasswordKey, nil];
        [keyPaths addObjectsFromArray:otherKeyPaths];
    }
    
    if ([key isEqualToString:RMUploadCredentialsUserIdentifierKey])
        [keyPaths addObject:CLCloudAppCredentialsEmailKey];
    
    return [keyPaths autorelease];
}

- (id)initWithPropertyListRepresentation:(id)values
{
    if ((self = [super initWithPropertyListRepresentation:[values objectForKey:@"super"]])) {
        self.email = [values valueForKey:CLCloudAppCredentialsEmailKey];
        self.password = [values valueForKey:CLCloudAppCredentialsPasswordKey];
    }
	
	return self;
}

- (id)propertyListRepresentation
{
	NSMutableDictionary *plist = [NSMutableDictionary dictionary];
	[plist setObject:[super propertyListRepresentation] forKey:@"super"];
	
    if (self.email != nil)
        [plist setObject:self.email forKey:CLCloudAppCredentialsEmailKey];
    if (self.password != nil)
        [plist setObject:self.password forKey:CLCloudAppCredentialsPasswordKey];
	
	return plist;
}

@end
