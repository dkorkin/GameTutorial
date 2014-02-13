//
//  Player.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Player.h"

@interface Player ()

@property (nonatomic, strong) SKTextureAtlas *spriteAtlas;

@end

@implementation Player


+ (instancetype)playerToWorld:(SKNode *)world atPosition:(CGPoint)position {
    return [[self alloc] initPlayerInWorld:world atPosition:position];
}

- (instancetype)initPlayerInWorld:(SKNode *)world atPosition:(CGPoint)position {
    self = [super initWithSpriteType:SpriteTypePlayer andTextureName:@"idle_0"];
    if(self) {
        self.position = position;
        [self setupSpriteSettings];
        [world addChild:self];
        [self setupAnimations];
    }
    return self;
}

- (void)setupSpriteSettings {
    self.physicsBody.allowsRotation = NO;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.texture.size];
    self.physicsBody.categoryBitMask = CollisionTypePlayer;
    self.physicsBody.contactTestBitMask = CollisionTypeExit | CollisionTypeKey | CollisionTypeFood;
    self.physicsBody.collisionBitMask = CollisionTypeWall | CollisionTypeDog;
    self.zPosition = 3;
}

#pragma mark - animation helper

- (void)setupAnimations {
    _animationID = 0;

    _idleAnimationFrames = @[[super textureNamed:@"idle_0"]];
    
    _walkAnimationFrames = @[[super textureNamed:@"walk_0"],
                             [super textureNamed:@"walk_1"],
                             [super textureNamed:@"walk_2"]];
}


- (void)resolveAnimationWithID:(NSUInteger)animationID {
    NSString *animationKey = nil;
    NSArray *animationFrames = nil;
    
    if(animationID == 0) {
        animationKey = @"anim_idle";
        animationFrames = self.idleAnimationFrames;
    }
    else {
        animationKey = @"anim_walk";
        animationFrames = self.walkAnimationFrames;
    }
    
    SKAction *animAction = [self actionForKey:animationKey];
    
    // If this animation is already running or there are no frames we exit
    if ( animAction || animationFrames.count < 1 ) {
        return;
    }
    
    animAction = [SKAction animateWithTextures:animationFrames timePerFrame:5.0f/60.0f resize:YES restore:NO];
    
    if ( animationID == 1 ) {
        animAction = [SKAction group:@[animAction, [SKAction playSoundFileNamed:@"step.wav" waitForCompletion:NO]]];
    }
    
    [self runAction:animAction withKey:animationKey];
}

@end
