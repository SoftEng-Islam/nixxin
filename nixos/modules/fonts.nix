{
	fonts = {
		packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		font-awesome
		source-han-sans
		source-han-sans-japanese
		source-han-serif-japanese
		jetbrains-mono
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
