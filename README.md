# ZLConstraintViewController
xib中用AutoLayout设置约束时,只需控制器继承该类,所有约束自动以宽比例缩放或扩大,无需脱线

注:

1.UIScrollView中没有做适配,需要自己做适配,例如cell中,可以将建立ZLConstraintCell将方法直接复制进去

2.以宽做比例,特殊界面需要特殊计算,例如iphoneX

3.做不到绝对精准,可以计算damo中的尺寸是否符合你的要求
