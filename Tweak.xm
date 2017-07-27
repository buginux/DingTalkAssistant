#include <dlfcn.h>
#import "MenuWindow/WBAssistantManager.h"

%hook DTAppDelegate 

- (void)applicationDidBecomeActive:(id)arg1 {
	%orig;

	[[WBAssistantManager sharedManager] showMenu];
}

%end
