//
//  AObject.m
//  test1
//
//  Created by Cqshinn on 3/4/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "AObject.h"


@implementation AObject

@synthesize velocity,next,nextframe,live;

//- (ccTime) next{
//    return next;
//}
//-(void) setNext:(ccTime)newVal{
//    next = newVal;
//}
//- (float)radius{
//    return radius;
//}
//
//- (void)setRadius:(float)newVal{
//    radius = newVal;
//}
//
//- (CGPoint)velocity {
//    return velocity;
//}
//
//- (void)setVelocity:(CGPoint)newValue {
//    velocity = newValue;
//}
//
//- (BOOL)live {
//    return live;
//}
//
//- (void)setLive:(BOOL)newValue {
//    live = newValue;
//}
//
//-(int) nextframe{
//    return nextframe;
//}
//
//-(void) setNextframe:(int) newValue{
//    nextframe = newValue;
//}

-(BOOL) isColisions:(CGRect) pos{
    BOOL colision = NO;
    CGPoint p = pos.origin;
    CGPoint mainpos = self.position;
    float vt = (pos.size.width*0.7f + self.boundingBox.size.width*.7f)/2;
    float t = ccpDistance(p,mainpos);
    if(ccpDistance(p,mainpos) <= vt && self.visible && self.live){
            colision = YES;
    }
    return colision;
}
@end
