//
//  CreatureObject.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/3/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "CreatureObject.h"

@interface CreatureObject ()

@property (nonatomic, strong) SKSpriteNode *healthStripe;

@end

@implementation CreatureObject

- (instancetype)initWithSpriteType:(SpriteType)type andTextureName:(NSString *)textureName {
    self = [super initWithSpriteType:type andTextureName:textureName];
    if(self) {
        [self addHealthPointsStripe];
    }
    return self;
}

- (void)addHealthPointsStripe {
    _healthStripe = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(kSpriteSize, 3)];
    [self addChild:_healthStripe];
    _healthStripe.position = CGPointMake(0, self.size.height / 2 + 3);
}

- (void)changeHealthStripeLengthForPartOfHealth:(CGFloat)healthPart {
    CGFloat newLength = kSpriteSize * healthPart + 2;
    SKAction *changeWidth = [SKAction resizeToWidth:newLength duration:0.05];
    SKAction *changeColor = [SKAction colorizeWithColor:[self colorForHeath:healthPart] colorBlendFactor:0.5 duration:0.05];
    [self.healthStripe runAction:[SKAction group:@[changeColor, changeWidth]]];
}

#pragma mark - choose color for health level
- (UIColor *)colorForHeath:(CGFloat)healthPart {
    if(healthPart <= 0.4) {
        return [UIColor redColor];
    }
    else if(healthPart <= 0.7) {
        return [UIColor yellowColor];
    }
    return [UIColor greenColor];
}


#pragma mark - base class method

- (SKTexture *)textureNamed:(NSString *)name {
    return [super textureNamed:name];
}

@end
