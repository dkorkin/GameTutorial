//
//  Food.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LevelObject.h"

#import "Map_Private.h"

typedef NS_ENUM(NSInteger, FoodType) {
    FoodTypeNone = 0,
    FoodTypeMouse = 1,
    FoodTypeBone = 2,
};

@interface Food : LevelObject

@property (nonatomic, assign) FoodType foodType;

+ (instancetype)foodToWorld:(SKNode *)world;

- (void)pickUpFood;

@end
