
#import "CurrenciesParser.h"
#import "SeedDataExtractor.h"
#import "NSManagedObject+Creating.h"
#import "Currency+CoreDataClass.h"
#import "StackFactory.h"

#define CURRENCIES  @"currencies"
#define ABBR        @"abbr"
#define SYM         @"sym"
#define AMOUNT      @"amount"

static NSString * const kRevolutSeedCurrencies = @"CurrenciesSeeds";

NSString * const kRevolutCurrencyTitleKey   = @"currency";
NSString * const kRevolutCurrencyRateKey    = @"rate";

@interface CurrenciesParser () <NSXMLParserDelegate>

@property (strong, nonatomic) NSXMLParser                   *xmlParser;
@property (weak, nonatomic) id<CurrenciesParserDelegate>    delegate;
@property (strong, atomic) NSMutableArray<NSDictionary *>       *currenciesRates;

@end

@implementation CurrenciesParser

- (instancetype)initWithDelegate:(id<CurrenciesParserDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    
    return self;
}

- (void)parseXMLWithData:(NSData *)data {
    _xmlParser = [[NSXMLParser alloc] initWithData:data];
    _xmlParser.delegate = self;
    [_xmlParser parse];
}

#pragma mark - XMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    _currenciesRates = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
    if (attributeDict[kRevolutCurrencyTitleKey] && attributeDict[kRevolutCurrencyRateKey]) {
        [_currenciesRates addObject:attributeDict];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@", parseError.localizedDescription);
    [_delegate errorOccuredWhileParsing];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [_delegate parserDidParseCurrenciesRates:_currenciesRates];
    _xmlParser = nil;
    _currenciesRates = nil;
}

#pragma mark - Seeding

+ (NSArray<Currency *> *)parseSeedCurrencies {
    NSDictionary *seedData = extractJSONWithFilename(kRevolutSeedCurrencies, [NSBundle bundleForClass:[self class]]);
    NSMutableArray *parsedCurrencies = [NSMutableArray new];
    NSManagedObjectContext *mainContext = [StackFactory stackForCurrentEnvironment].mainQueueContext;
    
    NSArray *currencies = [seedData objectForKey:CURRENCIES];
    
    for (NSDictionary *dict in currencies) {
        Currency *currency = [Currency createInContext:mainContext];
        
        //Abbreviation
        NSString *title = dict[ABBR];
        [currency setTitle:title];
        
        //Amount
        NSNumber *amount = dict[AMOUNT];
        
        if (amount) {
            [currency setAmount:amount.intValue];
        }
        
        //Symbol
        NSNumber *characterNumber = dict[SYM];
        
        if (characterNumber) {
            unichar symbol = characterNumber.intValue;
            NSString *symbolString = [NSString stringWithFormat:@"%C", symbol];
            [currency setSymbol:symbolString];
        }
        
        [parsedCurrencies addObject:currency];
    }
    
    return [parsedCurrencies copy];
}

@end
