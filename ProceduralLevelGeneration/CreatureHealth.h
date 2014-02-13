//
//  CreatureHealth.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/3/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CreatureHealth <NSObject>

@property (nonatomic, assign) CGFloat currentHealth;
@property (nonatomic, assign) CGFloat fullHealth;

@end
