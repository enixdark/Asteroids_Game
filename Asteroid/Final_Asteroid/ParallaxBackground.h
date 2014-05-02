//
//  ParallaxBackground.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxBackground : CCNode 
{
	CCSpriteBatchNode* spriteBatch;
	int numStripes;

	NSMutableArray* speedFactors;
	float scrollSpeed;
}

@end
