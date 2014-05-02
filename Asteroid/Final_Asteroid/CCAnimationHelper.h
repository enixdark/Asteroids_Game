//
//  CCAnimationHelper.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCAnimation (Helper)
+(CCSpriteFrame*) ImagewithFile:(NSString*)filename;
+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay;
+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount delay:(float)delay;

@end
