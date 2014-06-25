
#import "POPSwiftWrapper.h"
#import <POP/POP.h>
#import "POP/POPAnimator.h"

@interface _POPDecayAnimation ()
{ POPDecayAnimation* __self; }
@end

@implementation _POPDecayAnimation

-(_POPDecayAnimation*)mutableCopy {
  return [[_POPDecayAnimation alloc] initWithVelocity:[__self.velocity floatValue] decel:__self.deceleration];
}

-(instancetype)initWithVelocity:(CGFloat)velocity {
  return self = [[_POPDecayAnimation alloc] initWithVelocity:velocity decel:self.deceleration];
}

-(instancetype)initWithVelocity:(CGFloat)velocity decel:(CGFloat)decel {
 self = [super init];
 __self = [POPDecayAnimation animation];
 __self.velocity = @(velocity);
 __self.deceleration = decel;
 return self;
}

- (id) velocity { return __self.velocity; }
- (void) setVelocity:(id)velocity { __self.velocity = velocity; }

- (CGFloat)deceleration { return __self.deceleration; }
- (void) setDeceleration:(CGFloat)deceleration { __self.deceleration = deceleration; }

-(CFTimeInterval)duration { return __self.duration; }

-(id)reversedVelocity { return __self.reversedVelocity; }

- (id) originalVelocity { return __self.originalVelocity; }

@end

@interface _POPSpringAnimation ()
{ POPSpringAnimation* __self; }
@end

@implementation _POPSpringAnimation

-(instancetype)initWithTension:(CGFloat)tension friction:(CGFloat)friction mass:(CGFloat)mass {
  self = [super init];
  __self = [POPSpringAnimation animation];
  __self.dynamicsTension = tension;
  __self.dynamicsFriction = friction;
  __self.dynamicsMass = mass;
  return self;
}

-(instancetype)initWithTension:(CGFloat)tension friction:(CGFloat)friction mass:(CGFloat)mass velocity:(CGFloat)velocity {
  self = [[_POPSpringAnimation alloc] initWithTension:tension friction:friction mass:mass];
  __self.velocity = @(velocity);
  return self;
}

/// NB: Does not copy "velocity"
-(_POPSpringAnimation *)mutableCopy {
  return [[_POPSpringAnimation alloc] initWithTension:__self.dynamicsTension friction:__self.dynamicsFriction mass:__self.dynamicsMass];
}

-(CGFloat)springBounciness { return __self.springBounciness; }
-(void)setSpringBounciness:(CGFloat)springBounciness { __self.springBounciness = springBounciness; }

-(CGFloat)springSpeed { return __self.springSpeed; }
-(void)setSpringSpeed:(CGFloat)springSpeed { __self.springSpeed = springSpeed; }

-(CGFloat)dynamicsTension { return __self.dynamicsTension; }
-(void)setDynamicsTension:(CGFloat)dynamicsTension { __self.dynamicsTension = dynamicsTension; }

-(CGFloat)dynamicsFriction { return __self.dynamicsFriction; }
-(void)setDynamicsFriction:(CGFloat)dynamicsFriction { __self.dynamicsFriction = dynamicsFriction; }

-(CGFloat)dynamicsMass { return __self.dynamicsMass; }
-(void)setDynamicsMass:(CGFloat)dynamicsMass { __self.dynamicsMass = dynamicsMass; }

-(id)velocity { return __self.velocity; }
-(void)setVelocity:(id)velocity { __self.velocity = velocity; }

@end

@interface _POPBasicAnimation ()
{ POPBasicAnimation* __self; }
@end

@implementation _POPBasicAnimation

- (instancetype)initWithDuration:(CGFloat)duration timingFunction:(CAMediaTimingFunction *)timingFunction {
  self = [super init];
  __self = [POPBasicAnimation animation];
  __self.duration = duration;
  __self.timingFunction = timingFunction;
  return self;
}

-(instancetype)initWithDuration:(CGFloat)duration {
  return [[_POPBasicAnimation alloc] initWithDuration:duration timingFunction:nil];
}

-(_POPBasicAnimation *)mutableCopy {
  return [[_POPBasicAnimation alloc] initWithDuration:self.duration timingFunction:self.timingFunction];
}

-(CFTimeInterval)duration { return __self.duration; }
-(CAMediaTimingFunction *)timingFunction { return __self.timingFunction; }

@end

@interface _POPAnimation ()
{ POPAnimation* __self; }
@end

@implementation _POPAnimation

+(void)addAnimation:(_POPAnimation*)anim key:(NSString *)key obj:(id)obj {
  [[POPAnimator sharedAnimator] addAnimation:anim._self forObject:obj key:key];
}

+(void)removeAllAnimations:(id)obj {
  [[POPAnimator sharedAnimator] removeAllAnimationsForObject:obj];
}

