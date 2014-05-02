//
//  LightingCache.m
//  test1
//
//  Created by Cqshinn on 3/7/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "LightingCache.h"
#import "Lightning.h"

@implementation LightingCache

+(id) Lighting{
    return [[self alloc] init];
}

- (id)init{
//    if( (self=[super init])) {
//        
////        		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Lightening Demo" fontName:@"Marker Felt" fontSize:32];
////        		label.position =  ccp(240, 300);
////        		[self addChild: label];
//		
//		Lightning *l = [Lightning lightningWithStrikePoint:ccp(0,0)
//											  strikePoint2:ccp(200, 20) ];
//        l.anchorPoint = ccp(0,0);
//		[self addChild:l z:10 tag:999];
//		[self schedule:@selector(strikeLight) interval:2.0f];
//	}
	return self;
}
-(void) strikeLight
{
	Lightning *l = (Lightning *)[self getChildByTag:999];
	CGSize screen = [[CCDirector sharedDirector] winSize];
	//random position
//	l.strikePoint = ccp(200,screen.height - 100);
//	l.strikePoint2 = ccp(100 ,100 );
//	l.strikePoint3 = ccp(100 ,200);    
//	l.color = ccc3(CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255);
//	
//	l.displacement = 250 + CCRANDOM_0_1() * 100;
//	l.minDisplacement = 3 + CCRANDOM_0_1() * 10;
//	l.lighteningWidth = 1.0f;
//	l.split = YES;
//	l.opacity =0;
//	[l strikeRandom];
}

//-(void)draw{
//    Lightning *l = (Lightning *)[self getChildByTag:999];
//    [l draw];
//    [super draw];
//}

- (void) dealloc
{
	[super dealloc];
}

- (CCSpriteBatchNode *)batch {
    return batch;
}

- (void)setBatch:(CCSpriteBatchNode *)newValue {
    [batch autorelease];
    batch = [newValue retain];
}

@end
