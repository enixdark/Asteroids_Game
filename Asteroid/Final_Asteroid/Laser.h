//
//  Laser.h
//  test1
//
//  Created by Cqshinn on 3/13/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

NSMutableArray * list(CGPoint pos,int rotate_x,int rotate_y,int random_value);
//                      def laser(pos,rotate_x,rotate_y,random_value):
//                      l = []
//                      angle = my_ship.get_angle()
//                      m = random.randrange(random_value)
//                      n = random.randrange(random_value)
//                      for i in range(my_ship.pos[0] if my_ship.pos[0]> WIDTH/2 else  WIDTH - my_ship.pos[0]):
//                      x = math.cos(math.radians(angle-m))*i*math.atan(math.radians(i-rotate_x)) + pos[0]
//                      y = math.sin(math.radians(angle-n))*i*math.atan(math.radians(i-rotate_y)) + pos[1]
//                      l.append([x, y])
//                      laser_list.append(l))

@interface POINT : NSObject {
    float x;
    float y;
}
@property float x;
@property float y;

@end

@interface Laser : CCNode {
    NSMutableArray*ls;
}
@property NSMutableArray*ls;
+(id) laser;
@end
