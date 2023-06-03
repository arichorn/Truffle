#import <UIKit/UIKit.h>

%hook YouTubeLiveChatViewController

- (void)renderLiveChatMessage:(YTILiveChatMessage *)liveChatMessage
{
    %orig;

    // Add custom emoji support
    NSString *messageText = [liveChatMessage.snippet.displayMessage.text mutableCopy];
    messageText = [messageText stringByReplacingOccurrencesOfString:@":smile:" withString:@"😀"];
    messageText = [messageText stringByReplacingOccurrencesOfString:@":heart:" withString:@"❤️"];
    messageText = [messageText stringByReplacingOccurrencesOfString:@":thumbsup:" withString:@"👍"];
    messageText = [messageText stringByReplacingOccurrencesOfString:@":thumbsdown:" withString:@"👎"];

    liveChatMessage.snippet.displayMessage.text = messageText;
}

%end

%hook YouTubeLiveChatViewController

- (void)reloadData {
    %orig;
    // remove profile pictures from the chat
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"YTILiveChatCellView")]) {
            UIView *subView = [view.subviews objectAtIndex:0];
            for (UIView *subSubView in subView.subviews) {
                if ([subSubView isKindOfClass:NSClassFromString(@"YTIProfilePictureView")]) {
                    subSubView.hidden = YES;
                }
            }
        }
    }
}

%end
