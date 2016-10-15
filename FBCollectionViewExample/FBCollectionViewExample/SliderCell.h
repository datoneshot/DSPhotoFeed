//
//  SliderCell.h
//  Canvas-iPhone
//
//  Created by Yashwanth on 24/04/16.
//  Copyright © 2016 Zymr, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SliderCell : UICollectionViewCell<NSURLConnectionDataDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *overLay;
@property (strong, nonatomic) IBOutlet UILabel *countImage;
@property (nonatomic, strong) NSString *imageUrl;
@end
