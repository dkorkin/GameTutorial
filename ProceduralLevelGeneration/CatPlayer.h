//
//  CatPlayer.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/29/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "GameScene.h"

#import "CreatureHealth.h"

@interface CatPlayer : NSObject <CreatureHealth>

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) NSInteger keyCount;

+ (instancetype)playerToWorld:(SKNode *)world atPosition:(CGPoint)position;

- (void)didSimulatePhysics;
- (void)moveActionWithVelocity:(CGPoint)velocity andTime:(CFTimeInterval)time;
- (void)exitFromPoint:(CGPoint)exitPoint WithAction:(SKAction *)exitAnimationActions;
- (void)resolveAnimationWithID:(NSUInteger)animationID;
- (void)updateSpritePositionWithPlayerVelocity:(CGPoint)velocity andTime:(CFTimeInterval)time;

- (void)takeDamage;
- (BOOL)checkAttackAvailabilityOfPoint:(CGPoint)coordinate;

@end
