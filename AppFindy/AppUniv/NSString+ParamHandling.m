//
//  NSString+ParamHandling.m
//  AppUniv
//
//  Created by Jagadeesh Deivasigamani on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+ParamHandling.h"

@implementation NSString (NSStringAppUnivExtentions)

-(NSString*)encodeParameter
{
      
    return [[[[self stringByReplacingOccurrencesOfString:@"&" withString:@"%26"]componentsSeparatedByString:@" "] componentsJoinedByString:@"+"] stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
}

-(NSString*) processQuote
{
    
    return [self stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
}


@end
