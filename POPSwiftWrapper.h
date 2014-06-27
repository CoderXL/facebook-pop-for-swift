
#import <POP/POP.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

/// Abstract animation effect class
@interface _POPAnimation : NSObject

- (NSString*) description;

+ (void) addAnimation:(_POPAnimation*)anim key:(NSString*)key obj:(id)obj;

+ (void) removeAllAnimations:(id)obj;

+ (void) removeAnimationForKey:(NSString*)key obj:(id)obj;

+ (NSArray*) animationKeys:(id)obj;

+ (NSDictionary*) animations:(id)obj;

+ (_POPAnimation*) animationForKey:(NSString*)key obj:(id)obj;

- (_POPAnimation*) mutableCopy;

@property (copy, nonatomic)
NSString *name;

@property (copy, nonatomic)
void (^completionBlock)(_POPAnimation* anim, BOOL finished);

@property (assign, nonatomic)
BOOL removedOnCompletion;

@property (assign, nonatomic, getter = isPaused)
BOOL paused;

@property (assign, nonatomic)
BOOL autoreverses;

@property (assign, nonatomic)
NSInteger repeatCount;

@property (assign, nonatomic)
BOOL repeatForever;

@property (strong)
POPAnimation* ref;

@end

@class _POPAnimatableProperty;

/// Property animation effect class
@interface _POPPropertyAnimation : _POPAnimation

- (_POPPropertyAnimation*) mutableCopy;

@property (strong, nonatomic)
_POPAnimatableProperty *property;

- (NSString*) description;

@property (copy, nonatomic)
id fromValue;

@property (copy, nonatomic)
id toValue;

@property (readonly)
CGFloat progress;

@property (assign, nonatomic)
CGFloat roundingFactor;

@property (assign, nonatomic)
NSUInteger clampMode;

@property (assign, nonatomic, getter = isAdditive)
BOOL additive;

@property (strong)
POPPropertyAnimation* ref;

@end

///
///
///

@interface _POPSpringAnimation : _POPPropertyAnimation

- (instancetype) initWithTension:(CGFloat)tension friction:(CGFloat)friction mass:(CGFloat)mass;

- (instancetype) initWithTension:(CGFloat)tension friction:(CGFloat)friction mass:(CGFloat)mass velocity:(CGFloat)velocity;

- (_POPSpringAnimation*) mutableCopy;

- (NSString*) description;

@property (copy, nonatomic)
id velocity;

@property (assign, nonatomic)
CGFloat springBounciness;

@property (assign, nonatomic)
CGFloat springSpeed;

@property (assign, nonatomic)
CGFloat dynamicsTension;

@property (assign, nonatomic)
CGFloat dynamicsFriction;

@property (assign, nonatomic)
CGFloat dynamicsMass;

@property (strong)
POPSpringAnimation* ref;

@end

///
///
///

@interface _POPBasicAnimation : _POPPropertyAnimation

- (NSString*) description;

- (instancetype) initWithDuration:(CGFloat)duration;

- (instancetype) initWithDuration:(CGFloat)duration timingFunction:(CAMediaTimingFunction*)timingFunction;

- (_POPBasicAnimation*) mutableCopy;

@property (assign, nonatomic)
CFTimeInterval duration;

@property (strong, nonatomic)
CAMediaTimingFunction *timingFunction;

@property (strong)
POPBasicAnimation* ref;

@end

///
///
///

@interface _POPDecayAnimation : _POPPropertyAnimation

- (NSString*) description;

-(instancetype)initWithVelocity:(CGFloat)velocity;

-(instancetype)initWithVelocity:(CGFloat)velocity decel:(CGFloat)decel;

-(_POPDecayAnimation*)mutableCopy;

@property (copy, nonatomic)
id velocity;

@property (copy, nonatomic, readonly)
id originalVelocity;

@property (assign, nonatomic)
CGFloat deceleration;

@property (readonly, assign, nonatomic)
CFTimeInterval duration;

- (void)setToValue:(id)toValue NS_UNAVAILABLE;

- (id)reversedVelocity;

@property (strong)
POPDecayAnimation* ref;

@end

///
///
///

@interface POPAnimator (Swift)

- (void)addAnimation:(POPAnimation *)anim forObject:(id)obj key:(NSString *)key;

- (void)removeAllAnimationsForObject:(id)obj;

- (void)removeAnimationForObject:(id)obj key:(NSString *)key;

- (NSArray *)animationKeysForObject:(id)obj;

- (id)animationForObject:(id)obj key:(NSString *)key;

@end

///
///
///

@interface _POPMutableAnimatableProperty: NSObject

@property (readwrite, nonatomic, copy)
NSString *name;

@property (readwrite, nonatomic, copy)
void (^readBlock)(id obj, CGFloat values[]);

@property (readwrite, nonatomic, copy)
void (^writeBlock)(id obj, const CGFloat values[]);

@property (readwrite, nonatomic, assign)
CGFloat threshold;

@property (strong)
POPMutableAnimatableProperty* ref;

@end

///
///
///

@interface _POPAnimatableProperty: NSObject

+ (_POPAnimatableProperty*) propertyWithName:(NSString *)name;

+ (_POPAnimatableProperty*) propertyWithName:(NSString *)name initializer:(void (^)(_POPMutableAnimatableProperty* prop))block;

@property (readonly, nonatomic, copy)
NSString *name;

@property (readonly, nonatomic, copy)
void (^readBlock)(id obj, CGFloat values[]);

@property (readonly, nonatomic, copy)
void (^writeBlock)(id obj, const CGFloat values[]);

@property (readonly, nonatomic, assign)
CGFloat threshold;

@property (strong)
POPAnimatableProperty* ref;

@end
