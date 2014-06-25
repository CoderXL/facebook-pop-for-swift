##Facebook POP for Swift

**Why?** Objective-C++ couldn't be imported into Swift. So I made a wrapper in Objective-C that I, then, `#import "POPSwiftWrapper.h"` within my *Build Settings -> Objective-C Bridging Header*.

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
