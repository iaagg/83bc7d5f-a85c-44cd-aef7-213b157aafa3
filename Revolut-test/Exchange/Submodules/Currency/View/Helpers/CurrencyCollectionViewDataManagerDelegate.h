
#import <Foundation/Foundation.h>

@protocol CurrencyCollectionViewDataManagerDelegate <NSObject>

- (void)switchedToCurrencyWithIndex:(NSInteger)index;

@end
