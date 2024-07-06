import { ListView, RefreshController, RefreshDataSource, RefreshLayout, RefreshPositionEnum } from '@abner/refresh';

import { CommonEmptyView } from '../empty/CommonEmptyView';
import { CommonConstant } from '../../common/CommonConstant';


class HeaderData {
  category: string[] = ['测试1', '测试2', '测试3', '测试4', '测试5', '测试6', '测试7', '测试8',];
}

class HomeActivityListViewModel {
  private dataSource: RefreshDataSource = new RefreshDataSource();

  getDataSource(): RefreshDataSource {
    return this.dataSource;
  }

  loadData(callback: () => void) {
    setTimeout(() => {
      this.dataSource.deleteAll();
      let arr: number[] = []
      for (let index = 0; index < 15; index++) {
        arr.push(index);
      }
      this.dataSource.pushDataArray(arr);
      callback()
    }, 1.5 * 1000)
  }

  loadNextData(callback: () => void) {
    setTimeout(() => {
      const total = this.dataSource.totalCount();
      let arr: number[] = []
      for (let index = 0; index < 15; index++) {
        arr.push(index + total);
      }
      this.dataSource.pushDataArray(arr);
      callback()
    }, 1.5 * 1000)
  }
}

@Component
export struct HomeRootView {
  @State listNestedScroll?: NestedScrollOptions = undefined
  @State listPosition: RefreshPositionEnum = RefreshPositionEnum.TOP
  @State refreshPosition: RefreshPositionEnum = RefreshPositionEnum.TOP
  @State bannerHeaderH: number = 120;
  @State headerData: HeaderData | null = null;
  @Consume('NavPathStack') pageStack: NavPathStack;
  @State currentTabIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private refreshController: RefreshController = new RefreshController()
  private scroller: Scroller = new Scroller();
  private subViewModels: HomeActivityListViewModel[] = []

  aboutToAppear(): void {
    setTimeout(() => {
      let headerData = new HeaderData();
      this.subViewModels = headerData.category.map(_ => new HomeActivityListViewModel());
      this.headerData = headerData;
    }, 1000)
  }

  build() {
    Column() {
      RefreshLayout({
        itemLayout: () => {
          this.MainView()
        },
        controller: this.refreshController,
        refreshPosition: this.refreshPosition, //定位位置
        isRefreshSticky: true, //是否吸顶
        refreshStickyPosition: this.listPosition, //吸顶位置
        childScroller: this.scroller,
        onNestedScroll: (nestedScroll: NestedScrollOptions) => {
          this.listNestedScroll = nestedScroll
        },
        onRefresh: () => {
          if (this.subViewModels.length > 0) {
            this.subViewModels[this.currentTabIndex].loadData(() => {
              this.refreshController.finishRefresh()
            })
          }
        },
        onLoadMore: () => {
          if (this.subViewModels.length > 0) {
            this.subViewModels[this.currentTabIndex].loadData(() => {
              this.refreshController.finishLoadMore()
            })
          }
        }
      })
    }
    .backgroundColor("#f3f3f4")
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
  }

  @Builder
  BannerView() {
    Column() {
      Text('banner')
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.Brown)
    .size({ width: CommonConstant.FULL_WIDTH, height: this.bannerHeaderH })
  }

  @Builder
  MainView() {
    Scroll() {
      Column() {
        if (this.headerData) {
          this.BannerView()
          this.SubTabView()
        } else {
          this.EmptyView()
        }
      }
      .width(CommonConstant.FULL_WIDTH)
    }
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
    .scrollBar(BarState.Off)
    .friction(0.6)
    .onReachStart(() => {
      this.listPosition = RefreshPositionEnum.BOTTOM
    })
    .onScrollFrameBegin((offset: number, _: ScrollState) => {
      //设置起始位置，保障在顶部时，才能执行下拉刷新
      if (this.listPosition == RefreshPositionEnum.BOTTOM && offset <= 0) {
        return { offsetRemain: 0 }
      }
      this.listPosition = RefreshPositionEnum.CENTER
      return { offsetRemain: offset }
    })
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
  }

  @Builder
  SubTabView() {
    Tabs({ barPosition: BarPosition.Start, index: 0, controller: this.tabsController }) {
      if (this.headerData) {
        ForEach(this.headerData.category, (item: string, index: number) => {
          TabContent() {
            this.ListView(this.subViewModels[index])
          }
          .tabBar(this.SubTabBarView(item, index))

        }, (item: string, index: number) => item)
      }
    }
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
    .barMode(BarMode.Scrollable, { margin: 20, nonScrollableLayoutStyle: LayoutStyle.ALWAYS_CENTER })
    .vertical(false)
    .onChange((index) => {
      this.currentTabIndex = index;
    })
  }

  @Builder
  SubTabBarView(item: string, index: number) {
    Column() {
      Text(item)
        .fontSize(14)
        .fontColor(this.currentTabIndex == index ? Color.Black : Color.Gray)
        .margin({ right: 20 })
    }
    .justifyContent(FlexAlign.Center)
    .height(50)
  }

  @Builder
  ListItem(value: Object, index: number) {
    Column()
      .width(CommonConstant.FULL_WIDTH)
      .height(index == 0 ? 212 : 222)
      .backgroundColor('#686868')
      .margin({ top: index == 0 ? 10 : 0, bottom: 10 })
  }

  @Builder
  ListView(viewModel: HomeActivityListViewModel) {
    ListView({
      itemLayout: (value: Object, index: number) => {
        this.ListItem(value, index)
      },
      isLazyData: true,
      lazyDataSource: viewModel.getDataSource(),
      scroller: this.scroller,
      listNestedScroll: this.listNestedScroll,
      onListRefreshPosition: (position) => {
        this.refreshPosition = position
      },
    })
      .width(CommonConstant.FULL_WIDTH)
      .height(CommonConstant.FULL_HEIGHT)
      .backgroundColor(Color.White)
      .onAppear(() => {
        viewModel.loadData(() => {
        })
      })
  }

  @Builder
  EmptyView() {
    CommonEmptyView({
      image: $r('app.media.cm_def_empty'),
      message: 'empty data'
    })
      .width(CommonConstant.FULL_WIDTH)
      .layoutWeight(1)
  }
}