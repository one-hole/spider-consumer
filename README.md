开发环境

```bash
env APP_ENV=development ruby main.rb
```

---

生产环境
```bash
env APP_ENV=production ruby main.rb
```
---

Console Env - Dev Only

```
./bin/console
```

#### Pub/Sub

* Sub
  * hltv-matches-channel  HLTV 的 matches api

* Pub
  * hltv-matches-created  新创建的比赛
    * 获取比赛的详细信息
    * 创建事件需要推送
    * 内部需要创建相关的 Match
