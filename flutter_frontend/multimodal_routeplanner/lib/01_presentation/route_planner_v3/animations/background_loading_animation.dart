import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

final List<Color> _mobiscoreColors = [
  lightColorA,
  lightColorB,
  lightColorC,
  lightColorD,
  lightColorE,
];

Animation<Color?> backgroundLoadingAnimation(AnimationController controller) {
  Animation<Color?> animation = TweenSequence<Color?>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: _mobiscoreColors[0], end: _mobiscoreColors[1]),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: _mobiscoreColors[1], end: _mobiscoreColors[2]),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: _mobiscoreColors[2], end: _mobiscoreColors[3]),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: _mobiscoreColors[3], end: _mobiscoreColors[4]),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: _mobiscoreColors[4], end: _mobiscoreColors[3]),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: _mobiscoreColors[3], end: _mobiscoreColors[2]),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: _mobiscoreColors[2], end: _mobiscoreColors[1]),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: _mobiscoreColors[1], end: _mobiscoreColors[0]),
      ),
    ],
  ).animate(controller);

  return animation;
}
