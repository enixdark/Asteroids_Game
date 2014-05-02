//
//  LightingCache.h
//  test1
//
//  Created by Cqshinn on 3/7/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LightingCache : CCNode {
    CCSpriteBatchNode*batch;
}
+(id) Lighting;
- (CCSpriteBatchNode *)batch;

- (void)setBatch:(CCSpriteBatchNode *)newValue;

@end
