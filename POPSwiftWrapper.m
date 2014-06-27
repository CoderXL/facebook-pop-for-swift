
#import "POPSwiftWrapper.h"
#import <POP/POP.h>
#import <Foundation/Foundation.h>
#import "POP/POPAnimator.h"

@implementation _POPAnimation

-(NSString *)description {
  return @"";
}

+(NSDictionary*)animations:(id)obj {
  if (obj) {
    NSArray* keys = [self animationKeys:obj];
    NSMutableDictionary* anims = [NSMutableDictionary dictionary];
    for (NSString* key in keys) {
      [anims setObject:[self animationForKey:key obj:obj] forKey:key];
    }
    return anims;
  }
  
  return @{};
}

+(void)addAnimation:(_POPAnimation*)anim key:(NSString *)key obj:(id)obj {
  if (!obj || !key || !anim) return;
  [[POPAnimator sharedAnimator] addAnimation:anim.ref forObject:obj key:key];
}

+(void)removeAllAnimations:(id)obj {
  if (obj) [[POPAnimator sharedAnimator] removeAllAnimationsForObject:obj];
}

+(void)removeAnimationForKey:(NSString *)key obj:(id)obj {
  if (!obj || !key) return;
  [[POPAnimator sharedAnimator] removeAnimationForObject:obj key:key];
}

+(NSArray *)animationKeys:(id)obj {
  return obj ? [[POPAnimator sharedAnimator] animationKeysForObject:obj] : @[];
}

+(_POPAnimation*)animationForKey:(NSString *)key obj:(id)obj {
  if (!obj || !key) return nil;
  _POPAnimation* anim = [_POPAnimation new];
  anim.ref = [[POPAnimator sharedAnimator] animationForObject:obj key:key];
  return anim;
}

// Must be overridden
-(_POPAnimation *)mutableCopy { return nil; }

-(NSString *)name { return self.ref.name; }
-(void)setName:(NSString *)name { self.ref.name = name; }

@synthesize completionBlock = _completionBlock;
-(void (^)(_POPAnimation *, BOOL))completionBlock { return _completionBlock; }
-(void)setCompletionBlock:(void (^)(_POPAnimation *, BOOL))completionBlock {
  _completionBlock = completionBlock;
  __weak _POPAnimation* wself = self;
  self.ref.completionBlock = ^(POPAnimation* anim, BOOL finished){
    wself.completionBlock(wself, finished);
  };
}

-(BOOL)removedOnCompletion { return self.ref.removedOnCompletion; }
-(void)setRemovedOnCompletion:(BOOL)removedOnCompletion { self.ref.removedOnCompletion = removedOnCompletion; }

-(BOOL)isPaused { return self.ref.isPaused; }
-(void)setPaused:(BOOL)paused { self.ref.paused = paused; }

-(BOOL)autoreverses { return self.ref.autoreverses; }
-(void)setAutoreverses:(BOOL)autoreverses { self.ref.autoreverses = autoreverses; }

-(NSInteger)repeatCount { return self.ref.repeatCount; }
-(void)setRepeatCount:(NSInteger)repeatCount { self.ref.repeatCount = repeatCount; }

-(BOOL)repeatForever { return self.ref.repeatForever; }
-(void)setRepeatForever:(BOOL)repeatForever { self.ref.repeatForever = repeatForever; }

@end

@implementation _POPPropertyAnimation

-(NSString *)description {
  NSString* props = [NSString stringWithFormat:@", fromValue: %@, toValue: %@, property: %@, roundingFactor: %f, clampMode: %lu, additive: %@", self.ref.fromValue, self.ref.toValue, self.ref.property.name, self.ref.roundingFactor, self.ref.clampMode, [NSNumber numberWithBool:self.ref.additive]];
  return [[super description] stringByAppendingString:props];
}

- (_POPPropertyAnimation*) mutableCopy { return nil; }

-(CGFloat)progress { return self.ref.progress; }

