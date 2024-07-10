import { CommonConstant } from '../common/CommonConstant';
import { LoginPage } from './LoginPage';
import { MainPage } from './MainPage';

@Entry
@Component
struct NavigationPage {
  @Provide('pageStack') pageStack: NavPathStack = new NavPathStack();

  build() {
    Stack() {
      Navigation(this.pageStack) {
        Column({ space: 10 }) {
          Button('login')
            .onClick(_ => {
              let pathInfo: NavPathInfo = new NavPathInfo('loginPage', null)
              this.pageStack.pushPath(pathInfo, true);
            })

          Button('Main')
            .onClick(_ => {
              let pathInfo: NavPathInfo = new NavPathInfo('mainPage', null)
              this.pageStack.replacePath(pathInfo, true);
            })
        }
        .justifyContent(FlexAlign.Center)
        .width(CommonConstant.FULL_WIDTH)
        .height(CommonConstant.FULL_HEIGHT)
        .backgroundColor(Color.Gray)
        .expandSafeArea([SafeAreaType.SYSTEM, SafeAreaType.KEYBOARD], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      }
      .navDestination(this.PageMap)
      .width(CommonConstant.FULL_WIDTH)
      .height(CommonConstant.FULL_HEIGHT)
      .mode(NavigationMode.Stack)
      .titleMode(NavigationTitleMode.Free)
      .hideToolBar(true)
      .hideTitleBar(true)
    }
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
    .backgroundColor(Color.Brown)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  PageMap(name: string, param: object) {
    if (name === 'mainPage') {
      NavDestination() {
        MainPage()
      }
      .hideTitleBar(true)
      // .onBackPressed(() => true)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    } else if (name === "loginPage") {
      NavDestination() {
        LoginPage()
      }
      // .hideTitleBar(true)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
  }
}


