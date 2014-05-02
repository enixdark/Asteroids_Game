//
//  ExplosionCache.h
//  test1
//
//  Created by Cqshinn on 3/9/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AObject.h"
@interface ExplosionCache : AObject {
    NSMutableArray*listAction;
}

- (NSMutableArray *)listAction;

- (void)setListAction:(NSMutableArray *)newValue;

@end
