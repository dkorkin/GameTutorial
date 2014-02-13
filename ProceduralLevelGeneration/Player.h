//
//  Player.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "CreatureObject.h"

@interface Player : CreatureObject

@property (nonatomic, assign) NSUInteger animationID;

@property (nonatomic, strong) NSArray *idleAnimationFrames;
@property (nonatomic, strong) NSArray *walkAnimationFrames;

+ (instancetype)playerToWorld:(SKNode *)world atPosition:(CGPoint)position;

- (void)resolveAnimationWithID:(NSUInteger)animationID;

@end
