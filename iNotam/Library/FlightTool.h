

#import <Foundation/Foundation.h>

@interface FlightTool : NSObject

+ (UIColor *) colorFromHexString:(NSString *)hex;
+ (NSString *) htmlToContent:(NSString *)string;
+ (NSString *) getMonDate:(NSString *)day;
@end
