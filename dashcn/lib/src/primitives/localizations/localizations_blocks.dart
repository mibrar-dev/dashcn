// Shared blocks/flows/starters chrome for [ComponentLocalizations].

/// Shared blocks, flows and starters chrome for [ComponentLocalizations].
///
/// Applied by `ComponentLocalizations`; every getter has an English default and
/// translated locale tables may override it. Blocks, flows and starters reuse
/// these keys for their buttons, labels, titles and empty states; demo data
/// (names, messages, amounts, timestamps) stays English sample content.
mixin ComponentLocalizationsBlocks {
  /// Blocks, flows and starters string: Don't have an account?
  String get blockDontHaveAccount => 'Don\'t have an account?';

  /// Blocks, flows and starters string: Already have an account?
  String get blockAlreadyHaveAccount => 'Already have an account?';

  /// Blocks, flows and starters string: No account yet?
  String get blockNoAccountYet => 'No account yet?';

  /// Blocks, flows and starters string: Have an account?
  String get blockHaveAnAccount => 'Have an account?';

  /// Blocks, flows and starters string: Create one
  String get blockCreateOne => 'Create one';

  /// Blocks, flows and starters string: Create account
  String get blockCreateAccount => 'Create account';

  /// Blocks, flows and starters string: Create your account
  String get blockCreateYourAccount => 'Create your account';

  /// Blocks, flows and starters string: Forgot your password?
  String get blockForgotYourPassword => 'Forgot your password?';

  /// Blocks, flows and starters string: Back to sign in
  String get blockBackToSignIn => 'Back to sign in';

  /// Blocks, flows and starters string: Enter your credentials to access your workspace.
  String get blockEnterCredentialsWorkspace =>
      'Enter your credentials to access your workspace.';

  /// Blocks, flows and starters string: Enter your credentials to continue.
  String get blockEnterCredentialsContinue =>
      'Enter your credentials to continue.';

  /// Blocks, flows and starters string: Enter your details below to continue.
  String get blockEnterDetailsContinue =>
      'Enter your details below to continue.';

  /// Blocks, flows and starters string: Enter your email below to create your account.
  String get blockEnterEmailCreateAccount =>
      'Enter your email below to create your account.';

  /// Blocks, flows and starters string: Signed in — welcome back.
  String get blockSignedInWelcomeBack => 'Signed in — welcome back.';

  /// Blocks, flows and starters string: Account created — check your inbox to verify it.
  String get blockAccountCreatedVerify =>
      'Account created — check your inbox to verify it.';

  /// Blocks, flows and starters string: Trial started — check your inbox to verify it.
  String get blockTrialStartedVerify =>
      'Trial started — check your inbox to verify it.';

  /// Blocks, flows and starters string: Passwords do not match.
  String get blockPasswordsDoNotMatch => 'Passwords do not match.';

  /// Blocks, flows and starters string: Current password
  String get blockCurrentPassword => 'Current password';

  /// Blocks, flows and starters string: New password
  String get blockNewPassword => 'New password';

  /// Blocks, flows and starters string: Confirm new password
  String get blockConfirmNewPassword => 'Confirm new password';

  /// Blocks, flows and starters string: Update password
  String get blockUpdatePassword => 'Update password';

  /// Blocks, flows and starters string: Password updated.
  String get blockPasswordUpdated => 'Password updated.';

  /// Blocks, flows and starters string: At least 8 characters. Changing it signs you out elsewhere.
  String get blockPasswordHintChange =>
      'At least 8 characters. Changing it signs you out elsewhere.';

  /// Blocks, flows and starters string: Username
  String get blockUsername => 'Username';

  /// Blocks, flows and starters string: Lowercase letters, digits, underscores.
  String get blockUsernameHint => 'Lowercase letters, digits, underscores.';

  /// Blocks, flows and starters string: Your avatar
  String get blockYourAvatar => 'Your avatar';

  /// Blocks, flows and starters string: Upload image
  String get blockUploadImage => 'Upload image';

  /// Blocks, flows and starters string: Bio
  String get blockBio => 'Bio';

  /// Blocks, flows and starters string: Tell us a little bit about yourself
  String get blockBioHint => 'Tell us a little bit about yourself';

  /// Blocks, flows and starters string: Up to 160 characters.
  String get blockBioCounterHint => 'Up to 160 characters.';

  /// Blocks, flows and starters string: Profile saved.
  String get blockProfileSaved => 'Profile saved.';

  /// Blocks, flows and starters string: Save changes
  String get blockSaveChanges => 'Save changes';

  /// Blocks, flows and starters string: Invite member
  String get blockInviteMember => 'Invite member';

  /// Blocks, flows and starters string: Admin
  String get blockRoleAdmin => 'Admin';

  /// Blocks, flows and starters string: Owner
  String get blockRoleOwner => 'Owner';

  /// Blocks, flows and starters string: Member
  String get blockRoleMember => 'Member';

  /// Blocks, flows and starters string: Team
  String get blockTeam => 'Team';

  /// Blocks, flows and starters string: Profile
  String get blockProfile => 'Profile';

  /// Blocks, flows and starters string: Sign in with email
  String get blockSignInWithEmail => 'Sign in with email';

  /// Blocks, flows and starters string: Sign up
  String get blockSignUp => 'Sign up';

  /// Blocks, flows and starters string: Pick the way you prefer.
  String get blockPickWayYouPrefer => 'Pick the way you prefer.';

  /// Blocks, flows and starters string: Continue with $provider
  String blockContinueWith(Object? provider) => 'Continue with $provider';

  /// Blocks, flows and starters string: Creating…
  String get blockCreating => 'Creating…';

  /// Blocks, flows and starters string: Signing in…
  String get blockSigningIn => 'Signing in…';

  /// Blocks, flows and starters string: Sending…
  String get blockSending => 'Sending…';

  /// Blocks, flows and starters string: Saving…
  String get blockSaving => 'Saving…';

  /// Blocks, flows and starters string: Paying…
  String get blockPaying => 'Paying…';

  /// Blocks, flows and starters string: Send reset link
  String get blockSendResetLink => 'Send reset link';

  /// Blocks, flows and starters string: Reset password
  String get blockResetPassword => 'Reset password';

  /// Blocks, flows and starters string: Reset link sent. Check your inbox to continue.
  String get blockResetLinkSent =>
      'Reset link sent. Check your inbox to continue.';

  /// Blocks, flows and starters string: We will email you a reset link.
  String get blockWeWillEmailReset => 'We will email you a reset link.';

  /// Blocks, flows and starters string: You must accept the terms to continue.
  String get blockMustAcceptTerms => 'You must accept the terms to continue.';

  /// Blocks, flows and starters string: Check your inbox
  String get blockCheckInbox => 'Check your inbox';

  /// Blocks, flows and starters string: Enter the 6-digit code we sent you.
  String get blockEnterSixDigitCode => 'Enter the 6-digit code we sent you.';

  /// Blocks, flows and starters string: Code verified. You are signed in.
  String get blockCodeVerifiedSignedIn => 'Code verified. You are signed in.';

  /// Blocks, flows and starters string: Email verified — you are all set.
  String get blockEmailVerifiedSet => 'Email verified — you are all set.';

  /// Blocks, flows and starters string: Verify your email
  String get blockVerifyYourEmail => 'Verify your email';

  /// Blocks, flows and starters string: We sent a six-digit code to $email.
  String blockWeSentCodeTo(Object? email) =>
      'We sent a six-digit code to $email.';

  /// Blocks, flows and starters string: Didn't get the code?
  String get blockDidntGetCode => 'Didn\'t get the code?';

  /// Blocks, flows and starters string: Back
  String get blockBack => 'Back';

  /// Blocks, flows and starters string: Back to cart
  String get blockBackToCart => 'Back to cart';

  /// Blocks, flows and starters string: Back to settings
  String get blockBackToSettings => 'Back to settings';

  /// Blocks, flows and starters string: One account for everything.
  String get blockOneAccountEverything => 'One account for everything.';

  /// Blocks, flows and starters string: Start your 14-day trial. No credit card required.
  String get blockStartTrialNoCard =>
      'Start your 14-day trial. No credit card required.';

  /// Blocks, flows and starters string: Notifications
  String get blockNotifications => 'Notifications';

  /// Blocks, flows and starters string: Choose what you want to hear about, and where.
  String get blockNotifChoose =>
      'Choose what you want to hear about, and where.';

  /// Blocks, flows and starters string: Email notifications
  String get blockEmailNotifications => 'Email notifications';

  /// Blocks, flows and starters string: Push notifications
  String get blockPushNotifications => 'Push notifications';

  /// Blocks, flows and starters string: Mentions and replies
  String get blockMentionsReplies => 'Mentions and replies';

  /// Blocks, flows and starters string: Delivered to your devices
  String get blockDeliveredToDevices => 'Delivered to your devices';

  /// Blocks, flows and starters string: Email · $channel
  String blockEmailChannel(Object? channel) => 'Email · $channel';

  /// Blocks, flows and starters string: Push · $channel
  String blockPushChannel(Object? channel) => 'Push · $channel';

  /// Blocks, flows and starters string: Quiet hours
  String get blockQuietHours => 'Quiet hours';

  /// Blocks, flows and starters string: Weekly digest
  String get blockWeeklyDigest => 'Weekly digest';

  /// Blocks, flows and starters string: One email every Monday with everything that happened.
  String get blockWeeklyDigestBlurb =>
      'One email every Monday with everything that happened.';

  /// Blocks, flows and starters string: Preferences saved.
  String get blockPreferencesSaved => 'Preferences saved.';

  /// Blocks, flows and starters string: Save preferences
  String get blockSavePreferences => 'Save preferences';

  /// Blocks, flows and starters string: Reset
  String get blockReset => 'Reset';

  /// Blocks, flows and starters string: Welcome aboard
  String get blockWelcomeAboard => 'Welcome aboard';

  /// Blocks, flows and starters string: A quick tour before you start using the app.
  String get blockQuickTour => 'A quick tour before you start using the app.';

  /// Blocks, flows and starters string: Stay in the loop
  String get blockStayInLoop => 'Stay in the loop';

  /// Blocks, flows and starters string: Messages and updates arrive the moment they happen.
  String get blockMessagesArriveMoment =>
      'Messages and updates arrive the moment they happen.';

  /// Blocks, flows and starters string: Never miss a thing
  String get blockNeverMissThing => 'Never miss a thing';

  /// Blocks, flows and starters string: We only send what matters: replies, reminders and security alerts. You can change this later.
  String get blockNotifPermissionBlurb =>
      'We only send what matters: replies, reminders and security alerts. You can change this later.';

  /// Blocks, flows and starters string: Enable notifications?
  String get blockEnableNotifications => 'Enable notifications?';

  /// Blocks, flows and starters string: Allow notifications
  String get blockAllowNotifications => 'Allow notifications';

  /// Blocks, flows and starters string: Allow notifications to get the most out of the app.
  String get blockAllowNotificationsBlurb =>
      'Allow notifications to get the most out of the app.';

  /// Blocks, flows and starters string: Not now
  String get blockNotNow => 'Not now';

  /// Blocks, flows and starters string: Skip
  String get blockSkip => 'Skip';

  /// Blocks, flows and starters string: Get started
  String get blockGetStarted => 'Get started';

  /// Blocks, flows and starters string: Messages
  String get blockMessages => 'Messages';

  /// Blocks, flows and starters string: No conversations
  String get blockNoConversations => 'No conversations';

  /// Blocks, flows and starters string: Pull to refresh or start a new chat.
  String get blockPullRefreshChat => 'Pull to refresh or start a new chat.';

  /// Blocks, flows and starters string: Mute
  String get blockMute => 'Mute';

  /// Blocks, flows and starters string: Muted
  String get blockMuted => 'Muted';

  /// Blocks, flows and starters string: Attach
  String get blockAttach => 'Attach';

  /// Blocks, flows and starters string: File
  String get blockAttachFile => 'File';

  /// Blocks, flows and starters string: Photo
  String get blockAttachPhoto => 'Photo';

  /// Blocks, flows and starters string: Write a message…
  String get blockWriteMessage => 'Write a message…';

  /// Blocks, flows and starters string: Your cart
  String get blockYourCart => 'Your cart';

  /// Blocks, flows and starters string: Add something you love first.
  String get blockAddSomethingFirst => 'Add something you love first.';

  /// Blocks, flows and starters string: Cart is empty
  String get blockCartEmpty => 'Cart is empty';

  /// Blocks, flows and starters string: Checkout
  String get blockCheckout => 'Checkout';

  /// Blocks, flows and starters string: Qty $quantity
  String blockQty(int quantity) => 'Qty $quantity';

  /// Blocks, flows and starters string: Pay $amount
  String blockPayTotal(Object? amount) => 'Pay $amount';

  /// Blocks, flows and starters string: Payment
  String get blockPayment => 'Payment';

  /// Blocks, flows and starters string: Card number
  String get blockCardNumber => 'Card number';

  /// Blocks, flows and starters string: Expiry
  String get blockExpiry => 'Expiry';

  /// Blocks, flows and starters string: CVC
  String get blockCvc => 'CVC';

  /// Blocks, flows and starters string: Delivery address
  String get blockDeliveryAddress => 'Delivery address';

  /// Blocks, flows and starters string: Street
  String get blockStreet => 'Street';

  /// Blocks, flows and starters string: City
  String get blockCity => 'City';

  /// Blocks, flows and starters string: Save and continue
  String get blockSaveAndContinue => 'Save and continue';

  /// Blocks, flows and starters string: Order placed
  String get blockOrderPlaced => 'Order placed';

  /// Blocks, flows and starters string: Thanks for shopping with us. A confirmation is on its way.
  String get blockOrderThanks =>
      'Thanks for shopping with us. A confirmation is on its way.';

  /// Blocks, flows and starters string: Continue shopping
  String get blockContinueShopping => 'Continue shopping';

  /// Blocks, flows and starters string: Schedule
  String get blockSchedule => 'Schedule';

  /// Blocks, flows and starters string: Pick a date range for your report.
  String get blockPickDateRangeReport => 'Pick a date range for your report.';

  /// Blocks, flows and starters string: Pick a date range
  String get blockPickDateRange => 'Pick a date range';

  /// Blocks, flows and starters string: tap another day to extend the range
  String get blockTapAnotherDay => 'tap another day to extend the range';

  /// Blocks, flows and starters string: Book a meeting
  String get blockBookMeeting => 'Book a meeting';

  /// Blocks, flows and starters string: Pick a day, then a time that suits you.
  String get blockPickDayTime => 'Pick a day, then a time that suits you.';

  /// Blocks, flows and starters string: Four slots left, 30 minutes each. Pick one.
  String get blockFourSlots => 'Four slots left, 30 minutes each. Pick one.';

  /// Blocks, flows and starters string: Picked $slot, 30 minutes.
  String blockPickedSlot(Object? slot) => 'Picked $slot, 30 minutes.';

  /// Blocks, flows and starters string: Overview
  String get blockOverview => 'Overview';

  /// Blocks, flows and starters string: Revenue, subscriptions and the most recent orders.
  String get blockRevenueOrdersBlurb =>
      'Revenue, subscriptions and the most recent orders.';

  /// Blocks, flows and starters string: Total revenue
  String get blockTotalRevenue => 'Total revenue';

  /// Blocks, flows and starters string: Subscriptions
  String get blockSubscriptions => 'Subscriptions';

  /// Blocks, flows and starters string: Sales
  String get blockSales => 'Sales';

  /// Blocks, flows and starters string: Revenue by month
  String get blockRevenueByMonth => 'Revenue by month';

  /// Blocks, flows and starters string: Recent sales
  String get blockRecentSales => 'Recent sales';

  /// Blocks, flows and starters string: View all
  String get blockViewAll => 'View all';

  /// Blocks, flows and starters string: Transactions
  String get blockTransactions => 'Transactions';

  /// Blocks, flows and starters string: Filter transactions
  String get blockFilterTransactions => 'Filter transactions';

  /// Blocks, flows and starters string: Customer
  String get blockCustomer => 'Customer';

  /// Blocks, flows and starters string: Amount
  String get blockAmount => 'Amount';

  /// Blocks, flows and starters string: Method
  String get blockMethod => 'Method';

  /// Blocks, flows and starters string: Status
  String get blockStatus => 'Status';

  /// Blocks, flows and starters string: Paid
  String get blockPaid => 'Paid';

  /// Blocks, flows and starters string: Pending
  String get blockPending => 'Pending';

  /// Blocks, flows and starters string: Refunded
  String get blockRefunded => 'Refunded';

  /// Blocks, flows and starters string: No transactions match "$query".
  String blockNoTransactions(Object? query) =>
      'No transactions match "$query".';

  /// Blocks, flows and starters string: $delta from last month
  String blockDeltaFromLastMonth(Object? delta) => '$delta from last month';

  /// Blocks, flows and starters string: Analytics
  String get blockAnalytics => 'Analytics';

  /// Blocks, flows and starters string: Sessions, devices and where the traffic came from.
  String get blockSessionsDevicesBlurb =>
      'Sessions, devices and where the traffic came from.';

  /// Blocks, flows and starters string: Search reports
  String get blockSearchReports => 'Search reports';

  /// Blocks, flows and starters string: Last 30 days
  String get blockLast30Days => 'Last 30 days';

  /// Blocks, flows and starters string: All devices
  String get blockAllDevices => 'All devices';

  /// Blocks, flows and starters string: Sessions
  String get blockSessions => 'Sessions';

  /// Blocks, flows and starters string: Users
  String get blockUsers => 'Users';

  /// Blocks, flows and starters string: Avg. session
  String get blockAvgSession => 'Avg. session';

  /// Blocks, flows and starters string: Bounce rate
  String get blockBounceRate => 'Bounce rate';

  /// Blocks, flows and starters string: Conversions
  String get blockConversions => 'Conversions';

  /// Blocks, flows and starters string: By device
  String get blockByDevice => 'By device';

  /// Blocks, flows and starters string: Desktop
  String get blockDesktop => 'Desktop';

  /// Blocks, flows and starters string: Mobile
  String get blockMobile => 'Mobile';

  /// Blocks, flows and starters string: Tablet
  String get blockTablet => 'Tablet';

  /// Blocks, flows and starters string: Direct
  String get blockDirect => 'Direct';

  /// Blocks, flows and starters string: Referral
  String get blockReferral => 'Referral';

  /// Blocks, flows and starters string: Social
  String get blockSocial => 'Social';

  /// Blocks, flows and starters string: Traffic sources
  String get blockTrafficSources => 'Traffic sources';

  /// Blocks, flows and starters string: Visitors
  String get blockVisitors => 'Visitors';

  /// Blocks, flows and starters string: Home
  String get blockHome => 'Home';

  /// Blocks, flows and starters string: Inbox
  String get blockInbox => 'Inbox';

  /// Blocks, flows and starters string: Calendar
  String get blockCalendar => 'Calendar';

  /// Blocks, flows and starters string: Compose
  String get blockCompose => 'Compose';

  /// Blocks, flows and starters string: Mark all read
  String get blockMarkAllRead => 'Mark all read';

  /// Blocks, flows and starters string: Starred
  String get blockStarred => 'Starred';

  /// Blocks, flows and starters string: Snoozed
  String get blockSnoozed => 'Snoozed';

  /// Blocks, flows and starters string: Unread
  String get blockUnread => 'Unread';

  /// Blocks, flows and starters string: Documents
  String get blockDocuments => 'Documents';

  /// Blocks, flows and starters string: Reports
  String get blockReports => 'Reports';

  /// Blocks, flows and starters string: Dashboard
  String get blockDashboard => 'Dashboard';

  /// Blocks, flows and starters string: Storage
  String get blockStorage => 'Storage';

  /// Blocks, flows and starters string: Navigation
  String get blockNavigation => 'Navigation';

  /// Blocks, flows and starters string: Shared with you
  String get blockSharedWithYou => 'Shared with you';

  /// Blocks, flows and starters string: Recent projects
  String get blockRecentProjects => 'Recent projects';

  /// Blocks, flows and starters string: Storage used
  String get blockStorageUsed => 'Storage used';

  /// Blocks, flows and starters string: Open
  String get blockOpen => 'Open';

  /// Blocks, flows and starters string: Live
  String get blockLive => 'Live';

  /// Blocks, flows and starters string: Members
  String get blockMembers => 'Members';

  /// Blocks, flows and starters string: Projects
  String get blockProjects => 'Projects';

  /// Blocks, flows and starters string: Deploys
  String get blockDeploys => 'Deploys';

  /// Blocks, flows and starters string: Activity
  String get blockActivity => 'Activity';

  /// Blocks, flows and starters string: Recent files
  String get blockRecentFiles => 'Recent files';

  /// Blocks, flows and starters string: Usage this month
  String get blockUsageThisMonth => 'Usage this month';

  /// Blocks, flows and starters string: Upgrade plan
  String get blockUpgradePlan => 'Upgrade plan';

  /// Blocks, flows and starters string: No matches for "$query".
  String blockNoMatches(Object? query) => 'No matches for "$query".';

  /// Blocks, flows and starters string: Workspaces
  String get blockWorkspaces => 'Workspaces';

  /// Blocks, flows and starters string: Pricing
  String get blockPricing => 'Pricing';

  /// Blocks, flows and starters string: Plans that scale with you
  String get blockPlansScale => 'Plans that scale with you';

  /// Blocks, flows and starters string: Start free, upgrade when your team grows. Every plan includes the full component library and the theme presets.
  String get blockPlansBlurb =>
      'Start free, upgrade when your team grows. Every plan includes the full component library and the theme presets.';

  /// Blocks, flows and starters string: per user / month
  String get blockPerUserMonth => 'per user / month';

  /// Blocks, flows and starters string: Subscribe
  String get blockSubscribe => 'Subscribe';

  /// Blocks, flows and starters string: Contact sales
  String get blockContactSales => 'Contact sales';

  /// Blocks, flows and starters string: Promo code
  String get blockPromoCode => 'Promo code';

  /// Blocks, flows and starters string: Apply code
  String get blockApplyCode => 'Apply code';

  /// Blocks, flows and starters string: Have a code? Enter it below.
  String get blockHaveCodeEnter => 'Have a code? Enter it below.';

  /// Blocks, flows and starters string: Code applied — your discount shows at checkout.
  String get blockCodeAppliedDiscount =>
      'Code applied — your discount shows at checkout.';

  /// Blocks, flows and starters string: Questions
  String get blockFaqTitle => 'Questions';

  /// Blocks, flows and starters string: Can I change plans later?
  String get blockFaqChangePlans => 'Can I change plans later?';

  /// Blocks, flows and starters string: Yes. Upgrades apply immediately, downgrades next cycle.
  String get blockFaqChangePlansAnswer =>
      'Yes. Upgrades apply immediately, downgrades next cycle.';

  /// Blocks, flows and starters string: Is there a free trial?
  String get blockFaqFreeTrial => 'Is there a free trial?';

  /// Blocks, flows and starters string: Every plan starts with 14 days, no card required.
  String get blockFaqFreeTrialAnswer =>
      'Every plan starts with 14 days, no card required.';

  /// Blocks, flows and starters string: Account
  String get blockAccount => 'Account';

  /// Blocks, flows and starters string: General
  String get blockGeneral => 'General';

  /// Blocks, flows and starters string: Appearance
  String get blockAppearance => 'Appearance';

  /// Blocks, flows and starters string: Dark mode
  String get blockDarkMode => 'Dark mode';

  /// Blocks, flows and starters string: Preferences
  String get blockPreferences => 'Preferences';

  /// Blocks, flows and starters string: Sign out
  String get blockSignOut => 'Sign out';

  /// Blocks, flows and starters string: Sign out?
  String get blockSignOutConfirm => 'Sign out?';

  /// Blocks, flows and starters string: You can always sign back in later.
  String get blockSignOutBlurb => 'You can always sign back in later.';

  /// Blocks, flows and starters string: Sounds
  String get blockSounds => 'Sounds';

  /// Blocks, flows and starters string: What you get
  String get blockWhatYouGet => 'What you get';

  /// Blocks, flows and starters string: All component categories
  String get blockAllComponentCategories => 'All component categories';

  /// Blocks, flows and starters string: Priority support
  String get blockPrioritySupport => 'Priority support';

  /// Blocks, flows and starters string: Unlimited projects during the trial
  String get blockUnlimitedProjectsTrial =>
      'Unlimited projects during the trial';

  /// Blocks, flows and starters string: 14 days left in your trial
  String get blockTrialDaysLeft => '14 days left in your trial';

  /// Blocks, flows and starters string: Chat
  String get blockStarterChat => 'Chat';

  /// Blocks, flows and starters string: Shop
  String get blockStarterShop => 'Shop';

  /// Blocks, flows and starters string: Cart
  String get blockStarterCart => 'Cart';

  /// Blocks, flows and starters string: Add to cart
  String get blockAddToCart => 'Add to cart';
}
