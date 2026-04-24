# 🔐 Secrets Management Configuration

# This file contains secret configurations for Nixxin
# IMPORTANT: Never commit actual secrets to version control!
# Use this as a template for your own secrets.nix file

{
  # 📧 Email Configuration
  email = {
    # User email for Git and other services
    user = "your.email@example.com";

    # Email server settings (optional)
    smtp = {
      host = "smtp.example.com";
      port = 587;
      user = "your.email@example.com";
      # password = "your-app-password";  # Never store here!
    };
  };

  # 👤 User Information
  user = {
    name = "Your Name";
    username = "your-username";
    description = "Your Description";
  };

  # 🔑 API Keys and Tokens
  apiKeys = {
    # GitHub Personal Access Token
    github = "";

    # OpenAI API Key
    openai = "";

    # Anthropic API Key
    anthropic = "";

    # Other API keys...
    # example = "";
  };

  # 🌐 Network Configuration
  network = {
    # WiFi passwords (for known networks)
    wifi = {
      # "Network-SSID" = "password";
    };

    # VPN configurations
    vpn = {
      # provider = "mullvad";
      # username = "";
      # password = "";
    };
  };

  # 🎮 Gaming Accounts
  gaming = {
    # Steam credentials (optional)
    steam = {
      # username = "";
      # password = "";
    };

    # Epic Games
    epic = {
      # email = "";
      # password = "";
    };
  };

  # 🏠 Home Services
  services = {
    # Jellyfin API key
    jellyfin = "";

    # Plex token
    plex = "";

    # Nextcloud credentials
    nextcloud = {
      # url = "https://cloud.example.com";
      # username = "";
      # password = "";
    };
  };

  # 🤖 AI Services
  ai = {
    # Ollama configuration
    ollama = {
      # baseUrl = "http://localhost:11434";
      # models = ["llama2" "codellama"];
    };

    # Claude Code configuration
    claude = {
      # apiKey = "";
      # model = "claude-3-sonnet";
    };
  };

  # 🔧 Development Tools
  development = {
    # Docker Hub token
    dockerHub = "";

    # npm token
    npm = "";

    # PyPI token
    pypi = "";

    # SSH keys (reference only, never store actual keys)
    ssh = {
      # github = "~/.ssh/github_key";
      # gitlab = "~/.ssh/gitlab_key";
    };
  };

  # 🌍 Localization
  localization = {
    timezone = "America/New_York";
    locale = "en_US.UTF-8";
    keyboard = "us";
  };

  # 💾 Backup Configuration
  backup = {
    # Restic repository
    restic = {
      # repository = "sftp:user@backup.example.com:/backup";
      # password = "";
      # exclude = ["/home/user/.cache" "/home/user/.local/share/Trash"];
    };

    # Rclone configuration
    rclone = {
      # remote = "gdrive";
      # configPath = "/home/user/.config/rclone/rclone.conf";
    };
  };

  # 🖥️ Hardware Specific
  hardware = {
    # GPU configuration
    gpu = {
      # nvidia = {
      #   enable = true;
      #   prime = {
      #     intelBusId = "PCI:0:2:0";
      #     nvidiaBusId = "PCI:1:0:0";
      #   };
      # };
    };

    # Monitor configuration
    monitors = {
      # primary = "DP-1";
      # secondary = "HDMI-1";
    };
  };

  # 🎨 Theme Configuration
  theme = {
    # GTK theme
    gtk = "Adwaita-dark";

    # Qt theme
    qt = "Adwaita-dark";

    # Terminal theme
    terminal = "Catppuccin-Mocha";

    # Wallpaper
    wallpaper = "/home/user/Pictures/Wallpapers/default.jpg";
  };

  # 📱 Mobile Development
  mobile = {
    # Android SDK path
    androidSdk = "/home/user/Android/Sdk";

    # ADB configuration
    adb = {
      # serverPort = 5037;
      # keyPath = "/home/user/.android/adbkey";
    };
  };

  # 🔐 Security Settings
  security = {
    # GPG configuration
    gpg = {
      # defaultKey = "your-key-id";
      # keyserver = "keyserver.ubuntu.com";
    };

    # Password manager
    passwordManager = {
      # type = "bitwarden";  # or "keepassxc"
      # cliTool = "bw";       # or "keepassxc-cli"
    };
  };

  # 📊 Monitoring and Analytics
  monitoring = {
    # Prometheus configuration
    prometheus = {
      # apiKey = "";
      # endpoint = "https://prometheus.example.com";
    };

    # Grafana configuration
    grafana = {
      # apiKey = "";
      # url = "https://grafana.example.com";
    };
  };

  # 🌐 Social and Communication
  social = {
    # Discord token (for bots)
    discord = "";

    # Slack token
    slack = "";

    # Matrix configuration
    matrix = {
      # homeserver = "matrix.org";
      # username = "@user:matrix.org";
      # accessToken = "";
    };
  };

  # 🎵 Media Configuration
  media = {
    # Spotify configuration
    spotify = {
      # clientId = "";
      # clientSecret = "";
      # username = "";
      # password = "";
    };

    # YouTube API key
    youtube = "";

    # Plex configuration
    plex = {
      # serverUrl = "http://localhost:32400";
      # token = "";
    };
  };

  # 🛒 E-commerce and Subscriptions
  commerce = {
    # AWS credentials
    aws = {
      # accessKeyId = "";
      # secretAccessKey = "";
      # region = "us-east-1";
    };

    # DigitalOcean token
    digitalOcean = "";

    # GitHub Sponsors token
    githubSponsors = "";
  };

  # 🧪 Experimental Features
  experimental = {
    # Enable experimental modules
    enable = false;

    # Feature flags
    features = {
      # newDesktop = false;
      # aiIntegration = false;
      # cloudSync = false;
    };
  };
}
