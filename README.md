Proxy of DNS lookup for docker hosts behind (cooperate) HTTP proxy
====
# Preparetion
1. Add pairs of hostnames and IP addresses to /etc/hosts on the docker host.
    - Hostnames in /etc/hotsts will be able to resolved via DNS lookup from docker containers.
2. Make the docker engine refer to the specific DNS server that can listen from docker containers.
    - On Ubuntu 24.04 for example, add the following setting to `/etc/docker/daemon.json`:
        ```
        {
            "dns": ["172.17.0.1"]
        }
        ```
        - Note merge the above with existing settings (i.e. keep the setting text in valid JSON format) if the `/etc/docker/damon.json` has already existed and contained some settings.

3. Assign your http proxy setting string (e.g., "http://your_account:your_password:proxy.host.fqdn:port/") to the environment variable `build_time_proxy`.
    - I recommend append that assignment to `.env`.
    - The setting is only for building the docker images.

4. Build docker images.
    - `docker compose build`

# Run
0. If you restart the below docker containers every time the OS is restarted, assign `always` to the environment variable `restart`.
1. Start docker containers.
    - `docker compose up -d`
        - Two containers will be started. One is for forwarding UDP requests. Another for TCP requests, which may be unnecessary.
