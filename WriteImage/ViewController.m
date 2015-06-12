//
//  ViewController.m
//  WriteImage
//
//  Created by 刘杨 on 15/6/12.
//  Copyright (c) 2015年 Tony. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "WriteImageTableViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) UIImagePickerController *pickerController;
@property (strong, nonatomic) ALAssetsLibrary *library;
@property (strong, nonatomic) NSMutableArray *imageDataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.library = [[ALAssetsLibrary alloc] init];
    
//    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
//        
//        NSString *errorMessage = nil;
//        switch ([error code]) {
//            case ALAssetsLibraryAccessUserDeniedError:
//            case ALAssetsLibraryAccessGloballyDeniedError:
//                errorMessage = @"访问相册被拒绝";
//                break;
//            default:
//                errorMessage = @"访问相册失败";
//                break;
//        }
//    };
//    
//    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
//        NSInteger groupType = [[group valueForProperty:ALAssetsGroupPropertyType] integerValue];
//        
//        if (groupType == ALAssetsGroupSavedPhotos) {
//            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
//            [group setAssetsFilter:onlyPhotosFilter];
//        }
//    };
    
//    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:listGroupBlock failureBlock:failureBlock];
    NSMutableArray *data = [NSMutableArray array];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group != nil) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result != nil) {
                    [data addObject:result];
                    self.imageDataArray = data;
                }
                CGImageRef ref = result.thumbnail;
                self.myImageView.image = [UIImage imageWithCGImage:ref];
            }];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
    
}

- (IBAction)selectPhoto:(UIButton *)sender {

//    [self presentViewController:self.pickerController animated:YES completion:^{
    
//    }];
//    [self.navigationController pushViewController:self.pickerController animated:YES];
}

#pragma mark - property

- (UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _pickerController.delegate = self;
    }
    return _pickerController;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.library assetForURL:info[UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        CGImageRef ref = rep.fullScreenImage;
        self.myImageView.image = [UIImage imageWithCGImage:ref];
    } failureBlock:^(NSError *error) {
        
    }];
  
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
//    [asset writeModifiedImageDataToSavedPhotosAlbum:imageData metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//        NSLog(@"为什么不进来");
//    }];
}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    NSLog(@"%@",picker);
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   WriteImageTableViewController *tableView = segue.destinationViewController;
    tableView.imageDataArray = self.imageDataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
