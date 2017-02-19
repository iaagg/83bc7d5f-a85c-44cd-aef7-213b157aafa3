
#import "CurrencyDrawingHelper.h"

#define TRIANGLE_HALF_WIDTH 15
#define CORNER_RADIUS       2
#define TRIANGLE_HEIGHT     16

@implementation CurrencyDrawingHelper

+ (void)cutTriangleFromCurrencyOverlayView:(UIView *)view {
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = view.layer.bounds;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat width = view.layer.frame.size.width;
    
    //AnchorPoints creation
    
    //Start point
    CGFloat startPointX = (width / 2) - TRIANGLE_HALF_WIDTH;
    CGFloat startPointY = 0;
    
    //End point of left side
    CGFloat firstLineEndX = startPointX + TRIANGLE_HALF_WIDTH - CORNER_RADIUS;
    CGFloat firstLineEndY = TRIANGLE_HEIGHT - CORNER_RADIUS;
    
    //Start point of right side
    CGFloat secondStartLineX = firstLineEndX + (CORNER_RADIUS * 2);
    CGFloat secondStartLineY = firstLineEndY;
    
    //End point of right side
    CGFloat secondLineEndX = (width / 2) + TRIANGLE_HALF_WIDTH;
    CGFloat secondLineEndY = 0;
    
    //Control points for cubic bezier curve on triangle top
    CGFloat firstControlPointForCurveX = firstLineEndX;
    CGFloat firstControlPointForCurveY = firstLineEndY + (CORNER_RADIUS / 2);
    CGFloat secondControlPointForCurveX = secondStartLineX;
    CGFloat secondControlPointForCurveY = secondStartLineY + (CORNER_RADIUS / 2);
    
    CGPathAddRect(path, NULL, view.layer.bounds);
    CGPathMoveToPoint(path, nil, startPointX, startPointY);
    CGPathAddLineToPoint(path, nil, firstLineEndX, firstLineEndY);
    CGPathAddCurveToPoint(path, nil, firstControlPointForCurveX, firstControlPointForCurveY, secondControlPointForCurveX, secondControlPointForCurveY, secondStartLineX, secondStartLineY);
    CGPathAddLineToPoint(path, nil, secondLineEndX, secondLineEndY);
    CGPathAddLineToPoint(path, nil, startPointX, startPointY);
    
    mask.path = path;
    mask.fillRule = kCAFillRuleEvenOdd;
    view.layer.mask = mask;
}
@end
