//
//  DSCellDetail.m
//  FBCollectionViewExample
//
//  Created by Ruthwick S Rai on 14/10/16.
//  Copyright © 2016 Ruthwick S Rai. All rights reserved.
//

#import "DSCellDetail.h"
#import "HPGrowingTextView.h"
#import "DSPhotoCell.h"
@interface DSCellDetail ()<HPGrowingTextViewDelegate>{
    UIView *containerView;
    HPGrowingTextView *textView;
    UIButton *doneBtn;
}
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *detailCellHeightConstraint;
@end

@implementation DSCellDetail
-(void)viewWillAppear:(BOOL)animated{
    //***** setup hptextview observers ****//
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    //***** setup hptextview observers removers****//
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [textView resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [textView resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //****** setup tableview datasource and delegates  ****//
     [self.detailTableView registerNib:[UINib nibWithNibName:@"DSPhotoCell" bundle:nil] forCellReuseIdentifier:@"DSPhotoCell"];
    self.detailTableView.rowHeight = UITableViewAutomaticDimension;
    self.detailTableView.estimatedRowHeight = 250;
     [self setupComposeBarView];
    [self.detailTableView setDelegate:self];
    [self.detailTableView setDataSource:self];
    [self.detailTableView setNeedsLayout];
    [self.detailTableView layoutIfNeeded];
}

#pragma Setup hpGrowingTextview Properties
-(void)setupComposeBarView{
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 9, self.view.frame.size.width-80, 20)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    [[UITextView appearance] setTintColor:[UIColor colorWithHex:@"00A369"]];
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 6;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
    textView.returnKeyType = UIReturnKeyNext; //just as an example
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"Write your comment...";
    [self.view addSubview:containerView];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textView.layer.cornerRadius = 6.0;
    textView.layer.borderColor=[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00].CGColor;
    textView.layer.borderWidth=1.0;
    UIView * topBorder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, 1)];
    topBorder.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
    UIView * bckGrnd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    bckGrnd.backgroundColor = [UIColor colorWithRed:0.965 green:0.957 blue:0.957 alpha:1.00];
    bckGrnd.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [containerView addSubview:bckGrnd];
    [containerView addSubview:topBorder];
    [containerView addSubview:textView];
    doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(containerView.frame.size.width - 65, 11, 50, 30);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [doneBtn setTitle:@"Send" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor colorWithHex:@"00A369"] forState:UIControlStateNormal];
   	[doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.enabled=NO;
    [containerView addSubview:doneBtn];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Setup tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    DSPhotoCell* Cell = [tableView dequeueReusableCellWithIdentifier:@"DSPhotoCell" forIndexPath:indexPath];
    Cell.embededDetails = _postDetails;
    NSArray *mediaList =  [_postDetails objectOrNilForKey:@"medialist"];
    if (mediaList.count>0) {
        [Cell loadEmbedPhotos:mediaList];
    }
    [Cell laodCellContents];
    [Cell.contentView layoutIfNeeded];
    cell=Cell;
    return cell;
}

#pragma Setup what happens when text is entered comment box
-(void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView{
    if (![[growingTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        NSLog(@"growingTextViewDidChange  : %@",growingTextView.text);
        doneBtn.enabled=YES;
    }else doneBtn.enabled=NO;
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(void)resignTextView
{
    textView.text=@"";
    [textView resignFirstResponder];
}

#pragma setup notification functions
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    containerView.frame = containerFrame;
    
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    containerView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [textView resignFirstResponder];
}

-(void)resignKeyBoard{
    NSLog(@"resign keyboard ");
    [textView resignFirstResponder];
}

@end
