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
