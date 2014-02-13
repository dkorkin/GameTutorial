//
//  FoodManager.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDSingleton.h"

#import "Map.h"
#import "Food.h"

@interface FoodManager : NSObject

+ (instancetype)sharedManager;

- (void)generateFoodItemToWorld:(SKNode *)world onMap:(Map *)map;
- (BOOL)ifCreatureCanEatFoodItemType:(FoodType )foodType atPosition:(CGPoint)position;

@end
