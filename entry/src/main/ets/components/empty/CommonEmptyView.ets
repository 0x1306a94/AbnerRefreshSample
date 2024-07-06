import { CommonConstant } from '../../common/CommonConstant';

@Component
export struct CommonEmptyView {
  image: Resource | string | null = null;
  message: string = '';

  build() {
    Column() {
      Column({ space: 10 }) {
        if (this.image) {
          Image(this.image)
            .size({ width: 160, height: 160 })
            .objectFit(ImageFit.Contain)
        }

        Text(this.message)
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .width(CommonConstant.FULL_WIDTH)
    }
    .justifyContent(FlexAlign.Center)
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
  }
}