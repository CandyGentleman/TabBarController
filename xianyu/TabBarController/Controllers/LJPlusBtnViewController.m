//
//  LJPlusBtnViewController.m
//  TabBarController
//
//  Created by 刘鹿杰的mac on 2018/12/3.
//  Copyright © 2018 刘鹿杰的mac. All rights reserved.
//

#import "LJPlusBtnViewController.h"

@interface LJPlusBtnViewController ()

@end

@implementation LJPlusBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"popVC";
    [self setUpNav];
    
}

- (void)setUpNav{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = backItem;
    
}


- (void)pop{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
