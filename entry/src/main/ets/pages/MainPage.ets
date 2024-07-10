import { CommonConstant } from '../common/CommonConstant';

@Entry
@Component
export struct MainPage {
  @State message: string = 'Main Page';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('MainPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          top: { anchor: CommonConstant.RELATIVE_CONTAINER, align: VerticalAlign.Top },
          middle: { anchor: CommonConstant.RELATIVE_CONTAINER, align: HorizontalAlign.Center }
        })
    }
    .height(CommonConstant.FULL_WIDTH)
    .width(CommonConstant.FULL_HEIGHT)
    .backgroundColor(Color.Grey)
  }
}