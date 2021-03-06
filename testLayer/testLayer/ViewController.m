//
//  ViewController.m
//  testLayer
//
//  Created by FlyOceanFish on 2018/4/10.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import "ViewController.h"
#import "ShapeCircle.h"
@interface ViewController ()
{
    ShapeCircle *layer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self strokeStartAndEnd];
//    [self fillRule];
//    [self gradientLayer];
//    [self maskLayer];
    [self halfCircle];
//    [self keyFrameAnimal];
//    [self shapeAnimalQQMessage];
//    [self animalGroup];
//    [self gradientText];
}
- (void)animalGroup{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 50, 50);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim1.fromValue = @1;
    anim1.toValue = @0;
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim2.fromValue = @1;
    anim2.toValue = @0;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[anim1,anim2];
    group.duration = 5;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [layer addAnimation:group forKey:nil];
}
- (void)shapeAnimalQQMessage{
    layer = [ShapeCircle layer];
    layer.originFrame = CGRectMake(100, 100, 10, 10);
    layer.maxDistance = 140;
    layer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    layer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    layer.currentFrame = CGRectMake(point.x, point.y, 15, 15);
    NSLog(@"---开始---%@",NSStringFromCGPoint(point));
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    layer.currentFrame = CGRectZero;
    NSLog(@"-----结束-----");
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"-----取消-----");
}
- (void)keyFrameAnimal{
//    UIView *vi，ew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    view.backgroundColor = [UIColor orangeColor];
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 10, 10) cornerRadius:5];
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(0, 0, 10, 10);
    circleLayer.fillColor = [UIColor orangeColor].CGColor;
    circleLayer.path = circle.CGPath;
    
//    CALayer *circleLayer = [[CALayer alloc] init];
//    circleLayer.frame = CGRectMake(0, 0, 20, 20);
//    circleLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:circleLayer];
    
    CGMutablePathRef thePath = CGPathCreateMutable();
//    CGPathMoveToPoint(thePath,NULL,74.0,74.0);
//    CGPathAddCurveToPoint(thePath,NULL,74.0,74,
//                          130,300.0,
//                          186.0,74.0);
//    CGPathAddCurveToPoint(thePath,NULL,186,74.0,
//                          220,400.0,
//                          300,74.0);
    CGPathAddArc(thePath, NULL, 150, 200, 100, 0, 2*M_PI, YES);
    CAKeyframeAnimation * theAnimation;
    
    // Create the animation object, specifying the position property as the key path.
    theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path=thePath;
    theAnimation.duration=5.0;
    theAnimation.repeatCount = 100;
    theAnimation.fillMode = kCAFillModeForwards;
//    theAnimation.rotationMode = kCAAnimationRotateAutoReverse;//如果是长方体的话，重心是一直朝着圆的中心方向运动
    [circleLayer addAnimation:theAnimation forKey:@"position"];
    
    CAShapeLayer *animalTrack = [CAShapeLayer layer];
    animalTrack.path = thePath;
    animalTrack.strokeColor = [UIColor redColor].CGColor;
    animalTrack.fillColor = [UIColor clearColor].CGColor;
    animalTrack.lineWidth = 1;
    [self.view.layer addSublayer:animalTrack];
    

