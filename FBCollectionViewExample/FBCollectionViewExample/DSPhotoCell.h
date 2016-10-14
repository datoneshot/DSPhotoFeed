//
//  DSPhotoCell.h
//  FBCollectionViewExample
//
//  Created by Ruthwick S Rai on 13/10/16.
//  Copyright © 2016 Ruthwick S Rai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderCell.h"
#import "TTTAttributedLabel.h"
#import "MWPhotoBrowser.h"
@import SafariServices;
@interface DSPhotoCell : UITableViewCell <UIWebViewDelegate,SFSafariViewControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,TTTAttributedLabelDelegate,MWPhotoBrowserDelegate>
{
    NSArray *embedlist;
    NSArray *linkTitle;
    NSArray *linkDescription;
    NSArray *linkThumbnailurl;
    int favouriteButtonState;
    NSString *favoritecnt;
    
    //**** collectionview **//
    
    NSArray* arrayHeight5;
    NSArray* arrayHeight4;
    NSArray* arrayHeight3;
    CGFloat CollectionViewCellHeight;
  
}
@property (strong,nonatomic) NSString * comment;
@property (strong,nonatomic) NSString * commentString;
@property (strong, nonatomic) IBOutlet UIButton *more;
@property (strong, nonatomic) IBOutlet UIView *userContentDetailsView;
@property (strong, nonatomic) IBOutlet UIView *linkDetailsContentView;
@property (strong, nonatomic) IBOutlet TTTAttributedLabel *userDescription;
@property (strong, nonatomic) IBOutlet UICollectionView *sliderView;
@property(nonatomic,strong)NSMutableDictionary *embededDetails;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UILabel *profileUserName;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property(strong,nonatomic) IBOutlet UILabel * date;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UILabel *likesCount;
@property (strong, nonatomic) IBOutlet UILabel *commentsCount;
@property (nonatomic,strong) NSMutableArray *thumbs;
@property (nonatomic,strong) NSMutableArray *photos;
-(void)laodCellContents;
-(void)loadEmbedPhotos:(NSArray *)mediaList;

@end
