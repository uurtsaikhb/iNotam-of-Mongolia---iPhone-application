

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "CSeriesViewController.h"
#import "ASeriesViewController.h"
#import "AboutViewController.h"
#import "ContactViewController.h"



@interface SidebarViewController ()

@end

@implementation SidebarViewController {
    NSArray *menuItems;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
//    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
//    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    
    
    menuItems = @[@"title", @"home", @"a-series", @"c-series", @"about", @"contact"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
//    cell.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    
    return cell;
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender

{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
    
    if ([segue.identifier isEqualToString:@"a-series"]) {
        
        ASeriesViewController *aSeriesController = (ASeriesViewController*)segue.destinationViewController;
        
    }
   
    if ([segue.identifier isEqualToString:@"c-series"]) {
        
        CSeriesViewController *cSeriesController = (CSeriesViewController*)segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:@"about_view"]) {
        
        AboutViewController *aboutController = (AboutViewController*)segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:@"contact"]) {
        
        ContactViewController *contactController = (ContactViewController*)segue.destinationViewController;
    }
    
}

@end
