//
//  ViewController.m
//  LHQ3DTouchDemo
//
//  Created by Xhorse_iOS3 on 2021/1/14.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.label = [UILabel new];
    self.label.font = [UIFont systemFontOfSize:18];
    self.label.textColor = [UIColor blackColor];
    self.label.frame = CGRectMake(0, 0, 250, 80);
    self.label.center = self.view.center;
    self.label.numberOfLines = 2;
    [self.view addSubview:self.label];
    self.label.text = @"Not Quick";
}

- (void)setQuickStr:(NSString *)quickStr {
    _quickStr = quickStr;
    self.label.text = quickStr;
}

@end
