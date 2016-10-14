//
//  ViewController.m
//  FBCollectionViewExample
//
//  Created by Ruthwick S Rai on 13/10/16.
//  Copyright © 2016 Ruthwick S Rai. All rights reserved.
//

#import "ViewController.h"

//import your custom cell
#import "DSPhotoCell.h"
#define KEY_INDEXPATH         @"indexPath"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (strong, nonatomic) NSArray *cardDetailsArray;
@property (nonatomic,readwrite)NSMutableDictionary *postDict;
@property (strong, nonatomic) IBOutlet UITableView *timeLineTableView;
@property (strong,nonatomic) NSDictionary * timeLineDetails;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    //****** setup tableview ******//
    [self.timeLineTableView setDataSource:self];
    [self.timeLineTableView setDelegate:self];
    self.timeLineTableView.emptyDataSetSource = self;
    self.timeLineTableView.emptyDataSetDelegate = self;
    [self.timeLineTableView registerNib:[UINib nibWithNibName:@"DSPhotoCell" bundle:nil] forCellReuseIdentifier:@"DSPhotoCell"];
    self.timeLineTableView.estimatedRowHeight = 465;
    self.timeLineTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //***** Set up a data to load in the tableview *****//
_cardDetailsArray = @[@{@"author":@"Hemanth",
                            @"ownerName" : @"hemi",
                            @"favorited" : @"0",
                            @"favoritecnt" : @"0",
                            @"medialist" : @[
                                    @{
                                        @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Hennessey-Venom-GT.jpg"
                                        }
                                    ],
                            @"modifieddate" : @"1467223284429",
                            @"contenttext" : @"<p>Model year: 2012,Top speed: 270.49 (435.3km/h),Engine: 7.0l LSX Twin Turbocharged V8 (1244 hp). In this tableView cell only one cell of the collectionView is shown. (<a target=\"_blank\" href=\"http://www.wonderslist.com/top-20-fastest-supercars-in-the-world\">Source</a>)</p>"
                            },
                        @{@"author":@"Ruthwick S Rai",
                            @"ownerName" : @"ruthwick",
                            @"favorited" : @"0",
                            @"favoritecnt" : @"1",
                            @"medialist" : @[
                                    @{
                                        @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/lamborghini-huracan.jpg"
                                        },
                                    @{
                                        @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/McLaren-650S.jpg"
                                        },
                                    @{
                                        @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Porsche-918-Spyder.jpg"
                                        }
                                    ],
                            @"modifieddate" : @"1467223284429",
                            @"contenttext" : @"When there a only 3 photos"
                        },
                      @{@"author":@"Punith B M",
                          @"ownerName" : @"puni",
                          @"favorited" : @"1",
                          @"favoritecnt" : @"3",
                          @"medialist" : @[
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Koenigsegg-CCX.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Bugatti-Veyron-EB-16.4.jpg"
                                      }
                                  ],
    
                        @"modifieddate" : @"1467223284429",
                        @"contenttext" : @"When there a only 2 photos the cell resizes and fit the cell size to show only 2 photos<p></p>"
                        },
                      @{@"author":@"Nakul K J",
                          @"ownerName" : @"naki",
                          @"favorited" : @"0",
                          @"favoritecnt" : @"4",
                          @"medialist" : @[
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/9ff-GT9-R-Porsche.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Koenigsegg-Agera-R.jpeg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Porsche-918-Spyder.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Koenigsegg-One-Fastest-Supercars.jpg"
                
                                      }
                                  ],
                        @"modifieddate" : @"1467223284429",
                        @"contenttext" : @"When there a 4 photos"
                        },
                      @{@"author":@"Bharath P",
                          @"ownerName" : @"bhartaha",
                          @"favorited" : @"1",
                          @"favoritecnt" : @"6",
                          @"medialist" : @[
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/lamborghini-huracan.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/McLaren-650S.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Porsche-918-Spyder.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/McLaren-P1.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Ferrari-LaFerrari.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Lamborghini-Veneno.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Gumpert-Apollo.jpg"
                                      },
                                  @{
                                      @"mediaurl" : @"http://www.wonderslist.com/wp-content/uploads/2015/04/Pagani-Huayra.jpg"
                                      }
                                  ],
                        @"modifieddate" : @"1467223284429",
                        @"contenttext" : @"When there 5 or more photos"
            }
        ];
}

-(void)dealloc{
    // ****** Do this only if the memory warnig causes crash *****//
    self.timeLineTableView.emptyDataSetSource = nil;
    self.timeLineTableView.emptyDataSetDelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Posts found!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:0.000 green:0.718 blue:0.137 alpha:1.00]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor colorWithHex:@"F3F3F3"];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -35.0;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 10.0f;
}

#pragma mark - DZNEmptyDataSetDelegate Methods
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma setup table view delegates and data source
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cardDetailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    _postDict = [NSMutableDictionary dictionaryWithDictionary:[_cardDetailsArray objectAtIndex:indexPath.row]];
    [_postDict setObject:indexPath forKey:KEY_INDEXPATH];
    NSArray *mediaList =  [_postDict objectOrNilForKey:@"medialist"];
    DSPhotoCell* Cell = [tableView dequeueReusableCellWithIdentifier:@"DSPhotoCell" forIndexPath:indexPath];
            Cell.embededDetails = _postDict;
    if (mediaList.count>0) {
        [Cell loadEmbedPhotos:mediaList];
    }
    [Cell performSelector:@selector(laodCellContents) onThread:[NSThread mainThread] withObject:nil waitUntilDone:false];
            [Cell.contentView layoutIfNeeded];
    
               return Cell;
}

@end
