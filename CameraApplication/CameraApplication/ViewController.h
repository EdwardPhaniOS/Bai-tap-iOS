//
//  ViewController.h
//  CameraApplication
//
//  Created by Aaron Caines on 11/09/2018.
//  Copyright © 2018 Aaron Caines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    UIImagePickerController *picker;
    UIImage *image;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;
- (IBAction)choosePhoto:(id)sender;
- (IBAction)savePhoto:(id)sender;




@end

