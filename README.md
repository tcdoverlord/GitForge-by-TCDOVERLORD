# ⚙️ GitForge by TCDOVERLORD

<p align="center">
<img src="images/GitForge_Hero.png" width="100%">
</p>

<p align="center">

![Platform](https://img.shields.io/badge/Platform-Windows-0078D4?style=for-the-badge)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-5391FE?style=for-the-badge)
![Git](https://img.shields.io/badge/Git-Required-F05032?style=for-the-badge)
![GitHub CLI](https://img.shields.io/badge/GitHub_CLI-Required-181717?style=for-the-badge)
![License](https://img.shields.io/badge/License-TPLL-success?style=for-the-badge)

</p>

---

# 🚀 Overview

GitForge is a Windows PowerShell publishing assistant that transforms any local project folder into a fully initialized GitHub repository using an easy graphical interface.

Instead of repeatedly typing Git commands every time you create a project, GitForge automates the entire publishing workflow while still encouraging users to understand the Git process.

Developed by **TCDOVERLORD**

---

# ✨ Features

- 📂 Browse for any local project folder
- ⚙ Automatically initialize Git repositories
- 🌐 Create GitHub repositories
- 📝 Set repository descriptions
- 🏷 Add GitHub topics automatically
- 🔒 Choose Public or Private repositories
- 📊 Display Git status
- 🌍 Open the repository in your browser
- ⚡ Built entirely with PowerShell
- 🪶 Lightweight with no unnecessary dependencies

---

# 🔄 Automated Workflow

GitForge performs the complete publishing pipeline:

```powershell
git init
git add .
git commit
gh repo create
gh repo edit --description
gh repo edit --add-topic
git status
gh repo view --web
```

---

# 🖥 Requirements

- Windows 10 or Windows 11
- PowerShell 5.1 or newer
- Git
- GitHub CLI

Authenticate once using:

```powershell
gh auth login
```

---

# 🚀 Quick Start

Launch GitForge:

```text
launchers\START_GITFORGE.bat
```

Fill in:

- Project Folder
- Repository Name
- GitHub Username
- Description
- Topics
- Public or Private

Press:

```
Publish to GitHub
```

GitForge handles the rest.

---

# 📸 Interface

*(Screenshots coming soon)*

```
images/

├── GitForge_Hero.png
├── GitForge_Main_Window.png
├── GitForge_Repository_Created.png
└── GitForge_Workflow.png
```

---

# 📁 Project Structure

```text
GitForge-by-TCDOVERLORD/
│
├── config/
├── docs/
├── launchers/
├── logs/
├── scripts/
├── images/
│
├── LICENSE
├── README.md
└── setup.ps1
```

---

# 📚 Documentation

| Document | Description |
|----------|-------------|
| 📖 Philosophy | Project design principles |
| 🤖 AI Prompt Library | AI prompts for GitHub automation |
| 📘 Future Roadmap | Planned improvements |
| ⚙ Configuration Guide | Settings reference |

---

# 💡 Philosophy

GitForge exists because repetitive work should be automated.

The goal is not to hide Git—it is to eliminate repetitive setup so developers can spend more time building software.

> **If I have to do it twice... I build a system.**

— **TCDOVERLORD**

---

# 🛣 Roadmap

Future versions are planned to include:

- Repository templates
- Automatic README generation
- License selection
- GitHub Releases
- Changelog generation
- GitHub Actions support
- Repository health checks
- Batch publishing
- Project templates
- AI-assisted repository improvements

---

# 🏗️ Architecture

```mermaid
flowchart TD

A[START_GITFORGE.bat]
A --> B[Start-GitForge.ps1]

B --> C[Configuration Engine]
B --> D[PowerShell GUI]
B --> E[Logging Engine]

D --> F[Project Folder]
D --> G[Repository Information]
D --> H[Repository Visibility]

F --> I[Git Engine]
G --> I
H --> I

I --> J[git init]
J --> K[git add .]
K --> L[git commit]

L --> M[GitHub CLI]
M --> N[gh repo create]
N --> O[Repository Configuration]
O --> P[Description]
O --> Q[Topics]

Q --> R[git push]
R --> S[Git Status]
S --> T[Launch Repository]

T --> U[GitHub Repository]
```

# 🤝 Contributing

Contributions are welcome.

Please review the documentation before opening a pull request.

Ideas, bug reports, and improvements are appreciated.

---

📄 License

This project is licensed under the **TCDOVERLORD Personal Learning License (TPLL) v1.0**.

This project is intended to support:

- 📚 Personal learning
- 🎓 Educational use
- 🧪 Research and experimentation
- 💻 Private, non-commercial projects

You are welcome to study, modify, and experiment with the source code for your own personal or educational purposes.

Commercial use—including resale, redistribution, business integration, SaaS offerings, consulting use, enterprise deployment, or inclusion in commercial products—is **not permitted** without prior written permission from the copyright owner.

For commercial licensing inquiries, please contact:

**TCDOVERLORD**

GitHub: https://github.com/tcdoverlord

See the [LICENSE](license) file for the complete license terms.

# 👨‍💻 Author

Developed by **TCDOVERLORD**

Building practical Windows tools that automate repetitive work, improve productivity, and make technology more accessible.

---

<p align="center">

⭐ If GitForge saved you time, consider starring the repository.

</p>
