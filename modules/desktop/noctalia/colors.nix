{ settings, ... }:
{
  # The Noctalia Shell Colors
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell = {
      colors = {
        mError = "#f7768e";
        mOnError = "#0f0f14";
        mOnPrimary = "#0f0f14";
        mOnSecondary = "#ffffff";
        mOnSurface = "#c0caf5";
        mOnSurfaceVariant = "#9aa5ce";
        mOnTertiary = "#0f0f14";
        mOnHover = "#ffffff";
        mOutline = "#414868";
        mPrimary = "#5dff90";
        mSecondary = "#eff79a";
        mShadow = "#000000";
        mSurface = "#1a1b26";
        mHover = "#292e42";
        mSurfaceVariant = "#24283b";
        mTertiary = "#7dcfff";
      };
    };
  };
}
