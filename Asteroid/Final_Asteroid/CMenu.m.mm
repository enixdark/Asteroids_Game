//
//  CMenu.m
//  test1
//
//  Created by Cqshinn on 3/8/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "CMenu.h"
#import <OpenGLES/ES3/gl.h>
#import "GameLayer.h"
#import "AppDelegate.h"
#define rocket_storage_max 10
#define thunder_energy_max 1.0f
#define tran_am_energy_max 1.0f
#define level_shot_max 3
#define life_max 5
#define TAG_SCORE 1111

int rocket_storage;
float thunder_energy;
int life;
int level_shot;
float tran_am_energy;
GAMESTATE state;
float score;
@implementation CMenu


+(id) Menu{
    return [[[self alloc] init] autorelease];
}

-(id)init{
    if (self = [super init]) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Live" fontName:@"Marker Felt" fontSize:20 ];
        CCLabelTTF *rocket = [CCLabelTTF labelWithString:@"Rocket" fontName:@"Marker Felt" fontSize:15 ];
        CCLabelTTF *lighting = [CCLabelTTF labelWithString:@"Lighting" fontName:@"Marker Felt" fontSize:15 ];
        CCLabelTTF *tran_am = [CCLabelTTF labelWithString:@"Energy" fontName:@"Marker Felt" fontSize:15 ];
        CCLabelTTF *score_label= [CCLabelTTF labelWithString:@"Score" fontName:@"Marker Felt" fontSize:15 ];
        CCLabelTTF *score_point = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:7.5f ];
        rocket_storage = [Global rocket_storage];
        thunder_energy = [Global thunder_energy];
        life = [Global life];
        state = [Global state];
        score = [Global score];
        level_shot = [Global level_shot];
        listlife = [[NSMutableArray alloc] init];
        listrocket = [[NSMutableArray alloc] init];
        label.anchorPoint = ccp(0, 0);
        label.position =  ccp( 25 , size.height - 95);
        ccColor3B color;
        color.b = 123;
        color.g = 123;
        color.r = 123;
        label.color = color;
        label.rotation = 270;
		// add the label as a child to this Layer
		[self addChild:label];
        
        for(int i = 0 ; i < life_max ; i++){
            CCSprite*s = [[CCSprite alloc] initWithSpriteFrameName:@"Ship1.png"];
            s.rotation = 180;
            s.tag = i ;
            s.scale = .6f;
            s.position = ccp(40,size.height - 85 + i*25);
            s.visible = i < life ? YES : NO;
            [listlife addObject:s];
            [self addChild:s];
        }
        
        rocket.anchorPoint = ccp(0, 0);
        rocket.color = color;
        rocket.rotation = 270;
        rocket.position = ccp(70,size.height - 95 );
		// add the label as a child to this Layer
		[self addChild:rocket];
        
        for(int i = 0 ; i < rocket_storage_max ; i++){
            CCSprite*s = [[CCSprite alloc] initWithSpriteFrameName:@"shot3.png"];
            s.rotation = 180;
            s.tag = 10+i ;
            s.visible = NO;
            //s.scale = .6f;
            s.position = ccp(80,size.height - 90 + i*5);
            [listrocket addObject:s];
            [self addChild:s];
        }
        
        lighting.anchorPoint = ccp(0, 0);
        lighting.color = color;
        lighting.rotation = 270;
        lighting.position = ccp(110,size.height - 95 );
		// add the label as a child to this Layer
		[self addChild:lighting];
        
        CCSprite*s = [[CCSprite alloc] initWithSpriteFrameName:@"energythunder2.png"];
        s.rotation = 90;
        s.tag = 100 ;
        //s.scale = .6f;
        
        s.position = ccp(120,size.height - 55);
        [self addChild:s];
        
        CCSprite*l = [[CCSprite alloc] initWithSpriteFrameName:@"energytranam copy.png"];
        l.rotation = 90;
        l.tag = 101 ;
        //s.scale = .6f
        l.scaleX = thunder_energy;
        //l.scaleX = .8f; down .1 ~ 5ppi
        l.position = ccp(120,size.height - 55);
        [self addChild:l];
        
        tran_am.anchorPoint = ccp(0, 0);
        tran_am.color = color;
        tran_am.rotation = 270;
        tran_am.position = ccp(145,size.height - 95 );
		// add the label as a child to this Layer
		[self addChild:tran_am];
        
        CCSprite*t1 = [[CCSprite alloc] initWithSpriteFrameName:@"energythunder2.png"];
        t1.rotation = 90;
        t1.tag = 102 ;
        t1.position = ccp(155,size.height - 55);
        [self addChild:t1];
        
        CCSprite*t2 = [[CCSprite alloc] initWithSpriteFrameName:@"energytranam.png"];
        t2.rotation = 90;
        t2.tag = 103 ;
        t2.scaleX = tran_am_energy;
        t2.position = ccp(155,size.height - 55);
        [self addChild:t2];
        
        score_label.anchorPoint = ccp(0, 0);
        score_label.color = color;
        score_label.rotation = 270;
        score_label.position = ccp(195,size.height - 70 );
		// add the label as a child to this Layer
		[self addChild:score_label];
        
        score_point.anchorPoint = ccp(0, 0);
        score_point.color = color;
        score_point.rotation = 270;
        score_point.position = ccp(205,size.height - 70 );
		// add the label as a child to this Layer
		[self addChild:score_point z:1 tag:TAG_SCORE];
        [self scheduleUpdate];
        
    }
    return self;
}

