# NELC App Factory MCP Server

**Generate production-ready Cloud Run apps directly from Cursor IDE.**

This MCP (Model Context Protocol) server allows you to generate complete, deployable applications using natural language in Cursor.

## Features

- 🚀 **One-command deployment** to GCP Cloud Run
- 🗄️ **PostgreSQL database** (optional, auto-configured)
- 📦 **Cloud Storage** (optional, auto-configured)
- 🔒 **HTTPS with SSL** (automatic with custom domain)
- ⚛️ **Modern tech stack** (Node.js + React)

## Quick Start

### One-Time Setup (Automatic)

Run this single command:

```bash
curl -fsSL https://raw.githubusercontent.com/nelc/appfactory-v2-mcp/main/setup.sh | bash
```

This automatically:
- ✅ Checks Node.js and GitHub CLI
- ✅ Installs MCP tool
- ✅ Configures Cursor
- ✅ Authenticates GitHub

**Then restart Cursor.**

### Manual Installation (Alternative)

If you prefer manual setup:

```bash
# 1. Install MCP tool
npm install -g git+https://github.com/nelc/appfactory-v2-mcp.git

# 2. Configure Cursor
# Add to ~/.config/cursor/mcp.json (Mac/Linux) or %APPDATA%\Cursor\mcp.json (Windows):
{
  "mcpServers": {
    "app-factory": {
      "command": "app-factory-mcp"
    }
  }
}

# 3. Restart Cursor
```

## Usage

### Step 1: Generate Code in Cursor

Start a new chat and say:

```
Generate my Customer Tracker app using the App Factory tool.

Features:
- Add/edit/delete customers
- Search customers by name
- Export to CSV
- Customer notes

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

**That's it!** The script handles:
- ✅ Git initialization
- ✅ GitHub repo creation
- ✅ Code push
- ✅ Deployment trigger

### Step 3: Add DNS

After ~5 minutes, the workflow outputs:

```
📋 Add DNS: customer-tracker.futurex.sa → 34.xxx.xxx.xxx
```

Add this A record in Cloudflare, then visit: `https://customer-tracker.futurex.sa`

## Examples

### Simple Todo App

```
Generate my Todo List app using App Factory tool.

Features:
- Add/delete todos
- Mark complete
- Filter by status

Needs database: yes
```

### File Upload App

```
Generate my Document Manager app using App Factory tool.

Features:
- Upload documents
- Organize in folders
- Search files
- Download/delete

Needs database: yes
Needs file storage: yes
```

### API Service

```
Generate my Inventory API using App Factory tool.

Features:
- CRUD operations for inventory
- Stock level tracking
- Low stock alerts
- REST API endpoints

Needs database: yes
```

## After Deployment

The workflow will output DNS configuration:

```
📋 DNS CONFIGURATION REQUIRED:

Type: A
Name: customer-tracker.futurex.sa
Value: 34.xxx.xxx.xxx
TTL: Auto
```

Add this record in your DNS provider (Cloudflare), and your app will be live at:

```
https://customer-tracker.futurex.sa
```

## Troubleshooting

### "MCP server not responding"

- Verify installation: `which app-factory-mcp`
- Check Node.js version: `node --version` (requires 18+)
- Restart Cursor

### "Failed to generate prompt"

- Check internet connection
- Verify portal is accessible:
  ```bash
  curl https://appfactory-v2-portal-621571041797.me-central2.run.app/api/health
  ```

### "Deployment failed"

- Check GitHub Actions logs
- Verify GitHub organization membership
- Contact admin for organization secrets

## Technical Details

### Generated Tech Stack

- **Frontend:** React 18 + Vite
- **Backend:** Node.js 20 + Express
- **Database:** PostgreSQL (Cloud SQL)
- **Storage:** Google Cloud Storage
- **Deployment:** Cloud Run (serverless)

### Architecture

Each app gets:
- 2 Cloud Run services (frontend + backend)
- Load Balancer with unique static IP
- Database on shared Cloud SQL instance
- HTTPS with wildcard SSL certificate

## Security & Privacy

### What this MCP server does:
1. Takes your app requirements (name, features)
2. Sends them to the public portal API
3. Returns a generated prompt for code generation

### Data handling:
- ✅ **No secrets or credentials** stored or transmitted
- ✅ **No code** sent to external services
- ✅ **No proprietary data** leaves your machine
- ✅ Only app requirements (name, features) sent to portal
- ✅ Portal is public endpoint (same as web form)

### What's NOT in this repo:
- ❌ GCP credentials
- ❌ Infrastructure configuration  
- ❌ Deployment secrets
- ❌ Any sensitive organizational data

Safe to use and safe to be public. ✅

## Repository Structure

- **This repo (public):** MCP server for business users
- **Infrastructure repo (private):** Portal, deployment scripts (admin only)

## Support

- **Documentation:** Contact your organization admin
- **Issues:** https://github.com/nelc/appfactory-v2-mcp/issues
- **MCP Protocol:** https://modelcontextprotocol.io

## License

MIT

