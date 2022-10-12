//
//  ViewController.m
//  Rising
//
//  Created by SSR on 2022/10/11.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
}

- (void)test1 {
    NSMutableDictionary *dic = NSMutableDictionary.dictionary;
    NSRange r1 = NSMakeRange(1, 2);
    NSRange r2 = NSMakeRange(1, 3);
    
    NSValue *v1 = [NSValue valueWithRange:r1];
    NSValue *v2 = [NSValue valueWithRange:r2];
    
    dic[v1] = @"a";
    dic[v2] = @"b";
    
    NSValue *t1 = [NSValue valueWithRange:r1];
    
    dic[t1] = @"c";

    RisingLog("😀", @"%@", dic);
}

@end