@synthesize property = _property;
-(_POPAnimatableProperty *)property { return _property; }
-(void)setProperty:(_POPAnimatableProperty *)property {
  _property = property;
  self.ref.property = property.ref;
}

-(id)fromValue { return self.ref.fromValue; }
-(void)setFromValue:(id)fromValue { self.ref.fromValue = fromValue; }

-(id)toValue { return self.ref.toValue; }
-(void)setToValue:(id)toValue { self.ref.toValue = toValue; }

-(CGFloat)roundingFactor { return self.ref.roundingFactor; }
-(void)setRoundingFactor:(CGFloat)roundingFactor { self.ref.roundingFactor = roundingFactor; }

-(NSUInteger)clampMode { return self.ref.clampMode; }
-(void)setClampMode:(NSUInteger)clampMode { self.ref.clampMode = clampMode; }

-(BOOL)isAdditive { return self.ref.isAdditive; }
-(void)setAdditive:(BOOL)additive { self.ref.additive = additive; }

@end

@implementation _POPDecayAnimation

-(NSString *)description {
  NSString* props = [NSString stringWithFormat:@", velocity: %@, deceleration: %f", self.ref.velocity, self.ref.deceleration];
  return [[super description] stringByAppendingString:props];
}

-(_POPDecayAnimation*)mutableCopy {
  return [[_POPDecayAnimation alloc] initWithVelocity:[self.ref.velocity floatValue] decel:self.ref.deceleration];
}

-(instancetype)initWithVelocity:(CGFloat)velocity {
  return self = [[_POPDecayAnimation alloc] initWithVelocity:velocity decel:self.deceleration];
}

-(instancetype)initWithVelocity:(CGFloat)velocity decel:(CGFloat)decel {
 self = [super init];
 self.ref = [POPDecayAnimation animation];
 self.ref.velocity = @(velocity);
 self.ref.deceleration = decel;
 return self;
}

- (id) velocity { return self.ref.velocity; }
- (void) setVelocity:(id)velocity { self.ref.velocity = velocity; }

- (CGFloat) deceleration { return self.ref.deceleration; }
- (void) setDeceleration:(CGFloat)deceleration { self.ref.deceleration = deceleration; }

- (CFTimeInterval) duration { return self.ref.duration; }

- (id) reversedVelocity { return self.ref.reversedVelocity; }

- (id) originalVelocity { return self.ref.originalVelocity; }

@end

@implementation _POPSpringAnimation

-(NSString *)description {
  NSString* props = [NSString stringWithFormat:@", tension: %f, friction: %f, mass: %f, velocity: %@", self.ref.dynamicsTension, self.ref.dynamicsFriction, self.ref.dynamicsMass, self.ref.velocity];
  return [[super description] stringByAppendingString:props];
}

-(instancetype)initWithTension:(CGFloat)tension friction:(CGFloat)friction mass:(CGFloat)mass {
  self = [super init];
  self.ref = [POPSpringAnimation animation];
  self.ref.dynamicsTension = tension;
  self.ref.dynamicsFriction = friction;
  self.ref.dynamicsMass = mass;
  return self;
}

-(instancetype)initWithTension:(CGFloat)tension friction:(CGFloat)friction mass:(CGFloat)mass velocity:(CGFloat)velocity {
  self = [[_POPSpringAnimation alloc] initWithTension:tension friction:friction mass:mass];
  self.ref.velocity = @(velocity);
  return self;
}

/// NB: Does not copy "velocity"
-(_POPSpringAnimation *)mutableCopy {
  return [[_POPSpringAnimation alloc] initWithTension:self.ref.dynamicsTension friction:self.ref.dynamicsFriction mass:self.ref.dynamicsMass];
}

-(CGFloat)springBounciness { return self.ref.springBounciness; }
-(void)setSpringBounciness:(CGFloat)springBounciness { self.ref.springBounciness = springBounciness; }