-(void)draw{
    [super draw];
    //glClearColor(144, 122, 234,234);
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint p1 = ccp(0,screenSize.height);
    CGPoint p2 = ccp(screenSize.width,screenSize.height - 100);
    
    ccColor4F color;
    color.a = 1.0;
    color.r = 0;
    color.g = 0;
    color.b = 0;
    ccDrawSolidRect(p1,p2, color);
    ccDrawRect(p1,p2);
    
    ccDrawColor4B(0,0,0,0);
    ccDrawRect(p1,p2);
    //ccColor4F c = ccc4f(123,123,123,123);
//    ccDrawColor4B(123,123,123,255);
//    ccColor4F c = ccc4f(0,0,123, 255);
//    ccDrawSolidRect(ccp(0,100),ccp(100,0),c);
//    ccDrawRect(ccp(0,100),ccp(100,0));
}

-(void) update:(ccTime)delta{
    if(life!=[Global life]){
        int i = 0;
        for (CCSprite*s in listlife.objectEnumerator) {
            s.visible = i < [Global life] ? YES : NO;
            i++;
        }
        life = [Global life];
        if(life < 0){
            [Global setState:GAMEOVER];
        }
    }
    if(score != [Global score]){
        score++;
        CCLabelTTF*l = (CCLabelTTF*)[self getChildByTag:TAG_SCORE];
        [l setString:[NSString stringWithFormat:@"%f",score]];
    }
//    if (thunder_energy!=[Global thunder_energy]) {
//        
//    }
    if (tran_am_energy!=[Global tran_am_energy]) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        tran_am_energy = [Global tran_am_energy];
        [self getChildByTag:103].scaleX = tran_am_energy;
        [self getChildByTag:103].position = ccp(155,screenSize.height - 95 + 41*tran_am_energy );
    }
    if (rocket_storage!=[Global rocket_storage]) {
        int i = 0;
        for (CCSprite*s in listrocket.objectEnumerator) {
            s.visible = i < [Global rocket_storage] ? YES : NO;
            i++;
        }
        rocket_storage = [Global rocket_storage];
    }
}



- (NSMutableArray *)listrocket {
    return listrocket;
}

- (void)setListrocket:(NSMutableArray *)newValue {
    [listrocket autorelease];
    listrocket = [newValue retain];
}

- (NSMutableArray *)listlife {
    return listlife;
}

- (void)setListlife:(NSMutableArray *)newValue {
    [listlife autorelease];
    listlife = [newValue retain];
}

- (CCSprite *)thunder {
    return thunder;
}

- (void)setThunder:(CCSprite *)newValue {
    [thunder autorelease];
    thunder = [newValue retain];
}

- (CCSprite *)tran_am {
    return tran_am;
}

- (void)setTran_am:(CCSprite *)newValue {
    [tran_am autorelease];
    tran_am = [newValue retain];
}

@end
