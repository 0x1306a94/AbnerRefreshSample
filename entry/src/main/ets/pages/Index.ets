import { TabRootView } from '../components/tab/TabRootView';
import { CommonConstant } from '../common/CommonConstant';


@Entry
@Component
struct Index {
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageStack) {
      TabRootView()
    }
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
    .borderWidth(1)
    .borderColor('#00eeff')
    .hideTitleBar(true)
    .hideToolBar(true)
    .navBarPosition(NavBarPosition.Start)
    .mode(NavigationMode.Auto)
  }
}