//    [self.view.layer insertSublayer:animalTrack below:circleLayer];
}
// 带有动画和渐变的圆弧
- (void)halfCircle{
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 120)];//当宽高一样的时候就是圆,否则就是椭圆
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 120) cornerRadius:90];//首先是画一个矩形，然后再设置四个角的角度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:80 startAngle:-M_PI_2 endAngle:M_PI/2 clockwise:YES];//以point为中心，radius的值为半径画弧。此弧的开始角度为startAngle,结束角度为endAngle，这两个数值是弧度，不是角度。clockwise是画此弧是按照顺时针还是逆时针
    //    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:70 startAngle:-M_PI_2 endAngle:M_PI/2 clockwise:YES];
    //    [path appendPath:path2];
    CAShapeLayer *pointLayer = [CAShapeLayer layer];
    pointLayer.path = path.CGPath;
    pointLayer.strokeColor = [[UIColor blackColor] CGColor];//线条颜色
    
    //    kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态（可以理解为动画执行完成后移除）
    //    kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
    //    kCAFillModeBackwards 当在动画开始前,你只要把layer加入到一个动画中,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,延迟3秒让动画开始,只要动画被加入了layer,layer便处于动画初始状态
    //    pointLayer.fillMode = kCAFillModeBackwards;//是针对动画的，决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后的状态
    
    
    pointLayer.fillRule = kCAFillRuleEvenOdd;//对于两个path有重叠部分，取其非交集。比如一个矩形中有一个圆，则填充颜色的区域是这两个的非交集部分
    
    
    //    kCALineCapButt 直角
    //    kCALineCapRound 圆角
    //    kCALineCapSquare 与kCGLineCapButt是一样的，但是比kCGLineCapButt长一点
    pointLayer.lineCap = kCALineCapRound;//当线条是单独的没有与其他线连接的时候，此时线头的形状
    
    //    kCALineJoinMiter 正常连接
    //    kCALineJoinRound 圆角
    //    kCALineJoinBevel 成斜角，是一条斜线
    //    pointLayer.lineJoin = kCALineJoinRound;//当线条与其他线有连接的时候，连接处最外侧线的显示方式
    pointLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色
    pointLayer.lineWidth = 10;
    
    
    CABasicAnimation *animal = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animal.fromValue = @0;
    animal.toValue = @1;
    animal.duration = 2;
    animal.removedOnCompletion =
    //    必须设置这两个属性才能保证动画结束后保持动画结束后的状态
    //    animal.removedOnCompletion = NO;
    //    animal.fillMode = kCAFillModeForwards;
    
    // 动画先加速后减速
    animal.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    CASpringAnimation *anim2 = [CASpringAnimation animationWithKeyPath:@"strokeEnd"];
    anim2.fromValue = @0;
    anim2.toValue = @1;
    anim2.duration = 5;
    anim2.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim2.damping = 8;//阻尼系数，值越大停止的越快
    anim2.stiffness =100;//刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    anim2.mass = 2;//质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    
    //initialVelocity:
    //    初始速率，动画视图的初始速度大小
    //    速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    //    如果把速率改成-20，则动画变成
    //    [pointLayer addAnimation:anim2 forKey:@"animal"];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame =CGRectMake(10, 10, 190, 190);
    UIColor *middleColor = [UIColor blueColor];
    NSArray *colors = @[
                        (__bridge id)[UIColor redColor].CGColor,
                        (__bridge id)middleColor.CGColor,
                        ];
    gradientLayer.colors = colors;
    gradientLayer.startPoint =  CGPointMake(0.5, 0.5);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.mask = pointLayer;
    
    [self.view.layer addSublayer:gradientLayer];
    [pointLayer addAnimation:anim2 forKey:@"animal"];
}
//测试strokeStart和strokeEnd
- (void)strokeStartAndEnd{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 200) radius:80 startAngle:-M_PI_2 endAngle:M_PI*3/2 clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 5;
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor purpleColor].CGColor;
    layer.fillColor = [UIColor orangeColor].CGColor;
    layer.strokeStart = 0.5;
    layer.strokeEnd = 0.8;
    [self.view.layer addSublayer:layer];
}
//kCAFillRuleEvenOdd属性的例子
- (void)fillRule{
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) cornerRadius:50];
    [path1 appendPath:path2];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.frame = CGRectMake(50, 50, 100, 100);
    shapLayer.fillColor = [UIColor blackColor].CGColor;
    shapLayer.fillRule = kCAFillRuleEvenOdd;
    shapLayer.path = path1.CGPath;
    shapLayer.lineWidth = 0.5;
    
    
    [self.view.layer addSublayer:shapLayer];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.fillColor = [UIColor redColor].CGColor;
    layer.path= path1.CGPath;
    [self.view.layer insertSublayer:layer below:shapLayer];
}
// 渐变层测试
- (void)gradientLayer{
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(100, 300, 80, 100);
    UIColor *middleColor = [UIColor colorWithWhite:255/255 alpha:0.8];
    NSArray *colors = @[
                        (__bridge id)[UIColor redColor].CGColor,
                        (__bridge id)middleColor.CGColor,
                        (__bridge id)[UIColor redColor].CGColor
                        ];
    layer.colors = colors;
    [self.view.layer addSublayer:layer];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
}
//遮罩层demo
- (void)maskLayer{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) cornerRadius:50];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, 100, 100);
    maskLayer.path = maskPath.CGPath;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.path = path.CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.mask = maskLayer;
    [self.view.layer addSublayer:layer];
}
//文字颜色渐变
- (void)gradientText{
    NSString *str = @"在线阅读经典的好文章美文,爱情伤感文章,生活情感文章,欣赏最新原创空间博客伤感日志,情感日志及爱情,友情,心情...";
    CGFloat height = [str boundingRectWithSize:CGSizeMake(self.view.bounds.size.width-30, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:18] } context:nil].size.height;
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = str;
    textLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width-30, height+20);
    textLayer.backgroundColor = [UIColor clearColor].CGColor;
    textLayer.fontSize = 18;
    textLayer.wrapped = YES;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(15, 100, self.view.bounds.size.width-30, height+20);
    [gradientLayer setStartPoint:CGPointMake(0.0, 0.0)];
    [gradientLayer setEndPoint:CGPointMake(1.0, 1.0)];
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,  (id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor];
    //加上遮罩效果，以 gradientLayer 为 底色，用 textLayer 的文字为模板
    gradientLayer.mask = textLayer;
    [self.view.layer addSublayer:gradientLayer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
