//
//  Utility.h
//  UtilityForIOS
//
//  Created by 程红秀 on 2015-3-26.
//  Copyright (c) 2015年 chx20. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChxTools : NSObject

+(NSString *)applicationCachesDirectory;
+(NSString *)applicationDocumentsDirectory;
+(NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName;

+(NSString *)getCurrentDate;

@end
