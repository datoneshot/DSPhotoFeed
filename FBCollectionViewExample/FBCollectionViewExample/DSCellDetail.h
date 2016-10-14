//
//  DSCellDetail.h
//  FBCollectionViewExample
//
//  Created by Ruthwick S Rai on 14/10/16.
//  Copyright © 2016 Ruthwick S Rai. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DSCellDetail : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *contentViewCell;
@property(nonatomic,strong)NSMutableDictionary *postDetails;
@end
