##Facebook POP for Swift

**Why?** Objective-C++ couldn't be imported into Swift. So I made a wrapper in Objective-C that you can `#import "POPSwiftWrapper.h"` in the file being pointed to by *Build Settings -> Objective-C Bridging Header*.

--

####Swift classes

I didn't wrap *every* POP class, as you will see. Here's a list of what I wrapped:

- POPAnimation **to** _POPAnimation
- POPPropertyAnimation **to** _POPPropertyAnimation
- POPSpringAnimation **to** _POPSpringAnimation
- POPBasicAnimation **to** _POPBasicAnimation
- POPDecayAnimation **to** _POPDecayAnimation
- POPAnimatableProperty **to** _POPAnimatableProperty
- POPMutableAnimatableProperty **to** _POPMutableAnimatableProperty
 
--

####_POPAnimationManager

I also introduce the class `_POPAnimationManager`, which implements POP's `NSObject` category. If you want, you can make a Swift extension on NSObject like POP does it, but `_POPAnimationManager` allows `AnyObject` to be the associated object, which allows the animation of Swift object properties.

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
  _POPAnimationManager.addAnimation(anim, key: anim.property.name, obj: view)
````

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

