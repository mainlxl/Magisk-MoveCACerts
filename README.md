# MoveCACerts

这是一个 Magisk 模块，用于将自定义CA证书添加到系统信任存储区。安装完后需要重启手机.
支持安卓14

## 用法

1. `git clone https://github.com/wjf0214/Magisk-MoveCACerts.git` 或直接下载仓库 zip。
2. 将要添加的 Android 设备的CA证书（以 hash.0 命名）放进 `system/etc/security/cacerts` 目录。
3. 将 `Magisk-MoveCACerts` 目录中的所有文件打包，`zip -r ../Magisk-MoveCACerts.zip *`生成 `Magisk-MoveCACerts.zip` 文件。注意，请直接打包所有文件而不是打包 `Magisk-MoveCACerts` 项目的目录。
4. 将 `Magisk-MoveCACerts.zip` 导入到手机，在 Magisk 从本地选择 `Magisk-MoveCACerts.zip` 文件，安装模块。

⚠️ 注意：如果手机已经安装了模块，后续追加的证书可以直接放入 `/data/adb/modules/MoveCACerts/system/etc/security/cacerts/` 目录下，再重启手机即可。


```shell
#系统证书路径  
/system/etc/security/cacerts
#用户证书路径
/data/misc/user/0/cacerts-added
```

```shell
#读取hash值
#cer证书文件
openssl x509 -inform DER -subject_hash_old -in xxxx.cer | head -n 1
#pem证书文件
openssl x509 -inform PEM -subject_hash_old -in xxxx.pem | head -n 1

#根据hash值生成证书
#cer证书文件
openssl x509 -inform DER -text -in xxxx.cer > 哈希值xxx.0
#pem证书文件
openssl x509 -inform PEM -text -in xxxx.pem > 哈希值xxx.0
```
