//
//  DSMultipartFormDocument.h
//  Courier
//
//  Created by Keith Duncan on 29/04/2010.
//  Copyright 2010 Realmac Software. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
	@brief
	This format is described in RFC 2388 http://tools.ietf.org/html/rfc2388
	
	@detail
	The order you add values in is unpreserved.
 */
@interface RMUploadMultipartFormDocument : NSObject

/*!
	@brief
	Returns the value associated with a given fieldname.
 */
- (NSString *)valueForField:(NSString *)fieldname;

/*!
	@brief
	The fieldname should be unique per document, setting a value for an existing fieldname will overwrite the previous value.
	
	@detail
	This will clear any files added to the same fieldname.
	
	@param value
	Can be nil, will remove existing value.
	
	@param fieldname
	Cannot be nil.
 */
- (void)setValue:(NSString *)value forField:(NSString *)fieldname;

/*!
	@brief
	Unordered collection of previously added URLs using <tt>-addFileByReferencingURL:withFilename:toField:</tt>.
 */
- (NSSet *)fileLocationsForField:(NSString *)fieldname;

/*!
	@brief
	Form documents support multiple files per-fieldname.
	
	@detail
	Multiple files per fieldname are supported.
	This will clear any string values set for the same fieldname.
	
	@param filename
	This is optional, excluding it will use the last path component.
	
	@param
	To leave the 'name' value blank in the generated document, pass <tt>+[NSNull null]</tt> for the fieldname.
 */
- (void)addFileByReferencingURL:(NSURL *)location withFilename:(NSString *)filename toField:(NSString *)fieldname;

/*!
	@brief
	Serialise the field values into a data object.
	
	@param contentTypeRef
	This is the MIME type of the output. Contains the generated multipart boundary.
 */
- (void)getFormData:(NSData **)dataRef contentType:(NSString **)contentTypeRef;

@end
