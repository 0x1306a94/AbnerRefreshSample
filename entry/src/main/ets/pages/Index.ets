import { CommonConstant } from '../common/CommonConstant';
import { router } from '@kit.ArkUI';


@Entry
@Component
struct Index {

  build() {
    Column({space: 10}) {
      Button('多级tab')
        .onClick((e) => {
          router.pushUrl({ url: 'pages/Multitab' });
        });

      Button('安全区域')
        .onClick((e) => {
          router.pushUrl({ url: 'pages/SafeArea' });
        });

      Button('个人主页')
        .onClick((e) => {
          router.pushUrl({ url: 'pages/Profile' });
        });

      Button('Navigation')
        .onClick((e) => {
          router.pushUrl({ url: 'pages/NavigationPage' });
        });
    }
    .justifyContent(FlexAlign.Center)
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
  }
}