
import QuartzCore

enum _POPProperty: String {
  case
  LayerBackgroundColor = "backgroundColor",
  LayerBounds = "bounds",
  LayerCornerRadius = "cornerRadius",
  LayerBorderWidth = "borderWidth",
  LayerBorderColor = "borderColor",
  LayerOpacity = "opacity",
  LayerPosition = "position",
  LayerPositionX = "positionX",
  LayerPositionY = "positionY",
  LayerRotation = "rotation",
  LayerRotationX = "rotationX",
  LayerRotationY = "rotationY",
  LayerScaleX = "scaleX",
  LayerScaleXY = "scaleXY",
  LayerScaleY = "scaleY",
  LayerSize = "size",
  LayerSubscaleXY = "subscaleXY",
  LayerSubtranslationX = "subtranslationX",
  LayerSubtranslationXY = "subtranslationXY",
  LayerSubtranslationY = "subtranslationY",
  LayerSubtranslationZ = "subtranslationZ",
  LayerTranslationX = "translationX",
  LayerTranslationXY = "translationXY",
  LayerTranslationY = "translationY",
  LayerTranslationZ = "translationZ",
  LayerZPosition = "zPosition",
  LayerShadowColor = "shadowColor",
  LayerShadowOffset = "shadowOffset",
  LayerShadowOpacity = "shadowOpacity",
  LayerShadowRadius = "shadowRadius",

  // CAShapeLayer
  ShapeLayerStrokeStart = "shapeLayer.strokeStart",
  ShapeLayerStrokeEnd = "shapeLayer.strokeEnd",
  ShapeLayerStrokeColor = "shapeLayer.strokeColor",

  // UIScrollView
  ScrollViewContentOffset = "scrollView.contentOffset",
  ScrollViewContentSize = "scrollView.contentSize",
  ScrollViewZoomScale = "scrollView.zoomScale",

  //UILabel
  LabelTextColor = "label.textColor"
}

enum _POPThreshold: CGFloat {
  case
  Color = 0.01,
  Point = 1.0,
  Scale = 0.005
}

//let POPThresholdOpacity = POPThresholdColor
//let POPThresholdRotation = POPThresholdColor
//let POPThresholdRadius = POPThresholdColor
