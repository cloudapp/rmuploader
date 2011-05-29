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

@implementation CloudAppPreset

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
       
	}
	return self;
}

- (id)propertyListRepresentation
{
	NSMutableDictionary *plist = [NSMutableDictionary dictionary];
	[plist setObject:[super propertyListRepresentation] forKey:@"super"];
		
	return plist;
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
    
    return [keyPaths autorelease];
}

- (NSSet *)acceptedTypes {
	return [NSSet setWithObject:(id)kUTTypeItem];
}

@end
