# INSTALL PUPPET PE (PUPPET ENTERPRISE) ON DOCKER CONTAINERS

## What This Does

### ✅ Persistent Data

- Stores Puppet Server configurations in puppet_data and logs in puppet_logs.
- Stores Puppet Agent configurations in puppet_agent_data and logs in puppet_agent_logs.

### ✅ Automatic Restart

- Containers restart automatically unless manually stopped.

### ✅ Volume Mapping

- Keeps data and logs even if the containers are restarted or removed.

## How to Use

### Start the containers:
```bash 
docker-compose up -d
```

### Check logs:

```bash
docker logs -f puppetserver
```

### Stop the containers:

```bash 
docker-compose down
```

### Remove everything (if needed):

```bash 
docker-compose down -v
```

This setup ensures that your Puppet Server and Agent persist their data across container lifecycles. 🚀

## View Puppet Dashboard

In a WSL2 console `wsl -d Debian`

```bash
ip route show | grep -i default | awk '{ print $3}'
```

In powershell

```bat
netsh interface portproxy add v4tov4 listenport=8140 listenaddress=0.0.0.0 connectport=8140 connectaddress=(wsl hostname -I)
```
