# Debug The System

Here we will analyize some a three log files to find something wrong or not work correctly and want to be fixed, or something we could improve.

## How my nixos configs work? and what We want to do?

1. First in flake.nix we imported the `_settings.nix`
2. In `_settings.nix` we imported the Path of the user Profile that we want to apply his settings
3. Here is the User settings `users/softeng/desktop/HP/default.nix`
4. Here is the file where we imported all the modules that we want `users/softeng/desktop/HP/configuration.nix`
5. Here the user hardware configs file `users/softeng/desktop/HP/hardware.nix`
6. Here the user Home-Manager configs file `users/softeng/desktop/HP/home.nix`
7. We can enable/disable a spacific module when we set true/false in `users/softeng/desktop/HP/default.nix` also there are some settings for each module
8. In `modules/overclock` We trying to overclock the pc to get more performance
9. The `modules/graphics/default.nix` is the most important module for me, this is the module where all graphics/compute settings and packages exist, and also I use the compute with hashcat, like mesa opencl, and its work but it slow, I don't know why, there something make hashcast slow and lose 30% or 40% of the Performace/Speed and clvk doesn't work and gives me an error `clSetKernelArg(): CL_INVALID_ARG_VALUE`. also pocl doesn't work, In the past when I was work on the windows where radeon drivers on the hashcat speed was 24000 h/s and as you see its 12111 H/s. it so slow so there is something wrong, maybe because the drivers like mesa, amdgpu or the PC Mix RAMS make the A/B Channels now work correctly, or the APU Power, I realy doesn'y know.
10. You will find some useful logs about hashcat in `logs/hashcat_backend.log.txt` and `logs/hashcat.log.txt`
11. Here you will find the important system/boot configs `modules/system/*.nix`
12. Here you will find the power configs 4. `modules/power/*.nix`
13. I want you to understand the configs how it work and than we will read and analyize the log files like `logs/journalctl--system.log.txt` and `logs/journalctl--dmesg.log.txt` and `logs/dmesg.log.txt` so we can know the erros/warns and things that doens't work correctly and make the pc slow
14. As you know this is a desktop pc device it is not a laptop so we don't care about saving the power, All we care about is the **Performance**
15. While you working you can wrote a log/information and errors list, warns list and issues inside a `logs/log.md` or anything you want to save. and write everyting we must fix and change and if you have a soultion it would be nice to write it also in the `logs/log.md` don't edit directly the configs just read what you want to read.
