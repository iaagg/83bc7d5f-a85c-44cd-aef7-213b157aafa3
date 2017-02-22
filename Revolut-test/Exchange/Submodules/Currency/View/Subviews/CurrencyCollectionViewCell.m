
#import "CurrencyCollectionViewCell.h"

@implementation CurrencyCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    _currencyRateLabel.text = @"";
    _depositLabel.text = @"";
    _value.text = @"";
}

@end
