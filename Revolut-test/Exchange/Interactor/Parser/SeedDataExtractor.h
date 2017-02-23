
#ifndef SeedDataExtractor_h
#define SeedDataExtractor_h
#import <Foundation/Foundation.h>

/*!
 * @discussion Useful C function for extracting and serialization local json file
 * @param filename Name of local json file
 * @param bundle Bundle with json file
 * @return deserialized json to NSDictionary object
 */
NSDictionary* extractJSONWithFilename(NSString *filename, NSBundle *bundle) {
    NSString *filePath = [bundle pathForResource:filename ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding]
                          options:NSJSONReadingMutableContainers error:NULL];
    
    return json;
}


#endif
