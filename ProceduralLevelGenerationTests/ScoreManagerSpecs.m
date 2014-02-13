//
//  ScoreManagerSpecs.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Kiwi.h"
#import "ScoreManager.h"
#import "ScoreManager_Private.h"

SPEC_BEGIN(ScoreManagerSpecs)

describe(@"Score Manager", ^{
    
    __block NSInteger score = 0;
    
    context(@"Before any function of manager called", ^{
        it(@"score points should equal 0", ^{
             [[theValue([ScoreManager sharedManager].score) should] equal:theValue(0)];
        });
    });
    
    context(@"Bonus actions check", ^{
        it(@"it shoul add 5 point after dog hit", ^{
            [[ScoreManager sharedManager] addDogHit];
            score += 5;
            [[theValue([ScoreManager sharedManager].score) should] equal:theValue(score)];
        });
        
        it(@"should be correct text in score", ^{
            NSString *scoreText = [NSString stringWithFormat:@"Score: %d", score];
            [[[ScoreManager sharedManager].scoreLabel.text should] equal:scoreText];
        });
        
        it(@"it shoul add 50 point after killing dog", ^{
            [[ScoreManager sharedManager] addDogKill];
            score += 50;
            [[theValue([ScoreManager sharedManager].score) should] equal:theValue(score)];
        });
        
        it(@"it shoul add 50 point after key owning", ^{
            [[ScoreManager sharedManager] addKeyOwning];
            score += 50;
            [[theValue([ScoreManager sharedManager].score) should] equal:theValue(score)];
        });
        
        it(@"it shoul add 100 point after level completion", ^{
            [[ScoreManager sharedManager] addLevelCompletion];
            score += 100;
            [[theValue([ScoreManager sharedManager].score) should] equal:theValue(score)];
        });
        
        it(@"it shoul add 5 point after pick up food", ^{
            [[ScoreManager sharedManager] addFoodPickUp];
            score += 5;
            [[theValue([ScoreManager sharedManager].score) should] equal:theValue(score)];
        });
        
    });
    
    context(@"clear score", ^{
        it(@"score should be nil", ^{
            [[ScoreManager sharedManager] clearScore];
            [[theValue([ScoreManager sharedManager].score) should] equal:theValue(0)];
        });
    });
});


SPEC_END