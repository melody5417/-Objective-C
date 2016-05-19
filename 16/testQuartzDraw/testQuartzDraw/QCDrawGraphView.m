// ################################################################################//
//		文件名 : QCDrawGraphView.m
// ################################################################################//
/*!
 @file		QCDrawGraphView.m
 @brief		画固定图形的画板视图
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDrawGraphView.h"

@implementation QCDrawGraphView{
    CGPoint pntBegin;
    CGPoint pntEnd;
}
@synthesize color = _color;
@synthesize type = _type;

- (CGRect)selectedArea 
{
    CGPoint pntS = CGPointZero;    
    pntS.x = (pntBegin.x > pntEnd.x)? pntEnd.x: pntBegin.x;
    pntS.y = (pntBegin.y > pntEnd.y)? pntEnd.y: pntBegin.y;

    return CGRectMake (pntS.x,
                       pntS.y,
                       abs(pntEnd.x - pntBegin.x),
                       abs(pntEnd.y - pntBegin.y));
}

- (void)drawRect:(CGRect)rect 
{
    //当前context画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [self updateBG:context];
    
    //线宽
    CGContextSetLineWidth(context, 2.0);
    //线颜色
    CGContextSetStrokeColorWithColor(context, _color.CGColor);
    
    
    switch (_type) {
        case kLineGraph:
            //直线
            CGContextMoveToPoint(context, pntBegin.x, pntBegin.y);
            CGContextAddLineToPoint(context, pntEnd.x, pntEnd.y);
            CGContextStrokePath(context);
            break;
        case kRectGraph:
            //矩形
            CGContextSetFillColorWithColor(context, _color.CGColor);
            CGContextAddRect(context, [self selectedArea]);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kRoundGraph:
            //圆圈
            CGContextSetFillColorWithColor(context, _color.CGColor);
            CGContextAddEllipseInRect(context, [self selectedArea]);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        default:
            break;
    }
    
    CGContextRestoreGState(context);
}

- (void)updateBG:(CGContextRef)context
{
    //两个颜色，每个颜色分别是红绿蓝alpha四个通道
    CGFloat colors [] = { 
        1.0, 1.0, 1.0, 1.0, 
        0.4, 0.5, 0.6, 1.0
    };
    
    //创建CGGradientRef对象
    CGColorSpaceRef baseSpace   = CGColorSpaceCreateDeviceRGB();
    CGGradientRef   gradient    = CGGradientCreateWithColorComponents(baseSpace, 
                                                                      colors, 
                                                                      NULL, 
                                                                      2);
    CGColorSpaceRelease(baseSpace); 
    baseSpace = NULL;
    
    //以X轴中间点为主轴，Y轴为渐变轴进行渐变
    CGPoint startPoint  = CGPointMake(CGRectGetMidX(self.frame), 
                                      CGRectGetMinY(self.frame));
    CGPoint endPoint    = CGPointMake(CGRectGetMidX(self.frame), 
                                      CGRectGetMaxY(self.frame));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient); 
    gradient = NULL;
}

#pragma mark -
#pragma mark Touch Handler
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    pntBegin = [touch locationInView:self];
    pntEnd = [touch locationInView:self];
        
    [self setNeedsDisplay];
}

-  (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    pntEnd = [touch locationInView:self];
    
    [self setNeedsDisplay];
}

-  (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    pntEnd = [touch locationInView:self];

    [self setNeedsDisplay];
}

@end
