
#import "FlightTool.h"

@implementation FlightTool

#pragma mark Hex Code to Color
+ (UIColor *) colorFromHexString:(NSString *)hex {
    
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+ (NSString *) htmlToContent:(NSString *)string
{
    NSString *css = @"<style>body {font-family:\"RobotoCondensed-Regular\"; font-size: 11; color:#666666;} img, iframe {max-width: 280px!important; width: auto!important; height: auto!important;}</style>";
    string = [NSString stringWithFormat:@"<html><head>%@</head><body><div align='justify'>%@<div></body></html>", css, string];
    return string;
}

+ (NSString *)getMonDate:(NSString *)day
{
    NSString *outDay;
    
    if ([day isEqualToString:@"Mon"])
        outDay = @"Дав";
    
    if ([day isEqualToString:@"Tue"])
        outDay = @"Мяг";
    
    if ([day isEqualToString:@"Wed"])
        outDay = @"Лха";
    
    if ([day isEqualToString:@"Thu"])
        outDay = @"Пүр";
    
    if ([day isEqualToString:@"Fri"])
        outDay = @"Баа";
    
    if ([day isEqualToString:@"Sat"])
        outDay = @"Бям";
    
    if ([day isEqualToString:@"Sun"])
        outDay = @"Ням";
    
    return outDay;
}

@end
