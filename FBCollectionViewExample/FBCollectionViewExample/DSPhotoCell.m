//
//  DSPhotoCell.m
//  FBCollectionViewExample
//
//  Created by Ruthwick S Rai on 13/10/16.
//  Copyright © 2016 Ruthwick S Rai. All rights reserved.
//

#import "DSPhotoCell.h"
#define SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
@implementation DSPhotoCell
- (void)awakeFromNib
{
    [super awakeFromNib];
    [_profileImage layoutIfNeeded];
    _profileImage.layer.cornerRadius = _profileImage.frame.size.width / 2;
    _profileImage.layer.borderColor = [[UIColor whiteColor] CGColor];
    _profileImage.layer.borderWidth = 1.0;
    _profileImage.layer.masksToBounds = YES;
    [_likeButton setImage:[UIImage imageNamed:@"heart_icon_selected"] forState:UIControlStateSelected];
    [_likeButton setImage:[UIImage imageNamed:@"heart_icon"] forState:UIControlStateNormal];
    _userDescription.delegate = self;
    _userDescription.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    _userDescription.linkAttributes =  @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.263 green:0.718 blue:0.478 alpha:1.00],NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    
   //** setup collectionview **//
    [self.sliderView setDataSource:self];
    [self.sliderView setDelegate:self];
    [self.userDescription updateConstraints];
    [self.userDescription layoutIfNeeded];
    [self.sliderView updateConstraints];
    [self.sliderView layoutIfNeeded];
    [_likesCount layoutIfNeeded];
    [_likesCount updateConstraints];
    [self.contentView updateConstraints];
    [self.contentView layoutIfNeeded];
    [self updateConstraints];
    [self layoutIfNeeded];
    
    //***** setup height of collection view depending the count of images ****//
     NSLog(@"collectiobview height: %f",_sliderView.frame.size.height);
    CollectionViewCellHeight =293;
    arrayHeight5 = @[[NSString stringWithFormat:@"%f",CollectionViewCellHeight/2],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/2],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/3],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/3],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/3]];
    arrayHeight3 = @[[NSString stringWithFormat:@"%f",CollectionViewCellHeight],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/2],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/2]];
    arrayHeight4 = @[[NSString stringWithFormat:@"%f",CollectionViewCellHeight],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/3],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/3],[NSString stringWithFormat:@"%f",CollectionViewCellHeight/3]];
    NSLog(@"collectiobview height after update: %f",_sliderView.frame.size.height);
}

- (IBAction)likeButtonClicked:(id)sender {
    BOOL isFavorite = ![[_embededDetails objectForKey:@"favorited"]boolValue];
    int favoriteCnt =  [favoritecnt intValue];
    NSString *favoriteStr = [NSString stringWithFormat:@"%ld",(long)[favoritecnt intValue]];
    NSInteger likeStatus = 0;
    if(!isFavorite){
        favoriteCnt -= 1;
        likeStatus = 0;
        _likeButton.selected = NO;
    }else{
        favoriteCnt += 1;
        likeStatus = 1;
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.duration = 0.125;
        anim.repeatCount = 1;
        anim.autoreverses = YES;
        anim.removedOnCompletion = YES;
        anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)];
        [_likeButton.layer addAnimation:anim forKey:nil];
        _likeButton.selected = YES;
    }
    favoritecnt = [NSString stringWithFormat:@"%ld",(long)favoriteCnt];
    if ([favoritecnt integerValue]==0) {
        _likesCount.hidden=YES;
    }else{
        _likesCount.hidden=NO;
    }
    _likesCount.text = [NSString stringWithFormat:@"%@ favorites",favoritecnt];
    favoriteStr = [NSString stringWithFormat:@"%ld",(long)favoriteCnt];
    [_embededDetails setObject:[NSNumber numberWithBool:isFavorite] forKey:@"favorited"];
    [_embededDetails setObject:[NSNumber numberWithInt:favoriteCnt] forKey:@"favoritecnt"];
    [_likesCount layoutIfNeeded];
    [_likesCount updateConstraints];
    NSLog(@"likeButtonClicked photo-multi");
}

