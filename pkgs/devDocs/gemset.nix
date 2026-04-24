{
  activesupport = {
    dependencies = ["base64" "bigdecimal" "concurrent-ruby" "connection_pool" "drb" "i18n" "json" "logger" "minitest" "securerandom" "tzinfo" "uri"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bpxnr83z1x78h3jxvmga7vrmzmc8b4fic49h9jhzm6hriw2b148";
      type = "gem";
    };
    version = "8.1.2";
  };
  backports = {
    groups = ["app" "default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dbjl5ilyzlhl4p60pq41kdy4j8bg21f4m1vccawlh1wvhr8sacl";
      type = "gem";
    };
    version = "3.25.3";
  };
  base64 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yx9yn47a8lkfcjmigk79fykxvr80r4m1i35q82sxzynpbm7lcr7";
      type = "gem";
    };
    version = "0.3.0";
  };
  better_errors = {
    dependencies = ["erubi" "rack" "rouge"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wqazisnn6hn1wsza412xribpw5wzx6b5z5p4mcpfgizr6xg367p";
      type = "gem";
    };
    version = "2.10.1";
  };
  bigdecimal = {
  };
  browser = {
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bffb8dddrg6zn8c74swhy8mq2mysb195hi7chwwj9c8g2am4798";
      type = "gem";
    };
    version = "6.2.0";
  };
  chunky_png = {
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1znw5x86hmm9vfhidwdsijz8m38pqgmv98l9ryilvky0aldv7mc9";
      type = "gem";
    };
    version = "1.4.0";
  };
  coderay = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jvxqxzply1lwp7ysn94zjhh57vc14mcshw1ygw14ib8lhc00lyw";
      type = "gem";
    };
    version = "1.1.3";
  };
  concurrent-ruby = {
  };
  connection_pool = {
  };
  date = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1h0db8r2v5llxdbzkzyllkfniqw9gm092qn7cbaib73v9lw0c3bm";
      type = "gem";
    };
    version = "3.5.1";
  };
  debug = {
    dependencies = ["irb" "reline"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1djjx5332d1hdh9s782dyr0f9d4fr9rllzdcz2k0f8lz2730l2rf";
      type = "gem";
    };
    version = "1.11.1";
  };
  drb = {
  };
  erb = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1rcpq49pyaiclpjp3c3qjl25r95hqvin2q2dczaynaj7qncxvv18";
      type = "gem";
    };
    version = "6.0.1";
  };
  erubi = {
  };
  ethon = {
    dependencies = ["ffi"];
  };
  execjs = {
    groups = ["default" "production"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03a590q16nhqvfms0lh42mp6a1i41w41qpdnf39zjbq5y3l8pjvb";
      type = "gem";
    };
    version = "2.10.0";
  };
  exifr = {
  };
  ffi = {
  };
  fspath = {
  };
  highline = {
    dependencies = ["reline"];
  };
  hike = {
  };
  html-pipeline = {
    dependencies = ["selma" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bmpmws2spkw5cfixavyh03xi8v5147i1c6is3l6g3kg3vf9s0mn";
      type = "gem";
    };
    version = "3.2.4";
  };
  i18n = {
    dependencies = ["concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1994i044vdmzzkyr76g8rpl1fq1532wf0sb21xg5r1ilj5iphmr8";
      type = "gem";
    };
    version = "1.14.8";
  };
  image_optim = {
    dependencies = ["exifr" "fspath" "image_size" "in_threads" "progress"];
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1h3n8x1rlxz4mkk49lij22x1nn0qk5cvir3fsj4x3s382a4x1zsv";
      type = "gem";
    };
    version = "0.31.4";
  };
  image_size = {
    groups = ["app" "default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16h2gxxk212mlvphf03x1z1ddb9k3vm0lgsxbvi4fjg77x8q19f6";
      type = "gem";
    };
    version = "3.4.0";
  };
  in_threads = {
  };
  io-console = {
    groups = ["default" "development" "docs"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1k0lk3pwadm2myvpg893n8jshmrf2sigrd4ki15lymy7gixaxqyn";
      type = "gem";
    };
    version = "0.8.2";
  };
  irb = {
    dependencies = ["pp" "rdoc" "reline"];
  };
  json = {
  };
  logger = {
  };
  method_source = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1igmc3sq9ay90f8xjvfnswd1dybj1s3fi0dwd53inwsvqk4h24qq";
      type = "gem";
    };
    version = "1.1.0";
  };
  minitest = {
    dependencies = ["prism"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fslin1vyh60snwygx8jnaj4kwhk83f3m0v2j2b7bsg2917wfm3q";
      type = "gem";
    };
    version = "6.0.1";
  };
  multi_json = {
  };
  newrelic_rpm = {
    dependencies = ["logger"];
  };
  nokogiri = {
    dependencies = ["racc"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rrpjfy30dap772q1apnd2vr7x0fhq80nwlmygf5wzhf7k67xa8i";
      type = "gem";
    };
    version = "1.19.0";
  };
  options = {
  };
  pp = {
    dependencies = ["prettyprint"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1xlxmg86k5kifci1xvlmgw56x88dmqf04zfzn7zcr4qb8ladal99";
      type = "gem";
    };
    version = "0.6.3";
  };
  prettyprint = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14zicq3plqi217w6xahv7b8f7aj5kpxv1j1w98344ix9h5ay3j9b";
      type = "gem";
    };
    version = "0.2.0";
  };
  prism = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0m0jkk1y537xc2rw5fg7sid5fnd4a9mw2gphqmiflc2mxwb3lic4";
      type = "gem";
    };
    version = "1.8.0";
  };
  progress = {
  };
  progress_bar = {
    dependencies = ["highline" "options"];
  };
  pry = {
    dependencies = ["coderay" "method_source" "reline"];
  };
  psych = {
    dependencies = ["date" "stringio"];
  };
  racc = {
  };
  rack = {
    groups = ["app" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wr1f3g9rc9i8svfxa9cijajl1661d817s56b2w7rd572zwn0zi0";
      type = "gem";
    };
    version = "1.6.13";
  };
  rack-protection = {
    dependencies = ["rack"];
  };
  rack-ssl-enforcer = {
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "020i3fbii76g1b5jhc6va4zb13br0r2q5jzfpd3cms6is58l1vwr";
      type = "gem";
    };
    version = "0.2.9";
  };
  rack-test = {
    dependencies = ["rack"];
  };
  rake = {
  };
  rb-fsevent = {
    groups = ["app" "default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zmf31rnpm8553lqwibvv3kkx0v7majm1f341xbxc0bk5sbhp423";
      type = "gem";
    };
    version = "0.11.2";
  };
  rb-inotify = {
    dependencies = ["ffi"];
    groups = ["app" "default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vmy8xgahixcz6hzwy4zdcyn2y6d6ri8dqv5xccgzc1r292019x0";
      type = "gem";
    };
    version = "0.11.1";
  };
  rdoc = {
    dependencies = ["erb" "psych" "tsort"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qvky4s2fx5xbaz1brxanalqbcky3c7xbqd6dicpih860zgrjj29";
      type = "gem";
    };
    version = "7.1.0";
  };
  redcarpet = {
    groups = ["docs"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0iglapqs4av4za9yfaac0lna7s16fq2xn36wpk380m55d8792i6l";
      type = "gem";
    };
    version = "3.6.1";
  };
  reline = {
    dependencies = ["io-console"];
  };
  rexml = {
    groups = ["app" "default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0hninnbvqd2pn40h863lbrn9p11gvdxp928izkag5ysx8b1s5q0r";
      type = "gem";
    };
    version = "3.4.4";
  };
  rouge = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fd77qcz603mli4lyi97cjzkv02hsfk60m495qv5qcn02mkqk9fv";
      type = "gem";
    };
    version = "4.7.0";
  };
  rr = {
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06zzn378kkdc8sn32l60z7c3d7cz85a12rnw2z9jf8q13z4mqjnc";
      type = "gem";
    };
    version = "3.1.2";
  };
  rss = {
    dependencies = ["rexml"];
  };
  sass = {
    dependencies = ["sass-listen"];
  };
  sass-listen = {
    dependencies = ["rb-fsevent" "rb-inotify"];
  };
  securerandom = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1cd0iriqfsf1z91qg271sm88xjnfd92b832z49p1nd542ka96lfc";
      type = "gem";
    };
    version = "0.4.1";
  };
  selma = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1gbd1v1vghnwywp5m8li2ra04gyzph95m5gad0fsmz6gy91x6rd1";
      type = "gem";
    };
    version = "0.4.15";
  };
  sinatra = {
    dependencies = ["rack" "rack-protection" "tilt"];
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0byxzl7rx3ki0xd7aiv1x8mbah7hzd8f81l65nq8857kmgzj1jqq";
      type = "gem";
    };
    version = "1.4.8";
  };
  sinatra-contrib = {
    dependencies = ["backports" "multi_json" "rack-protection" "rack-test" "sinatra" "tilt"];
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vi3i0icbi2figiayxpvxbqpbn1syma7w4p4zw5mav1ln4c7jnfr";
      type = "gem";
    };
    version = "1.4.7";
  };
  sprockets = {
    dependencies = ["hike" "multi_json" "rack" "tilt"];
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10ljpxb0wvcaw0waakjg1ixdhmldxqbbmk7vrlanh2m4bcxvv6hq";
      type = "gem";
    };
    version = "2.12.5";
  };
  sprockets-helpers = {
    dependencies = ["sprockets"];
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0513ma356g05lsskhsb363263177h6ccmp475il0p69y18his2ij";
      type = "gem";
    };
    version = "1.4.0";
  };
  sprockets-sass = {
    dependencies = ["sprockets" "tilt"];
    groups = ["app"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1b9z9qcvp0zh6q4p8bmd4bq0zvmrins5gfy3x65zg3xj8wx7s6d5";
      type = "gem";
    };
    version = "1.3.1";
  };
  stringio = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1q92y9627yisykyscv0bdsrrgyaajc2qr56dwlzx7ysgigjv4z63";
      type = "gem";
    };
    version = "3.2.0";
  };
  strings = {
    dependencies = ["strings-ansi" "unicode-display_width" "unicode_utils"];
    groups = ["default" "docs"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1yynb0qhhhplmpzavfrrlwdnd1rh7rkwzcs4xf0mpy2wr6rr6clk";
      type = "gem";
    };
    version = "0.2.1";
  };
  strings-ansi = {
    groups = ["default" "docs"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "120wa6yjc63b84lprglc52f40hx3fx920n4dmv14rad41rv2s9lh";
      type = "gem";
    };
    version = "0.2.0";
  };
  terminal-table = {
    dependencies = ["unicode-display_width"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lh18gwpksk25sbcjgh94vmfw2rz0lrq61n7lwp1n9gq0cr7j17m";
      type = "gem";
    };
    version = "4.0.0";
  };
  terser = {
    dependencies = ["execjs"];
    groups = ["production"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1arp7z8yp9i2k5fs328g9ymaf3yp9kklkcdrw83mn0gp7nwh1pvd";
      type = "gem";
    };
    version = "1.2.6";
  };
  thor = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wsy88vg2mazl039392hqrcwvs5nb9kq8jhhrrclir2px1gybag3";
      type = "gem";
    };
    version = "1.5.0";
  };
  tilt = {
    groups = ["app" "default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00sr3yy7sbqaq7cb2d2kpycajxqf1b1wr1yy33z4bnzmqii0b0ir";
      type = "gem";
    };
    version = "1.4.1";
  };
  tsort = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "17q8h020dw73wjmql50lqw5ddsngg67jfw8ncjv476l5ys9sfl4n";
      type = "gem";
    };
    version = "0.2.0";
  };
  tty-pager = {
    dependencies = ["strings" "tty-screen"];
    groups = ["docs"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cz0yrfjzz9xkd3wh939hz64nqxny4h6hrkc17rkfgj38lyyd44z";
      type = "gem";
    };
    version = "0.14.0";
  };
  tty-screen = {
    groups = ["default" "docs"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0l4vh6g333jxm9lakilkva2gn17j6gb052626r1pdbmy2lhnb460";
      type = "gem";
    };
    version = "0.8.2";
  };
  typhoeus = {
    dependencies = ["ethon"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fryvvqz7432lvi8rrrqy0b0jnzih2w6s5rqx70fc5gm3vnnf2qj";
      type = "gem";
    };
    version = "1.5.0";
  };
  tzinfo = {
    dependencies = ["concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16w2g84dzaf3z13gxyzlzbf748kylk5bdgg3n1ipvkvvqy685bwd";
      type = "gem";
    };
    version = "2.0.6";
  };
  unicode-display_width = {
  };
  unicode_utils = {
    groups = ["default" "docs"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0h1a5yvrxzlf0lxxa1ya31jcizslf774arnsd89vgdhk4g7x08mr";
      type = "gem";
    };
    version = "1.4.0";
  };
  unix_utils = {
    groups = ["docs"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "134ii02ig7x77lwpw8lgmaaizzkp3g60r85dia72ha19hbd9xj71";
      type = "gem";
    };
    version = "0.0.15";
  };
  uri = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ijpbj7mdrq7rhpq2kb51yykhrs2s54wfs6sm9z3icgz4y6sb7rp";
      type = "gem";
    };
    version = "1.1.1";
  };
  yajl-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lni4jbyrlph7sz8y49q84pb0sbj82lgwvnjnsiv01xf26f4v5wc";
      type = "gem";
    };
    version = "1.4.3";
  };
  zeitwerk = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12zcvhzfnlghzw03czy2ifdlyfpq0kcbqcmxqakfkbxxavrr1vrb";
      type = "gem";
    };
    version = "2.7.4";
  };
}
