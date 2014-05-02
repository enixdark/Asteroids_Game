//
//  Laser.m
//  test1
//
//  Created by Cqshinn on 3/13/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "Laser.h"
#import "Ship.h"
#import "GameLayer.h"

#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

int len = 0;

@implementation Laser
@synthesize ls;

+(id) laser{
    return [[self alloc] initwithLaser];
}

-(id) initwithLaser{
    if (self = [super init]) {
        //ls = [[NSMutableArray alloc] init];
        Ship*ship = [GameLayer sharedGameLayer].defaultShip;
        ls = list(ship.position, 175, 150, 10);
    }
    return self;
}

-(void)draw{
    Ship*ship = [GameLayer sharedGameLayer].defaultShip;
    ls = list(ship.position, 175, 150, 10);
    glLineWidth(4.0f);
    glEnable(GL_POINTS);
    ccDrawColor4F(12, 234, 23, 255);
    CGPoint poi[1000];
    int i = 0;
    if ([ls count] > 0) {
        for (POINT*p in ls) {
            poi[i++] = ccp(p.x,p.y);
            //ccDrawPoints(poi,1);
        }
        //ccDrawPoly(<#const CGPoint *vertices#>, <#NSUInteger numOfVertices#>, <#BOOL closePolygon#>)
    }
    ccDrawPoly(poi,i,NO);
    //len += 5;
    //ccDrawLine(ccp(ship.position.x  + len, ship.position.y + 3),ccp(ship.position.x + 400, ship.position.y + 3));
    //ccDrawLine(ccp(ship.position.x  + len, ship.position.y - 3),ccp(ship.position.x + 400, ship.position.y - 3));
}

NSMutableArray * list(CGPoint pos,int rotate_x,int rotate_y,int random_value){
    NSMutableArray*l = [[NSMutableArray alloc] init];
    Ship*ship = [GameLayer sharedGameLayer].defaultShip;
    CGSize screen = [CCDirector sharedDirector].winSize;
    float angle = 360 - ship.rotation;
    float m = CCRANDOM_0_1()*random_value;
    float n = CCRANDOM_0_1()*random_value;
    int range = ship.position.x > screen.width/2 ? ship.position.x : screen.width - ship.position.x;
    for(int i = 0 ; i < range ; i++){
        float x = cosf(degreesToRadians(angle-m))*i*atan(degreesToRadians(i-rotate_x)) + ship.position.x;
        float y = cosf(degreesToRadians(angle-n))*i*atan(degreesToRadians(i-rotate_y)) + ship.position.y;
        POINT*p = [[POINT alloc] init];
        p.x = x;
        p.y = y;
        [l addObject:p];
    }
    return l;
    //angle = my_ship.get_angle()
    //                      m = random.randrange(random_value)
    //                      n = random.randrange(random_value)
    //                      for i in range(my_ship.pos[0] if my_ship.pos[0]> WIDTH/2 else  WIDTH - my_ship.pos[0]):
    //                      x = math.cos(math.radians(angle-m))*i*math.atan(math.radians(i-rotate_x)) + pos[0]
    //                      y = math.sin(math.radians(angle-n))*i*math.atan(math.radians(i-rotate_y)) + pos[1]
    //                      l.append([x, y])
    //                      laser_list.append(l))
}

@end


@implementation POINT

@synthesize x,y;

-(id)init{
    if(self = [super init]){
        x = 0 ;
        y = 0 ;
    }
    return self;
}

@end