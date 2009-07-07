John Siracusa: Programmer, writer for Ars Technica - 2009-07-01T20:49:03+10:00

### Who are you and what do you do?

I'm John Siracusa. I'm a programmer by day and a freelance [technology writer](http://arstechnica.com/authors/john-siracusa/ "A list of John's articles on Ars Technica.") by night (and weekends).

### What hardware do you use?

My main machine is a 2x2.8 GHz [Mac Pro][mac-pro] (Early 2008) with 8 GB of RAM, dual optical drives, an NVIDIA GeForce 8800 GT video card, and 3.5 TB of disk space spread over four internal drives: two 1 TB Western Digital Caviar Blacks, a 1 TB Samsung Spinpoint F1, and the 500GB Western Digital Caviar Blue that came with the Mac.

It's connected to a 23-inch Apple [Cinema display][cinema-display] (the model right before the 24-inch LED display was introduced) and Creative Labs [GigaWorks T40 Premium 2.0][gigaworks-t40] speakers, plus a separate subwoofer left over from an old set of Labtec speakers. I use the Apple aluminum keyboard that came with the Mac Pro and a [Logitech MX300][mx-300] mouse. (I haven't used an Apple mouse since the one that came with my [Performa 6110CD][performa-6110cd].) I've also got a tiny [i-rocks][] powered USB 2.0 hub.

