//
//  MyScene.m
//  Hop Hero Hell
//
//  Created by Michael Leech on 4/9/14.
//  Copyright (c) 2014 micah. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.anchorPoint = CGPointMake(0.5, 0.5);
        [self createContent];
        
    }
    return self;
}

- (void)createContent
{
    [self loadWalls];
}

- (void)loadWalls
{
    UIColor *wallColor = [UIColor redColor];
    double wallWidth = 10.0;
    
    SKSpriteNode *left = [SKSpriteNode spriteNodeWithColor:wallColor size:CGSizeMake(wallWidth, self.frame.size.height)];
    left.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:left.size];
    left.physicsBody.dynamic = NO;
    left.position = CGPointMake(-self.frame.size.width/2, 0);
    [self addChild:left];
    
    SKSpriteNode *right = [left copy];
    right.position = CGPointMake(self.frame.size.width/2, 0);
    [self addChild:right];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithColor:wallColor size:CGSizeMake(self.frame.size.width, wallWidth)];
    top.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:top.size];
    top.physicsBody.dynamic = NO;
    top.position = CGPointMake(0, self.frame.size.height/2);
    [self addChild:top];
    
    SKSpriteNode *bottom = [top copy];
    bottom.position = CGPointMake(0, -self.frame.size.height/2);
    [self addChild:bottom];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        [self spawnHeroAtPoint:touchLocation];
    }
    
}

- (void)spawnHeroAtPoint:(CGPoint)point
{
    SKSpriteNode *hero = [SKSpriteNode spriteNodeWithColor:[self getRandomColor] size:CGSizeMake(30, 30)];
    hero.position = point;
    
    SKSpriteNode *leftEye = [SKSpriteNode spriteNodeWithColor:[self getRandomColor] size:CGSizeMake(5, 5)];
    leftEye.position = CGPointMake(-3, 8);
    [hero addChild:leftEye];
    
    SKSpriteNode *rightEye = [SKSpriteNode spriteNodeWithColor:[self getRandomColor] size:CGSizeMake(5, 5)];
    rightEye.position = CGPointMake(12, 8);
    [hero addChild:rightEye];
    
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
    [self addChild:hero];
    
    double yDirection = (double) (arc4random() % 200) / 100.0 - 1.0;
    double xDirection = (double) (arc4random() % 200) / 100.0 - 1.0;
    double power = 200;
    CGVector impulse = CGVectorMake(yDirection * power, xDirection * power);
    [hero.physicsBody applyImpulse:impulse];
}

- (UIColor *)getRandomColor
{
    int rand = arc4random() % 6;
    
    UIColor *color;
    switch (rand) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor orangeColor];
            break;
        case 2:
            color = [UIColor yellowColor];
            break;
        case 3:
            color = [UIColor greenColor];
            break;
        case 4:
            color = [UIColor purpleColor];
            break;
        case 5:
            color = [UIColor blueColor];
            break;
            
        default:
            break;
    }
    return color;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
