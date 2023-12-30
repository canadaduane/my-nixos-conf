{ pkgs, user, ... }:

{
  users.users.${user} = {
    home = "/Users/${user}";
  };

  # Apple menu > System Preferences > Users and Groups > Login Options
  system.defaults.loginwindow = {
    # Allow users to login to the machine as guests using the Guest
    # account. Default is true.
    GuestEnabled = false;
  };

  security.pam.enableSudoTouchIdAuth = true;
}
