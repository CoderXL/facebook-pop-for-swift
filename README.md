##Facebook POP for Swift

This is a wrapper in Objective-C that makes Facebook's POP animation library useable in Swift. Just `#import` the wrapper in your **Objective-C to Swift bridging header**.

**Why is this needed?** Objective-C++ can't be imported into Swift. (As of June 24, 2014)

--

####Swift classes

I didn't wrap *every* POP class, as you will see. Here's a list of what I wrapped:

- _POPAnimation
- _POPPropertyAnimation
- _POPSpringAnimation
- _POPBasicAnimation
- _POPDecayAnimation
- _POPAnimatableProperty
- _POPMutableAnimatableProperty
 
--

####_POPAnimation class methods

I've added some class methods to `_POPAnimation` that implement POP's `NSObject` category. If you want, you can make a Swift extension on `NSObject` like POP does it, but these class methods allow `AnyObject` to be the associated object, which allows the animation of Swift object properties.

````Objective-C
+ (void) addAnimation:(_POPAnimation*)anim key:(NSString*)key obj:(id)obj;
+ (void) removeAllAnimations:(id)obj;
+ (void) removeAnimationForKey:(NSString*)key obj:(id)obj;
+ (NSArray*) animationKeys:(id)obj;
+ (_POPAnimation*) animationForKey:(NSString*)key obj:(id)obj;
````

*...use like this...*

````Swift
_POPAnimation.addAnimation(anim, key: anim.property.name, obj: view.layer)
_POPAnimation.removeAllAnimations(view.layer)
_POPAnimation.removeAnimationsForKey(_POPProperty.LayerOpacity, obj: view.layer)
var keys = _POPAnimation.animationKeys(view.layer)
var anim = _POPAnimation(forKey: _POPProperty.LayerOpacity, obj: view.layer)
````

--

####Added convenience initializers

I added some convenience initializers to `_POPSpringAnimation`, `_POPBasicAnimation`,  and `_POPDecayAnimation`. I implemented `- (id) mutableCopy {}` in these three, as well! Enjoy, or take them out!

**_POPSpringAnimation**

````Objective-C
- (instancetype) initWithTension:(CGFloat)tension friction:(CGFloat)friction mass:(CGFloat)mass;
- (instancetype) initWithTension:(CGFloat)tension friction:(CGFloat)friction mass:(CGFloat)mass velocity:(CGFloat)velocity;
````

*...use like this...*

````Swift
var anim = _POPSpringAnimation(tension: 100, friction: 10, mass: 1)
var anim = _POPSpringAnimation(tension: 100, friction: 10, mass: 1, velocity: 1000)
````

**_POPDecayAnimation**

````Objective-C
-(instancetype)initWithVelocity:(CGFloat)velocity;
-(instancetype)initWithVelocity:(CGFloat)velocity decel:(CGFloat)decel;
````

*...use like this...*

````Swift
var anim = _POPDecayAnimation(velocity: 1000)
var anim = _POPDecayAnimation(velocity: 1000, decel: 0.995)
````

**_POPBasicAnimation**

````Objective-C
- (instancetype) initWithDuration:(CGFloat)duration;
- (instancetype) initWithDuration:(CGFloat)duration timingFunction:(CAMediaTimingFunction*)timingFunction;
````

*...use like this...*

````Swift
var anim = _POPBasicAnimation(duration: 1)
var anim = _POPBasicAnimation(duration: 1, timingFunction: CAMediaTimingFunction(controlPoints: 0, 0, 1, 1))
````

--

####How to use

You can use POP like you would normally! Here's an example:

````Swift
  var view = UIView(frame: UIScreen.mainScreen().bounds)
  view.backgroundColor = UIColor.blueColor()
  
  var anim = _POPSpringAnimation(tension: 100, friction: 10, mass: 1)
  anim.property = _POPAnimatableProperty(name: _POPProperty.LayerOpacity.toRaw())
  anim.toValue = 0
  _POPAnimation.addAnimation(anim, key: anim.property.name, obj: view.layer)
````

--

####_POPProperty

`_POPProperty` is an `enum: String` that recreates POP's animatable property `NSString* const` keys, for use in Swift. I didn't port over all the keys POP supports. Sorry for any inconvenience this causes.

--

####Typealias

Take advantage of Swift's `typealias` to make the wrapper names more memorable/readable.

````Swift
typealias Animation = _POPAnimation
typealias SpringAnimation = _POPSpringAnimation
typealias DecayAnimation = _POPDecayAnimation
typealias BasicAnimation = _POPBasicAnimation
typealias AnimatableProperty = _POPAnimatableProperty
typealias MutableAnimatableProperty = _POPMutableAnimatableProperty
````

--

Coded by **Alec Larson** (@aleclarsoniv)
