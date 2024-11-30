{ pkgs, ... }:
{
	fonts = {
		packages = with pkgs; [
			# ttf-jetbrains-mono-nerd
			# ttf-material-symbols-variable-git
			# ttf-readex-pro
			# ttf-space-mono-nerd
			font-awesome
			jetbrains-mono
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-emoji
			source-han-sans
			source-han-sans-japanese
			source-han-serif-japanese
			(nerdfonts.override { fonts = [ "Meslo" ]; }) # You can also override this with JetBrains Mono Nerd Font if desired
		];
		fontconfig = {
			enable = true;
			defaultFonts = {
				monospace = [ "JetBrains Mono" ];
				serif = [ "Noto Serif" "Source Han Serif" ];
				sansSerif = [ "Noto Sans" "Source Han Sans" ];
			};
		};
	};
}