- (IBAction)commentButtonClicked:(id)sender {
    NSLog(@"commentButtonClicked");
}

- (IBAction)shareButtonClicked:(id)sender {
    NSLog(@"shareButtonClicked");
    NSString* textToShare = @"Share your text here!!";
    NSArray* itemsToShare = @[ textToShare ];
    UIActivityViewController* activityVC =
    [[UIActivityViewController alloc] initWithActivityItems:itemsToShare
                                      applicationActivities:nil];
    activityVC.excludedActivityTypes = @[
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll
                                         ];
    UIViewController *currentTopVC = [self currentTopViewController];
    [currentTopVC presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)userProfileButtonClicked:(id)sender {
    NSLog(@"userProfileButtonClicked");
}

- (UIViewController *)currentTopViewController
{
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (IBAction)moreButtonClicked:(id)sender {
    NSLog(@"moreButtonClicked");
    [self moreAction];
}

#pragma setup cell data
- (void)laodCellContents {
    NSString* profileName = [_embededDetails objectForKey:@"author"];
    NSString* profileUserName = [_embededDetails objectForKey:@"ownerName"];
    NSString * profilePhoto = [_embededDetails objectForKey:@"photo"]; 
    [_profileImage sd_setImageWithURL:[NSURL URLWithString:profilePhoto] placeholderImage:[UIImage imageNamed:@"No_profile_image"] ];
    NSString *dateStamp = [_embededDetails objectForKey:@"modifieddate"];
    NSString *favorited =  [_embededDetails objectForKey:@"favorited"];
    if ([favorited intValue] == 1 || favouriteButtonState == 1) {
        _likeButton.selected = YES;
    }else{
        _likeButton.selected = NO;
    }
    NSString *duration = [FBCollectionViewUtilityManager getPostDurationWhenPostedWithLongDate:[[NSString stringWithFormat:@"%@",dateStamp]doubleValue]];
    _date.text = [NSString stringWithFormat:@"%@",duration];
    favoritecnt = [_embededDetails objectForKey:@"favoritecnt"];
    _likesCount.text = [NSString stringWithFormat:@"%@ Likes",favoritecnt];
    _profileName.text = [NSString stringWithFormat:@"%@", profileName];
    _profileUserName.text = [NSString stringWithFormat:@"@%@", profileUserName];
    NSString *discription = [NSString stringWithFormat:@"%@",[_embededDetails objectOrNilForKey:@"contenttext"]];
    _userDescription.text = discription;
}

#pragma setup what to do when link in user description is clicked
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    NSLog(@"Did click :%@",url);
    if ([FBCollectionViewUtilityManager validateUrl:[NSString stringWithFormat:@"%@",url]]) {
        SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:url entersReaderIfAvailable:YES];
        safariVC.delegate = self;
        UIViewController *currentTopVC = [self currentTopViewController];
        [currentTopVC presentViewController:safariVC animated:YES completion:nil];
    }
}


-(void)loadEmbedPhotos:(NSArray *)mediaList{
    NSLog(@"here at laodembedphotos: %@",mediaList);
    embedlist = mediaList;
    linkThumbnailurl = [mediaList valueForKey:@"mediaurl"];
    [self.sliderView reloadData];
}

#pragma setup collectioView datasource and delegates
- (NSInteger)numberOfSectionsInCollectionView:
(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    if (embedlist.count>5) {
        return 5;
    }else{
        return embedlist.count;
    }
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    [self.sliderView registerClass:[SliderCell class] forCellWithReuseIdentifier:@"SliderCell"];
    [self.sliderView registerNib: [UINib nibWithNibName:@"SliderCell" bundle:nil] forCellWithReuseIdentifier:@"SliderCell"] ;
    SliderCell* cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"SliderCell"
                                              forIndexPath:indexPath];
    NSLog(@"cell reloaded  %@",linkThumbnailurl);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:linkThumbnailurl[indexPath.item]] placeholderImage:[UIImage imageNamed:@"no_image_placeholder"] ];
    cell.imageUrl = [FBCollectionViewUtilityManager neutraliseString:linkThumbnailurl[indexPath.item]];
    cell.contentView.layer.cornerRadius= 4;
    cell.contentView.clipsToBounds = YES;     cell.contentView.layer.borderColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;
    NSIndexPath *indexPathLast = [NSIndexPath indexPathForItem:(int)2 inSection:0];
    if ([indexPath isEqual:indexPathLast] && embedlist.count>5)
    {
        cell.overLay.hidden=NO;
        cell.countImage.text=[NSString stringWithFormat:@"+ %lu",(embedlist.count-5)];
    }else{
        cell.overLay.hidden=YES;
        cell.countImage.text=@"";
    }
  return cell;
}

