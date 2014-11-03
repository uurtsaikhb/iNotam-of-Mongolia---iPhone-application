//
//  MessageViewController.h
//  SidebarDemo
//
//  Created by Uurtsaikh Batbileg on 1/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController 

{
    
    UIWebView * webView;
    
    NSString * htmlString;
    
    
    
}


@property(strong, nonatomic) NSString * scope;
@property(strong, nonatomic) NSString * description;
@property(strong, nonatomic) NSString * notamNumber;

@end
