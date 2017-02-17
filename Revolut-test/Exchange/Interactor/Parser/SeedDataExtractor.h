
#ifndef SeedDataExtractor_h
#define SeedDataExtractor_h
#import <Foundation/Foundation.h>

NSDictionary* extractJSONWithFilename(NSString *filename, NSBundle *bundle) {
    NSString *filePath = [bundle pathForResource:filename ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding]
                          options:NSJSONReadingMutableContainers error:NULL];
    
    return json;
}


#endif
