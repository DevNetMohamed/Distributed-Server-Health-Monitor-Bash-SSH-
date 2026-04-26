# 🚀 Distributed Server Health Monitor (Bash + SSH)

A production-grade DevOps script to monitor the health of multiple remote servers in parallel using SSH, with alerting, logging, and reporting capabilities.

---

## 📌 Overview

This project is a **Bash-based automation tool** designed to:

* Connect to multiple remote servers via SSH
* Perform system health checks (CPU, Memory, Disk, Security)
* Execute checks in **parallel** for speed ⚡
* Generate structured **JSON reports** 📦
* Send **real-time alerts to Slack** 💬
* Log all operations for debugging and auditing

---

## 🛠️ Features

✅ Parallel SSH execution (multi-server monitoring)
✅ Disk usage alerts (threshold > 80%) 🚨
✅ JSON report generation
✅ Slack webhook integration
✅ Secure logging system
✅ Error handling with strict Bash mode
✅ Clean shutdown with trap & cleanup

---

## 📂 Project Structure

```
.
├── server_health_check.sh   # Main script
├── servers.txt             # List of target servers
├── report.json             # Generated report
└── README.md               # Project documentation
```

---

## ⚙️ Requirements

* Linux / WSL / macOS
* Bash (v4+)
* SSH access to target servers
* `awk`, `grep`, `df`, `free` installed
* Optional: Slack Webhook URL

---

## 🚀 Usage

### 1. Clone the repository

```bash
git clone https://github.com/your-username/server-health-monitor.git
cd server-health-monitor
```

---

### 2. Create server list

```bash
nano servers.txt
```

Example:

```
192.168.1.10
192.168.1.20
localhost
```

---

### 3. Make script executable

```bash
chmod +x server_health_check.sh
```

---

### 4. Run the script

```bash
./server_health_check.sh -f servers.txt -u your-ssh-user
```

---

## 📊 Output Example

### 🔹 Console

```
[INFO] Checking server: 192.168.1.10
[INFO] Finished: 192.168.1.10
```

---

### 🔹 JSON Report (`report.json`)

```json
[
  {
    "server": "192.168.1.10",
    "disk": "65",
    "memory": "42.5",
    "ssh_failed": "3"
  }
]
```

---

## 💬 Slack Integration

1. Create a Slack Webhook
2. Add it inside the script:

```bash
SLACK_WEBHOOK="https://hooks.slack.com/services/XXXX"
```

---

## 🚨 Alerts

* Sends alert when:

  * Disk usage exceeds **80%**
* Example:

```
⚠️ Server 192.168.1.10 disk usage is high: 85%
```

---

## 🧠 Technical Highlights

* Uses `set -euo pipefail` for safe scripting
* Parallel execution using background jobs (`&`)
* Process synchronization using `wait`
* JSON generation using Bash string formatting
* SSH here-doc for remote command batching
* Trap-based cleanup for reliability

---

## 🔮 Future Improvements

* [ ] Thread pool (limit parallel jobs)
* [ ] Retry mechanism for failed SSH connections
* [ ] Email notifications
* [ ] Docker containerization
* [ ] Prometheus / Grafana integration
* [ ] REST API wrapper

---

## 👨‍💻 Author

**Mohamed Adel Abdel Aal**
DevOps Engineer | Full-Stack Developer

---

## ⭐ Contributing

Feel free to fork this project and submit pull requests!

---

## 📜 License

MIT License
