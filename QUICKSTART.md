# App Factory V2 - Quick Start Guide

Deploy production apps to GCP in **2 simple steps**.

---

## ⚡ One-Time Setup (5 minutes)

Run this command:

```bash
curl -fsSL https://raw.githubusercontent.com/nelc/appfactory-v2-mcp/main/setup.sh | bash
```

This installs and configures everything automatically.

**Then restart Cursor.**

---

## 🚀 Deploy an App (Every Time)

### Step 1: Generate Code

In Cursor, start a new chat and say:

```
Generate my Customer Tracker app using the App Factory tool.

Features:
- Add/edit/delete customers
- Search by name
- Export to CSV

Needs database: yes
Needs file storage: no
```

Wait for all files to be generated.

### Step 2: Deploy

In Cursor terminal:

```bash
cd ~/customer-tracker  # or wherever code was generated
./deploy.sh
```

**That's it!**

The script will:
- ✅ Create GitHub repo
- ✅ Push code
- ✅ Start deployment
- ✅ Show you the DNS record to add

---

## 📋 After Deployment

You'll see output like:

```
╔════════════════════════════════════════════════════╗
║  📋 DNS CONFIGURATION REQUIRED                    ║
╠════════════════════════════════════════════════════╣
║  Type: A                                          ║
║  Name: customer-tracker.futurex.sa               ║
║  Value: 34.123.456.789                           ║
╚════════════════════════════════════════════════════╝
```

**Add this DNS record in Cloudflare** (or ask admin).

Wait 1-5 minutes → Visit: `https://customer-tracker.futurex.sa` ✅

---

## 💡 Examples

### Todo App
```
Generate my Todo List app using App Factory tool.

Features:
- Add/delete todos
- Mark complete
- Filter by status

Needs database: yes
```

### Document Manager
```
Generate my Document Manager app using App Factory tool.

Features:
- Upload files
- Search documents
- Download/delete

Needs database: yes
Needs file storage: yes
```

---

## 🔧 Troubleshooting

### "gh: command not found"
Run setup again: `curl -fsSL https://raw.githubusercontent.com/nelc/appfactory-v2-mcp/main/setup.sh | bash`

### "Permission denied (nelc organization)"
Contact admin to add you to nelc GitHub organization.

### "Deployment failed"
1. Check GitHub Actions logs: `gh run view --repo nelc/your-app`
2. Re-run: `gh run rerun --repo nelc/your-app`
3. If still fails, contact admin

### "DNS not resolving"
- Wait 5 minutes for propagation
- Verify DNS record matches workflow output exactly
- Test: `dig your-app.futurex.sa`

---

## 📊 Summary

```
One-time:  curl ... | bash  (setup)
Every app: ./deploy.sh       (deploy)
```

**Two commands total. That's it.** 🎉

