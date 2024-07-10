import { CommonConstant } from '../common/CommonConstant';

@Entry
@Component
export struct LoginPage {
  @State message: string = 'Login Page';
  @Consume('pageStack') pageStack: NavPathStack
  build() {
    RelativeContainer() {
      Text(this.message)
        .id('LoginPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: CommonConstant.RELATIVE_CONTAINER, align: VerticalAlign.Center },
          middle: { anchor: CommonConstant.RELATIVE_CONTAINER, align: HorizontalAlign.Center }
        })
    }
    .height(CommonConstant.FULL_WIDTH)
    .width(CommonConstant.FULL_HEIGHT)
    .backgroundColor(Color.Grey)
  }
}