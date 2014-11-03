//
//  CSeriesViewController.h
//  SidebarDemo
//
//  Created by Uurtsaikh Batbileg on 1/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSeriesViewController :  UIViewController <UITableViewDelegate, UITableViewDataSource,
                                    NSXMLParserDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

{
    
    IBOutlet UITableView * cTableView;
    
    IBOutlet UIBarButtonItem * barItem;
    
    IBOutlet UISearchBar * searchBar;
    
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (nonatomic, retain) IBOutlet UITableView * cTableView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem * barItem;

@property (nonatomic, retain) IBOutlet UISearchBar * searchBar;

@end
