//
//  RandomItem.m
//  test1
//
//  Created by Cqshinn on 3/8/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "RandomItem.h"
#import "GameLayer.h";
#import "Ship.h";
#import "Global.h";
#define ccitem 4;
#define nextitem 10.0f;


@implementation RandomItem

//@synthesize dict;

+(id) RandoItem{
    
    return [[self alloc] inititem];
}

-(id)inititem{
    if(self = [super init]){
        [self setNext: .0f];
        item = (int)CCRANDOM_0_1()*ccitem;
        self.visible = NO;
        self.rotation = 90;
        self.scale = .7f;
//        NSArray*image = {@"homing.png",@"bullet2.png",@"laser_item.png",@"tran_am.png"};
//        NSArray*key = {ROCKET,SHOT,LASER,TRANAM};
        [self setDict: [[NSDictionary alloc] init]];
        [self setDict: @{
                 @"homing.png" : [NSNumber numberWithInt:ROCKET],
                 @"bullet2.png" :[NSNumber numberWithInt:SHOT],
                 @"laser_item.png" :[NSNumber numberWithInt:LASER],
                 @"tran_am.png":[NSNumber numberWithInt:TRANAM]
                 }];
        [self setRandom];

        
    }
    return self;
}

-(void) update:(ccTime)delta{
    [self setNext:[self next]+delta];
    if ([self next] > 50.0f) {
        [self refreshtime];
        [self setRandom];
    }
    
    self.position = ccpAdd(self.position,self.velocity);
    if([self ColisionShip]){
        
        switch ([self item]) {
            case TRANAM:
                [Ship setHyper_thrust:YES];
                [Global setTran_am_energy:1.0f];
                break;
            case ROCKET:
                [Global setRocket_storage:[Global rocket_storage] + 4];
                break;
            case LASER:
                break;
            default:
                break;
        }
        self.visible = NO;
    }
    
}

-(void) setPosition:(CGPoint)pos
{
	CGSize screenSize = [CCDirector sharedDirector].winSize;
    if(pos.x > screenSize.width)
        pos.x = 0;
    if(pos.x < 0)
        pos.x = screenSize.width;
    if(pos.y > screenSize.height - 100)
        pos.y = 0;
    if(pos.y < 0)
        pos.y = screenSize.height -100;
	[super setPosition:pos];
}

-(void) refreshtime{
    
    [self setNext:.0f] ;
    self.visible = NO;
    [self unscheduleUpdate];
}
-(void) setRandom{
    CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"all.pvr.ccz"];
    [self setTexture:gameArtTexture];
    CGSize winsize = [CCDirector sharedDirector].winSize;
    self.visible = YES;
    float x = CCRANDOM_0_1()*ccitem;
    item = floor(x);
    CGPoint m = CGPointMake(CCRANDOM_0_1()*(CCRANDOM_0_1()>.5?1:-1),CCRANDOM_0_1()*(CCRANDOM_0_1()>.5?1:-1));

    [self setVelocity:CGPointMake(CCRANDOM_0_1()*2*m.x
                                  ,CCRANDOM_0_1()*2*m.y)];
    self.position = CGPointMake(winsize.width*CCRANDOM_0_1(),winsize.height*CCRANDOM_0_1());
    NSString*img = @"homing.png";
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    NSEnumerator*e = [[self dict] keyEnumerator];
    for (NSString*s in e) {
        NSNumber*i = [[self dict] valueForKey:s];
        if(i == [NSNumber numberWithInt:item]){
            img = s;
            break;
        }
    }
    CCSpriteFrame* frame = [frameCache spriteFrameByName:img];
    [self setDisplayFrame:frame];
    [self scheduleUpdate];
}



-(TYPEITEM) item{
    return item;
}

-(BOOL) ColisionShip{
    Ship*ship = [GameLayer sharedGameLayer].defaultShip;
    if([ship isCollisions:self.boundingBox] && self.visible){
        return YES;
    }
    return NO;
}
- (NSDictionary *)dict {
    return dict;
}

- (void)setDict:(NSDictionary *)newValue {
    [dict autorelease];
    dict = [newValue retain];
}

- (ccTime)next {
    return next;
}

- (void)setNext:(ccTime)newValue {
    next = newValue;
}

- (CGPoint)velocity {
    return velocity;
}

- (void)setVelocity:(CGPoint)newValue {
    velocity = newValue;
}

@end
