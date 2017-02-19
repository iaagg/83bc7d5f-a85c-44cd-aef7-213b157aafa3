
#import "CurrenciesParser.h"
#import "SeedDataExtractor.h"
#import "NSManagedObject+Creating.h"
#import "Currency+CoreDataClass.h"
#import "StackFactory.h"

static NSString * const kRevolutSeedCurrencies = @"SeedCurrencies";

#define CURRENCIES @"currencies"
#define ABBR @"abbr"
#define SYM @"sym"
#define AMOUNT @"amount"


@interface CurrenciesParser () <NSXMLParserDelegate>

@property (strong, nonatomic) NSXMLParser *xmlParser;

@end

@implementation CurrenciesParser

- (instancetype)init {
    if (self = [super init]) {
        _xmlParser = [[NSXMLParser alloc] init];
        _xmlParser.delegate = self;
    }
    
    return self;
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
