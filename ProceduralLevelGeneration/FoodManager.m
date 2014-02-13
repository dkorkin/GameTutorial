//
//  FoodManager.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "FoodManager.h"

#import "DistanceMeasure.h"

#import "RandomGenerator.h"

@interface FoodManager ()

@property (nonatomic, strong) NSMutableArray *fridge;

@end

@implementation FoodManager

+ (instancetype)sharedManager {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init {
    self = [super init];
    if(self) {
        _fridge = [NSMutableArray new];
    }
    return self;
}

- (void)generateFoodItemToWorld:(SKNode *)world onMap:(Map *)map {
    if(randomNumberBetweenNumbers(0, 1) == 0) {
        NSInteger randomX = randomNumberBetweenNumbers(0, map.gridSize.width);
        NSInteger randomY = randomNumberBetweenNumbers(0, map.gridSize.height);
        CGPoint foodPosition = CGPointMake(randomX, randomY);
        MapTileType type = [map.tiles tileTypeAt:foodPosition];
        if(type == MapTileTypeFloor) {
            Food *food = [Food foodToWorld:world];
            CGPoint worldPoint = [map convertMapCoordinateToWorldCoordinate:foodPosition];
            NSLog(@"%d-type at %f, %f", type, worldPoint.x, worldPoint.y);
            food.position = worldPoint;
            [self.fridge addObject:food];
        }
    }
}

- (BOOL)ifCreatureCanEatFoodItemType:(FoodType )foodType atPosition:(CGPoint)position {
    for (Food *foodItem in self.fridge) {
        CGFloat distance = distanceBetweenPoints(position, foodItem.position);
        if(distance < 32 && foodItem.foodType == foodType) {
            [foodItem pickUpFood];
            return YES;
        }
    }
    return NO;
}

@end
