##Facebook POP for Swift

**What is this?** A wrapper for [Facebook POP](https://github.com/facebook/pop) written in Objective-C (whereas POP is written in Objective-C++)

**Why would I need this?** [Objective-C++ can't be imported into Swift](http://stackoverflow.com/a/24042893/2228559), as of June 24 2014.

--

####Example

````Swift
  // Create view to animate
  var view = UIView(frame: UIScreen.mainScreen().bounds)
  view.backgroundColor = UIColor.blueColor()
  
  // Create animation
  var anim = _POPSpringAnimation(tension: 100, friction: 10, mass: 1)
  anim.property = _POPAnimatableProperty(name: kPOPLayerOpacity)
  anim.toValue = 0
  _POPAnimation.addAnimation(anim, key: anim.property.name, obj: view.layer)
````

--

####Install

Add `#import "POPSwiftWrapper.h"` to the **.h** file pointed to under *Build Settings -> Swift Compiler - Code Generation -> Objective-C Bridging Header*.

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

I've added some class methods to `_POPAnimation` that implement POP's `NSObject` category. If you want, you can make a Swift extension on `NSObject` like POP does it, but these class methods allow `AnyObject` to be the associated object, which allows the animation of Swift object properties. In order to do this, a category on `POPAnimator` is required and can be found at the bottom of **POPSwiftWrapper.h**.

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
_POPAnimation.removeAnimationsForKey(kPOPLayerOpacity, obj: view.layer)
var keys = _POPAnimation.animationKeys(view.layer)
var anim = _POPAnimation(forKey: kPOPLayerOpacity, obj: view.layer)
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

####POPProperty.swift

This file provides POP's property keys (eg: `kPOPLayerBounds`) as Swift constant `String`s. You can also access POP's threshold values through `kPOPThresholdColor`, `kPOPThresholdPoint`, and `kPOPThresholdScale`.

Note: I didn't port all POP-supported property keys. Sorry for any inconvenience!

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

Created by **Alec Larson** (@aleclarsoniv)
