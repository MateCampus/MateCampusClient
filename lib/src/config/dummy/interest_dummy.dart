import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';

import '../../business_logic/view_models/profile_viewmodel.dart';

List<InterestPresentation> interestDummy = [
  InterestPresentation(
      title: InterestData.iconOf(Interest(codeNum: InterestCode.interest0001)
              .codeNum
              .name) + //이렇게하는게 맞음
          " " +
          InterestData.korNameOf('interest0001'),
      status: InterestStatus.SAME),
  InterestPresentation(
      title: InterestData.iconOf('interest0002') +
          " " +
          InterestData.korNameOf('interest0002'),
      status: InterestStatus.DIFFERENT),
  InterestPresentation(
      title: InterestData.iconOf('interest0003') +
          " " +
          InterestData.korNameOf('interest0003'),
      status: InterestStatus.NONE),
  InterestPresentation(
      title: InterestData.iconOf('interest0004') +
          " " +
          InterestData.korNameOf('interest0004'),
      status: InterestStatus.SAME),
  InterestPresentation(
      title: InterestData.iconOf('interest0005') +
          " " +
          InterestData.korNameOf('interest0005'),
      status: InterestStatus.NONE),
  InterestPresentation(
      title: InterestData.iconOf('interest0006') +
          " " +
          InterestData.korNameOf('interest0006'),
      status: InterestStatus.SAME),
  InterestPresentation(
      title: InterestData.iconOf('interest0007') +
          " " +
          InterestData.korNameOf('interest0007'),
      status: InterestStatus.NONE),
  InterestPresentation(
      title: InterestData.iconOf('interest0008') +
          " " +
          InterestData.korNameOf('interest0008'),
      status: InterestStatus.DIFFERENT),
  InterestPresentation(
      title: InterestData.iconOf('interest0009') +
          " " +
          InterestData.korNameOf('interest0009'),
      status: InterestStatus.SAME),
  InterestPresentation(
      title: InterestData.iconOf('interest0010') +
          " " +
          InterestData.korNameOf('interest0010'),
      status: InterestStatus.NONE),
  InterestPresentation(
      title: InterestData.iconOf('interest0011') +
          " " +
          InterestData.korNameOf('interest0011'),
      status: InterestStatus.NONE),
  InterestPresentation(
      title: InterestData.iconOf('interest0012') +
          " " +
          InterestData.korNameOf('interest0012'),
      status: InterestStatus.SAME),
  InterestPresentation(
      title: InterestData.iconOf('interest0013') +
          " " +
          InterestData.korNameOf('interest0013'),
      status: InterestStatus.SAME),
  InterestPresentation(
      title: InterestData.iconOf('interest0014') +
          " " +
          InterestData.korNameOf('interest0014'),
      status: InterestStatus.NONE),
  InterestPresentation(
      title: InterestData.iconOf('interest0015') +
          " " +
          InterestData.korNameOf('interest0015'),
      status: InterestStatus.NONE),
  InterestPresentation(
      title: InterestData.iconOf('interest0016') +
          " " +
          InterestData.korNameOf('interest0016'),
      status: InterestStatus.DIFFERENT),
];
