%group JustSettings
NSInteger pageStyle = 0;
%hook YTRightNavigationButtons
%property (strong, nonatomic) YTQTMButton *truffleButton;
-(NSMutableArray *)buttons {
    NSMutableArray *retVal = %orig.mutableCopy;
    [self.truffleButton removeFromSuperview];
    [self addSubview:self.truffleButton];
    if(!self.truffleButton || pageStyle != [%c(YTPageStyleController) pageStyle]) {
        self.truffleButton = [%c(YTQTMButton) iconButton];
        self.truffleButton.frame = CGRectMake(0, 0, 40, 40);
        
        if([%c(YTPageStyleController) pageStyle]) { //dark mode
            [self.truffleButton setImage:[UIImage imageWithContentsOfFile:@"/var/mobile/Library/Application Support/Truffle/trufflesettings-20@2x.png"] forState:UIControlStateNormal];
        }
        else { //light mode
            UIImage *image = [UIImage imageWithContentsOfFile:@"/var/mobile/Library/Application Support/iSponsorBlock/trufflesettings-20@2x.png"];
            image = [image imageWithTintColor:UIColor.blackColor renderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.truffleButton setImage:image forState:UIControlStateNormal];
            [self.truffleButton setTintColor:UIColor.blackColor];
        }
        pageStyle = [%c(YTPageStyleController) pageStyle];
        
        [self.truffleButton addTarget:self action:@selector(truffleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [retVal insertObject:self.truffleButton atIndex:0];
    }
    return retVal;
}
-(NSMutableArray *)visibleButtons {
    NSMutableArray *retVal = %orig.mutableCopy;
