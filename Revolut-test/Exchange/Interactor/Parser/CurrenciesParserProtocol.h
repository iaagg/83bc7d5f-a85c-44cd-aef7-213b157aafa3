
#import <Foundation/Foundation.h>

@protocol CurrenciesParserProtocol <NSObject>

/*!
 * @discussion Starts process of parsing provided XML file encoded in NSData
 * @param data Encoded XML file
 */
- (void)parseXMLWithData:(NSData *)data;

@end
