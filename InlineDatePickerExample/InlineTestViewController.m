//  Created by Alessio on 06/03/14.
//  Copyright (c) 2014 Alessio. All rights reserved.

#import "InlineTestViewController.h"

@interface InlineTestViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSIndexPath *firstDatePickerIndexPath;
@property (nonatomic, strong) NSIndexPath *secondDatePickerIndexPath;
@property (nonatomic, strong) NSIndexPath *thirdDatePickerIndexPath;
@property (nonatomic, strong) NSIndexPath *fourthDatePickerIndexPath;
@property (nonatomic, strong) NSIndexPath *fifthDatePickerIndexPath;
@property (nonatomic, strong) NSIndexPath *sixthDatePickerIndexPath;

- (void)changeButtonPressed:(UIBarButtonItem *)button;

@end

@implementation InlineTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.firstDatePickerIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    self.secondDatePickerIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    self.thirdDatePickerIndexPath = [NSIndexPath indexPathForRow:6 inSection:2];
    self.fourthDatePickerIndexPath = [NSIndexPath indexPathForRow:12 inSection:2];
    self.fifthDatePickerIndexPath = [NSIndexPath indexPathForRow:13 inSection:2];
    self.sixthDatePickerIndexPath = [NSIndexPath indexPathForRow:24 inSection:2];
    
    self.datePickerPossibleIndexPaths = @[self.firstDatePickerIndexPath,
                                          self.secondDatePickerIndexPath,
                                          self.thirdDatePickerIndexPath,
                                          self.fourthDatePickerIndexPath,
                                          self.fifthDatePickerIndexPath,
                                          self.sixthDatePickerIndexPath];
    
    [self setDate:[NSDate date] forIndexPath:self.firstDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.secondDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.thirdDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.fourthDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.fifthDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.sixthDatePickerIndexPath];
    
    NSArray *firstSectionArray = @[@"elem 1", @"elem 2", @"elem 3", @"elem 4"];
    NSArray *secondSectionArray = @[@"b 1", @"b 2"];
    NSArray *thirdSectionArray = @[@"a1", @"a2", @"a3", @"a4", @"a5", @"a6", @"a7", @"a8", @"a9", @"a10", @"a11", @"a12", @"a13", @"a14", @"a15", @"a16", @"a17", @"a18", @"a19", @"a20", @"a21", @"a22", @"a23", @"a24", @"a25", @"a26", @"a27", @"a28", @"a29", @"a30", @"a31", @"a32", @"a33", @"a34", @"a35", @"a36", @"a37", @"a38", @"a39", @"a40", @"a41", @"a42", @"a43", @"a44", @"a45", @"a46" ,@"a47", @"a48", @"a49", @"a50"];
    
    self.dataSource = @[firstSectionArray, secondSectionArray, thirdSectionArray];
    
    [self.tableView reloadData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"change"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(changeButtonPressed:)];
}

- (void)changeButtonPressed:(UIBarButtonItem *)button
{
    self.firstDatePickerIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    self.secondDatePickerIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    self.thirdDatePickerIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
    self.fourthDatePickerIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];
    self.fifthDatePickerIndexPath = [NSIndexPath indexPathForRow:10 inSection:2];
    self.sixthDatePickerIndexPath = [NSIndexPath indexPathForRow:26 inSection:2];
    
    self.datePickerPossibleIndexPaths = @[self.firstDatePickerIndexPath,
                                          self.secondDatePickerIndexPath,
                                          self.thirdDatePickerIndexPath,
                                          self.sixthDatePickerIndexPath,
                                          self.fourthDatePickerIndexPath,
                                          self.fifthDatePickerIndexPath];
    
    [self setDate:[NSDate date] forIndexPath:self.firstDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.secondDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.thirdDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.fourthDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.fifthDatePickerIndexPath];
    [self setDate:[NSDate date] forIndexPath:self.sixthDatePickerIndexPath];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.dataSource[section];
    NSInteger numberOfRows = [super tableView:tableView numberOfRowsInSection:section] + [sectionArray count];
    return numberOfRows;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];;
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSIndexPath *adjustedIndexPath = [self adjustedIndexPathForDatasourceAccess:indexPath];
        if ([adjustedIndexPath compare:self.firstDatePickerIndexPath] == NSOrderedSame) {
            NSDate *firstDate = [self dateForIndexPath:self.firstDatePickerIndexPath];
            cell.textLabel.text = [NSDateFormatter localizedStringFromDate:firstDate
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterNoStyle];
        }
        else if ([adjustedIndexPath compare:self.secondDatePickerIndexPath] == NSOrderedSame) {
            NSDate *secondDate = [self dateForIndexPath:self.secondDatePickerIndexPath];
            cell.textLabel.text = [NSDateFormatter localizedStringFromDate:secondDate
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterNoStyle];
        }
        else if ([adjustedIndexPath compare:self.thirdDatePickerIndexPath] == NSOrderedSame) {
            NSDate *thirdDate = [self dateForIndexPath:self.thirdDatePickerIndexPath];
            cell.textLabel.text = [NSDateFormatter localizedStringFromDate:thirdDate
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterNoStyle];
        }
        else if ([adjustedIndexPath compare:self.fourthDatePickerIndexPath] == NSOrderedSame) {
            NSDate *fourthDate = [self dateForIndexPath:self.fourthDatePickerIndexPath];
            cell.textLabel.text = [NSDateFormatter localizedStringFromDate:fourthDate
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterNoStyle];
        }
        else if ([adjustedIndexPath compare:self.fifthDatePickerIndexPath] == NSOrderedSame) {
            NSDate *fifthDate = [self dateForIndexPath:self.fifthDatePickerIndexPath];
            cell.textLabel.text = [NSDateFormatter localizedStringFromDate:fifthDate
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterNoStyle];
        }
        else if ([adjustedIndexPath compare:self.sixthDatePickerIndexPath] == NSOrderedSame) {
            NSDate *sixthDate = [self dateForIndexPath:self.sixthDatePickerIndexPath];
            cell.textLabel.text = [NSDateFormatter localizedStringFromDate:sixthDate
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterNoStyle];
        }
        else {
            NSArray *sectionArray = self.dataSource[adjustedIndexPath.section];
            cell.textLabel.text = sectionArray[adjustedIndexPath.row];
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    if (rowHeight == 0) {
        rowHeight = self.tableView.rowHeight;
    }
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
