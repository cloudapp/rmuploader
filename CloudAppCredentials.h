//
//  CloudAppCredentials.h
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright 2011 Linebreak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMUploadKit/RMUploadKit.h"

@interface CloudAppCredentials : RMUploadCredentials {
    NSString *_email;
    NSString *_password;
}

@property (nonatomic, readwrite, copy) NSString *email;
@property (nonatomic, readwrite, copy) NSString *password;

@end
