//
//  ShowImageViewController.m
//  WriteImage
//
//  Created by 刘杨 on 15/6/12.
//  Copyright (c) 2015年 Tony. All rights reserved.
//

#import "ShowImageViewController.h"

@interface ShowImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ALAssetRepresentation *rep = self.asset.defaultRepresentation;
    if (rep) {
        CGImageRef ref = rep.fullResolutionImage;
        self.imageView.image = [UIImage imageWithCGImage:ref];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
