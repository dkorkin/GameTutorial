//
//  CreatureObject.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/3/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "LevelObject.h"

@interface CreatureObject : LevelObject

- (instancetype)initWithSpriteType:(SpriteType)type andTextureName:(NSString *)textureName;

- (SKTexture *)textureNamed:(NSString *)name;

- (void)changeHealthStripeLengthForPartOfHealth:(CGFloat)healthPart;

@end
