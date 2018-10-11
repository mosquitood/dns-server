### DNS    Server    For    DNS   Leak   Test

##### 前期准备

- 一台Linux服务器
  -  假设IP：213.23.2.122
- 一个合法的域名
  - 例如：    domain.com

##### 操作步骤

以centos系统为例

- 安装docker

  ```shell
  yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
    
  yum-config-manager \
      --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo
      
  yum install docker-ce -y
  
  systemctl start docker
  systemctl enable docker
  ```

- 设置UDP端口   53

  ```shell
  systemctl start firewalld
  
  firewall-cmd --zone=public --add-port=53/udp --permanent
  firewall-cmd --reload
  ```

- 解析域名

  | Type | Name | Value          |
  | ---- | ---- | -------------- |
  | A    | dns  | 213.23.2.122   |
  | NS   | *    | dns.domain.com |

- 拉取镜像

  ```shell
  docker pull mosquitood/dnsleakserver
  ```

- 启动容器

  ```shell
  docker run -itd -p 53:53/udp -p 6379:6379 -e NS="domain.com" -e IP="213.23.2.122" mosquitood/dnsleakserver
  ```

- 测试数据

  - 打开浏览器，访问 xxx.domain.com

- 查看数据

  - 数据是存到redis里面的，redis已经包含在了容器中

  - 登录容器

    ```shell
    docker exec -it 容器ID bash
    
    redis-cli
    lrange "xxx.domain.com" 0 -1
    ```

- 取得数据

  - 不多说了

