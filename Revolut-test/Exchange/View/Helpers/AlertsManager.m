
#import "AlertsManager.h"
#import "ExchangeViewController.h"

static NSString * const kRevolutCurrenciesRatesUpdatingFailedMessage = @"Error while updating currencies rates. Please, retry or wait for update";
static NSString * const kRevolutRetryUpdateButtonTitle = @"Retry";
static NSString * const kRevolutWaitForUpdateButtonTitle = @"OK";

@implementation AlertsManager

+ (void)showUpdatingFailedAlertInController:(UIViewController *)controller {
    if ([controller isKindOfClass:[ExchangeViewController class]]) {
        __weak ExchangeViewController *weakSelf = (ExchangeViewController *)controller;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:kRevolutCurrenciesRatesUpdatingFailedMessage
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        //Retry action
        UIAlertAction *retryAction = [UIAlertAction actionWithTitle:kRevolutRetryUpdateButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                [weakSelf.output userChoosedToRetryToUpdateCurrencies];
                                                            }];
        [alert addAction:retryAction];
        
        //OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:kRevolutWaitForUpdateButtonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
        [alert addAction:okAction];
        
        //Presenting
        [controller presentViewController:alert animated:YES completion:nil];
    }
}

@end
