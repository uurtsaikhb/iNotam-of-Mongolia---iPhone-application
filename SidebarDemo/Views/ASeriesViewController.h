//
//  ASeriesViewController.h
//  SidebarDemo
//
//  Created by Uurtsaikh Batbileg on 1/3/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASeriesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

{
    
    IBOutlet UITableView * aTableView;
    
    IBOutlet UIBarButtonItem * barItem;
    
    IBOutlet UISearchBar * searchBar;
    
}

@property (nonatomic, retain) IBOutlet UITableView * aTableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (nonatomic, retain) IBOutlet UIBarButtonItem * barItem;

@property (nonatomic, retain) IBOutlet UISearchBar * searchBar;



@end