-(CGFloat)springSpeed { return self.ref.springSpeed; }
-(void)setSpringSpeed:(CGFloat)springSpeed { self.ref.springSpeed = springSpeed; }

-(CGFloat)dynamicsTension { return self.ref.dynamicsTension; }
-(void)setDynamicsTension:(CGFloat)dynamicsTension { self.ref.dynamicsTension = dynamicsTension; }

-(CGFloat)dynamicsFriction { return self.ref.dynamicsFriction; }
-(void)setDynamicsFriction:(CGFloat)dynamicsFriction { self.ref.dynamicsFriction = dynamicsFriction; }

-(CGFloat)dynamicsMass { return self.ref.dynamicsMass; }
-(void)setDynamicsMass:(CGFloat)dynamicsMass { self.ref.dynamicsMass = dynamicsMass; }

-(id)velocity { return self.ref.velocity; }
-(void)setVelocity:(id)velocity { self.ref.velocity = velocity; }

@end

@implementation _POPBasicAnimation

- (NSString *)description {
  NSString* props = [NSString stringWithFormat:@", duration: %f, timingFunction: %@", self.ref.duration, self.ref.timingFunction];
  return [[super description] stringByAppendingString:props];
}

- (instancetype)initWithDuration:(CGFloat)duration timingFunction:(CAMediaTimingFunction *)timingFunction {
  self = [super init];
  self.ref = [POPBasicAnimation animation];
  self.ref.duration = duration;
  self.ref.timingFunction = timingFunction;
  return self;
}

-(instancetype)initWithDuration:(CGFloat)duration {
  return [[_POPBasicAnimation alloc] initWithDuration:duration timingFunction:nil];
}

-(_POPBasicAnimation *)mutableCopy {
  return [[_POPBasicAnimation alloc] initWithDuration:self.ref.duration timingFunction:self.ref.timingFunction];
}

-(CFTimeInterval)duration { return self.ref.duration; }
-(CAMediaTimingFunction *)timingFunction { return self.ref.timingFunction; }

@end

@implementation _POPAnimatableProperty

+(_POPAnimatableProperty*)propertyWithName:(NSString *)name {
  _POPAnimatableProperty* prop = [_POPAnimatableProperty new];
  prop.ref = [POPAnimatableProperty propertyWithName:name];
  return prop;
}

+(_POPAnimatableProperty*)propertyWithName:(NSString *)name initializer:(void (^)(_POPMutableAnimatableProperty*))block {
  _POPAnimatableProperty* prop = [_POPAnimatableProperty new];
  prop.ref = [POPAnimatableProperty propertyWithName:name initializer:^(POPMutableAnimatableProperty* prop){
    _POPMutableAnimatableProperty* mprop = [_POPMutableAnimatableProperty new];
    mprop.ref = prop;
    block(mprop);
  }];
  return prop;
}

-(NSString *)name { return self.ref.name; }

-(void (^)(id, CGFloat *))readBlock { return self.ref.readBlock; }

-(void (^)(id, const CGFloat *))writeBlock { return  self.ref.writeBlock; }

-(CGFloat)threshold { return self.ref.threshold; }

@end

@implementation _POPMutableAnimatableProperty

-(NSString *)name { return self.ref.name; }
-(void)setName:(NSString *)name { self.ref.name = name; }

-(void (^)(id, CGFloat *))readBlock { return self.ref.readBlock; }
-(void)setReadBlock:(void (^)(id, CGFloat *))readBlock { self.ref.readBlock = readBlock; }

-(void (^)(id, const CGFloat *))writeBlock { return self.ref.writeBlock; }
-(void)setWriteBlock:(void (^)(id, const CGFloat *))writeBlock { self.ref.writeBlock = writeBlock; }

-(CGFloat)threshold { return self.ref.threshold; }
-(void)setThreshold:(CGFloat)threshold { self.ref.threshold = threshold; }

@end
