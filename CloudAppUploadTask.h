//
//  CloudAppUploadTask.h
//  CloudApp
//
//  Created by Nick Paulson on 5/28/11.
//  Copyright Linebreak 2011. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RMUploadKit/RMUploadKit.h"

@class CLAPIEngine;
@interface CloudAppUploadTask : RMUploadTask {
    CLAPIEngine *_engine;
}

@end
