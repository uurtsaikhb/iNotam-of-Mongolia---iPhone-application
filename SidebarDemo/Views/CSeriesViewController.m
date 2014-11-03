//
//  CSeriesViewController.m
//  SidebarDemo
//
//  Created by Uurtsaikh Batbileg on 1/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "CSeriesViewController.h"
#import "SWRevealViewController.h"
#import "NotamCell.h"
#import "MessageViewController.h"

@interface CSeriesViewController ()

{

    UISearchDisplayController *searchDisplayController;
    
    
    NSXMLParser * parser;
    NSMutableArray * notams;
    NSMutableArray * notamsConst;
    
    NSMutableDictionary * item;
    
    NSMutableString * title;
    NSMutableString * scope;
    NSMutableString * description;
    NSMutableString * eitem;
    NSMutableString * aitem;
    
    NSString * element;
    
    NSMutableArray * searchData;
    
}

@end

@implementation CSeriesViewController

@synthesize cTableView, barItem, searchBar;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search by Location indicator";
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsTableView.delegate = self;
    self.cTableView.tableHeaderView = searchBar;
    searchData = [[NSMutableArray alloc] init];

    
    
    notams = [[NSMutableArray alloc] init];
    notamsConst = [[NSMutableArray alloc] init];
    
    NSURL * url = [NSURL URLWithString:@"https://ais.mn/iproduct/inotam-c.php"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    
    UIRefreshControl *refreshControl=[[UIRefreshControl alloc] init];
    [self.cTableView addSubview:refreshControl];
    [refreshControl setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin)];
    [refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    refreshControl.backgroundColor = [UIColor whiteColor];
    [[refreshControl.subviews objectAtIndex:0] setFrame:CGRectMake(self.view.frame.size.width / 4 , 10, 20, 20)];
    
    
    [self getCurrentTime];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return notams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    NotamCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[NotamCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                reuseIdentifier:simpleTableIdentifier] ;
    }
    
    
    if ([@"aerodrome      \n" isEqualToString:[[notams objectAtIndex:indexPath.row] objectForKey:@"scope"]]) {
        cell.logo.textColor = [FlightTool colorFromHexString:@"E37E0B"];
        cell.logo.text = @"A";
    } else if ([@"enroute      \n" isEqualToString:[[notams objectAtIndex:indexPath.row] objectForKey:@"scope"]]) {
        cell.logo.textColor = [FlightTool colorFromHexString:@"0A74D1"];
        cell.logo.text = @"E";
    } else if ([@"warning      \n" isEqualToString:[[notams objectAtIndex:indexPath.row] objectForKey:@"scope"]]) {
        cell.logo.textColor = [FlightTool colorFromHexString:@"F5072F"];
        cell.logo.text = @"W";
    } else if ([@"ae      \n" isEqualToString:[[notams objectAtIndex:indexPath.row] objectForKey:@"scope"]]) {
        cell.logo.textColor = [FlightTool colorFromHexString:@"0F8A17"];
        cell.logo.text = @"AE";
    }
    
    
    cell.title.text = [[notams objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.aitem.text = [[notams objectAtIndex:indexPath.row] objectForKey:@"aitem"];
    cell.scope.text = [[notams objectAtIndex:indexPath.row] objectForKey:@"scope"];
    cell.eitem.text = [[notams objectAtIndex:indexPath.row] objectForKey:@"eitem"];
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MessageViewController * messageController = [[MessageViewController alloc] init];
    
    messageController.notamNumber = [[notams objectAtIndex:indexPath.row] objectForKey:@"title"];
    messageController.scope = [[notams objectAtIndex:indexPath.row] objectForKey:@"scope"];
    messageController.description = [[notams objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    [self.navigationController pushViewController:messageController animated:YES];
    
    
}



// xml parsing

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item            = [[NSMutableDictionary alloc] init];
        title           = [[NSMutableString alloc] init];
        eitem           = [[NSMutableString alloc] init];
        aitem           = [[NSMutableString alloc] init];
        scope           = [[NSMutableString alloc] init];
        description     = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:eitem forKey:@"eitem"];
        [item setObject:aitem forKey:@"aitem"];
        [item setObject:scope forKey:@"scope"];
        [item setObject:description forKey:@"description"];
        
        [notams addObject:[item copy]];
        [notamsConst addObject:[item copy]];
        
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"eitem"]) {
        [eitem appendString:string];
    } else if ([element isEqualToString:@"aitem"]) {
        [aitem appendString:string];
    } else if ([element isEqualToString:@"scope"]) {
        [scope appendString:string];
    } else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
    }
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.cTableView reloadData];
    [self getCurrentTime];
    
}



// refreshing

- (void) refreshTableView:(UIRefreshControl * ) refreshControl

{
    
    double delayInSeconds = 0.6;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^(void){[refreshControl endRefreshing];});
    
    notams = [[NSMutableArray alloc] init];
    notamsConst = [[NSMutableArray alloc] init];
    NSURL * url = [NSURL URLWithString:@"https://ais.mn/iproduct/inotam-c.php"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    
}

// setup current time

-(void)getCurrentTime {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm   "];
    
    NSString * time = [formatter stringFromDate:[NSDate date]];
    
    NSString *date = [NSString stringWithFormat:@"Last update: %@", time];
    
    barItem.title = date;
    
}


// Searching

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar

{

    [notams removeAllObjects];
    [notams setArray:notamsConst];
    [cTableView reloadData];
    
}

- (void) searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView

{

    [tableView setRowHeight:[[self cTableView] rowHeight ]];
    
    [tableView reloadData];
    
}





- (BOOL) searchDisplayController:(UISearchDisplayController *)controller
    shouldReloadTableForSearchString:(NSString *)searchString
{
    
    
    if ([searchString length] == 0) {
        
        [notams removeAllObjects];
        [notams setArray:notamsConst];

    } else {
        
        [notams removeAllObjects];
        
        NSMutableDictionary * tempArr;
        
        for (tempArr in notamsConst) {
            
            NSString * tempValue = [tempArr objectForKey:@"aitem"];
            
            NSRange range = [tempValue rangeOfString:searchString options:NSCaseInsensitiveSearch];
            
            if (range.location != NSNotFound ) {
                
                [notams addObject:tempArr];
                
                NSLog(@"%@", tempArr);
            }
            
        }
        
    }
    
    [cTableView reloadData];
    
    return YES;
    
}




@end
