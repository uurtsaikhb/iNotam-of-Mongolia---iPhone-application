//
//  MessageViewController.m
//  SidebarDemo
//
//  Created by Uurtsaikh Batbileg on 1/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

@synthesize notamNumber, scope, description;


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
    
    htmlString = [NSString stringWithFormat:@"<html>"
                  "<body bgcolor=\"#dcdcdc\">"
                  "<div style=\"width: 304px; background-image: url(background.gif); background-repeat: repeat-y; margin-top: 20px;\">"
                  "<div><img src=\"top.gif\"></div>"
                  "<div>"
                  "<div style=\"padding: 0px 21px 0px 24px;\">"
                  "<div style=\"color: #0884C2; font-weight: bold; font-family: HelveticaNeue; text-align: right; font-size: 20px;\">%@</div>"
                  "<div style=\"color: #787878; font-weight: normal; font-size: 10px; font-family: HelveticaNeue; text-align: right; border-bottom: 1px solid #787878; padding: 1px 0px 4px 0px; margin-bottom: 11px;\">"
                  "<em>Scope: %@</em></div>"
                  "<div style=\"color: #939492; font-family: HelveticaNeue; text-align: left; font-size: 11px;\">%@</div>"
                  "</div>"
                  "</div>"
                  "<div><img src=\"bottom.gif\"></div>"
                  "</div>"
                  "</body>"
                  "</html>", notamNumber, scope, description];
    
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44)];
    
      
    NSURL * baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    [webView loadHTMLString:htmlString baseURL:baseUrl];
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    [self.view addSubview:webView];
    
    
    UIToolbar * toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.height, 44)];
    toolbar.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:toolbar];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
