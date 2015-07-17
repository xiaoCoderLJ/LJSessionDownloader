//
//  MyView.m
//  Qurtz2D_text
//
//  Created by Jay_Apple on 15/6/18.
//  Copyright (c) 2015年 Jay_Apple. All rights reserved.
//

#import "MyProgressView.h"

@interface MyProgressView ()

@property (nonatomic, weak) UILabel *percent;

@end

@implementation MyProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *percent = [[UILabel alloc] init];
        percent.textAlignment = NSTextAlignmentCenter;
        percent.font = [UIFont systemFontOfSize:20];
        percent.textColor = [UIColor blackColor];
        [self addSubview:percent];
        _percent = percent;
    }
    return self;
}

-(void)awakeFromNib{

    UILabel *percent = [[UILabel alloc] init];
    percent.textAlignment = NSTextAlignmentCenter;
    percent.font = [UIFont systemFontOfSize:20];
    percent.textColor = [UIColor blackColor];
    [self addSubview:percent];
    _percent = percent;

}

-(void)drawRect:(CGRect)rect{
    
    //创建图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置进度颜色填充高度
    CGFloat progressRectH = rect.size.height * _progressValue;
    
    CGFloat progressRectW = rect.size.width;
    
    CGFloat progressRectY =  rect.size.height-progressRectH;
    //创建颜色填充绘图路径
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, progressRectY, progressRectW, progressRectH)];
    
    //设置颜色填充
    [[UIColor greenColor] set];
    
    //添加路径到图形上下文
    CGContextAddPath(ctx, path.CGPath);
    
    //进行绘图填充（渲染）
    CGContextFillPath(ctx);
    
    //设置进度圈的圆心半径
    CGPoint center = CGPointMake(rect.size.width *0.5, rect.size.height*0.5);
    
    CGFloat radius = self.frame.size.width * 0.5 - 5;
    
    CGFloat startAngle = -M_PI_2;
    
    CGFloat endAngle = self.progressValue * M_PI * 2 - M_PI_2;
    
    //设置路径
    path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    //颜色设置
    [[UIColor blackColor] set];
    
    //添加路径到图形上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 渲染
    CGContextStrokePath(ctx);
    // 设置限时进度
    self.percent.text = [NSString stringWithFormat:@"%.2f%%",self.progressValue*100];
}

-(void)setProgressValue:(CGFloat)progressValue{

    _progressValue = progressValue;
    [self setNeedsDisplay];
}


-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.percent.frame = self.bounds;
    
}





@end
