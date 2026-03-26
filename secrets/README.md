# 🔐 Secrets Management

This directory contains sensitive configuration for your Nixxin setup.

## 🚨 IMPORTANT SECURITY NOTES

### ⚠️ **NEVER** commit actual secrets to version control!

This file should contain only templates and examples. Your actual secrets should be:

1. **Stored in a secure location** (not in this repository)
2. **Encrypted** if possible
3. **Backed up securely**
4. **Access-controlled**

## 📁 File Structure

```
secrets/
├── default.nix          # Template file (this repo)
├── secrets.nix          # Your actual secrets (DO NOT COMMIT)
├── .gitignore           # Prevents committing secrets
└── README.md           # This file
```

## 🔧 Setup Instructions

### 1. Create Your Personal Secrets File

```bash
# Copy the template
cp secrets/default.nix secrets/secrets.nix

# Edit with your actual information
nano secrets/secrets.nix
```

### 2. Configure Git to Ignore Secrets

```bash
# Ensure secrets are ignored
echo "secrets/secrets.nix" >> .gitignore
echo "secrets/*.key" >> .gitignore
echo "secrets/*.pem" >> .gitignore
echo "secrets/*.json" >> .gitignore
```

### 3. Set Up Secure Permissions

```bash
# Restrict file permissions
chmod 600 secrets/secrets.nix
chmod 700 secrets/
```

## 🔐 Best Practices

### ✅ **DO:**
- Use environment variables for sensitive data
- Store passwords in a password manager
- Use SSH keys instead of passwords
- Rotate secrets regularly
- Use different secrets for different environments

### ❌ **DON'T:**
- Commit secrets to version control
- Share secrets via email or chat
- Use the same password everywhere
- Store secrets in plain text files
- Hard-code secrets in scripts

## 🔧 Usage Examples

### In Your Configuration

```nix
# configuration.nix
{ config, pkgs, ... }:

let
  secrets = import ../secrets/secrets.nix;
in {
  # Use secrets in your configuration
  users.users.${secrets.user.username} = {
    isNormalUser = true;
    description = secrets.user.description;
    email = secrets.email.user;
  };

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      user.name = secrets.user.name;
      user.email = secrets.email.user;
    };
  };

  # AI services configuration
  services.ollama = {
    enable = true;
    host = secrets.ai.ollama.baseUrl or "127.0.0.1";
    port = 11434;
  };
}
```

### Environment Variables

```bash
# Create a script to load secrets
cat > ~/.config/nixxin/load-secrets.sh << 'EOF'
#!/bin/bash
export GITHUB_TOKEN="$(jq -r '.apiKeys.github' ~/.config/nixxin/secrets/secrets.nix)"
export OPENAI_API_KEY="$(jq -r '.apiKeys.openai' ~/.config/nixxin/secrets/secrets.nix)"
export ANTHROPIC_API_KEY="$(jq -r '.apiKeys.anthropic' ~/.config/nixxin/secrets/secrets.nix)"
EOF

chmod +x ~/.config/nixxin/load-secrets.sh
```

## 🔍 Secret Management Tools

### 1. **Age** (Recommended)

```bash
# Install age
nix-env -iA nixpkgs.age

# Encrypt secrets
age -r $(cat ~/.config/nixxin/pubkey.txt) -o secrets/secrets.nix.age secrets/secrets.nix

# Decrypt during rebuild
age -d -i ~/.config/nixxin/key.txt secrets/secrets.nix.age > /tmp/secrets.nix
```

### 2. **SOPS** (Secrets OPerationS)

```bash
# Install sops
nix-env -iA nixpkgs.sops

# Encrypt with GPG
sops --encrypt --kms 'arn:aws:kms:...' secrets/secrets.nix > secrets/secrets.nix.enc

# Decrypt in configuration
sops --decrypt secrets/secrets.nix.enc > /run/secrets.nix
```

### 3. **Pass** (Password Manager)

```bash
# Store secrets in pass
pass insert nixxin/github-token
pass insert nixxin/openai-key

# Use in configuration
githubToken = "$(pass nixxin/github-token)";
```

## 🔄 Automatic Secret Loading

### Systemd Service

```nix
# Create a service to load secrets
systemd.services.load-secrets = {
  description = "Load Nixxin secrets";
  serviceConfig = {
    Type = "oneshot";
    RemainAfterExit = true;
    ExecStart = "${pkgs.bash}/bin/bash ${./load-secrets.sh}";
  };
  wantedBy = ["multi-user.target"];
};
```

### Home Manager Integration

```nix
# home.nix
{ config, pkgs, ... }:

let
  secrets = import ../secrets/secrets.nix;
in {
  # Environment variables
  home.sessionVariables = {
    GITHUB_TOKEN = secrets.apiKeys.github;
    OPENAI_API_KEY = secrets.apiKeys.openai;
  };

  # Configuration files
  home.file.".config/github/config".text = ''
    token = ${secrets.apiKeys.github}
  '';
}
```

## 🚨 Emergency Procedures

### If Secrets Are Committed

1. **Immediately revoke** all exposed tokens/keys
2. **Rotate** all compromised secrets
3. **Remove** from git history:
   ```bash
   git filter-branch --force --index-filter \
     'git rm --cached --ignore-unmatch secrets/secrets.nix' \
     --prune-empty --tag-name-filter cat -- --all
   ```
4. **Force push** cleaned history
5. **Change** all related passwords

### Backup and Recovery

```bash
# Create encrypted backup
tar -czf - secrets/ | age -r $(cat ~/.config/nixxin/pubkey.txt) > secrets-backup.tar.gz.age

# Restore backup
age -d -i ~/.config/nixxin/key.txt secrets-backup.tar.gz.age | tar -xzf -
```

## 📞 Getting Help

- **Security Issues**: Report privately to maintainers
- **Best Practices**: Consult NixOS security guidelines
- **Tools Documentation**: Read tool-specific documentation

---

**🔐 Remember: Security is everyone's responsibility!**
