//
//  Food.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Food.h"

#import "RandomGenerator.h"

@implementation Food

+ (instancetype)foodToWorld:(SKNode *)world {
    return [[self alloc] initFoodInWorld:world];
}

- (instancetype)initFoodInWorld:(SKNode *)world{
    FoodType foodType = [Food generateFoodType];
    self = [super initWithSpriteType:SpriteTypeKey andTextureName:[Food imageNameToFood:foodType]];
    if(self) {
        _foodType = foodType;
        [self foodSettings];
        [world addChild:self];
    }
    return self;
}


#pragma mark - setup physic properties section

- (void)foodSettings {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.texture.size.width, self.texture.size.height)];
    self.physicsBody.categoryBitMask = CollisionTypeFood;
    self.physicsBody.collisionBitMask = 0;
    self.zPosition = 2;
}


#pragma mark - behaviour

- (void)pickUpFood {
    SKAction *fadeAction = [SKAction fadeAlphaTo:0.0f duration:0.5f];
    SKAction *scaleAction = [SKAction scaleTo:0.0f duration:0.5f];
    SKAction *removeAction = [SKAction removeFromParent];
    SKAction *keyDisapearAnimation = [SKAction sequence:@[[SKAction group:@[ fadeAction, scaleAction]], removeAction]];
    
    [self runAction:keyDisapearAnimation];
}

+ (FoodType)generateFoodType {
    NSInteger type = randomNumberBetweenNumbers(1,3);
    if(type == 2) {
        return FoodTypeMouse;
    }
    return FoodTypeBone;
}

+ (NSString*)imageNameToFood:(FoodType)type {
    if(type == FoodTypeBone) {
        return @"bone.png";
    }
    return @"mouse.png";
}
@end
