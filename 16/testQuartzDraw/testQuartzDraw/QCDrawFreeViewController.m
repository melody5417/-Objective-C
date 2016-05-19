// ################################################################################//
//		文件名 : QCDrawFreeViewController.m
// ################################################################################//
/*!
 @file		QCDrawFreeViewController.m
 @brief		画自由内容的视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDrawFreeViewController.h"

@interface QCDrawFreeViewController ()
{
    CGPoint _pntBegin;
    CGFloat _fRed;
    CGFloat _fGreen;
    CGFloat _fBlue;
    CGFloat _fBrushWidth;
    BOOL    _bMoved;
    BOOL    _bRubber;
}

@property (nonatomic, retain) IBOutlet UIImageView          *freeCanvas;
@property (nonatomic, retain) IBOutlet UISegmentedControl   *colorSegControl;

@end

@implementation QCDrawFreeViewController
@synthesize freeCanvas;
@synthesize colorSegControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _fBrushWidth = 5.0f;
    [self actSelectColor:self.colorSegControl];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.freeCanvas = nil;
    self.colorSegControl = nil;
}

#pragma mark -
#pragma mark Touch Handler
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _bMoved = NO;
    
    UITouch *touch  = [touches anyObject];
    _pntBegin        = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _bMoved = YES;
    UITouch         *touch          = [touches anyObject];
    CGPoint         currentPoint    = [touch locationInView:self.view];
    CGContextRef    context         = NULL;

    //创建Context
    UIGraphicsBeginImageContext(self.freeCanvas.frame.size);
    //继续上一次的作画
    [self.freeCanvas.image drawInRect:self.freeCanvas.frame];
    
    //获取Context进行配置
    context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //橡皮擦
    if (_bRubber) {
        CGContextClearRect(context, 
                           CGRectMake(currentPoint.x - _fBrushWidth, 
                                      currentPoint.y - _fBrushWidth, 
                                      _fBrushWidth*2, 
                                      _fBrushWidth*2));
    }
    else {
        CGContextMoveToPoint(context, _pntBegin.x, _pntBegin.y);
        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, _fBrushWidth );
        CGContextSetBlendMode(context,kCGBlendModeNormal);
        CGContextSetRGBStrokeColor(context, _fRed, _fGreen, _fBlue, 1.0f);
        
        //作画
        CGContextStrokePath(context);
    }

    CGContextRestoreGState(context);
    //将作画结果保存至UIImageView上
    self.freeCanvas.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束作画
    UIGraphicsEndImageContext();
    
    _pntBegin = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch  *touch          = [touches anyObject];
    CGPoint  currentPoint    = [touch locationInView:self.view];

    if(!_bMoved ) 
    {
        UIGraphicsBeginImageContext(self.freeCanvas.frame.size);
        [self.freeCanvas.image drawInRect:self.freeCanvas.frame];
        CGContextRef    context = UIGraphicsGetCurrentContext();
        
        if (_bRubber) {
            CGContextClearRect(context, 
                               CGRectMake(currentPoint.x - _fBrushWidth, 
                                          currentPoint.y - _fBrushWidth, 
                                          _fBrushWidth*2, 
                                          _fBrushWidth*2));
        }
        else {
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineWidth(context, _fBrushWidth);
            CGContextSetRGBStrokeColor(context, _fRed, _fGreen, _fBlue, 1.0f);
            CGContextMoveToPoint(context, _pntBegin.x, _pntBegin.y);
            CGContextAddLineToPoint(context, _pntBegin.x, _pntBegin.y);
            CGContextStrokePath(context); 
        }

        CGContextFlush(context);
        self.freeCanvas.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

#pragma mark -
#pragma mark Action
- (IBAction)actSelectColor:(id)sender
{
    UISegmentedControl *control = sender;
    NSInteger index = [control selectedSegmentIndex];
    
    switch (index) {
        case 0:
            _bRubber = NO;
            _fRed = 102.0f/255.0f;
            _fGreen = 208.0f/255.0f;
            _fBlue = 0.0f/255.0f;
            break;
        case 1:
            _bRubber = NO;
            _fRed = 255.0f/255.0f;
            _fGreen = 104.0f/255.0f;
            _fBlue = 0.0f/255.0f;
            break;
        case 2:
            _bRubber = YES;
            break;
        default:
            _bRubber = NO;
            break;
    }
}

- (IBAction)actClose:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
}

@end
