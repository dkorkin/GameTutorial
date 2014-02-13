//
//  CatPlayer.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/29/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "CatPlayer.h"

#import "Player.h"
#import "PlayerShadow.h"

#import "HealthHolder.h"

static const CGFloat kPlayerMovementSpeed = 100.0f;

@interface CatPlayer ()

@property (nonatomic, strong) SKNode *world;

@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) PlayerShadow *playerShadow;


@end

@implementation CatPlayer

@synthesize fullHealth = _fullHealth;
@synthesize currentHealth = _currentHealth;

+ (instancetype)playerToWorld:(SKNode *)world atPosition:(CGPoint)position{
    return [[self alloc] initPlayerInWorld:world atPosition:position];
}

- (instancetype)initPlayerInWorld:(SKNode *)world atPosition:(CGPoint)position{
    self = [super init];
    if(self) {
        _position = position;
        _world = world;
        _keyCount = 0;
        
        self.fullHealth = kCatFullHealth;
        
        [self createShadow];
        [self createPlayer];
    }
    return self;
}

#pragma mark - cretion section

- (void)createPlayer {
    _player = [Player playerToWorld:_world atPosition:_position];
}

- (void)createShadow {
    CGPoint shadowPosition = CGPointMake(self.player.position.x, self.player.position.y - 7.0f);
    _playerShadow = [PlayerShadow playerShadowToWorld:_world atPosition:shadowPosition];
}


#pragma mark - behavior section

- (void)resolveAnimationWithID:(NSUInteger)animationID {
    [self.player resolveAnimationWithID:animationID];
}

- (void)moveActionWithVelocity:(CGPoint)velocity andTime:(CFTimeInterval)time {
    
    // Update player sprite position and orientation based on DPad input
    self.player.position = CGPointMake(self.player.position.x + velocity.x * time * kPlayerMovementSpeed,
                                       self.player.position.y + velocity.y * time * kPlayerMovementSpeed);
    
    if ( velocity.x != 0.0f ) {
        self.player.xScale = (velocity.x > 0.0f) ? -1.0f : 1.0f;
    }
    
    // Ensure correct animation is playing
    self.player.animationID = (velocity.x != 0.0f) ? 1 : 0;
    
    [self resolveAnimationWithID:self.player.animationID];
    
    // Move "camera" so the player is in the middle of the screen
    self.world.position = CGPointMake(-self.player.position.x + CGRectGetMidX([UIScreen mainScreen].bounds),
                                      -self.player.position.y + CGRectGetMidY([UIScreen mainScreen].bounds));

}

- (void)exitFromPoint:(CGPoint)exitPoint WithAction:(SKAction *)exitAnimationActions {
    // Remove shadow
    [self.playerShadow removeFromParent];
    [self.player runAction:exitAnimationActions];
}

- (void)didSimulatePhysics {
    self.player.zRotation = 0.0f;
    self.playerShadow.position = CGPointMake(self.player.position.x, self.player.position.y - 7.0f);
}


#pragma mark - animation helper

- (void)updateSpritePositionWithPlayerVelocity:(CGPoint)velocity andTime:(CFTimeInterval)time {
    self.player.position = CGPointMake(self.player.position.x + velocity.x * time * kPlayerMovementSpeed,
                                       self.player.position.y + velocity.y * time * kPlayerMovementSpeed);
    
    if (velocity.x != 0.0f) {
        self.player.xScale = (velocity.x > 0.0f) ? -1.0f : 1.0f;
    }
    
    // Ensure correct animation is playing
    self.player.animationID = (velocity.x != 0.0f) ? 1 : 0;
    [self.player resolveAnimationWithID:self.player.animationID];
}


#pragma mark - get position

-(CGPoint)position {
    return self.player.position;
}


#pragma mark - check attack availability

- (BOOL)checkAttackAvailabilityOfPoint:(CGPoint)coordinate {
    if(self.player.xScale > 0) {
        if(self.player.position.x - coordinate.x < -16) {
            return NO;
        }
        return YES;
    }
    else if(coordinate.x - self.player.position.x > 16) {
        return YES;
    }
    
    return NO;
}


#pragma mark - creature health protocol


- (void)takeDamage {
    self.currentHealth--;
}

- (CGFloat)currentHealth {
    return _currentHealth;
}

- (void)setCurrentHealth:(CGFloat)currentHealth {
    _currentHealth = currentHealth;
    CGFloat healthPart = self.currentHealth / self.fullHealth;
    [self.player changeHealthStripeLengthForPartOfHealth:healthPart];
}

- (CGFloat)fullHealth {
    return _fullHealth;
}

- (void)setFullHealth:(CGFloat)fullHealth {
    _fullHealth = fullHealth;
}

@end
