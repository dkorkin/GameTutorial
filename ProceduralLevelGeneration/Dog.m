//
//  Dog.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Dog.h"

#import "HealthHolder.h"

#import "DistanceMeasure.h"

const CGFloat kDogMovementSpeed = 90.0f;

@interface Dog ()

@property(nonatomic, strong) DogRoute *route;

@end

@implementation Dog

@synthesize fullHealth = _fullHealth;
@synthesize currentHealth = _currentHealth;

+ (instancetype)dogToWorld:(SKNode *)world withPosition:(CGPoint)position forRoute:(DogRoute *)route {
    return [[self alloc] initToWorld:world withPosition:position forRoute:route];
}

- (instancetype)initToWorld:(SKNode *)world withPosition:(CGPoint)position forRoute:(DogRoute *)route {
    self = [super initWithSpriteType:SpriteTypeDog andTextureName:@"dog_1.png"];
    
    if(self) {
        _route = route;
        
        self.position = position;
        [self dogSettings];
        [world addChild:self];
    }
    
    return self;
}

#pragma mark - setup physic properties section

- (void)dogSettings {
    NSArray* dogTextures = @[[SKTexture textureWithImageNamed:@"dog_1.png"],
                             [SKTexture textureWithImageNamed:@"dog_2.png"]];

    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:dogTextures timePerFrame:0.4]]];
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.texture.size];
    self.physicsBody.categoryBitMask = CollisionTypeDog;
    self.physicsBody.collisionBitMask = CollisionTypeWall | CollisionTypePlayer;
    self.physicsBody.allowsRotation = NO;
    self.zPosition = 3;
    self.physicsBody.contactTestBitMask = CollisionTypePlayer | CollisionTypeFood;
    
    self.fullHealth = kDogFullHealth;
    self.currentHealth = self.fullHealth;
}

#pragma mark - behaviour
- (void)move {
    if(![self actionForKey:@"DogMoves"]) {
        if([_route checkForMoveAvailabilityFromPosition:self.position]  || ([self isLowhealthLevel])) {
            CGPoint newPosition = [_route movePointForDogPosition:self.position forState:[self isLowhealthLevel]];
            CGFloat duration = (fabs(newPosition.x - self.position.x) + fabs(newPosition.y - self.position.y))/kDogMovementSpeed;
            SKAction *moveAction = [SKAction moveTo:newPosition duration:duration];
            [self runAction:moveAction withKey:@"DogMoves"];
        }
    }
}

- (void)healthRegenation {
    if(self.currentHealth < self.fullHealth) {
        self.currentHealth++;
    }
}


#pragma mark - health rate
- (BOOL)isLowhealthLevel {
    if(self.currentHealth <= self.fullHealth / 3.0) {
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
    [self changeHealthStripeLengthForPartOfHealth:healthPart];
}

- (CGFloat)fullHealth {
    return _fullHealth;
}

- (void)setFullHealth:(CGFloat)fullHealth {
    _fullHealth = fullHealth;
}

@end
