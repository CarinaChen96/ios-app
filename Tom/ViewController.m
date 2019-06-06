//
//  ViewController.m
//  Tom
//
//  Created by 409 on 17-4-27.
//  Copyright (c) 2017年 409. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSDictionary *_dict; // 保存所有图片个数
}
@end

@implementation ViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
     //1.获得字典tom.olist的全路径
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"tom" ofType:@"plist"];
    
    //2.根据文件路径加载字典
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
}

- (void)playAnim:(int)count filename:(NSString *)filename{
    
    //1.创建可变数组
    NSMutableArray *images = [NSMutableArray array];
    
    //2.添加图片
    for (int i  = 0; i<count; i++) {
        
        NSString *name = [NSString stringWithFormat:@"%@_%02d.jpg",filename,i];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
        
        //加载图片（缓存）
        //UIImage *img = [UIImage imageNamed:name];
        
        [images addObject:img];
    }
    
    //3.设置动画图片(squence)
    _tom.animationImages = images;
    
    //4.播放次数：1次
    _tom.animationRepeatCount = 1;
    
    //5.animation duration time
    _tom.animationDuration = 0.1 * count;
    
    //6.animation beginning
    [_tom startAnimating];
}

- (IBAction)btnClick:(UIButton *)sender {
    //1.如果正在播放动画，直接返回
    if(_tom.isAnimating) return;
    
    //2.取出按钮文字
    NSString *title = [sender titleForState:UIControlStateNormal];
    
    //3.获得图片数量
    int count = [_dict[title] intValue];
    
    //4.播放动画
    [self playAnim:count filename:title];
}
@end
