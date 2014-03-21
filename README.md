ALEInlineDatePickerViewController
=================================

View Controller to display a date picker inline in a tableview iOS7 style

  This view controller simplifies the presentation of a date picker inline in a tableview.
  The dates inserted by the user can be accessed with the corresponding date picker's indexPath.
  
Usage
=================================

Subclass to use (see the provided example).

Subclasses MUST do at least 2 things:

- provide an array of indexPaths from which the date picker can be displayed 	(datePickerPossibleIndexPaths)

		 - (void)viewDidLoad
		{
		    [super viewDidLoad];
			
		    //...
			
		    //tell the controller where the date picker can be shown from in the tableview
		    self.datePickerPossibleIndexPaths = @[[NSIndexPath indexPathForRow:2 inSection:0],
		                                          [NSIndexPath indexPathForRow:1 inSection:1]];
			
		    //...
		}

- call super in the tableview delegate & datasource before their implementation

		- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
		{
		//add this value to your own calculations
		    NSInteger numberOfRows = [super tableView:tableView numberOfRowsInSection:section];
		    //...
		    return numberOfRows;
		}
		
		// Customize the appearance of table view cells.
		- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
		{
		    static NSString *CellIdentifier = @"Cell";
		    
		    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];;
		    if (cell == nil) {
				//your implementation goes here
				
				//this utility method adjusts the index path for datasource access based on the presence of the date picker in the table
				//NSIndexPath *adjustedIndexPath = [self adjustedIndexPathForDatasourceAccess:indexPath];

		    }		
		    return cell;
		}
		
		- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
		{
		    CGFloat rowHeight = [super tableView:tableView heightForRowAtIndexPath:indexPath];
		    if (rowHeight == 0) {
				//your implementation goes here	
		    }
		    return rowHeight;
		}
		
		- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
		{
		    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
		    
		    //your implementation here
		}
