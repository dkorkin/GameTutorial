//
//  PointsManager.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@protocol ScoreManagerDelegate <NSObject>

- (void)scoreManagerDidCompleteGame:(id)scoreManager;

@end

@interface ScoreManager : NSObject

@property (nonatomic, strong) SKLabelNode *scoreLabel;

@property (weak, nonatomic) id<ScoreManagerDelegate> delegate;

+ (instancetype)sharedManager;

- (void)addDogHit;
- (void)addDogKill;
- (void)addKeyOwning;
- (void)addLevelCompletion;
- (void)addFoodPickUp;
- (void)clearScore;

@end
