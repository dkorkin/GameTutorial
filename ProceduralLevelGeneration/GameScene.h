//
//  MyScene.h
//  ProceduralLevelGeneration
//
//  Created by Kim Pedersen on 09/08/13.
//  Copyright (c) 2013 Kim Pedersen. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>


typedef NS_ENUM(uint32_t, CollisionType) {
    CollisionTypePlayer = 0x1 << 0,
    CollisionTypeWall = 0x1 << 1,
    CollisionTypeExit = 0x1 << 2,
    CollisionTypeKey = 0x1 << 3,
    CollisionTypeDog = 0x1 << 4,
    CollisionTypeFood = 0x1 << 5,
};


@interface GameScene : SKScene

@end
