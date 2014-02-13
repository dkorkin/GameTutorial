//
//  Key.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Key.h"

@implementation Key

+ (instancetype)keyToWorld:(SKNode *)world atPosition:(CGPoint)position {
    return [[self alloc] initKeyInWorld:world atPosition:position];
}

- (instancetype)initKeyInWorld:(SKNode *)world atPosition:(CGPoint)position {
    self = [super initWithSpriteType:SpriteTypeKey andTextureName:@"key.png"];
    if(self) {
        self.position = position;
        [self keySettings];
        [world addChild:self];
    }
    return self;
}

#pragma mark - setup physic properties section

- (void)keySettings {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.texture.size.width - 16, self.texture.size.height - 16)];
    self.physicsBody.categoryBitMask = CollisionTypeKey;
    self.physicsBody.collisionBitMask = 0;
    self.zPosition = 3;
}

#pragma mark - behaviour

- (void)pickUpKey {
    SKAction *fadeAction = [SKAction fadeAlphaTo:0.0f duration:0.5f];
    SKAction *scaleAction = [SKAction scaleTo:0.0f duration:0.5f];
    SKAction *removeAction = [SKAction removeFromParent];
    SKAction *keyDisapearAnimation = [SKAction sequence:@[[SKAction group:@[ fadeAction, scaleAction]], removeAction]];
    
    [self runAction:keyDisapearAnimation];
}

@end
