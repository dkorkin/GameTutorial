//
//  PointsManager.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "ScoreManager.h"
#import "GCDSingleton.h"

@interface ScoreManager ()

@property (nonatomic, assign) NSInteger score;

@end

@implementation ScoreManager

+ (instancetype)sharedManager {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init {
    self = [super init];
    if(self) {
        _score = 0;
    }
    return self;
}


#pragma mark - dog points

- (void)addDogHit {
    self.score += 5;
    [self changeScoreText];
}

- (void)addDogKill {
    self.score += 50;
    [self changeScoreText];
}


#pragma mark - level points

- (void)addKeyOwning {
    self.score += 50;
    [self changeScoreText];
}

- (void)addLevelCompletion {
    self.score += 100;
    [self changeScoreText];
}


#pragma mark - food points

- (void)addFoodPickUp {
    self.score += 5;
    [self changeScoreText];
}


#pragma mark - clear Score

- (void)clearScore {
    self.score = 0;
    [self changeScoreText];
}


#pragma mark - score text

- (void)changeScoreText {
    NSString *scoreText = [NSString stringWithFormat:@"Score: %d", self.score];
    self.scoreLabel.text = scoreText;
    [self checkGameCompletion];
} 


#pragma mark - score Label setter

- (void)setScoreLabel:(SKLabelNode *)scoreLabel {
    _scoreLabel = scoreLabel;
    [self changeScoreText];
}



#pragma mark - check for Game Ending

- (void)checkGameCompletion {
    if(self.score >= 1000) {
        [self.delegate scoreManagerDidCompleteGame:self];
    }
}

@end
