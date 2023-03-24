# pod install 报错
1.终端输入以下内容以安装"ffi"
sudo arch -x86_64 gem install ffi
2.终端输入以下内容以继续pod操作（也就是在原本的命令前面加上arch -x86_64）
arch -x86_64 pod install
以后pod install时只需做第二步即可。