#pragma Setup collectioView height
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [[NSString stringWithFormat:@"%f",SCREEN_WIDTH] floatValue];
    NSLog(@"embedlist.count  %lu",(unsigned long)embedlist.count);
    if (embedlist.count>=5) {
        int Limiter = (int) indexPath.item;
        if (Limiter>5)Limiter=5;
        CGFloat newHeight = [arrayHeight5[Limiter] floatValue ];
        return CGSizeMake(width/2,newHeight);
    }
    switch (embedlist.count) {
        case 2:{
            return CGSizeMake(width/2, CollectionViewCellHeight);
        }break;
        case 3:{
            CGFloat newHeight = [arrayHeight3[indexPath.item] floatValue ];
            return CGSizeMake(width/2,newHeight);
        }break;
        case 4:{
            CGFloat newHeight = [arrayHeight4[indexPath.item] floatValue ];
            return CGSizeMake(width/2,newHeight);
        }break;
        default:
        {
            return CGSizeMake(width, CollectionViewCellHeight);
        }break;
    }
}

#pragma setup collectionView didSelect function
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"collectionviewcell didtap!!");
    self.photos = [NSMutableArray array];
    for (int i = 0; i<linkThumbnailurl.count; i++) {
        NSString *linkThumbnailurlString = linkThumbnailurl[i];
        NSURL *url = [NSURL URLWithString:linkThumbnailurlString];
        NSLog(@"photo browser url: %@",linkThumbnailurlString);
        [_photos addObject:[MWPhoto photoWithURL:url]];
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    _thumbs = _photos;
    // Set options
    browser.displayNavArrows = YES; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    if (indexPath.item>1)
    {
        NSLog(@"indexpath item > 1 ");
        browser.startOnGrid = YES;
        browser.enableGrid = YES;
    }
    else{
        NSLog(@"indexpath item < 1 ");
        browser.enableGrid = NO;
        browser.startOnGrid = NO;
        [browser setCurrentPhotoIndex:indexPath.item];
    }
    // Optionally set the current visible photo before displaying
    // Present
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:browser]; //add this as a root view controller
    UIViewController *currentTopVC = [self currentTopViewController];
    [currentTopVC presentViewController:navController animated:YES completion:nil];
}

#pragma setup photobrowser properties
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < self.thumbs.count) {
        return [self.thumbs objectAtIndex:index];
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma  setup more button options
-(void)moreAction {
    UIAlertController* alertctrl = [UIAlertController alertControllerWithTitle:@"More action:" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIViewController *currentTopVC = [self currentTopViewController];
    UIAlertAction* edit = [UIAlertAction actionWithTitle:@"Edit Cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            NSLog(@"edit detail");
        [FTToastIndicator showToastMessage:@"Cell edited"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [FTToastIndicator dismiss];
            });
             }];
        UIAlertAction* More = [UIAlertAction actionWithTitle:@"Delete Cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            
                [FTToastIndicator showToastMessage:@"Cell deleted"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [FTToastIndicator dismiss];
                });
        }];
        UIAlertAction* cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction* action) {
                                           NSLog(@"Cancel action");
                                       }];
        [alertctrl addAction:edit];
        [alertctrl addAction:More];
        [alertctrl addAction:cancelAction];
        [currentTopVC presentViewController:alertctrl animated:YES completion:nil];
}

@end