+(void)removeAnimationForKey:(NSString *)key obj:(id)obj {
  [[POPAnimator sharedAnimator] removeAnimationForObject:obj key:key];
}

+(NSArray *)animationKeys:(id)obj {
  return [[POPAnimator sharedAnimator] animationKeysForObject:obj];
}

+(_POPAnimation*)animationForKey:(NSString *)key obj:(id)obj {
  _POPAnimation* anim = [_POPAnimation new];
  anim._self = [[POPAnimator sharedAnimator] animationForObject:obj key:key];
  return anim;
}

-(NSString *)name { return __self.name; }
-(void)setName:(NSString *)name { __self.name = name; }

@synthesize completionBlock = _completionBlock;
-(void (^)(_POPAnimation *, BOOL))completionBlock { return _completionBlock; }
-(void)setCompletionBlock:(void (^)(_POPAnimation *, BOOL))completionBlock {
  _completionBlock = completionBlock;
  __weak _POPAnimation* wself = self;
  __self.completionBlock = ^(POPAnimation* anim, BOOL finished){
    wself.completionBlock(wself, finished);
  };
}

-(BOOL)removedOnCompletion { return __self.removedOnCompletion; }
-(void)setRemovedOnCompletion:(BOOL)removedOnCompletion { __self.removedOnCompletion = removedOnCompletion; }

-(BOOL)isPaused { return __self.isPaused; }
-(void)setPaused:(BOOL)paused { __self.paused = paused; }

-(BOOL)autoreverses { return __self.autoreverses; }
-(void)setAutoreverses:(BOOL)autoreverses { __self.autoreverses = autoreverses; }

-(NSInteger)repeatCount { return __self.repeatCount; }
-(void)setRepeatCount:(NSInteger)repeatCount { __self.repeatCount = repeatCount; }

-(BOOL)repeatForever { return __self.repeatForever; }
-(void)setRepeatForever:(BOOL)repeatForever { __self.repeatForever = repeatForever; }

@end

@interface _POPPropertyAnimation ()
{ POPPropertyAnimation* __self; }
@end

@implementation _POPPropertyAnimation

-(id)fromValue { return __self.fromValue; }
-(void)setFromValue:(id)fromValue { __self.fromValue = fromValue; }

-(id)toValue { return __self.toValue; }
-(void)setToValue:(id)toValue { __self.toValue = toValue; }

-(CGFloat)roundingFactor { return __self.roundingFactor; }
-(void)setRoundingFactor:(CGFloat)roundingFactor { __self.roundingFactor = roundingFactor; }

-(NSUInteger)clampMode { return __self.clampMode; }
-(void)setClampMode:(NSUInteger)clampMode { __self.clampMode = clampMode; }

-(BOOL)isAdditive { return __self.isAdditive; }
-(void)setAdditive:(BOOL)additive { __self.additive = additive; }

@end

@interface _POPAnimatableProperty ()
{ POPAnimatableProperty* __self; }
@end

@implementation _POPAnimatableProperty

+(_POPAnimatableProperty*)propertyWithName:(NSString *)name {
  _POPAnimatableProperty* prop = [_POPAnimatableProperty new];
  prop._self = [POPAnimatableProperty propertyWithName:name];
  return prop;
}

+(_POPAnimatableProperty*)propertyWithName:(NSString *)name initializer:(void (^)(_POPMutableAnimatableProperty*))block {
  _POPAnimatableProperty* prop = [_POPAnimatableProperty new];
  prop._self = [POPAnimatableProperty propertyWithName:name initializer:^(POPMutableAnimatableProperty* prop){
    _POPMutableAnimatableProperty* mprop = [_POPMutableAnimatableProperty new];
    mprop._self = prop;
    block(mprop);
  }];
  return prop;
}

-(NSString *)name { return __self.name; }

-(void (^)(id, CGFloat *))readBlock { return __self.readBlock; }

-(void (^)(id, const CGFloat *))writeBlock { return  __self.writeBlock; }

-(CGFloat)threshold { return __self.threshold; }

@end

@interface _POPMutableAnimatableProperty ()
{ POPMutableAnimatableProperty* __self; }
@end

@implementation _POPMutableAnimatableProperty

-(NSString *)name { return __self.name; }
-(void)setName:(NSString *)name { __self.name = name; }

-(void (^)(id, CGFloat *))readBlock { return __self.readBlock; }
-(void)setReadBlock:(void (^)(id, CGFloat *))readBlock { __self.readBlock = readBlock; }

-(void (^)(id, const CGFloat *))writeBlock { return __self.writeBlock; }
-(void)setWriteBlock:(void (^)(id, const CGFloat *))writeBlock { __self.writeBlock = writeBlock; }

-(CGFloat)threshold { return __self.threshold; }
-(void)setThreshold:(CGFloat)threshold { __self.threshold = threshold; }

@end
