//
//  Exit.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Exit.h"

@interface Exit ()

//@property (nonatomic, strong) SKTextureAtlas *spriteAtlas;

@end

@implementation Exit

+ (instancetype)exitToWorld:(SKNode *)world atPosition:(CGPoint)position{
    return [[self alloc] initExitInWorld:world atPosition:position];
}

- (instancetype)initExitInWorld:(SKNode *)world atPosition:(CGPoint)position {
    self = [super initWithSpriteType:SpriteTypeExit andTextureName:@"exit.png"];
    if(self) {
        self.position = position;
        [self exitSettings];
        [world addChild:self];
    }
    return self;
}

#pragma mark - setup physic properties section

- (void)exitSettings {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.texture.size.width - 16, self.texture.size.height - 16)];
    self.physicsBody.categoryBitMask = CollisionTypeExit;
    self.physicsBody.collisionBitMask = 0;
    self.zPosition = 3;
}


@end
