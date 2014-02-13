//
//  MyScene.m
//  ProceduralLevelGeneration
//
//  Created by Kim Pedersen on 09/08/13.
//  Copyright (c) 2013 Kim Pedersen. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"

#import "DPad.h"
#import "APad.h"
#import "Map.h"

#import "DogRoute.h"
#import "Dog.h"

#import "CatPlayer.h"
#import "Key.h"
#import "Exit.h"

#import "HealthHolder.h"
#import "FoodManager.h"
#import "ScoreManager.h"

#import "DistanceMeasure.h"


const CGFloat kPlayerMovementSpeed = 100.0f;

@interface GameScene() <SKPhysicsContactDelegate, APadDelegate, ScoreManagerDelegate>

@property (nonatomic, assign) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic, strong) SKNode *world;
@property (nonatomic, strong) SKNode *hud;

@property (nonatomic, strong) Map *map;
@property (nonatomic, strong) DPad *dPad;
@property (nonatomic, strong) APad *aPad;

@property (nonatomic, strong) SKLabelNode *scoreLabel;

@property (nonatomic, strong) Dog *dog;
@property (nonatomic, strong) Key *key;
@property (nonatomic, strong) Exit *exit;
@property (nonatomic, strong) CatPlayer *player;

@property (nonatomic, assign) BOOL isExitingLevel;

@property NSTimeInterval timeOfDogMove;
@property NSTimeInterval timeOfDogRegenation;

@end


@implementation GameScene

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    
    if (self) {
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        self.backgroundColor = [SKColor colorWithRed:175.0f/255.0f green:143.0f/255.0f blue:106.0f/255.0f alpha:1.0f];
        
        _isExitingLevel = NO;
        _world = [SKNode node];
        
        [self addChild:self.world];
        [self createMap];
        
        [self createExit];
        [self createKey];
        [self createPlayer];
        [self createDog];
        
        [self createHud];
        [self createDPad];
        [self createAPad];
        
        [self createScoreLabel];
        
        _timeOfDogMove = 0;
        _timeOfDogRegenation = 0;
    }
    return self;
}

#pragma mark -
#pragma mark - creation section

- (void)createMap {
    // Create a new map
    _map = [[Map alloc] initWithGridSize:CGSizeMake(48, 48)];
    _map.maxFloorCount = 110;
    _map.turnResistance = 20;
    _map.floorMakerSpawnProbability = 25;
    _map.maxFloorMakerCount = 5;
    _map.roomProbability = 20;
    _map.roomMinSize = CGSizeMake(2, 2);
    _map.roomMaxSize = CGSizeMake(6, 6);
    [_map generate];
    
    [_world addChild:_map];
}

- (void)createKey {
    _key = [Key keyToWorld:self.world atPosition:self.map.keyPoint];
}

- (void)createDog {
    DogRoute *route = [DogRoute routeOnMap:self.map andAim:self.player];
    _dog = [Dog dogToWorld:self.world withPosition:self.map.dogPoint forRoute:route];
}

- (void)createExit {
    _exit = [Exit exitToWorld:self.world atPosition:self.map.exitPoint];
}

- (void)createPlayer {
    _player = [CatPlayer playerToWorld:self.world atPosition:self.map.spawnPoint];
    _player.currentHealth = [HealthHolder sharedHolder].catHealth;
}

- (void)createHud {
    _hud = [SKNode node];
    [self addChild:_hud];
}

- (void)createDPad {
    _dPad = [[DPad alloc] initWithRect:CGRectMake(0, 0, 64.0f, 64.0f)];
    _dPad.position = CGPointMake(64.0f / 4, 64.0f / 4);
    _dPad.numberOfDirections = 24;
    _dPad.deadRadius = 8.0f;
    
    [_hud addChild:_dPad];
}

- (void)createAPad {
    _aPad = [[APad alloc] init];
    _aPad.delegate = self;
    _aPad.position = CGPointMake(self.size.width - _aPad.size.width/2 - 10, _aPad.size.height/2 + 13);
    [self addChild:_aPad];
    
}

- (void)createScoreLabel {
    _scoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    _scoreLabel.fontSize = 15.0;
    _scoreLabel.zPosition = 5;
    _scoreLabel.position = CGPointMake(self.size.width - 70, self.size.height - 30);
    [self addChild:_scoreLabel];
    [ScoreManager sharedManager].scoreLabel = _scoreLabel;
    [ScoreManager sharedManager].delegate = self;
}

#pragma mark -
#pragma mark - update section

- (void)update:(CFTimeInterval)currentTime {
    
    // Calculate the time since last update
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    
    self.lastUpdateTimeInterval = currentTime;
    
    if ( timeSinceLast > 1 ) {
        timeSinceLast = 1.0f / 60.0f;
        self.lastUpdateTimeInterval = currentTime;
        
    }
    [self dogMove:currentTime];
    [self dogRegeneration:currentTime];
    
    // Poll the DPad
    CGPoint playerVelocity = self.isExitingLevel ? CGPointZero : self.dPad.velocity;
    [self.player updateSpritePositionWithPlayerVelocity:playerVelocity andTime:timeSinceLast];
    
    // Move "camera" so the player is in the middle of the screen
    self.world.position = CGPointMake(-self.player.position.x + CGRectGetMidX(self.frame),
                                      -self.player.position.y + CGRectGetMidY(self.frame));
}


