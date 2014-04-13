//
//  photoPickerViewController.h
//  photoPicker
//
//  Created by Olivier Delecueillerie on 12/04/2014.
//  Copyright (c) 2014 Olivier Delecueillerie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "photoPicker.h"

@interface photoPickerViewController : UIViewController <photoPickerDelegate>
@property (strong, nonatomic) NSData *dataImageCaptured;

@end
