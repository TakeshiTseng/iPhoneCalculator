//
//  MathUtil.h
//  Calculator
//
//  Created by Takeshi on 13/10/14.
//  Copyright (c) 2013年 Takeshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathUtil : NSObject{
	
}
+(BOOL)isNum:(NSString*) text;
+(BOOL)isRealNum:(NSString*) text;
+(BOOL)isNagtive:(NSString*) text;
@end
