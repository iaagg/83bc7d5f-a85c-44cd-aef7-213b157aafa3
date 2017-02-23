#import <UIKit/UIKit.h>

@interface UIView (DefaultConstraints)

/*!
 * @brief Adds subviw and sets up constraints to margins of it's superview
 * @param view UIView object which will be added as subview with constraints to it's superview
 */
- (void)addToMarginsConstraintsForView:(UIView *)view;

@end
