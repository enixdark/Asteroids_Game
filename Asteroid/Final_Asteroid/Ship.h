//
//  Ship.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AObject.h"
FOUNDATION_EXPORT CGFloat *const constants;
@interface Ship : AObject
{
    CCSpriteBatchNode* batch;
    CGPoint accuracy;
    BOOL hyper_thrust;
    NSMutableArray*listship;
    CCAnimate*animate;
}
//@property (readwrite,nonatomic) NSMutableArray * listship;
//@property (readwrite,nonatomic) BOOL hyper_thrust;
@property (readwrite,nonatomic) CGPoint accuracy;
+(id) ship;
+(NSMutableArray*)listship;
+(void)setListship:(NSMutableArray*)newValue;
-(id) initWithShipImage;
+(BOOL)hyper_thrust;
+(void)setHyper_thrust:(BOOL)newValue;
-(BOOL)isCollisions:(CGRect)rect;
-(void) Gothit;
//- (CGPoint)accuracy;
//
//- (void)setAccuracy:(CGPoint)newValue;

@end
