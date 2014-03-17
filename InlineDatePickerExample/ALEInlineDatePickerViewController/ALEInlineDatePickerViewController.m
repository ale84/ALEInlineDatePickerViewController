//  Created by Alessio on 25/02/14.
//  Copyright (c) 2014 Alessio Orlando. All rights reserved.

#import "ALEInlineDatePickerViewController.h"

@implementation ALEDatePickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.datePicker = [[UIDatePicker alloc]init];
        self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.datePicker];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_datePicker]|"
                                                                    options:0
                                                                     metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(_datePicker)]];
    }
    return self;
}

@end

@interface ALEInlineDatePickerViewController ()
@property (nonatomic, strong, readwrite) NSIndexPath *datePickerIndexPath;
@property (nonatomic, assign) CGFloat pickerCellRowHeight;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, strong) NSMutableDictionary *dates;   //key is NSIndexPath, value is NSDate

- (void)hideCurrentPicker;
- (NSIndexPath *)calculateIndexPathForPicker:(NSIndexPath *)selectedIndexPath;
- (void)showPickerAtIndex:(NSIndexPath *)indexPath;
- (NSString *)stringFromIndexPath:(NSIndexPath *)indexPath;

@end

static NSString *DateCellIdentifier = @"DateCell";

@implementation ALEInlineDatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.tableViewStyle = style;
    }
    return self;
}

- (void)loadView
{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:self.tableViewStyle];
    self.view = self.tableView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[ALEDatePickerCell class] forCellReuseIdentifier:DateCellIdentifier];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    self.pickerCellRowHeight = datePicker.frame.size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - getter/setters

- (NSMutableDictionary *)dates
{
    if (!_dates) {
        _dates = [[NSMutableDictionary alloc]init];
    }
    return _dates;
}

- (void)setDatePickerPossibleIndexPaths:(NSArray *)datePickerPossibleIndexPaths
{
    if (_datePickerPossibleIndexPaths != datePickerPossibleIndexPaths) {
        _datePickerPossibleIndexPaths = datePickerPossibleIndexPaths;
    }
    
    _dates = nil;
    _datePickerIndexPath = nil;
}

#pragma mark - date picker

- (void)dateChanged:(UIDatePicker *)sender
{
    NSIndexPath *keyIndexPath = [NSIndexPath indexPathForRow:self.datePickerIndexPath.row -1 inSection:self.datePickerIndexPath.section];
    [self setDate:sender.date forIndexPath:keyIndexPath];
    
    [self.tableView reloadData];
}

- (BOOL)datePickerIsShown
{
    return self.datePickerIndexPath != nil;
}

- (ALEDatePickerCell *)createPickerCell:(NSDate *)date
{
    
    ALEDatePickerCell *cell = [self.tableView dequeueReusableCellWithIdentifier:DateCellIdentifier];
    
    cell.datePicker.datePickerMode = UIDatePickerModeDate;
    
    if (!date) {
        date = [NSDate date];
    }
    
    [cell.datePicker setDate:date animated:NO];
    
    [cell.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

- (void)hideCurrentPicker {
    
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:self.datePickerIndexPath.section]]
                          withRowAnimation:UITableViewRowAnimationFade];
    
    self.datePickerIndexPath = nil;
}

- (NSIndexPath *)calculateIndexPathForPicker:(NSIndexPath *)selectedIndexPath
{
    
    NSIndexPath *newIndexPath;
    
    if (([self datePickerIsShown]) && (self.datePickerIndexPath.row < selectedIndexPath.row)){
        
        newIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row - 1 inSection:selectedIndexPath.section];
        
    }else {
        
        newIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row  inSection:selectedIndexPath.section];
        
    }
    
    return newIndexPath;
}

- (void)showPickerAtIndex:(NSIndexPath *)indexPath {
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationFade];
}

- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath
{
    NSDate *date = [self.dates objectForKey:[self stringFromIndexPath:indexPath]];
    return date;
}

- (void)setDate:(NSDate *)date forIndexPath:(NSIndexPath *)indexPath
{
    [self.dates setObject:date forKey:[self stringFromIndexPath:indexPath]];
}

#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
//    for (NSIndexPath *indexPath in self.datePickerPossibleIndexPaths) {
        if (self.datePickerIndexPath.section == section) {
            [self datePickerIsShown] ? (numberOfRows = 1) :  (numberOfRows = 0);
//            break;
        }
  //  }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALEDatePickerCell *cell = nil;

    if ([self datePickerIsShown] && ([self.datePickerIndexPath compare:indexPath] == NSOrderedSame)) {
        
        NSIndexPath *keyIndexPath = [NSIndexPath indexPathForRow:indexPath.row -1 inSection:indexPath.section];
        NSDate *date = [self dateForIndexPath:keyIndexPath];
        cell = [self createPickerCell:date];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 0;

    if ([self datePickerIsShown] && ([self.datePickerIndexPath compare:indexPath] == NSOrderedSame)){
        rowHeight = self.pickerCellRowHeight;
    }
    
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSIndexPath *possibleIndexPath in self.datePickerPossibleIndexPaths) {
        if ([self datePickerIsShown]) {
            if (possibleIndexPath.section == indexPath.section && (indexPath.row == possibleIndexPath.row || indexPath.row == possibleIndexPath.row +1) ) {
                [self.tableView beginUpdates];
                
                [self hideCurrentPicker];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                
                [self.tableView endUpdates];
                
                break;
            }
        }
        else if ([possibleIndexPath compare:indexPath] == NSOrderedSame) {
            [tableView beginUpdates];
            
            NSIndexPath *newPickerIndexPath = [self calculateIndexPathForPicker:indexPath];
            
            if ([self datePickerIsShown]){
                
                [self hideCurrentPicker];
                
            }
            
            [self.view endEditing:YES];
            [self showPickerAtIndex:newPickerIndexPath];
            
            self.datePickerIndexPath = [NSIndexPath indexPathForRow:newPickerIndexPath.row + 1 inSection:newPickerIndexPath.section];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            [tableView endUpdates];
            break;
        }
    }
}

#pragma mark - utils

- (NSIndexPath *)adjustedIndexPathForDatasourceAccess:(NSIndexPath *)indexPath
{
    NSIndexPath *keyIndexPath = indexPath;
    if ([self datePickerIsShown] &&
        (indexPath.section == self.datePickerIndexPath.section) &&
        (indexPath.row > self.datePickerIndexPath.row)) {
        keyIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
    }
    return keyIndexPath;
}

- (NSString *)stringFromIndexPath:(NSIndexPath *)indexPath
{
    NSString *iPathString = [NSString stringWithFormat:@"%li-%li", (long)indexPath.section, (long)indexPath.row];
    return iPathString;
}

@end
