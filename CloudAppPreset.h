//
//  CloudAppPreset.h
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright Linebreak 2011. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "RMUploadKit/RMUploadKit.h"

@interface CloudAppPreset : RMUploadPreset {
    BOOL _privateUpload;
}

@property (nonatomic, readwrite, assign) BOOL privateUpload;

@end
