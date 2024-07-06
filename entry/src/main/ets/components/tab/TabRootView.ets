import { CommonConstant } from '../../common/CommonConstant';
import { HomeRootView } from '../home/HomeRootView';

@Component
export struct TabRootView {
  @State tabItems: string[] = [
    '首页',
    '发现',
  ]
  @State currentTabIndex: number = 0;
  private controller: TabsController = new TabsController();

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      TabContent() {
        HomeRootView()
      }
      .width(CommonConstant.FULL_WIDTH)
      .tabBar(this.BuildTabBarItem(this.tabItems[0], 0))

      TabContent() {
        Column()
          .backgroundColor("#656")
          .width(CommonConstant.FULL_WIDTH)
          .height(CommonConstant.FULL_HEIGHT)
      }
      .width(CommonConstant.FULL_WIDTH)
      .tabBar(this.BuildTabBarItem(this.tabItems[1], 1))
    }
    .vertical(false)
    .scrollable(false)
    .onChange(index => {
      this.currentTabIndex = index;
    })
  }

  @Builder
  BuildTabBarItem(item: string, index: Number) {
    Column() {
      Text(item)
        .margin({ top: "4vp" })
        .fontSize(10)
        .fontColor(this.currentTabIndex == index ? Color.Black : Color.Gray)
    }
    .justifyContent(FlexAlign.Center)
    .width(CommonConstant.FULL_WIDTH)
  }
}