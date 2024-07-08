import { CommonConstant } from '../common/CommonConstant';
import { matrix4 } from '@kit.ArkUI';

const ProfileHeaderHeight: number = 240;

@Component
struct ProfileHeader {
  build() {
    Stack() {
      Image($r('app.media.show_bg_top'))
        .objectFit(ImageFit.Cover)
        .width(CommonConstant.FULL_WIDTH)
        .height(CommonConstant.FULL_HEIGHT)
    }
    .backgroundColor(Color.Yellow)
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
    .alignRules({
      left: {
        anchor: CommonConstant.RELATIVE_CONTAINER,
        align: HorizontalAlign.Start,
      },
      top: {
        anchor: CommonConstant.RELATIVE_CONTAINER,
        align: VerticalAlign.Top,
      }
    })
  }
}

@Entry
@Component
struct Profile {
  @State headerDynamicHeight: number = ProfileHeaderHeight + 20;
  @State headerTransform: matrix4.Matrix4Transit = matrix4.identity();
  private scroller: Scroller = new Scroller();

  build() {
    RelativeContainer() {
      ProfileHeader()
        .id("ProfileHeader")
        .width(CommonConstant.FULL_WIDTH)
        .height(this.headerDynamicHeight)
        .transform(this.headerTransform)
      // .offset({ y: this.headerDynamicHeight });

      Scroll(this.scroller) {
        Column() {
          Row() {
            // passthrough
          }
          .width(CommonConstant.FULL_WIDTH)
          .height(ProfileHeaderHeight)

          Row() {

          }
          .backgroundColor(Color.Brown)
          .width(CommonConstant.FULL_WIDTH)
          .height('30%')
          .borderRadius({ topLeft: 10, topRight: 10 })

          Row() {

          }
          .backgroundColor(Color.Pink)
          .width(CommonConstant.FULL_WIDTH)
          .height('20%')

          Row() {

          }
          .backgroundColor(Color.Black)
          .width(CommonConstant.FULL_WIDTH)
          .height('30%')

          Row() {

          }
          .backgroundColor(Color.Blue)
          .width(CommonConstant.FULL_WIDTH)
          .height('40%')
        }

      }
      .id("Scroll")
      .backgroundColor(Color.Transparent)
      .width(CommonConstant.FULL_WIDTH)
      .height(CommonConstant.FULL_HEIGHT)
      .edgeEffect(EdgeEffect.Spring)
      .onScroll((x: number, y: number) => {
        const currentOffset = this.scroller.currentOffset();
        console.debug(`offset y: ${currentOffset.yOffset}`);

        if (currentOffset.yOffset < 0) {
          this.headerDynamicHeight = ProfileHeaderHeight + 20 + Math.abs(currentOffset.yOffset);
          // let transform = matrix4.identity();
          // let scale = ((ProfileHeaderHeight + Math.abs(currentOffset.yOffset)) / ProfileHeaderHeight); // + 0.06;
          // transform = transform.scale({ x: scale, y: scale, centerX: 0.5, centerY: 0 });
          // this.headerTransform = transform;
        } else {
          this.headerDynamicHeight = ProfileHeaderHeight + 20;
          // this.headerTransform = matrix4.identity();
        }
      })
    }
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
  }
}