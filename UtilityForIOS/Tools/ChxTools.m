//
//  Utility.m
//  UtilityForIOS
//
//  Created by 程红秀 on 2015-3-26.
//  Copyright (c) 2015年 chx20. All rights reserved.
//

#import "ChxTools.h"


@implementation ChxTools

//NSCachesDirectory: location of discardable cache files (Library/Caches)
+(NSString *)applicationCachesDirectory {
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return cachesDirectory;
}


//NSDocumentDirectory: documents (Documents)
+(NSString *)applicationDocumentsDirectory {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return documentDirectory;
}


+(NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:fileName];    
    return path;
}

+(NSString *)getCurrentDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

@end
