
#import <UIKit/UIKit.h>

@interface CurrencyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel        *currencyTitle;
@property (weak, nonatomic) IBOutlet UILabel        *depositLabel;
@property (weak, nonatomic) IBOutlet UITextField    *value;
@property (weak, nonatomic) IBOutlet UILabel        *currencyRateLabel;
@property (strong, nonatomic) id                    textFieldDelegateStrongReference;

@end