#pragma mark - update helpers

- (void)dogMove:(NSTimeInterval)currentTime {
    if (currentTime - self.timeOfDogMove < 0.5) {
        return;
    }
    self.timeOfDogMove= currentTime;
    [self.dog move];
    [self foodMaker];
}

- (void)foodMaker {
    if (self.dog) {
        [[FoodManager sharedManager] generateFoodItemToWorld:self.world onMap:self.map];
    }
}

- (void)dogRegeneration:(NSTimeInterval)currentTime {
    if (currentTime - self.timeOfDogRegenation < 3.0) {
        return;
    }
    self.timeOfDogRegenation = currentTime;
    [self.dog healthRegenation];
}


#pragma mark - physics

- (void)didSimulatePhysics {
    [self.player didSimulatePhysics];
}


- (void)resolveExit {
    // Disables DPad
    self.isExitingLevel = YES;
    [HealthHolder sharedHolder].catHealth = self.player.currentHealth;
    [[ScoreManager sharedManager] addLevelCompletion];
    
    // Animations
    SKAction *moveAction = [SKAction moveTo:self.map.exitPoint duration:0.5f];
    SKAction *rotateAction = [SKAction rotateByAngle:(M_PI * 2) duration:0.5f];
    SKAction *fadeAction = [SKAction fadeAlphaTo:0.0f duration:0.5f];
    SKAction *scaleAction = [SKAction scaleXTo:0.0f y:0.0f duration:0.5f];
    SKAction *soundAction = [SKAction playSoundFileNamed:@"win.wav" waitForCompletion:NO];
    SKAction *blockAction = [SKAction runBlock:^{
        [self.view presentScene:[[GameScene alloc] initWithSize:self.size] transition:[SKTransition doorsCloseVerticalWithDuration:0.5f]];
    }];
    
    SKAction *exitAnimAction = [SKAction sequence:@[[SKAction group:@[moveAction, rotateAction, fadeAction, scaleAction, soundAction]], blockAction]];
    
    [self.player exitFromPoint:self.map.exitPoint WithAction:exitAnimAction];
}


#pragma mark - contact

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0
        && (secondBody.categoryBitMask & CollisionTypeExit) != 0
        && (self.player.keyCount > 0)) {
        [self resolveExit];
    }
    else if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0
             && (secondBody.categoryBitMask & CollisionTypeKey) != 0) {
        [self.key pickUpKey];
        self.player.keyCount++;
        [[ScoreManager sharedManager] addKeyOwning];
    }
    else if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0
             && (secondBody.categoryBitMask & CollisionTypeDog) != 0) {
        if(self.player.currentHealth == 0) {
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO];
            [self.view presentScene:gameOverScene transition: reveal];
            [self endGame];
        }
        else {
            self.player.currentHealth--;
        }

    }
    else if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0
             && (secondBody.categoryBitMask & CollisionTypeFood) != 0) {
        if([[FoodManager sharedManager] ifCreatureCanEatFoodItemType:FoodTypeMouse atPosition:self.player.position]) {
            NSLog(@"CAT EAT");
            if(self.player.currentHealth < self.player.fullHealth) {
                self.player.currentHealth++;
                [[ScoreManager sharedManager] addFoodPickUp];
            }
        }
    }
    else if ((firstBody.categoryBitMask & CollisionTypeDog) != 0
             && (secondBody.categoryBitMask & CollisionTypeFood) != 0) {
        if([[FoodManager sharedManager] ifCreatureCanEatFoodItemType:FoodTypeBone atPosition:self.dog.position]) {
            self.dog.currentHealth++;
        }
    }
}

#pragma mark - attack actions

- (void)attackPressed:(APad *)aPad {
    CGFloat distance = distanceBetweenPoints(self.player.position, self.dog.position);
    BOOL isAttackCanBePerformed = [self.player checkAttackAvailabilityOfPoint:self.dog.position];
    if(distance < 32 && isAttackCanBePerformed && self.dog) {
        self.dog.currentHealth--;
        [[ScoreManager sharedManager] addDogHit];
        if(self.dog.currentHealth == 0) {
            [self.dog removeFromParent];
            self.dog = nil;
            [[ScoreManager sharedManager] addDogKill];
        }
    }
}


#pragma mark - game completion ScoreManager Delegate

- (void)scoreManagerDidCompleteGame:(id)scoreManager {
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:YES];
    [self.view presentScene:gameOverScene transition: reveal];
    [self endGame];
}

- (void)endGame {
    [[ScoreManager sharedManager] clearScore];
    [HealthHolder sharedHolder].catHealth = kCatFullHealth;
}

@end