The Mac is connected through a [D-Link DGS-2205][dgs-2205] 5-Port Gigabit Ethernet switch to an 802.11n [AirPort Extreme][airport-extreme] base station. (It's not the new dual-band model, unfortunately.) The AirPort, in turn, is connected to my gloriously symmetrical 20/20 Mbps [FiOS][] Internet connection. (I don't use the router that Verizon supplied; the AirPort connects directly to the FiOS [ONT](http://en.wikipedia.org/wiki/Optical_Network_Terminal#ONT "Wikipedia entry on ONT.") in the basement with 100 feet of Cat-6 cable.) An Epson [Stylus CX7800][stylus-cx7800] is also connected to the AirPort via USB.

The family laptop (ostensibly my wife's machine) is a 2.4 GHz 15-inch [MacBook Pro][macbook-pro] (Mid 2007) with 4 GB of RAM, a matte screen, and the stock 160 GB hard drive. It's intermittently connected via a FireWire 400 cable to a Western Digital Caviar 250 GB hard drive inside a Macally [PHR-100AF][] external drive enclosure.

Finally, I've got a 1G [iPod touch][ipod-touch] (16 GB), a 2G iPod touch (32 GB), a 1G [iPod shuffle][ipod-shuffle] (1 GB), a 2G iPod shuffle (1 GB), and a 3G [iPod][] (20 GB). I've also got a [Newton MessagePad 120][messagepad-120] on my desk as a decoration.

This is just the hardware that gets used on a daily basis. In the attic, I've got every Mac I've ever owned, all the way back to my original Mac 128k, in their original boxes, plus many, many more second-hand Macs and NeXT machines that I've acquired over the years, mostly from the [M.I.T swapfest](http://www.mitflea.com/ "The MIT flea markets site.").

One final hardware note. All those hard drives feed my paranoid backup regime. On the Mac Pro, the three 1 TB drives give me 1 TB of actual storage. I boot from and use the first drive, which is continuously backed up to the second drive using [Time Machine][time-machine]. All other volumes are unmounted until needed. I make a bootable backup of the first drive onto the third drive using [SuperDuper!][superduper] every few weeks. I also do an encrypted network backup using [Backblaze][]. (About 400 GB uploaded so far. FiOS!) The fourth drive is chopped up into several partitions for Boot Camp, prerelease OS installs, etc.

The laptop backup is simpler: periodic Time Machine backup to the 250 GB external drive via FireWire.

### And what software?

I do all of my programming and writing in [BBEdit][], which I've been using since version 2.1 (despite a brief dalliance with emacs when I was in college).

My second-most-frequently-typed-in application is [Terminal][]. It has few frills, but it gets the basics right: I can copy and paste long lines of text without incident, it supports UTF-8, "unlimited" scrollback length, bitmapped 9pt Monaco, and it never crashes. Sounds boring, but just try a few terminal emulators on other platforms to see how badly it can be botched.

For email, I use [Entourage][] which I've always viewed as the spiritual successor to [Claris Emailer][emailer], my first email love. I use it instead of Apple Mail because of its superior Exchange support (for work), its integrated calendar, which I use instead of [iCal][], and a huge number of little features: mailing list manager, custom columns on a per-folder basis, quote-aware text re-wrapping, etc.

My primary web browser has been [Safari][] since it was introduced, mostly due to the minimalist user interface and speed of non-rendering tasks (e.g., how long it takes to create a new, empty browser window). The fact that Safari 4 now also renders web pages and runs JavaScript lightning-fast is just icing on the cake for me. (I'm still sore about what they did to the reload button, however. I'm using the [Safari 4 Reload Fix][safari-4-reload-fix] hack for now.) [Firefox][] is my secondary browser, and my primary [JavaScript debugger][firebug]. I also have [Camino][], [OmniWeb][], [Opera][], and the latest Mac builds of [Chrome][] and [Chromium][] installed.

Despite having all those web browsers, I do [most of my web browsing](http://arstechnica.com/staff/fatbits/2005/09/1200.ars "John's Ars Technica article, 'The state of Mac web browsing'.") indirectly via RSS/Atom feeds inside [NetNewsWire][]. I use [Colloquy][] for IRC. For IM, I use [Adium][] with a custom Colloquy-look-alike message theme that I created when I came over from [Fire][] a few years ago. My Twitter client of choice is [Twitterrific][], on both the Mac and the iPod.

I've been reducing my system customizations in recent years, but there are a few that I can't live without. [WindowShade X][windowshade-x] is the most significant, as my sole remaining [APE][] module. So-called "haxies" [get a bad rap](http://arstechnica.com/staff/fatbits/2006/02/2918.ars "John's Arc Technica article, 'Paths in the grass'."), but I seriously don't know what I would do without WindowShade.

[Quicksilver][] is my next essential. I assign it to command-spacebar instead of Spotlight. (Quicksilver used that key-combination first, after all.) I use Quicksilver solely as an application/file launcher (okay, and clipboard history tracker), with the "Bezel" interface appearance. I've tried [LaunchBar][] and a few others, but I always come back to Quicksilver. I want my launcher to appear, react to my input, and disappear instantly. Quicksilver has always felt the snappiest to me. I also want the UI to be in the middle of the screen, not up in a corner or near the menu bar.

If I could avoid using the Dock entirely, I would. But there's still no other way to get notifications (bouncing icons) or see a icon badge updates. So in addition to the Dock, I run [DragThing][] with two docks: a "process dock" growing down from the upper right corner, a la Mac OS 9, and a "folder dock" in the lower right corner containing my most frequently accessed folders. (I find the way that the Leopard Dock handles folders so disagreeable that I no longer have any folders in my Dock.)

I still have [ASM][] installed, but I rarely use it directly these days. I keep it running mostly for its "Classic Window Mode" which brings all windows belonging to an application forward when you click on any one of them, but (and this is the important part) *shift*-click suppresses the behavior. It's the best of both worlds. DragThing has a similar feature, but for now I'm sticking with ASM for this.

I also have the excellent [iStat Menus][istat-menus] installed so I can see the freaking date next to the time in the menu bar.

[Dropbox][] is recent addition to my "essentials" list. It works the way iDisk always should have. [Yojimbo][] with [MobileMe][mobile-me] syncing is the other half of my machine-independent "Big Wad o' Stuff" system. Anything of interest that I encounter during the day but don't have time to look at gets dumped into either Dropbox or Yojimbo (or a MobileMe-synced NetNewsWire tab).

[MacFUSE][] with [sshfs][] has really helped take the pain out of mounting remote volumes in recent years.

I use [VMware Fusion][fusion] for work and play. It's an amazingly Mac-like application for a first-time Mac developer, and it's been rock-solid for me. I've also got Windows XP installed on a [Boot Camp][boot-camp] partition for gaming.

On my iPod, I mostly bounce between [Twitterrific][twitterrific-iphone], [Safari][safari-iphone], and (sadly) [Peggle][peggle-iphone]. (It was on sale for $0.99. I was powerless.)

Oh yeah, and what you're reading now was written (mostly) using MacSpeech [Dictate][]. A few decades of typing has left me with some significant [RSI](http://en.wikipedia.org/wiki/Repetitive_strain_injury "Wikipedia entry on RSI."), and speech recognition, for all its flaws and limitations, goes a long way towards mitigating the damage.

### What would be your dream setup?

My dream setup could be described as "more of what I already have." Bigger/more displays, more RAM, more hard disk space, a faster video card, faster network connection, etc. In particular, I really wanted to buy a 30-inch display with my Mac Pro, but couldn't bring myself to pay so much money for the "old" model with the [CCFL](http://en.wikipedia.org/wiki/Cold_cathode "Wikipedia entry on CCFL.") backlight. (Of course, here we are a year later and there's still no 30-inch LED-backlit Apple display.) I'd also like a big, fast pool of fault-tolerant network-attached storage hidden somewhere in my basement.

On the software side, I have [so many complaints](http://arstechnica.com/staff/fatbits/2009/05/hypercritical.ars "") about every application that I use, even (*especially*) the ones I love the most, it's hard to know where to begin. I guess I'd start with a version of NetNewsWire with much better syncing features. (Only MobileMe syncing will sync NetNewsWire browser tabs, and that feature is going away soon.) An arbitrary number of window splitters in BBEdit and Terminal would also be nice. That's just two off the top of my head, but I think I'd better stop there.

[mac-pro]: http://www.apple.com/macpro/ "The Intel-based Mac tower computer."
[cinema-display]: http://www.apple.com/displays/cinema/ "The LCD display line."
[gigaworks-t40]: http://www.amazon.com/gp/product/B00113V748 "Compact computer speakers."
[mx-300]: http://www.amazon.com/Logitech-930672-0403-300-Optical-Mouse/dp/B00006HMPJ "An optical mouse."
[performa-6110cd]: http://www.everymac.com/systems/apple/mac_performa/stats/mac_performa_6110cd.html "An old PPC-based Mac."
[i-rocks]: http://www.i-rocks.com/Product_List.aspx?CLASS_ID=1036 "A USB 2.0 hub."
[dgs-2205]: http://www.dlink.com/products/?pid=494 "5-port Gigabit switch."
[airport-extreme]: http://www.apple.com/airportextreme/ "A wireless access point."
[fios]: http://www.verizon.com/fios/ "Fibre optic Internet connection."
[stylus-cx7800]: http://www.epson.com/cgi-bin/Store/consumer/consDetail.jsp?BV_UseBVCookie=yes&oid=56291070&modeloid=58773&infoType=Overview "An all-in-one printer/copier/scanner."
[macbook-pro]: http://www.apple.com/macbookpro/ "The popular Intel-based Mac laptop."
[phr-100af]: http://www.macally.com/en/product/ArticleShow.asp?ArticleID=104 "An external Firewire hard drive enclosure."
[ipod-touch]: http://www.apple.com/ipodtouch/ "It's like an iPhone, without the phone bit."
[ipod-shuffle]: http://www.apple.com/ipodshuffle/ ""
[ipod]: http://www.apple.com/ipod/ "The infamous music player."
[messagepad-120]: http://www.everymac.com/systems/apple/messagepad/stats/newton_mp_120.html "A much-loved PDA device."
[time-machine]: http://www.apple.com/macosx/features/timemachine.html "Backup software for the masses, included with Mac OS X 10.5."
[superduper]: http://shirt-pocket.com/SuperDuper/SuperDuperDescription.html "An excellent Mac backup/cloning application."
[backblaze]: http://backblaze.com/internet-backup.html "Online backup."
[bbedit]: http://barebones.com/products/bbedit/ "A rather popular text editor for the Mac."
[terminal]: http://www.apple.com/macosx/technology/unix.html "The console application for OS X."
[entourage]: http://www.microsoft.com/mac/products/entourage2008/default.mspx "A Mac email client included with Office."
[emailer]: http://en.wikipedia.org/wiki/Claris_Emailer "A popular old email client for the Mac."
[ical]: http://www.apple.com/macosx/features/300.html#ical "Calendaring software included with Mac OS X."
[safari]: http://www.apple.com/safari/ "A fast web browser."
[safari-4-reload-fix]: http://earthlingsoft.net/ssp/tidbits/#safari4reloadfix "A hack to change the 'Add Bookmark' button into a 'Reload' button."
[firefox]: http://mozilla.com/firefox/ "The very popular open source web browser."
[firebug]: http://getfirebug.com/ "A Firefox addon for web development."
[camino]: http://caminobrowser.org/ "An alternative Mac browser based on Gecko."
[omniweb]: http://www.omnigroup.com/applications/omniweb/ "An alternative Mac browser based on WebKit."
[opera]: http://www.opera.com/ "A popular, cross-platform web browser."
[chrome]: http://google.com/chrome "A WebKit-based browser, where each tab runs in its own thread."
[chromium]: http://code.google.com/chromium/ "Open-source builds of the Chrome web browser."
[netnewswire]: http://newsgator.com/individuals/netnewswire/ "A popular feed reader for the Mac."
[colloquy]: http://www.colloquy.info/ "A popular IRC client for the Mac."
[adium]: http://adiumx.com/ "The excellent multi-chat-protocol Mac application."
[fire]: http://fire.sourceforge.net/ "A once popular multi-protocol chat client for the Mac."
[twitterrific]: http://iconfactory.com/software/twitterrific "A popular Twitter Mac client."
[windowshade-x]: http://unsanity.com/haxies/wsx "A Mac haxie to customise window minimising."
[ape]: http://unsanity.com/haxies/ape "An OS X framework and system daemon for loading haxies."
[quicksilver]: http://code.google.com/p/blacktree-alchemy/ "The ultimate data manipulator/launcher for the Mac."
[launchbar]: http://obdev.at/products/launchbar/ "An application launcher and data manager for the Mac."
[dragthing]: http://dragthing.com/ "A popular dock application for the Mac."
[asm]: http://vercruesse.de/software/asm "A menu-based application switcher for OS X."
[istat-menus]: http://www.islayer.com/apps/istatmenus/ "A collection of OS X menu items for monitoring your system."
[dropbox]: http://getdropbox.com/ "Online syncing and storage."
[yojimbo]: http://barebones.com/products/Yojimbo/ "Data 'bucket' software for the Mac."
[mobile-me]: http://www.me.com/ "An online 'cloud' service (mail, calendar, etc)."
[macfuse]: http://code.google.com/p/macfuse/ "A system for adding third-party file systems to Mac OS X."
[sshfs]: http://code.google.com/p/macfuse/wiki/MACFUSE_FS_SSHFS "An SSH file system for MacFUSE."
[fusion]: http://vmware.com/products/fusion/ "A PC emulator for the Mac."
[boot-camp]: http://www.apple.com/macosx/what-is-macosx/compatibility.html "Software to allow Macs to run Windows natively."
[twitterrific-iphone]: http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=284540316&mt=8 "A popular Twitter Mac client for the iPhone."
[safari-iphone]: http://www.apple.com/iphone/iphone-3g/safari.html "The iPhone version of Safari."
[peggle-iphone]: http://www.popcap.com/games/iphone/peggle "A terribly addictive peg-popping game."
[dictate]: http://www.macspeech.com/dictate/ "Speech recognition software for the Mac."
