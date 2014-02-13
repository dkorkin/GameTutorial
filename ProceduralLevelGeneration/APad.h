//
//  APad.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/3/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class APad;

@protocol APadDelegate <NSObject>

- (void)attackPressed:(APad *)aPad;

@end

@interface APad : SKSpriteNode

@property (weak, nonatomic) id<APadDelegate> delegate;

-(id)init;

@end
